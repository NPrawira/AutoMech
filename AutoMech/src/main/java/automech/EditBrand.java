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

@WebServlet("/admin/editBrand")
public class EditBrand extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("brand_id"));
		String name = req.getParameter("name");
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con= DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			pstmt = con.prepareStatement("UPDATE `motorbike_brands` SET `motorbike_brand_id`=?,`name`=? WHERE motorbike_brand_id="+id);
			pstmt.setInt(1, id);
			pstmt.setString(2, name);	
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
