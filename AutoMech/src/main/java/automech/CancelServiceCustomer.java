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

@WebServlet("/cancelService")
public class CancelServiceCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String service_id = req.getParameter("cancel_service");
		
		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			pstmt1 = con.prepareStatement("UPDATE services SET status = ? WHERE service_id = " + service_id + "");
			pstmt1.setString(1, "Cancelled");
			pstmt1.executeUpdate();
			pstmt2 = con.prepareStatement("DELETE FROM service_payments WHERE service_tag IN(SELECT service_tag FROM services WHERE service_id = " + service_id + ")");
			pstmt2.executeUpdate();
			getServletContext().getRequestDispatcher("/myservices.jsp").forward(req, resp);
		} catch(SQLException e) {
			getServletContext().getRequestDispatcher("/view-service.jsp?error=1").forward(req, resp);
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
