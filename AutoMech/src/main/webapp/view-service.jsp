<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String idc = null;
String name = null;
if(session.getAttribute("idc") != null) {
	idc = session.getAttribute("idc").toString();
	name = session.getAttribute("customer").toString();
} else {
	response.sendRedirect("login.jsp");
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();

String service_id = request.getParameter("view");
ResultSet rs = stmt.executeQuery("SELECT * FROM services WHERE service_id = " + service_id);
rs.next();
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Service tag <%out.println(rs.getString("service_tag"));%> | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body>
		<nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
			<div class="container">
		    	<h3><a class="navbar-brand" href="index.jsp">AutoMech</a></h3>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="mymotorbikes.jsp">Motorbikes</a>
				       	</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="myservices.jsp">Services</a>
				       	</li>
				       	<li class="nav-item">
							<a class="nav-link" aria-current="page" href="myservicepayments.jsp">Payments</a>
				       	</li>
				       	<li class="nav-item dropdown">
                            <a class="nav-link active dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><%out.print(session.getAttribute("customer"));%></a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <li>
									<a class="dropdown-item" href="myprofile.jsp"><i class="fa fa-user" style="padding:10px"></i>My Profile</a>
				       			</li>
				       			<li>
				            		<a class="dropdown-item" href="logout.jsp" onclick="return confirm('Do you want to logout?');"><i class="fa fa-sign-out" style="padding:10px"></i>Logout</a>
				            	</li>
                            </ul>
                        </li>
		        	</ul>
		    	</div>
			</div>
		</nav>
		<br>
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-md-6 col-lg-6 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-header p-4 p-sm-4 bg-primary">
							<h5 class="pull-left text-white" style="display: inline;">Service tag 
							<%out.println(rs.getString("service_tag"));%></h5>
							<form name="service_status">
								<% if(rs.getString("status").equals("Requested")) { %>
								<h6 class="pull-right text-uppercase bg-white" style="display: inline; color: gray; padding: 5px"><%out.println(rs.getString("status"));%></h6>
								<% } else if(rs.getString("status").equals("Cancelled")) { %>
								<h6 class="pull-right text-uppercase" style="display: inline; background-color: red; color: #FFCCBB; padding: 5px"><%out.println(rs.getString("status"));%></h6>
								<% } else if(rs.getString("status").equals("In service")) { %>
								<h6 class="pull-right text-uppercase" style="display: inline; background-color: orange; color: #FFFF00; padding: 5px"><%out.println(rs.getString("status"));%></h6>
								<% } else if(rs.getString("status").equals("Finished")) { %>
								<h6 class="pull-right text-uppercase" style="display: inline; background-color: green; color: #90EE90; padding: 5px"><%out.println(rs.getString("status"));%></h6>
								<% } %>
							</form>
						</div>
						<div class="card-body p-3 p-sm-3">
	            			<table class="table table-responsive table-borderless table-sm">
								<tr>
									<td><h6>Motorbike</h6></td>
								    <td><%out.println(rs.getString("motorbike"));%></td>
								</tr>
								<tr>
									<td><h6>Request date</h6></td>
								    <td><%out.println(rs.getDate("start_date"));%></td>
								</tr>
								<tr>
									<td><h6>Service type</h6></td>
								    <td><%out.println(rs.getString("service_type"));%></td>
								</tr>
								<tr>
									<td><h6>Customer notes</h6></td>
									<td><%out.println(rs.getString("customer_notes"));%></td>
								</tr>
							</table>
							<hr>
							<table class="table table-responsive table-borderless table-sm">
								<tr>
								    <% if(rs.getDate("finish_date") != null && rs.getString("status") != "Cancelled") { %>
								    <td><h6>Finish date</h6></td>
								    <td><%out.println(rs.getDate("finish_date"));%></td>
								    <% } %>
								</tr>
								<tr>
									<% if(rs.getString("mechanic") != null && rs.getString("status") != "Cancelled") { %>
								    <td><h6>Mechanic name</h6></td>
								    <td><%out.println(rs.getString("mechanic"));%></td>
								    <% } %>
								</tr>
								<tr>
								    <% if(!rs.getString("mechanic_notes").equals("") && rs.getString("status") != "Cancelled") { %>
								    <td><h6>Mechanic notes</h6></td>
								    <td><%out.println(rs.getString("mechanic_notes"));%></td>
								    <% } %>
								</tr>
							</table>
							<% if(rs.getString("status").equals("Requested")) { %>
							<div class="text-center">
								<form action="cancelService" method="post" onsubmit="return confirm('Do you want to cancel this service request?');">
									<input type="hidden" value="<% out.println(rs.getInt("service_id")); %>" name="cancel_service">
					        		<input type="submit" class="btn btn-danger btn-user" value="Cancel service request">
								</form>
							</div>
							<% } %>
	          			</div>
	        		</div>
	      		</div>
	    	</div>
	  	</div>
	  	<footer class="py-4 text-center text-medium navbar-dark bg-secondary" style="color:white">
			<div class="container">
				<h6 class="list-inline-item" style="color: white; padding:10px">Copyright &copy; AutoMech 2022</h6>
			</div>
		</footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
        	
		</script>
	</body>
</html>
