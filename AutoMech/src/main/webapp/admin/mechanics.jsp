<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");	
	Connection con = null; 
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
	Statement stmt = con.createStatement();
	ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Mechanics - AutoMech Administrator</title>
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
                    <span>Customers</span></a>
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
            <li class="nav-item active">
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
                	<!-- Page Heading -->
                	<h1 class="h3 mb-4 text-gray-800">Mechanics</h1>
                	<div class="card shadow mb-4">
                		<div class="card-header py-3">
                			<h6 class="m-0 font-weight-bold text-primary">Mechanics List</h6>
                		</div>
                		<div class="card-body">
	                		<div class="text-left">
								<a href="mechanics-form.jsp" type="button" class="btn btn-success btn-user">Add new mechanic</a>
							</div>
							<hr>
                			<div class="table-responsive">
                				<table id="tb_matakuliah" class="table table-bordered" width="100%" cellspacing="0">
                					<thead>
										<tr class="bg-dark text-white" style="font-weight: bold; text-align: center">
	                						<td>Name</td>
	                						<td>Specialization</td>
	                						<td>Action</td>
	                					</tr>
									</thead>
									<%
	                					rs = stmt.executeQuery("SELECT * FROM mechanics");
		                        		while(rs.next()) {
	                        		%>
                					<tbody>
                						<tr>
											<td><% out.println(rs.getString(2)); %></td>
											<td><% out.println(rs.getString(3)); %></td>
											<td style="text-align: center;">
												<form action="mechanics-form.jsp" method="post">
													<input type="hidden" value="<% out.println(rs.getString(1)); %>" name="mechanic">
				        							<input type="submit" class="btn btn-warning btn-user" value="Manage">
				        						</form>
											</td>
										</tr>
									</tbody>
									<% } %>
                				</table>
                			</div>
                		</div>
                	</div>
                </div>
            </div>
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; AutoMech 2022</span>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <jsp:include page="support/scroll-modal.jsp"></jsp:include>
    <jsp:include page="support/scripts.jsp"></jsp:include>
</body>
</html>
