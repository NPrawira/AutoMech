<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String id = null;
String name = null;
if(session.getAttribute("idc") != null) {
	id = session.getAttribute("idc").toString();
	name = session.getAttribute("customer").toString();
} else {
	response.sendRedirect("login.jsp");
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Motorbike Service | AutoMech</title>
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
        <div class="container">
        	<br><br>
			<h2 class="d-flex justify-content-center">Motorbike Services List</h2>
			<br>
			<form action="searchservice.jsp" method="get" name="search" onsubmit="return validate();">
				<div class="row">
					<div class='col-md-10 mb-3'>
						<input class="form-control" type="text" placeholder="Search service tag..." aria-label="Search" id="service" name="service">    
					</div>
					<div class='col-md-1 mb-3'>
						<input type="submit" class="btn btn-info" value="Search">
					</div>
					<div class='col-md-1 mb-3'>
						<a href="myservices.jsp" type="submit" class="btn btn-danger">Reset</a>		
					</div>
				</div>
			</form>
			<hr>
			<div class="table-responsive">
				<table id="tblService" class="table table-bordered">
                	<thead>
						<tr class="bg-secondary text-white" style="font-weight: bold; text-align: center">
	                		<td>Service tag</td>
	                		<td>License plate</td>
	                		<td>Service type</td>
	                		<td>Status</td>
	                		<td>Action</td>
	                	</tr>
					</thead>
                	<tbody>
                		<%
                		ResultSet rs = stmt.executeQuery("SELECT * FROM services WHERE customer = '" + name + "'");
	           			if(!rs.isBeforeFirst()) {
	                   	%>
                   		<tr style="text-align: center; background-color: gray; color: white;"><td colspan="5">No service queries.</td></tr>
                   		<%
                   		} else {
                   			while(rs.next()) {
                   				int service_id = rs.getInt("service_id");
                   				String service_tag = rs.getString("service_tag");
                   				String motorbike = rs.getString("motorbike");
                   				String service_type = rs.getString("service_type");
                   				String status = rs.getString("status");
						%>
                    	<tr>
                        	<td><%out.println(service_tag);%></td>
                			<td><%out.println(motorbike);%></td>
                			<td><%out.println(service_type);%></td>
                			<td class="text-center">
								<% if(status.equals("Requested")) { %>
								<p style="display: inline; color: gray; padding: 5px"><%out.println(status);%></p>
								<% } else if(status.equals("Cancelled")) { %>
								<p style="display: inline; background-color: red; color: #FFCCBB; padding: 5px"><%out.println(status);%></p>
								<% } else if(status.equals("In service")) { %>
								<p style="display: inline; background-color: orange; color: #FFFF00; padding: 5px"><%out.println(status);%></p>
								<% } else if(status.equals("Finished")) { %>
								<p style="display: inline; background-color: green; color: #90EE90; padding: 5px"><%out.println(status);%></p>
								<% } %>
							</td>
                    		<td class="text-center">
                    			<form action="view-service.jsp" method="post" style="display: inline;">
                    				<input type="hidden" value="<%out.println(service_id);%>" name="view">
                    				<input type="submit" class="btn btn-primary btn-user" value="View">
                    			</form>
                    		</td>
                    	</tr>
						<%
	                    	}
	                   	}
	           			%>
					</tbody>
               	</table>
			</div>
			<br>
        </div>
        <br>
        <footer class="py-4 text-center text-medium navbar-dark bg-secondary" style="color:white">
			<div class="container">
				<h6 class="list-inline-item" style="color: white; padding:10px">Copyright &copy; AutoMech 2022</h6>
			</div>
		</footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
	        function validate() {
	        	var search = document.forms["search"]["service"].value;
	        	if (search == null || search == "") {
	        		alert("Enter your search!");
	        		return false;
	            }
	    	}
        </script>
    </body>
</html>
