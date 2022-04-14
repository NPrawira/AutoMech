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

@WebServlet("/admin/createBrand")
public class CreateBrand extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			pstmt = con.prepareStatement("INSERT INTO motorbike_brands(name) VALUES(?)");
			pstmt.setString(1, name);
			pstmt.executeUpdate();
			getServletContext().getRequestDispatcher("/admin/motorbike-brands.jsp").forward(req, resp);
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
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
