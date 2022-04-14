<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	try {
		if(session.getAttribute("idc") != null) {
			response.sendRedirect("index.jsp");
		}
	} catch(Exception e) {}
%>
<% 
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
		
		if(request.getParameter("reset") != null) {
			String email = request.getParameter("email");
			String phone_no = request.getParameter("phone_no");
			String newpass = request.getParameter("newpassword");
			String confirmpass = request.getParameter("confirmpassword");
			
			if(confirmpass.equals(newpass)) {
				PreparedStatement pstmt = null;
				pstmt = con.prepareStatement("UPDATE customers SET password = ? WHERE email = ? AND phone_no = ?");
				pstmt.setString(1, newpass);
				pstmt.setString(2, email);
				pstmt.setString(3, phone_no);
				pstmt.executeUpdate();
				request.setAttribute("success", "Your password has been reset.");
				con.close();	
			} else {
				request.setAttribute("wrong", "Password don't match.");
			}
		}
	} catch(Exception e) {
		System.out.print(e);
		request.setAttribute("error", "An error occurred. Please try again.");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Reset Password | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="support/navbar.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-md-12 mx-auto">
					<div class="card border-0 shadow rounded-3 my-5">
						<div class="card-body p-4 p-sm-5">
							<h1 class="card-title text-center mb-5 fw-bold fs-5">Reset Password</h1>
	            			<form method="post">
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
		                				<label for="email">Email</label>
		              				</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="tel" class="form-control" id="phone_no" name="phone_no" placeholder="Phone number" required>
						            	<label for="phone_no">Phone number</label>
									</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-6 mb-3">
						            	<input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="Password" required>
						            	<label for="password">New password</label>
									</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="password" class="form-control" id="confirmpassword" name="confirmpassword" placeholder="Password" required>
						            	<label for="password">Confirm new password</label>
									</div>
	              				</div>
	              				<div class="column">
	              					<p style="color: red;">
	              					<%
			              				if(request.getAttribute("error") != null) {
			        						out.println(request.getAttribute("error"));
			        					} 
										if(request.getAttribute("wrong") != null) {
			        						out.println(request.getAttribute("wrong"));
			        					}
									%>
	              					</p>
	              					<p style="color: green;">
	              					<%
			              				if(request.getAttribute("success") != null) {
			        						out.println(request.getAttribute("success"));
			        					}
									%>
	              					</p>
	              				</div>
								<hr class="my-4">
								<div class="d-grid">
				                	<input class="btn btn-primary fw-bold" type="submit" id="reset" name="reset" value="Reset">
								</div>
							</form>
	          			</div>
	          			<div class="card-footer" style="padding:25px">
	          				<div class="d-flex justify-content-center links">I remember my password:
								&nbsp;<a href="login.jsp">Back to Login</a>
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
	  	<!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
	</body>
</html>
