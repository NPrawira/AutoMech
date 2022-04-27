<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
String id = null;
String name = null;
if(session.getAttribute("idc") != null) {
	id = session.getAttribute("idc").toString();
	name = session.getAttribute("customer").toString();
} else {
	response.sendRedirect("login.jsp");
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = null;
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/automech", "root", "");
Statement stmt = con.createStatement();
ResultSet rs = null;
String search = request.getParameter("motorbike");
rs = stmt.executeQuery("SELECT * FROM motorbikes WHERE owner = '" + name + "' AND (license_plate REGEXP '" + search + "' OR brand REGEXP '" + search + "' OR model REGEXP '" + search + "' OR type REGEXP '" + search + "')");
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
							<a class="nav-link active" aria-current="page" href="mymotorbikes.jsp">Motorbikes</a>
				       	</li>
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="myservices.jsp">Services</a>
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
        	<br><br>
			<h2 class="d-flex justify-content-center">Search "<%=search%>"</h2>
			<br>
			<form action="searchmotorbike.jsp" method="get" name="search" onsubmit="return validate();">
				<div class="row">
					<div class='col-md-10 mb-3'>
						<input class="form-control" type="text" placeholder="Search motorbike license plate..." aria-label="Search" id="motorbike" name="motorbike">    
					</div>
					<div class='col-md-1 mb-3'>
						<input type="submit" class="btn btn-info" value="Search">
					</div>
					<div class='col-md-1 mb-3'>
						<a href="mymotorbikes.jsp" type="submit" class="btn btn-danger">Reset</a>		
					</div>
				</div>
			</form>
			<hr>
			<div class="table-responsive">
				<table id="tblMotorbike" class="table table-bordered">
                	<thead>
						<tr class="bg-secondary text-white" style="font-weight: bold; text-align: center">
	                		<td>License plate</td>
	                		<td>Motorbike</td>
	                		<td>Action</td>
	                	</tr>
					</thead>
           			<tbody>
           			<%
           			if(!rs.isBeforeFirst()) {
           			%>
           				<tr style="text-align: center; background-color: gray; color: white;"><td colspan="3">No motorbikes.</td></tr>
           			<%
           			} else {
           				while(rs.next()) {
					%>	 
                    	<tr>
                       		<td><%out.println(rs.getString("license_plate"));%></td>
        					<td><%out.println(rs.getString("brand"));%> <%out.println(rs.getString("model"));%> <%out.println(rs.getString("type"));%></td>
            				<td style="text-align: center">
            					<form action="manage-motorbike.jsp" method="post" style="display: inline;">
            						<input type="hidden" value="<%out.println(rs.getInt("motorbike_id"));%>" name="manage">
            				        <input type="submit" class="btn btn-warning btn-user" value="Manage motorbike">
            					</form>
            					&nbsp;or&nbsp;
            					<form action="new-service.jsp" method="post" style="display: inline;" onsubmit="return confirm('Proceed to service this motorbike?');">
            						<input type="hidden" value="<%out.println(rs.getString("license_plate"));%>" name="proceed">
            						<input type="submit" class="btn btn-success btn-user" value="Proceed to service">	        
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
			<div class="d-flex justify-content-center links">I have a new motorbike:
				&nbsp;<a href="new-motorbike.jsp">Add new motorbike</a>
			</div>
			<br>
        </div>
        <footer class="py-4 text-center text-medium navbar-dark bg-secondary" style="color:white">
			<div class="container">
				<h6 class="list-inline-item" style="color: white; padding:10px">Copyright &copy; AutoMech 2022</h6>
			</div>
		</footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
	        function validate() {
	        	var x = document.forms["search"]["motorbike"].value;
	        	if (x == null || x == "") {
	        		alert("Enter your search!");
	        		return false;
	            }
	    	}
        </script>
    </body>
</html>
