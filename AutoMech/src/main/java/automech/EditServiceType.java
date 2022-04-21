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

@WebServlet("/admin/editServiceType")
public class EditServiceType extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("service_type_id"));
		String service_code = req.getParameter("service_code");
		String name = req.getParameter("name");
		int price = Integer.parseInt(req.getParameter("price"));
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			pstmt = con.prepareStatement("UPDATE service_types SET service_type_id = ?, service_code = ?, name = ?, price = ? WHERE service_type_id = " + id);
			pstmt.setInt(1, id);
			pstmt.setString(2, service_code);
			pstmt.setString(3, name);
			pstmt.setInt(4, price);
			pstmt.executeUpdate();			
			getServletContext().getRequestDispatcher("/admin/service-types.jsp").forward(req, resp);
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
