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

String motorbike_id = request.getParameter("manage");
ResultSet rs = stmt.executeQuery("SELECT * FROM motorbikes WHERE motorbike_id = " + motorbike_id);
rs.next();
String type = rs.getString("type");
String brand = rs.getString("brand");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Manage <%out.println(rs.getString("license_plate"));%> | AutoMech</title>
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
							<a class="nav-link active" aria-current="page" href="mymotorbikes.jsp">Motorbikes</a>
				       	</li>
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="myservices.jsp">Services</a>
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
			<div class="row">
				<div class="col-md-12 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-body p-4 p-sm-5">
							<h1 class="card-title text-center mb-5 fw-bold fs-5">Manage Motorbike</h1>
	            			<form action="editMotorbike" method="post" onsubmit="return validate();">
	            				<input type="hidden" id="motorbike_id" name="motorbike_id" value="<%=rs.getInt("motorbike_id")%>">
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="text" class="form-control" id="licenseplate" name="licenseplate" placeholder="License plate" value="<%out.println(rs.getString("license_plate"));%>" required>
		                				<label for="licenseplate">License plate</label>
		              				</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="text" class="form-control" id="owner" name="owner" placeholder="Owner" value="<%out.println(rs.getString("owner"));%>" style="background: white;" readonly>
						            	<label for="owner">Owner</label>
									</div>
	              				</div>
	              				<div class="row">
									<div class="form-floating col-md-6 mb-3">
				                		<input type="text" class="form-control" id="model" name="model" placeholder="Model" value="<%out.println(rs.getString("model"));%>" required>
				                		<label for="model">Model</label>
									</div>
				              		<div class="form-floating col-md-6 mb-3">
				                		<input type="number" class="form-control" id="kilometer" name="kilometer" placeholder="Odometer (km)" value="<%=rs.getInt("kilometer")%>" required>
				                		<label for="kilometer">Odometer (km)</label>
									</div>
			              		</div>
	              				<div class="row">
	              					<div class="form-floating col-md-6 mb-3">
		                				<select class="form-control" id="brand" name="brand" required>
		                					<option disabled="disabled" selected="selected">Select brand...</option>
		                					<%
		                					ResultSet rs1 = null;
		                					rs1 = stmt.executeQuery("SELECT * FROM motorbike_brands ORDER BY name ASC");
		                					while(rs1.next()) {	
			                				%>
			                				<option value="<%= rs1.getString("name") %>"><%= rs1.getString("name") %></option>
			                				<% } %>
		                				</select>
		                				<script type="text/javascript">
		                					document.getElementById("brand").value = <%out.print("'" + brand + "'"); %>;
			                            </script>
			                            <label for="brand">Brand</label>
		              				</div>
	              					<div class="form-floating col-md-6 mb-3">
			                			<select class="form-control" id="type" name="type" required>
		                					<option disabled="disabled" selected="selected">Select type...</option>
		                					<option value="Cruiser">Cruiser</option>
		                					<option value="Cub">Cub</option>
		                					<option value="Off-road">Off-road</option>
		                					<option value="Roadster">Roadster</option>
		                					<option value="Scooter">Scooter</option>
		                					<option value="Sport">Sport</option>
		                					<option value="Touring">Touring</option>
		                					<option value="Other">Other</option>
		                				</select>
		                				<script type="text/javascript">
		                					document.getElementById("type").value = <%out.print("'" + type + "'"); %>;
			                            </script>
			                            <label for="type">Type</label>
		              				</div>
	              				</div>
	              				<div class="column">
	              					<p style="color: red;">
	              					<%
									if(request.getParameter("error") != null) {
										out.print("An error occurred. Please try again.");
									}
									%>
	              					</p>
	              				</div>
								<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary fw-bold" type="submit" id="editmotorbike" name="editmotorbike" value="Confirm" onclick="return confirm('Do you want to update this motorbike?');">
								</div>
							</form>
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
