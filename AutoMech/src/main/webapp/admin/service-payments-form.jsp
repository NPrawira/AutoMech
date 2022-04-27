<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- 
String username = null;
if(session.getAttribute("username") != null) {
	username = session.getAttribute("username").toString();
} else {
	response.sendRedirect("login.jsp");
}
-->
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();

String service_payment = request.getParameter("service_payment");
ResultSet rs = stmt.executeQuery("SELECT * FROM service_payments WHERE service_payment_id = " + service_payment);
rs.next();

int service_payment_id = rs.getInt("service_payment_id");
String payment_no = rs.getString("payment_no");
String customer = rs.getString("customer");
Date date = rs.getDate("date");
String service_tag = rs.getString("service_tag");
String service_type = rs.getString("service_type");
int amount = rs.getInt("amount");
String method = rs.getString("method");
String status = rs.getString("status");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Service Payments - AutoMech Administrator</title>
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
			<li class="nav-item">
                <a class="nav-link" href="services.jsp">
                    <i class="fas fa-fw fa-tags"></i>
                    <span>Service Queries</span>
				</a>
            </li>
            <li class="nav-item active">
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
                	<h1 class="h3 mb-4 text-gray-800">Manage Service Payment</h1>
                	<div class="container col-md-12">
	                	<form action="updatePaymentAdmin" method="post" onsubmit="return confirm('Update payment for this service?');">
	                		<input type="hidden" id="service_payment_id" name="service_payment_id" value="<%out.print(service_payment_id);%>">
	                		<div class="form-group row">
	                			<div class="col-sm-3 mb-3 mb-sm-0">
	                				<label>Payment no.</label>
	                				<input type="text" class="form-control" id="payment_no" name="payment_no" value="<%out.print(payment_no);%>" readonly>
	                			</div>
	                			<div class="col-sm-3">
	                				<label>Service tag</label>
	                				<input type="text" class="form-control" id="service_tag" name="service_tag" value="<%out.print(service_tag);%>" readonly>
	                			</div>
	                			<div class="col-sm-3">
	                				<label>Date</label>
	                				<input type="date" class="form-control" id="date" name="date" onclick="validDate()" required="required">
	                				<script type="text/javascript">
										document.getElementById("date").value = <%out.print("'" + date + "'");%>;
									</script>
	                			</div>
	                			<div class="col-sm-3">
	                				<label>Status</label>
									<select class="form-control" id="status" name="status" required>
		                				<option disabled="disabled" selected="selected">Select status...</option>
		                				<option value="Payment due">Payment due</option>
		                				<option value="Paid">Paid</option>
		                			</select>
		                			<script type="text/javascript">
		                				document.getElementById("status").value = <%out.print("'" + status + "'"); %>;
									</script>
	                			</div>
	                		</div>
	                		<div class="form-group row">
	                			<div class="col-sm-6 mb-3 mb-sm-0">
	                				<label>Motorbike type</label>
	                				<%
	                				ResultSet rs2 = stmt.executeQuery("SELECT type FROM motorbikes WHERE license_plate IN(SELECT motorbike FROM services WHERE service_tag = '" + service_tag + "')");
	                				rs2.next();
	                				String type = rs2.getString("type");
	                				%>
									<input type="text" class="form-control" id="motorbike_type" name="motorbike_type" value="<%out.println(type);%>" readonly>
	                			</div>
	                			<div class="col-sm-6">
	                				<label>Motorbike type price (RM)</label>
	                				<%
	                				String getType = rs2.getString("type");
	                				int type_price = 0;
	                				if(getType.equals("Cub")) {
	                					type_price = 0;
	                				} else if(getType.equals("Scooter")) {
	                					type_price = 5;
	                				} else if(getType.equals("Sport")) {
	                					type_price = 10;
	                				} else {
	                					type_price = 15;
	                				}
	                				%>
									<input type="text" class="form-control" id="motorbike_type_price" name="motorbike_type_price" value="<%out.print(type_price);%>" readonly>
	                			</div>
	                		</div>
	                		<div class="form-group row">
	                			<div class="col-sm-6 mb-3 mb-sm-0">
	                				<label>Service type</label>
	                				<input type="text" class="form-control" id="service_type" name="service_type" value="<%out.print(service_type);%>" readonly>
	                			</div>
	                			<div class="col-sm-6">
	                				<label>Service type price (RM)</label>
	                				<%
	                				ResultSet rs1 = stmt.executeQuery("SELECT price FROM service_types WHERE name = '" + service_type + "'");
	                				rs1.next();
	                				int price = rs1.getInt(1);
	                				%>
									<input type="text" class="form-control" id="service_type_price" name="service_type_price" value="<%out.print(price);%>" readonly>
	                			</div>
	                		</div>
	                		<div class="form-group row">
	                			<div class="col-sm-6 mb-3 mb-sm-0">
	                				<label>Payment method</label>
	                				<% if(method.equals("")) { %>
	                				<input type="text" class="form-control" id="method" name="method" placeholder="To be determined by customer" readonly>
	                				<% } else { %>
	                				<input type="text" class="form-control" id="method" name="method" value="<%out.print(method);%>" readonly>
	                				<% } %>
	                			</div>
	                			<% if(amount == 0) { %>
	                			<div class="col-sm-4">
	                				<label>Amount</label>
	                				<input type="text" class="form-control" id="amount" name="amount" value="<%out.print(amount);%>" readonly>
	                			</div>
	                			<div class="col-sm-2">
	                				<input class="btn btn-primary" type="button" value="Calculate total" onclick="calcAmount()" style="display: inline;">
	                			</div>
	                			<% } else { %>
	                			<div class="col-sm-6">
	                				<label>Amount</label>
	                				<input type="text" class="form-control" id="amount" name="amount" value="<%out.print(amount);%>" readonly>	                				
	                			</div>
	                			<% } %>
	                		</div>
	                		<hr>
	                		<input class="btn btn-warning" type="submit" value="Update">
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
	    	document.getElementsByName("date")[0].setAttribute('min', today);
	    	document.getElementsByName("date")[0].setAttribute('max', today)
	    }
    	
    	function calcAmount () {
    	    var service = document.getElementById ("service_type_price").value;
    	    service = parseInt (service);
    	    var motorbike = document.getElementById("motorbike_type_price").value;
    	    motorbike = parseInt (motorbike);
    	    var amount = service + motorbike;
    	    document.getElementById("amount").value = amount;
    	}
    </script>
</body>
</html>
