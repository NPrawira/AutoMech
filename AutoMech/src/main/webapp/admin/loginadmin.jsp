<%@ page import="java.sql.*"%>
<%
Class.forName("com.mysql.cj.jdbc.Driver"); 

Connection con = null; 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();

String username = request.getParameter("username");
String password = request.getParameter("password");

ResultSet rs = null;

try {
	rs = stmt.executeQuery("SELECT COUNT(*) FROM admin WHERE username = '" + username + "' AND password = '" + password + "'"); 
} catch(Exception e) {
	session.setAttribute("val", "1");
	response.sendRedirect("login.jsp");	
}

rs.next();
if(!rs.getString(1).equals("0")) {	
	try {
		rs = stmt.executeQuery("SELECT * FROM admin WHERE username = '" + username + "' AND password = '" + password + "'"); 
		while(rs.next()) {
			if(rs.getString("username").equals(username) && rs.getString("password").equals(password)) {
				session.setAttribute("admin", rs.getString("username"));
			    session.setAttribute("val", "0");
			    response.sendRedirect("customers.jsp");
			} else {
				session.setAttribute("val", "1");
				response.sendRedirect("login.jsp");
			}
		}
	} catch (Exception e) {
		out.println(e);
	}
} else {
	session.setAttribute("val", "1");
	response.sendRedirect("login.jsp");	
}
%>
