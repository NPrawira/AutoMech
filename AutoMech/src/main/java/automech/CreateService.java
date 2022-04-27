package automech;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/createService")
public class CreateService extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String customer = req.getParameter("customer");
		String motorbike = req.getParameter("license_plate");
		String service_tag = req.getParameter("service_tag");
		String start_date = req.getParameter("start_date").toString();
		String service_type = req.getParameter("service_type").toString();
		String customer_notes = req.getParameter("customer_notes");
		String payment_no = req.getParameter("payment_no");
		
		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet date_avail = null;
		
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			
			java.sql.Statement stmt = con.createStatement();
			date_avail = stmt.executeQuery("SELECT COUNT(start_date) FROM services WHERE start_date = '" + start_date + "'");
			date_avail.next();
			int check_date = date_avail.getInt(1);
			
			if(check_date >= 5) {
				getServletContext().getRequestDispatcher("/mymotorbikes.jsp?limit=1").forward(req, resp);
			} else {
				pstmt1 = con.prepareStatement("INSERT INTO services(service_tag, motorbike, customer, start_date, finish_date, service_type, mechanic, customer_notes, mechanic_notes, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				pstmt1.setString(1, service_tag);
				pstmt1.setString(2, motorbike);
				pstmt1.setString(3, customer);
				pstmt1.setString(4, start_date);
				pstmt1.setString(5, null);
				pstmt1.setString(6, service_type);
				pstmt1.setString(7, null);
				pstmt1.setString(8, customer_notes);
				pstmt1.setString(9, "");
				pstmt1.setString(10, "Requested");
				pstmt1.executeUpdate();
				
				pstmt2 = con.prepareStatement("INSERT INTO service_payments(payment_no, customer, date, service_tag, service_type, amount, method, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
				pstmt2.setString(1, payment_no);
				pstmt2.setString(2, customer);
				pstmt2.setString(3, null);
				pstmt2.setString(4, service_tag);
				pstmt2.setString(5, service_type);
				pstmt2.setInt(6, 0);
				pstmt2.setString(7, "");
				pstmt2.setString(8, "Waiting");
				pstmt2.executeUpdate();
				
				getServletContext().setAttribute("error", null);
				getServletContext().getRequestDispatcher("/myservices.jsp?success=1").forward(req, resp);
			}
		} catch (SQLException e) {
			getServletContext().getRequestDispatcher("/new-service.jsp?error=1").forward(req, resp);
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
