<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
if(session.getAttribute("ida") != null) {
	String ida = session.getAttribute("ida").toString();
	String username = session.getAttribute("admin").toString();
} else {
	response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Add Service Type - AutoMech Administrator</title>
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
				<li class="nav-item">
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
				<li class="nav-item active">
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
						<h1 class="h3 mb-4 text-gray-800">Add Service Type</h1>
						<div class="container col-md-5">
							<form action="createServiceType" class="user" method="post" onsubmit="return confirm('Add this new motorbike service type?');">
								<div class="card">
									<div class="card-body">
										<fieldset class="form-group">
											<%
											Random r = new Random();
											int n = r.nextInt(90) + 10;
											%>
											<label>Service code</label>
											<input type="text" class="form-control form-control-user" id="service_code" name="service_code" value="ST<%=n%>" style="background: white;" readonly>
											<label>Name</label>
											<input type="text" class="form-control form-control-user" id="name" name="name" maxlength="50" required="required">
											<label>Price (RM)</label>
											<input type="number" class="form-control form-control-user" id="price" name="price" required="required">
										</fieldset>
										<input class="btn btn-primary btn-user" type="submit" value="Add service type">
									</div>
								</div>
							</form>
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
