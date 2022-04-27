package automech;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/updateService")
public class UpdateServiceAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int service_id = Integer.parseInt(req.getParameter("service_id"));
		String status = req.getParameter("status").toString();
		String mechanic = req.getParameter("mechanic").toString();
		String mechanic_notes = req.getParameter("mechanic_notes");
		
		String date1 = req.getParameter("finish_date");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date finish_date = null;
		try {
			java.util.Date date2 = sdf1.parse(date1);
			finish_date = new java.sql.Date(date2.getTime());
		} catch(ParseException e) {
			e.printStackTrace();
		}
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			if(finish_date != null) {
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
				pstmt = con.prepareStatement("UPDATE services SET service_id = ?, status = ?, mechanic = ?, finish_date = ?, mechanic_notes = ? WHERE service_id = " + service_id);
				pstmt.setInt(1, service_id);
				pstmt.setString(2, "Finished");
				pstmt.setString(3, mechanic);
				pstmt.setDate(4, finish_date);
				pstmt.setString(5, mechanic_notes);
				pstmt.executeUpdate();
				getServletContext().setAttribute("error", null);
				getServletContext().getRequestDispatcher("/admin/services.jsp?success=1").forward(req, resp);
			} else {
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
				pstmt = con.prepareStatement("UPDATE services SET service_id = ?, status = ?, mechanic = ?, finish_date = null, mechanic_notes = ? WHERE service_id = " + service_id);
				pstmt.setInt(1, service_id);
				pstmt.setString(2, status);
				pstmt.setString(3, mechanic);
				pstmt.setString(4, mechanic_notes);
				pstmt.executeUpdate();
				getServletContext().setAttribute("error", null);
				getServletContext().getRequestDispatcher("/admin/services.jsp?success=1").forward(req, resp);
			}
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
