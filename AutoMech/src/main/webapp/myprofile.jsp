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

ResultSet rs = stmt.executeQuery("SELECT * FROM customers WHERE name = '" + name + "'");
rs.next();
%>
<!DOCTYPE html>
<html>
	<head>
        <title><%=rs.getString("name")%>'s Profile | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="support/navbar.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-md-12 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-body p-4 p-sm-5">
							<h1 class="card-title text-center mb-5 fw-bold fs-5">My Profile</h1>
	            			<form action="editCustomer" method="post" onsubmit="return validate();">
	            				<input type="hidden" id="customer_id" name="customer_id" value="<%=rs.getInt("customer_id")%>">
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="text" class="form-control" id="name" name="name" placeholder="Full name" value="<%=rs.getString("name")%>" required maxlength="30">
		                				<label for="name">Full name</label>
		              				</div>
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="email" class="form-control" id="email" name="email" placeholder="Email" value="<%=rs.getString("email")%>" required maxlength="30">
		                				<label for="email">Email</label>
		              				</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-6 mb-3">
						            	<input type="tel" class="form-control" id="phone_no" name="phone_no" placeholder="Phone number" value="<%=rs.getString("phone_no")%>" required maxlength="20">
						            	<label for="phone_no">Phone number</label>
									</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="text" class="form-control" id="postal_code" name="postal_code" placeholder="Postal code" value="<%=rs.getInt("postal_code")%>" required maxlength="5">
						            	<label for="postal_code">Postal code</label>
									</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-12 mb-3">
	              						<textarea class="form-control" id="address" name="address" placeholder="Address" style="height:100px" required maxlength="100"><%=rs.getString("address")%></textarea>
	              						<label for="address">Address</label>
									</div>
	              				</div>
	              				<div class="column">
	              					<p style="color: red; display: inline;">
	              					<%
									if(request.getParameter("error") != null) {
										out.print("An error occurred. Please try again.");
									}
									%>
	              					</p>
	              					<p style="color: green; display: inline;">
	              					<%
									if(request.getParameter("success") != null) {
										out.print("Your profile has been updated.");
									}
									%>
	              					</p>
	              				</div>
								<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary fw-bold" type="submit" id="update" name="update" value="Confirm" onclick="return confirm('Do you want to update your profile?');">
								</div>
							</form>
							<br>
							<a href="changepassword.jsp">
								<button class="btn btn-info fw-bold col-md-12 mb-3">Change password</button>
							</a>
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
	  	<!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
        	function validate() {
        		
        	}
        </script>
	</body>
</html>
