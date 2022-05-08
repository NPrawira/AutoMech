<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("ida") != null) {
	response.sendRedirect("customers.jsp");
}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Login - AutoMech Administrator</title>
		<jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body class="bg-gradient-primary">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-xl-10 col-lg-12 col-md-9">
					<div class="card o-hidden border-0 shadow-lg my-5">
						<div class="card-body p-0">
							<div class="row">
								<div class="col-lg-12">
									<div class="p-5">
										<div class="text-center">
											<h1 class="h4 text-gray-900 mb-4">AutoMech Administrator</h1>
										</div>
										<form action="loginadmin.jsp" class="user" id="formLogin" name="formLogin" method="post" onsubmit="return validate();">
											<div class="form-group">
												<input type="text" class="form-control form-control-user" id="username" name="username" placeholder="Username">
											</div>
											<div class="form-group">
												<input type="password" class="form-control form-control-user" id="password" name="password" placeholder="Password">
											</div>
	                                        <p style="color: red;">
				              				<%
				              				try {
				              					if(session.getAttribute("val").equals("1")) {
				          							out.print("Username or password is incorrect!");
				                            	}
				              				} catch(Exception e) {}
											%>
											</p>
											<input class="btn btn-primary btn-user btn-block" type="submit" value="Login">
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
	            </div>
			</div>
		</div>
		<jsp:include page="support/scripts.jsp"></jsp:include>
	</body>
</html>
