<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("idc") != null) {
	response.sendRedirect("index.jsp");
}

if(request.getParameter("reset") != null) {
	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
	Statement stmt = con.createStatement();

	String email = request.getParameter("email");
	String phone_no = request.getParameter("phone_no");
	String newpass = request.getParameter("newpass");
	String confirmpass = request.getParameter("confirmpass");

	ResultSet rs = null;
	try {
		rs = stmt.executeQuery("SELECT COUNT(*) FROM customers WHERE email = '" + email + "' AND phone_no = '" + phone_no + "'");
	} catch(Exception e) {
		e.printStackTrace();
	}

	rs.next();
	if(!rs.getString(1).equals("0")) {
		try {
			rs = stmt.executeQuery("SELECT * FROM customers WHERE email = '" + email + "' AND phone_no = '" + phone_no + "'");
			while(rs.next()) {
				if(rs.getString("email").equals(email) && rs.getString("phone_no").equals(phone_no) && newpass.equals(confirmpass)) {
					PreparedStatement pstmt = con.prepareStatement("UPDATE customers SET password = ? WHERE email = '" + email + "' AND phone_no = '" + phone_no + "'");
					pstmt.setString(1, newpass);
					pstmt.executeUpdate();
					getServletContext().getRequestDispatcher("/login.jsp?reset=1").forward(request, response);
				} else {
					getServletContext().getRequestDispatcher("/resetpassword.jsp?error=1").forward(request, response);
				}
			}
		} catch (SQLException e) {
			System.out.println(e);
		}
	} else {
		request.setAttribute("error", "Cannot find account with this email and/or phone number. Please try again.");
	}
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
	            			<form method="post" onsubmit="return validate();">
	              				<div class="row">
		              				<div class="form-floating col-md-6 mb-3">
		                				<input type="email" class="form-control" id="email" name="email" placeholder="Email" required maxlength="30">
		                				<label for="email">Email</label>
		              				</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="tel" class="form-control" id="phone_no" name="phone_no" placeholder="Phone number" required maxlength="20">
						            	<label for="phone_no">Phone number</label>
									</div>
	              				</div>
	              				<div class="row">
	              					<div class="form-floating col-md-6 mb-3">
						            	<input type="password" class="form-control" id="newpass" name="newpass" placeholder="New password" required maxlength="20">
						            	<label for="password">New password</label>
									</div>
		              				<div class="form-floating col-md-6 mb-3">
						            	<input type="password" class="form-control" id="confirmpass" name="confirmpass" placeholder="Confirm new password" required maxlength="20">
						            	<label for="password">Confirm new password</label>
									</div>
	              				</div>
	              				<div class="row">
	              					<p style="color: red; display: inline;">
	              					<%
			              			if(request.getAttribute("error") != null) {
			        					out.println(request.getAttribute("error"));
			        				} else if(request.getAttribute("wrong") != null) {
			        					out.println(request.getAttribute("wrong"));
			        				}
									%>
	              					</p>
	              					<p style="color: green; display: inline;">
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
			
        	var newpass = document.getElementById("newpass");
			var confirmpass = document.getElementById("confirmpass");
			
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
