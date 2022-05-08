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

String service_id = request.getParameter("service");
ResultSet rs = stmt.executeQuery("SELECT * FROM services WHERE service_id = " + service_id);
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
                	<div class="container col-md-12">
	                	<form action="updateService" class="user" method="post" onsubmit="return confirm('Update this motorbike service progress?');">
	                		<input type="hidden" id="service_id" name="service_id" value="<%=rs.getInt("service_id")%>">
	                		<div class="form-group row">
	                			<div class="col-sm-4 mb-3 mb-sm-0">
	                				<label>Service tag</label>
	                				<input type="text" class="form-control form-control-user" id="service_tag" name="service_tag" value="<%out.println(service_tag);%>" style="background: white;" readonly="readonly">
	                			</div>
	                			<div class="col-sm-4">
	                				<label>Motorbike</label>
	                				<input type="text" class="form-control form-control-user" id="motorbike" name="motorbike" value="<%out.println(motorbike);%>" style="background: white;" readonly="readonly">
	                			</div>
	                			<div class="col-sm-4">
	                				<label>Status</label>
									<select class="form-control" id="status" name="status" required="required">
		                				<option disabled="disabled" selected="selected">Select status...</option>
		                				<option value="In service">In service</option>
		                				<option value="Finished">Finished</option>
		                			</select>
		                			<script type="text/javascript">
		                				document.getElementById("status").value = <%out.print("'" + status + "'"); %>;
									</script>
	                			</div>
	                		</div>
	                		<div class="form-group row">
	                			<div class="col-sm-4 mb-3 mb-sm-0">
	                				<label>Service type</label>
	                				<input type="text" class="form-control form-control-user" id="service_type" name="service_type" value="<%out.println(service_type);%>" style="background: white;" readonly="readonly">
	                			</div>
	                			<div class="col-sm-4">
	                				<label>Request date</label>
	                				<input type="date" class="form-control form-control-user" id="start_date" name="start_date" style="background: white;" readonly="readonly">
	                				<script type="text/javascript">
										document.getElementById("start_date").value = <%out.print("'" + start_date + "'");%>;
									</script>
	                			</div>
	                			<div class="col-sm-4">
	                				<label>Finish date</label>
	                				<% if(rs.getString("status").equals("Finished")) { %>
	                				<input type="date" class="form-control form-control-user" id="finish_date" name="finish_date" style="background: white;" readonly="readonly">
	                				<% } else { %>
	                				<input type="date" class="form-control form-control-user" id="finish_date" name="finish_date" onclick="validDate()">
	                				<% } %>
	                				<script type="text/javascript">
										document.getElementById("finish_date").value = <%out.print("'" + finish_date + "'");%>;
									</script>
	                			</div>
	                		</div>
	                		<div class="form-group row">
	                			<div class="col-sm-4 mb-3 mb-sm-0">
	                				<label>Customer</label>
	                				<input type="text" class="form-control form-control-user" id="customer" name="customer" value="<%out.println(customer);%>" style="background: white;" readonly="readonly">
	                			</div>
	                			<div class="col-sm-8">
	                				<label>Customer notes</label>
	                				<input type="text" class="form-control form-control-user" id="customer_notes" name="customer_notes" value="<%out.println(customer_notes);%>" style="background: white;" readonly="readonly">
	                			</div>
	                		</div>
	                		<div class="form-group row">
	                			<div class="col-sm-4 mb-3 mb-sm-0">
	                				<label>Mechanic</label>
									<select class="form-control" id="mechanic" name="mechanic" required="required">
		                				<option disabled="disabled" selected="selected">Select mechanic...</option>
		                				<%
		                				ResultSet rs1 = null;
		                				rs1 = stmt.executeQuery("SELECT * FROM mechanics ORDER BY specialization ASC");
		                				while(rs1.next()) {	
			                			%>
			                			<option value="<%= rs1.getString("name") %>"><%= rs1.getString("specialization") %> - <%= rs1.getString("name") %></option>
			                			<% } %>
		                			</select>
		                			<script type="text/javascript">
		                				document.getElementById("mechanic").value = <%out.print("'" + mechanic + "'"); %>;
									</script>
	                			</div>
	                			<div class="col-sm-8">
	                				<label>Mechanic notes</label>
	                				<input type="text" class="form-control form-control-user" id="mechanic_notes" name="mechanic_notes" value="<%out.println(mechanic_notes);%>">
	                			</div>
	                		</div>
	                		<hr>
	                		<input class="btn btn-warning btn-user" type="submit" value="Update">
	                	</form>
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
    <script type="text/javascript">
		function validDate(){
	    	var today = new Date().toISOString().split('T')[0];
	    	document.getElementsByName("finish_date")[0].setAttribute('min', today);
	    	document.getElementsByName("finish_date")[0].setAttribute('max', today)
	    }
	</script>
</body>
</html>
