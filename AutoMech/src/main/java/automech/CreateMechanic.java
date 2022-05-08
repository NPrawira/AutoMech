package automech;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/createMechanic")
public class CreateMechanic extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mechanic_code = req.getParameter("mechanic_code");
		String name = req.getParameter("name");
		String specialization = req.getParameter("specialization").toString();
		
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			PreparedStatement pstmt = con.prepareStatement("INSERT INTO mechanics(mechanic_code, name, specialization) VALUES(?, ?, ?)");
			pstmt.setString(1, mechanic_code);
			pstmt.setString(2, name);
			pstmt.setString(3, specialization);
			pstmt.executeUpdate();
			getServletContext().setAttribute("error", null);
			getServletContext().getRequestDispatcher("/admin/mechanics.jsp?success=1").forward(req, resp);
		} catch(SQLException e) {
			getServletContext().getRequestDispatcher("/admin/mechanics-add.jsp?error=1").forward(req, resp);		
			System.out.println(e);
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
