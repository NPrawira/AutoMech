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

@WebServlet("/admin/createServiceType")
public class CreateServiceType extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String service_code = req.getParameter("service_code");
		String name = req.getParameter("name");
		int price = Integer.parseInt(req.getParameter("price"));
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			pstmt = con.prepareStatement("INSERT INTO service_types(service_code, name, price) VALUES(?, ?, ?)");
			pstmt.setString(1, service_code);
			pstmt.setString(2, name);
			pstmt.setInt(3, price);
			pstmt.executeUpdate();
			getServletContext().setAttribute("error", null);
			getServletContext().getRequestDispatcher("/admin/service-types.jsp?success=1").forward(req, resp);
		} catch(SQLException e) {
			getServletContext().getRequestDispatcher("/admin/service-types-add.jsp?error=1").forward(req, resp);		
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

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
