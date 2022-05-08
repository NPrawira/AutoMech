<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("idc") != null) {
	String idc = session.getAttribute("idc").toString();
	String name = session.getAttribute("customer").toString();
} else {
	response.sendRedirect("login.jsp");
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();

String id = request.getParameter("view");
ResultSet rs = stmt.executeQuery("SELECT * FROM service_payments WHERE service_payment_id = " + id);
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
<html>
	<head>
		<title>Payment no. <%out.println(payment_no);%> | AutoMech</title>
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
							<a class="nav-link" aria-current="page" href="myservices.jsp">Services</a>
				       	</li>
				       	<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="myservicepayments.jsp">Payments</a>
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
		<br>
		<div class="container">
			<div class="row">
				<form action="updatePaymentCustomer" method="post" onsubmit="return confirm('Submit your payment for this service?');">
					<input type="hidden" id="service_payment_id" name="service_payment_id" value="<%out.print(service_payment_id);%>">
					<div class="col-sm-9 col-md-9 col-lg-9 mx-auto">
						<div class="card border-0 shadow rounded-3 my-5">
							<div class="card-header p-4 p-sm-4 bg-success">
								<h5 class="pull-left text-white" style="display: inline;">Payment no. <%out.print(payment_no);%></h5>
								<% if(status.equals("Payment due")) { %>
								<h6 class="pull-right text-uppercase" style="display: inline; background-color: red; color: #FFCCBB; padding: 5px"><%out.print(status);%></h6>
								<% } else if(status.equals("Confirming")) { %>
								<h6 class="pull-right text-uppercase" style="display: inline; background-color: orange; color: #FFFF00; padding: 5px"><%out.println(status);%></h6>
								<% } %>
							</div>
							<div class="card-body p-3 p-sm-3">
								<div style="display: grid; grid-template-columns: 1fr 1fr; grid-gap: 20px;">
									<div class="grid-child">
										<table class="table table-responsive table-borderless table-sm">
											<tr>
												<td><h6>Customer</h6></td>
												<td><%out.print(customer);%></td>
											</tr>
											<tr>
												<td><h6>Date</h6></td>
												<td><%out.print(date);%></td>
											</tr>
											<tr>
												<td><h6>Service tag</h6></td>
												<td><%out.print(service_tag);%></td>
											</tr>
											<tr>
												<td><h6>Service type</h6></td>
												<td><%out.print(service_type);%></td>
											</tr>
										</table>
									</div>
									<div class="grid-child">
										<table class="table table-responsive table-borderless table-sm">
											<tr>
												<td><h6>Payment due</h6></td>
												<td><p style="font-size: 50px">RM<b><%out.println(amount);%></b></p></td>
											</tr>
											<tr>
												<td><h6>Payment method</h6></td>
												<td>
													<% if(status.equals("Payment due")) { %>
												    <select class="form-control" id="method" name="method" required="required">
						                				<option value="" disabled="disabled" selected="selected">Select payment method...</option>
						                				<option value="Cash">Cash</option>
						                				<option value="Debit card">Debit card</option>
						                				<option value="Credit card">Credit card</option>
						                				<option value="DANA">DANA</option>
						                				<option value="GOPAY">GOPAY</option>
						                				<option value="OVO">OVO</option>
						                			</select>
												    <% } else if(status.equals("Confirming")) { %>
												    <%out.print(method);%>
												    <% } %>
												</td>
											</tr>
										</table>
									</div>
								</div>
								<% if(status.equals("Payment due")) { %>
								<hr>
								<div class="text-center">
							        <input class="btn btn-warning" type="submit" value="Submit payment">
								</div>
								<% } %>
			          		</div>
		        		</div>
		      		</div>
	      		</form>
	    	</div>
	  	</div>
	  	<jsp:include page="support/footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
	</body>
</html>
