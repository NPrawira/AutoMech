<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("idc") != null) {
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>New Customer Registration | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="support/navbar.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-md-12 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-body p-4 p-sm-5" id="regist">
							<h1 class="card-title text-center mb-5 fw-bold fs-5">New Customer Registration</h1>
	            			<form action="createCustomer" method="post" onsubmit="return validate();">
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="text" class="form-control" id="name" name="name" placeholder="Full name" required maxlength="30">
		                				<label for="name">Full name</label>
		              				</div>
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="email" class="form-control" id="email" name="email" placeholder="Email" required maxlength="30">
		                				<label for="email">Email</label>
		              				</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-6 mb-3">
						            	<input type="password" class="form-control" id="password" name="password" placeholder="Password" required maxlength="20">
						            	<label for="password">Password</label>
									</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="tel" class="form-control" id="phone_no" name="phone_no" placeholder="Phone number" required maxlength="20">
						            	<label for="phone_no">Phone number</label>
									</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-10 mb-3">
	              						<textarea class="form-control" id="address" name="address" placeholder="Address" style="height:100px" required maxlength="100"></textarea>
	              						<label for="address">Address</label>
									</div>
		              				<div class="form-floating col-md-2 mb-3">
						            	<input type="number" class="form-control" id="postal_code" name="postal_code" placeholder="Postal code" required maxlength="5">
						            	<label for="postal_code">Postal code</label>
									</div>
	              				</div>
	              				<p style="color: red;">
								<%
								if(request.getParameter("error") != null) {
									out.print("An error occurred. Please retry the registration.");
								}
								%>
								</p>
	              				<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary fw-bold" type="submit" id="register" name="register" value="Register">
								</div>
							</form>
	          			</div>
	          			<div class="card-footer" style="padding:25px">
	          				<div class="d-flex justify-content-center links">I have an account:
								&nbsp;<a href="login.jsp">Login</a>
							</div>
						</div>
	        		</div>
	      		</div>
	    	</div>
	  	</div>
	  	<jsp:include page="support/footer.jsp"></jsp:include>
	  	<!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
	        var email = document.getElementById("email");
			var email_pattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			
			var phone_no = document.getElementById("phone_no");
			var phone_pattern = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
			
        	var password = document.getElementById("password");
			var password_pattern = ;
			
        	function validate() {
        		if(email.value.match(email_pattern)) {
    				email.setCustomValidity("");
    			} else {
    				email.setCustomValidity("Enter a correct email format.");
    			}
        		
        		if(phone_no.value.match(phone_pattern)) {
    				phone_no.setCustomValidity("");
    			} else {
    				phone_no.setCustomValidity("Enter a correct phone number format.");
    			}
        		
				if(password.value.match(password_pattern)) {
					password.setCustomValidity("");
				} else {
					password.setCustomValidity("Password cannot be like this.");
				}
        	}
		</script>
	</body>
</html>
