package automech;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/createCustomer")
public class CreateCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String phone_no = req.getParameter("phone_no");
		String address = req.getParameter("address");
		int postal_code = Integer.parseInt(req.getParameter("postal_code"));
		
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
			pstmt = con.prepareStatement("INSERT INTO customers(name, email, password, phone_no, address, postal_code) VALUES(?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, password);
			pstmt.setString(4, phone_no);
			pstmt.setString(5, address);
			pstmt.setInt(6, postal_code);
			pstmt.executeUpdate();
			getServletContext().setAttribute("error", null);
			getServletContext().getRequestDispatcher("/login.jsp?success=1").forward(req, resp);
		} catch(SQLException e) {
			getServletContext().getRequestDispatcher("/register.jsp?error=1").forward(req, resp);		
			System.out.println(e);
		} finally {
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
		}
	}
	
}
