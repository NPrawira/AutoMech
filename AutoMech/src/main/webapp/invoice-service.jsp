<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("idc") != null) {
	String id = session.getAttribute("idc").toString();
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
String payment_no = rs.getString("payment_no");
String customer = rs.getString("customer");
Date date = rs.getDate("date");
String service_tag = rs.getString("service_tag");
String service_type = rs.getString("service_type");
int amount = rs.getInt("amount");
String method = rs.getString("method");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Invoice for <%out.println(payment_no);%> | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
		<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <style type="text/css">
        	.invoice-title h2, .invoice-title h3 {
			    display: inline-block;
			}
			.table > tbody > tr > .no-line {
			    border-top: none;
			}
			.table > thead > tr > .no-line {
			    border-bottom: none;
			}
			.table > tbody > tr > .thick-line {
			    border-top: 2px solid;
			}
        </style>
	</head>
	<body style="padding-top: 25px">
		<div id="invoice">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<div class="invoice-title">
				    		<h2 style="display: inline;">AutoMech</h2>
				    		<h3 class="pull-right">Payment no. <% out.print(payment_no); %></h3>
				    	</div>
				    	<hr>
				    	<div class="row">
				    		<%
				    		ResultSet rs1 = stmt.executeQuery("SELECT * FROM customers WHERE name = '" + customer + "'");
				    		rs1.next();
				    		String phone_no = rs1.getString("phone_no");
							String address = rs1.getString("address");
				    		String postal_code = rs1.getString("postal_code");
							%>
				    		<div class="col-xs-6">
				    			<address>
				    				<strong>Customer:</strong><br>
				    				<% out.print(customer); %><br>
				    				<% out.print(address); %> <% out.print(postal_code); %><br>
				    				<% out.print(phone_no); %>
				    			</address>
				    		</div>
				    		<div class="col-xs-6 text-right">
				    			<address>
				    				<strong>Date:</strong><br>
				    				<% out.print(date); %><br>
				    			</address>
				    		</div>
				    	</div>
				    	<div class="row">
				    		<%
				    		ResultSet rs2 = stmt.executeQuery("SELECT * FROM motorbikes WHERE license_plate IN(SELECT motorbike FROM services WHERE service_tag = '" + service_tag + "')");
				    		rs2.next();
				    		String license_plate = rs2.getString("license_plate");
							String brand = rs2.getString("brand");
				    		String model = rs2.getString("model");
							%>
				    		<div class="col-xs-6">
				    			<address>
				    				<strong>Motorbike:</strong><br>
				    				<% out.print(license_plate); %> <% out.print(brand); %> <% out.print(model); %>
				    			</address>
				    		</div>
				    		<div class="col-xs-6 text-right">
				    			<address>
				    				<strong>Payment method:</strong><br>
				    				<% out.print(method); %>
				    			</address>
				    		</div>
				    	</div>
				    </div>
				</div>
				<div class="row">
					<div class="col-md-12">
				    	<div class="panel panel-default">
				    		<div class="panel-heading">
				    			<h3 class="panel-title"><strong>Service <% out.print(service_tag); %> summary</strong></h3>
				    		</div>
				    		<div class="panel-body">
				    			<div class="table-responsive">
				    				<table class="table table-condensed">
				    					<thead>
				                        	<tr>
				        						<td><strong>Detail</strong></td>
				        						<td class="text-right"><strong>Price</strong></td>
											</tr>
				    					</thead>
				    					<tbody>
				    						<%
				                			ResultSet rs4 = stmt.executeQuery("SELECT price FROM service_types WHERE name = '" + service_type + "'");
				                			rs4.next();
				                			int price = rs4.getInt(1);
				                			%>
				    						<tr>
				    							<td>Service type : <% out.print(service_type); %></td>
				    							<td class="text-right">RM<% out.print(price); %></td>
				    						</tr>
								    		<%
				                			ResultSet rs3 = stmt.executeQuery("SELECT type FROM motorbikes WHERE license_plate IN(SELECT motorbike FROM services WHERE service_tag = '" + service_tag + "')");
				                			rs3.next();
				                			String type = rs3.getString("type");
											String getType = rs3.getString("type");
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
				                            <tr>
				        						<td>Motorbike type : <% out.print(type); %></td>
				    							<td class="text-right">RM<% out.print(type_price); %></td>
				    						</tr>
				    						<tr>
				    							<td class="no-line text-right"><strong>Amount</strong></td>
				    							<td class="no-line text-right"><strong><u>RM<% out.print(amount); %></u></strong></td>
				    						</tr>
				    					</tbody>
				    				</table>
				    			</div>
				    		</div>
				    	</div>
				    </div>
				</div>
			</div>
		</div>
		<div class="container text-center">
			<hr>
			<button class="btn btn-primary" onclick="PrintElem('invoice')">Print invoice</button>
			<button class="btn btn-secondary" onclick="history.back()">Back</button>
		</div>
		<script type="text/javascript">
			function PrintElem(elem) {
			    var mywindow = window.open('', 'Print', 'height=720,width=1280');
			    mywindow.document.write('<html><head><title>' + document.title  + '</title>');
			    mywindow.document.write('<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">');
			    mywindow.document.write('</head><body style="padding-top: 150px">');
			    mywindow.document.write(document.getElementById(elem).innerHTML);
			    mywindow.document.write('</body></html>');
			    mywindow.document.close();
			    mywindow.focus();
			    mywindow.print();
			    return true;
			}
	    </script>
	</body>
</html>
