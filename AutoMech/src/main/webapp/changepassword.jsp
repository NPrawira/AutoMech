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
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Change Password | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="support/navbar.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-body p-4 p-sm-5">
	            			<form action="changePassword" method="post" onsubmit="return validate();">
	            				<h1 class="card-title text-center mb-5 fw-bold fs-5">Change Password</h1>
	            				<input name="id" type="hidden" value="<%=session.getAttribute("idc")%>">
	            				<div class="form-floating mb-3">
					            	<input type="password" class="form-control" id="oldpass" name="oldpass" placeholder="Old password" required>
									<label for="password">Old password</label>
								</div>
	              				<div class="form-floating mb-3">
					            	<input type="password" class="form-control" id="newpass" name="newpass" placeholder="New password" required>
									<label for="password">New password</label>
								</div>
								<div class="form-floating mb-3">
					            	<input type="password" class="form-control" id="confirmpass" name="confirmpass" placeholder="Confirm new password" required>
									<label for="password">Confirm new password</label>
								</div>
								<p style="color: red;">
								<%
								if(request.getParameter("error") != null) {
              						out.print("Error in resetting your password. Please try again.");
								}
								%>
								</p>
								<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary btn-login fw-bold" type="submit" value="Change password" onclick="return confirm('Do you want to change your password?');">
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
        	var newpass = document.getElementById("newpass");
			var confirmpass = document.getElementById("confirmpass");
        	function validate() {
				if(newpass.value != confirmpass.value) {
					confirmpass.setCustomValidity("Password confirmation failed.");
				} else {
					confirmpass.setCustomValidity("");
				}
        	}
			newpass.onchange = validate;
			confirmpass.onkeyup = validate;
		</script>
	</body>
</html>
