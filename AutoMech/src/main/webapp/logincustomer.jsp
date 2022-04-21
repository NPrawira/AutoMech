<%@ page import="java.sql.*"%>
<%
Class.forName("com.mysql.cj.jdbc.Driver"); 

Connection con = null; 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();

String email = request.getParameter("email");
String password = request.getParameter("password");

ResultSet rs = null;

try {
	rs = stmt.executeQuery("SELECT COUNT(*) FROM customers WHERE email = '" + email + "' AND password = '" + password + "'"); 
} catch(Exception e) {
	session.setAttribute("val", "1");
	response.sendRedirect("login.jsp");	
}

rs.next();
if(!rs.getString(1).equals("0")) {	
	try {
		rs = stmt.executeQuery("SELECT * FROM customers WHERE email = '" + email + "' AND password = '" + password + "'"); 
		while(rs.next()) {
			if(rs.getString(2).equals(email) || rs.getString(3).equals(email) && rs.getString(4).equals(password)) {
				session.setAttribute("idc", rs.getString(1));
				session.setAttribute("customer", rs.getString(2));
			    session.setAttribute("val", "0");
			    response.sendRedirect("index.jsp");
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
