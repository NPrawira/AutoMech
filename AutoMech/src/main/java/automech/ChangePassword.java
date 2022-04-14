package automech;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/changePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));		
		String oldpass,newpass;	
		
		oldpass = req.getParameter("oldpass");
		newpass = req.getParameter("newpass");
		
		PreparedStatement pstmt = null; 
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			java.sql.Statement stmt = con.createStatement();
			ResultSet rs = null;
			rs = stmt.executeQuery("SELECT password FROM `customers` WHERE customer_id ="+id); 
			rs.next();
			String pass = rs.getString(1);
			if(oldpass.equals(pass)) {
				pstmt = con.prepareStatement("UPDATE `customers` SET `password`=? WHERE `customer_id`="+id);
				pstmt.setString(1, newpass);
				pstmt.executeUpdate();
				getServletContext().getRequestDispatcher("/myprofile.jsp?success=1").forward(req, resp);
			} else {
				getServletContext().getRequestDispatcher("/changepassword.jsp?error=1").forward(req, resp);
			}
		} catch (SQLException e) {
			System.out.print(e);
		} finally {
			if(con != null) {
				 try {
					 con.close();
				 } catch (SQLException e) {
	             	e.printStackTrace();
				 }
			}
		}
	}
}
