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

@WebServlet("/admin/updatePaymentAdmin")
public class UpdatePaymentAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unused")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int service_payment_id = Integer.parseInt(req.getParameter("service_payment_id"));
		String payment_no = req.getParameter("payment_no");
		String date = req.getParameter("date");
		String service_tag = req.getParameter("service_tag");
		String service_type = req.getParameter("service_type");
		int amount = Integer.parseInt(req.getParameter("amount"));
		String method = req.getParameter("method");
		String status = req.getParameter("status");
		
		Connection con = null;
		try {
			if(method != null || method != "") {
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
				PreparedStatement pstmt = con.prepareStatement("UPDATE service_payments SET service_payment_id = ?, payment_no = ?, date = ?, service_tag = ?, service_type = ?, amount = ?, method = ?, status = ? WHERE service_payment_id = " + service_payment_id);
				pstmt.setInt(1, service_payment_id);
				pstmt.setString(2, payment_no);
				pstmt.setString(3, date);
				pstmt.setString(4, service_tag);
				pstmt.setString(5, service_type);
				pstmt.setInt(6, amount);
				pstmt.setString(7, method);
				pstmt.setString(8, status);
				pstmt.executeUpdate();
				getServletContext().setAttribute("error", null);
				getServletContext().getRequestDispatcher("/admin/service-payments.jsp?success=1").forward(req, resp);
			} else {
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
				PreparedStatement pstmt = con.prepareStatement("UPDATE service_payments SET service_payment_id = ?, payment_no = ?, date = ?, service_tag = ?, service_type = ?, amount = ?, method = ?, status = ? WHERE service_payment_id = " + service_payment_id);
				pstmt.setInt(1, service_payment_id);
				pstmt.setString(2, payment_no);
				pstmt.setString(3, date);
				pstmt.setString(4, service_tag);
				pstmt.setString(5, service_type);
				pstmt.setInt(6, amount);
				pstmt.setString(7, "");
				pstmt.setString(8, status);
				pstmt.executeUpdate();
				getServletContext().setAttribute("error", null);
				getServletContext().getRequestDispatcher("/admin/service-payments.jsp?success=1").forward(req, resp);
			}
		} catch(SQLException e) {
			getServletContext().getRequestDispatcher("/admin/service-payments.jsp?error=1").forward(req, resp);
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
