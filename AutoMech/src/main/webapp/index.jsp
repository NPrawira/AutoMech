<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home | AutoMech</title>
        <jsp:include page="support/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="support/navbar.jsp"></jsp:include>
        <div class="container">
        	<div class="text-center mt-5">
        		<h1>AutoMech Workshop</h1>
                <p class="lead">Your One Stop for All Your Motorbike Needs</p>
                <hr>
        		<table style="margin-left: auto; margin-right: auto;">
					<tr>
						<td style="height:300px;">
							<a href="mymotorbikes.jsp">
								<button class="btn btn-primary head-button-size">
								<div style="text-align:center">
									<i class="fa fa-motorcycle fa-5x"></i>
				              		<br><br>
				              		<span class="head-mini-text">Motorbike Service</span>
				            	</div>
				          	</button>
							</a>
				    	</td>
				    	<td style="padding: 0 50px"></td>
					    <td style="height:300px;">
							<a href="#">
								<button class="btn btn-info head-button-size">
					            <div style="text-align:center">
					              <i class="fa fa-wrench fa-5x"></i>
					              <br><br>
					              <span class="head-mini-text">Spare Parts Purchase</span>
					            </div>
							</button>
							</a>
					    </td>
				  	</tr>
				</table>
        	</div>
        </div>
        <jsp:include page="support/footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
