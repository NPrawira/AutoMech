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

@WebServlet("/updatePaymentCustomer")
public class UpdatePaymentCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int service_payment_id = Integer.parseInt(req.getParameter("service_payment_id"));
		String method = req.getParameter("method");
		
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			PreparedStatement pstmt = con.prepareStatement("UPDATE service_payments SET method = ?, status = ? WHERE service_payment_id = " + service_payment_id);
			pstmt.setString(1, method);
			pstmt.setString(2, "Confirming");
			pstmt.executeUpdate();
			getServletContext().setAttribute("error", null);
			getServletContext().getRequestDispatcher("/myservicepayments.jsp?success=1").forward(req, resp);
		} catch(SQLException e) {
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
