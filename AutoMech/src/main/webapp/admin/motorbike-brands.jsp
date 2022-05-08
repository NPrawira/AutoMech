<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("ida") != null) {
	String ida = session.getAttribute("ida").toString();
	String username = session.getAttribute("admin").toString();
} else {
	response.sendRedirect("login.jsp");
}

Class.forName("com.mysql.cj.jdbc.Driver");	
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Motorbike Brands - AutoMech Administrator</title>
		<jsp:include page="support/head.jsp"></jsp:include>
	</head>
	<body id="page-top">
		<div id="wrapper">
			<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
				<a class="sidebar-brand d-flex align-items-center justify-content-center" href="customers.jsp">
					<div class="sidebar-brand-text mx-3">Automech Administrator</div>
				</a>
				<hr class="sidebar-divider my-0">
				<li class="nav-item">
					<a class="nav-link" href="customers.jsp">
						<i class="fas fa-fw fa-users"></i>
						<span>Customers</span>
					</a>
				</li>
				<hr class="sidebar-divider">
				<div class="sidebar-heading">
					Motorbike Service
				</div>
				<li class="nav-item">
					<a class="nav-link" href="motorbikes.jsp">
						<i class="fas fa-fw fa-motorcycle"></i>
						<span>Motorbikes</span>
					</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="motorbike-brands.jsp">
						<i class="fas fa-fw fa-copyright"></i>
						<span>Motorbike Brands</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="mechanics.jsp">
						<i class="fas fa-fw fa-screwdriver"></i>
						<span>Mechanics</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="service-types.jsp">
						<i class="fas fa-fw fa-tape"></i>
						<span>Service Types</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="services.jsp">
						<i class="fas fa-fw fa-tags"></i>
						<span>Service Queries</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="service-payments.jsp">
						<i class="fas fa-fw fa-cash-register"></i>
						<span>Payments</span>
					</a>
				</li>
				<hr class="sidebar-divider">
				<div class="sidebar-heading">
					Spare Parts Sales
				</div>
				<li class="nav-item">
					<a class="nav-link" href="products.jsp">
						<i class="fas fa-fw fa-box"></i>
						<span>Products</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="orders.jsp">
						<i class="fas fa-fw fa-receipt"></i>
						<span>Orders</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="sparepart-payments.jsp">
						<i class="fas fa-fw fa-cash-register"></i>
						<span>Payments</span>
					</a>
				</li>
				<hr class="sidebar-divider d-none d-md-block">
				<div class="text-center d-none d-md-inline">
					<button class="rounded-circle border-0" id="sidebarToggle"></button>
				</div>
			</ul>
			<div id="content-wrapper" class="d-flex flex-column">
				<div id="content">
					<jsp:include page="support/navtop.jsp"></jsp:include>
					<div class="container-fluid">
						<h1 class="h3 mb-4 text-gray-800">Motorbike Brands</h1>
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">Motorbike Brands List</h6>
							</div>
							<div class="card-body">
								<form class="user">
									<div class="text-left">
										<a href="motorbike-brands-add.jsp" class="btn btn-success btn-user">
											<i class="fa fa-plus"></i>&nbsp;&nbsp;New brand
										</a>
									</div>
								</form>
								<hr>
								<div class="table-responsive">
									<table class="table table-bordered" width="100%" cellspacing="0">
										<thead>
											<tr class="bg-dark text-white text-center" style="font-weight: bold;">
												<td>Name</td>
												<td>Action</td>
											</tr>
										</thead>
										<tbody>
											<%
				                			ResultSet rs = stmt.executeQuery("SELECT * FROM motorbike_brands ORDER BY name ASC");
					                        while(rs.next()) {
					                        	int motorbike_brand_id = rs.getInt("motorbike_brand_id");
					                        	String name = rs.getString("name");
				                        	%>
											<tr>
												<td><% out.print(name); %></td>
												<td class="text-center">
													<form action="motorbike-brands-edit.jsp" class="user" method="post" style="display: inline;">
														<input type="hidden" value="<% out.print(motorbike_brand_id); %>" name="brand">
														<button class="btn btn-warning btn-user" type="submit">
															<i class="fa fa-file"></i>&nbsp;&nbsp;Manage
														</button>
													</form>
													<form action="deleteBrand" class="user" method="post" style="display: inline;" onsubmit="return confirm('Do you want to delete this motorbike brand?');">
														<input type="hidden" value="<% out.print(motorbike_brand_id); %>" name="brand">
														<button class="btn btn-danger btn-user" type="submit">
															<i class="fa fa-trash"></i>&nbsp;&nbsp;Delete
														</button>	        
													</form>
												</td>
											</tr>
											<% } %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<jsp:include page="support/footer.jsp"></jsp:include>
			</div>
		</div>
		<jsp:include page="support/scroll-modal.jsp"></jsp:include>
		<jsp:include page="support/scripts.jsp"></jsp:include>
	</body>
</html>
