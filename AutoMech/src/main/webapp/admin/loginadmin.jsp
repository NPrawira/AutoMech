<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
	String user = request.getParameter("exampleInputText");
	String pass = request.getParameter("exampleInputPassword");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = null; 
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
	Statement stmt = con.createStatement();
	
	ResultSet rs = null;
	rs = stmt.executeQuery("SELECT COUNT(*) FROM admin WHERE username='" + user + "' AND password='" + pass + "'"); 
	rs.next();
	
	if(rs.getString(1).equals("1")) {
		rs = stmt.executeQuery("SELECT * FROM admin WHERE username='" + user + "' AND password='" + pass + "'"); 
		try {
			while(rs.next()) {
			    if(rs.getString(1).equals(user) && rs.getString(2).equals(pass)) {
			    	session.setAttribute("val", "1");
					response.sendRedirect("login.jsp");
				}
			}
		} catch (Exception e) {
			out.println(e);
		}
	} else {
		session.setAttribute("val", "0");
    	response.sendRedirect("customers.jsp");
	}
%>
