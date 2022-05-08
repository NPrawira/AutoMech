<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String name = null;
if(session.getAttribute("idc") != null) {
	String id = session.getAttribute("idc").toString();
	name = session.getAttribute("customer").toString();
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
        <title>Paid Motorbike Service Payments | AutoMech</title>
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
        <div class="container">
        	<br><br>
			<h2 class="d-flex justify-content-center">Paid Motorbike Service Payments</h2>
			<br><hr><br>
			<div class="table-responsive">
				<table id="tblService" class="table table-bordered">
                	<thead>
						<tr class="bg-secondary text-white text-center" style="font-weight: bold;">
	                		<td>Payment no.</td>
	                		<td>Service tag</td>
	                		<td>Service type</td>
	                		<td>Action</td>
	                	</tr>
					</thead>
                	<tbody>
                		<%
	           			ResultSet rs = stmt.executeQuery("SELECT * FROM service_payments WHERE customer = '" + name + "' AND status = 'Paid'");
	           			if(!rs.isBeforeFirst()) {
	                   	%>
                   		<tr style="text-align: center; background-color: gray; color: white;"><td colspan="5">No paid service payments.</td></tr>
                   		<%
                   		} else {
                   			while(rs.next()) {
                   				int service_payment_id = rs.getInt("service_payment_id");
                   				String payment_no = rs.getString("payment_no");
                   				String service_tag = rs.getString("service_tag");
                   				String service_type = rs.getString("service_type");
						%>
                    	<tr>
                        	<td><%out.println(payment_no);%></td>
                			<td><%out.println(service_tag);%></td>
                			<td><%out.println(service_type);%></td>
                    		<td class="text-center">
                    			<form action="invoice-service.jsp" method="post" style="display: inline;">
                    				<input type="hidden" value="<%out.println(service_payment_id);%>" name="view">
                    				<input type="submit" class="btn btn-primary btn-user" value="View invoice">
                    			</form>
                    		</td>
                    	</tr>
						<%
	                    	}
	                   	}
	           			%>
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
