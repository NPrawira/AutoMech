package automech;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/deleteBrand")
public class DeleteBrand extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("brand"));
		
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			java.sql.Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM motorbike_brands WHERE motorbike_brand_id ="+id);
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
}
