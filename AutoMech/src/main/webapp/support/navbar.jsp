<nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
	<div class="container">
    	<h3><a class="navbar-brand" href="index.jsp">AutoMech</a></h3>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
				<%
				try {
					if(session.getAttribute("customer") == null ||session.getAttribute("customer") == "") { %>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="login.jsp"><i class="fa fa-sign-in" style="color:white; padding:10px"></i>Login</a>
	            		</li>
	            <% } else { %>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="myprofile.jsp"><i class="fa fa-user" style="padding:10px"></i><%out.print(session.getAttribute("customer"));%></a>
		            	</li>
		            	<li class="nav-item">
		            		<form method="post" onclick="return confirm('Do you want to logout?');">
								<a class="nav-link active" aria-current="page" href="logout.jsp"><i class="fa fa-sign-out" style="padding:10px"></i>Logout</a>
							</form>
		            	</li>
				<% }
				} catch(Exception e) {} %>
        	</ul>
    	</div>
	</div>
</nav>
