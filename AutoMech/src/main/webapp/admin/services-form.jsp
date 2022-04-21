<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 
String username = null;
if(session.getAttribute("username") != null) {
	username = session.getAttribute("username").toString();
} else {
	response.sendRedirect("login.jsp");
}
-->
<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = null;
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();

String id = request.getParameter("service");
ResultSet rs = null;
rs = stmt.executeQuery("SELECT * FROM services WHERE service_id = " + id);
rs.next();
String service_tag = rs.getString("service_tag");
String motorbike = rs.getString("motorbike");
String customer = rs.getString("customer");
Date start_date = rs.getDate("start_date");
String service_type = rs.getString("service_type");
String customer_notes = rs.getString("customer_notes");
String status = rs.getString("status");
Date finish_date = rs.getDate("finish_date");
String mechanic = rs.getString("mechanic");
String mechanic_notes = rs.getString("mechanic_notes");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Service Queries - AutoMech Administrator</title>
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
			<li class="nav-item active">
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
                	<h1 class="h3 mb-4 text-gray-800">Manage Service Query</h1>
                	<form class="user" id="service" name="service" action="updateService">
                		<div class="form-group row">
                			<div class="col-sm-4 mb-3 mb-sm-0">
                				<label>Service tag</label>
                				<input type="text" class="form-control" id="service_tag" name="service_tag" value="<%out.println(service_tag);%>" readonly>
                			</div>
                			<div class="col-sm-4">
                				<label>Motorbike</label>
                				<input type="text" class="form-control" id="motorbike" name="motorbike" value="<%out.println(motorbike);%>" readonly>
                			</div>
                			<div class="col-sm-4">
                				<label>Status</label>
                				<select class="form-control" class="form-control" id="status" name="status">
                					<option value="" disabled="disabled" selected="selected">Select status...</option>
                					<option value="In service">In service</option>
                					<option value="Finished">Finished</option>
                				</select>
                			</div>
                		</div>
                		<div class="form-group row">
                			<div class="col-sm-4 mb-3 mb-sm-0">
                				<label>Service type</label>
                				<input type="text" class="form-control" id="service_type" name="service_type" value="<%out.println(service_type);%>" readonly>
                			</div>
                			<div class="col-sm-4">
                				<label>Start date</label>
                				<input type="date" class="form-control" id="start_date" name="start_date" readonly>
                				<script type="text/javascript">
									document.getElementById("start_date").value = <%out.print("'"+start_date+"'"); %>;
								</script>
                			</div>
                			<div class="col-sm-4">
                				<label>Finish date</label>
                				<input type="date" class="form-control" id="finish_date" name="finish_date">
                			</div>
                		</div>
                		<div class="form-group row">
                			<div class="col-sm-4 mb-3 mb-sm-0">
                				<label>Customer</label>
                				<input type="text" class="form-control" id="customer" name="customer" value="<%out.println(customer);%>" readonly>
                			</div>
                			<div class="col-sm-8">
                				<label>Customer notes</label>
                				<input type="text" class="form-control" id="customer_notes" name="customer_notes" value="<%out.println(customer_notes);%>" readonly>
                			</div>
                		</div>
                		<div class="form-group row">
                			<div class="col-sm-4 mb-3 mb-sm-0">
                				<label>Mechanic</label>
                				<select class="form-control" id="mechanic" name="mechanic" required>
								<%
		                		try {
		                			ResultSet rs1 = null;
			                		rs1 = stmt.executeQuery("SELECT * FROM mechanics ORDER BY specialization ASC");
			                		while(rs1.next()) {
			                	%>
			                		<option value="<%= rs1.getString("name") %>"><%= rs1.getString("specialization") %> - <%= rs1.getString("name") %></option>
			                	<%	}
		                		} catch(Exception e) {}
		                		%>
		                		</select>
		                		<script type="text/javascript">
		                			
								</script>
                			</div>
                			<div class="col-sm-8">
                				<label>Mechanic notes</label>
                				<input type="text" class="form-control" id="mechanic_notes" name="mechanic_notes" value="<%out.println(mechanic_notes);%>">
                			</div>
                		</div>
                		<hr>
                		<input type="button" value="Update" class="btn btn-warning" />
                	</form>
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
