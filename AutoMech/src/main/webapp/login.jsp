<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("idc") != null) {
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Login | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="support/navbar.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-body p-4 p-sm-5">
	            			<form action="logincustomer.jsp" id="formLogin" name="formLogin" method="post" onsubmit="return validate();">
	            				<h1 class="card-title text-center mb-5 fw-bold fs-5">Login</h1>
	            				<p style="color: green;">
	              				<%
								if(request.getParameter("success") != null) {
									out.print("Registration success. Please login.");
								}
								%>
	              				</p>
	            				<div class="form-floating mb-3">
	                				<input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
	                				<label for="email">Email</label>
	              				</div>
	              				<div class="form-floating mb-3">
					            	<input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
									<label for="password">Password</label>
								</div>
								<p style="color: red;">
	              				<%
	              				try {
	              					if(session.getAttribute("val").equals("1")) {
	          							out.print("Email or password is incorrect!");
	                            	}
	              				} catch(Exception e) {}
								%>
								</p>
								<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary btn-login fw-bold" type="submit" id="btnLogin" name="btnLogin" value="Login">
								</div>
							</form>
	          			</div>
	          			<div class="card-footer" style="padding:25px">
	          				<div class="d-flex justify-content-center links">I don't have an account:
								&nbsp;<a href="register.jsp">Register</a>
							</div>
							<div class="d-flex justify-content-center"></div>
							<div class="d-flex justify-content-center links">I forgot my password:
								&nbsp;<a href="resetpassword.jsp">Reset</a>
							</div>
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
			function validate() {
				
			}
		</script>
	</body>
</html>
