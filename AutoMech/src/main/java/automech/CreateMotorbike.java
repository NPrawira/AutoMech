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

@WebServlet("/createMotorbike")
public class CreateMotorbike extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String licenseplate = req.getParameter("licenseplate");
		String owner = req.getParameter("owner");
		String type = req.getParameter("type").toString();
		String brand = req.getParameter("brand").toString();
		String model = req.getParameter("model");
		int kilometer = Integer.parseInt(req.getParameter("kilometer"));
		
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			PreparedStatement pstmt = con.prepareStatement("INSERT INTO motorbikes(license_plate, owner, type, brand, model, kilometer) VALUES(?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, licenseplate);
			pstmt.setString(2, owner);
			pstmt.setString(3, type);
			pstmt.setString(4, brand);
			pstmt.setString(5, model);
			pstmt.setInt(6, kilometer);
			pstmt.executeUpdate();
			getServletContext().setAttribute("error", null);
			getServletContext().getRequestDispatcher("/mymotorbikes.jsp?success=1").forward(req, resp);
		} catch(SQLException e) {
			getServletContext().getRequestDispatcher("/new-motorbike.jsp?error=1").forward(req, resp);		
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
