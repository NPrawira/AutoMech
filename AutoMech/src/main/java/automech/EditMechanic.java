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

@WebServlet("/admin/editMechanic")
public class EditMechanic extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("mechanic_id"));
		String mechanic_code = req.getParameter("mechanic_code");
		String name = req.getParameter("name");
		String specialization = req.getParameter("specialization").toString();
		
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			PreparedStatement pstmt = con.prepareStatement("UPDATE mechanics SET mechanic_id = ?, mechanic_code = ?, name = ?, specialization = ? WHERE mechanic_id = " + id);
			pstmt.setInt(1, id);
			pstmt.setString(2, mechanic_code);
			pstmt.setString(3, name);
			pstmt.setString(4, specialization);
			pstmt.executeUpdate();			
			getServletContext().getRequestDispatcher("/admin/mechanics.jsp").forward(req, resp);
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
