<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
String name = null;
if(session.getAttribute("idc") != null) {
	String id = session.getAttribute("idc").toString();	
	name = session.getAttribute("customer").toString();
} else {
	response.sendRedirect("login.jsp");
}

String motorbike = request.getParameter("proceed");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();
%>
<!DOCTYPE html>
<html>
	<head>
		<title>New Service Request | AutoMech</title>
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
                            <a class="nav-link active dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><%out.print(name);%></a>
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
							<h1 class="card-title text-center mb-5 fw-bold fs-5">New Service Request</h1>
	            			<form action="createService" method="post" onsubmit="return validate();">
	            				<input type="hidden" id="customer" name="customer" value="<%out.print(name);%>">
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="text" class="form-control" id="license_plate" name="license_plate" placeholder="License plate" value="<%out.print(motorbike);%>" style="background: white;" readonly>
		                				<label for="license_plate">License plate</label>
		              				</div>
		              				<%
									Random r = new Random();
									int n = r.nextInt(9000000) + 1000000;
									%>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="text" class="form-control" id="service_tag" name="service_tag" placeholder="Service tag" value="SRV<%=n%>" style="background-color: white" readonly>
						            	<label for="service_tag">Service tag</label>
									</div>
	              				</div>
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="date" class="form-control" id="start_date" name="start_date" placeholder="Request date" onclick="validDate()" required>
		                				<label for="start_date">Request date</label>
		              				</div>
		              				<div class="form-floating col-md-6 mb-3">
		                				<select class="form-control" id="service_type" name="service_type" required>
		                					<option disabled="disabled" selected="selected">Select service type...</option>
		                					<%
		                					ResultSet type = null;
			                				type = stmt.executeQuery("SELECT * FROM service_types ORDER BY name ASC");
			                				while(type.next()) {
			                				%>
			                				<option value="<%=type.getString("name") %>"><%= type.getString("name")%></option>
			                				<% } %>
		                				</select>
		              				</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-12 mb-3">
	              						<textarea class="form-control" id="customer_notes" name="customer_notes" placeholder="Your service notes" style="height:100px" required maxlength="100"></textarea>
	              						<label for="customer_notes">Your service notes</label>
									</div>
	              				</div>
	              				<input type="hidden" id="payment_no" name="payment_no" value="PYS<%=n%>">
	              				<div class="column">
	              					<p style="color: red;">
	              					<%
									if(request.getParameter("error") != null) {
										out.print("An error occurred. Please try again.");
									}
	              					if(request.getParameter("limit") != null) {
	              						out.print("Selected date for your service request is already full. Please select another date.");
	              					}
									%>
	              					</p>
	              				</div>
								<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary fw-bold" type="submit" id="createservice" name="createservice" value="Submit service request" onclick="return confirm('Submit service request for this motorbike?');">
								</div>
							</form>
	          			</div>
	        		</div>
	      		</div>
	    	</div>
	  	</div>
	  	<jsp:include page="support/footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
	        function validDate(){
	    	    var today = new Date().toISOString().split('T')[0];
	    	    var nextWeekDate = new Date(new Date().getTime() + 6 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]
	    	    document.getElementsByName("start_date")[0].setAttribute('min', today);
	    	    document.getElementsByName("start_date")[0].setAttribute('max', nextWeekDate)
	    	}
		</script>
	</body>
</html>
