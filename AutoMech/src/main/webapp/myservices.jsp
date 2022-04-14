<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	String id = null;
	if(session.getAttribute("idc") != null) {
		id = session.getAttribute("idc").toString();		
	} else {
		response.sendRedirect("login.jsp");
	}
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
        	<br>
			<br>
			<h2 class="d-flex justify-content-center">Motorbike Services List</h2>
			<br>
			<form action="" method="get">
				<div class="row">
					<div class='col-md-10 mb-3'>
						<input class="form-control" type="text" placeholder="Search service tag..." aria-label="Search" id="searchservice" name="searchservice">    
					</div>
					<div class='col-md-1 mb-3'>
						<input type="submit" class="btn btn-info" value="Search">
					</div>
					<div class='col-md-1 mb-3'>
						<input type="submit" class="btn btn-danger" value="Reset">		
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
                		<tr style="text-align: center; background-color: gray; color: white;"><td colspan="5">No service queries.</td></tr>
                			<tr>
								<td>SRV1</td>
								<td>B1234ABC</td>
								<td>Lubricant refill</td>
								<td>In service</td>
								<td style="text-align: center">
									<form action="" method="post">
										<input type="hidden" value="" name="manage">
					        			<input type="submit" class="btn btn-warning btn-user" value="Manage">
									</form>
								</td>
							</tr>
					</tbody>
               	</table>
			</div>
			<br>
        </div>
        <jsp:include page="support/footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
