<!DOCTYPE html>
<html>
<head>
<title>HTML5 Login</title>
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div
		style="height: 100px; background-color: black; width: 100%; position: relative; font-size: 25px;">
		<img src="images/logo_eng.png" alt="TNEB"
			style="height: 75px; padding-left: 40px; padding-top: 10px;" /> <span
			style="font-weight: normal; text-align: left; text-indent: 1.8%; 
			line-height: 55px; color: #FFF; text-shadow: 0px -1px 0px #000; 
			top: 10px; veritical-align: top; position: absolute; 
			top: 25px; min-width: 300px; width: 40%;"> Intelli Task Management System - ITMS</span>
	</div>
	<section class="loginform cf">
		<form name="login" id="login_form_me" action="LoginServlet.do"
			method="post"  >
			<ul>
				<li><label for="customer_id">Customer ID</label> <input
					type="customer_id" name="customer_id" placeholder="customer id"
					required></li>
				<li><label for="password">Password</label> <input
					type="password" name="password" placeholder="password" required></li>
				<li><input type="submit" id="cust_login_form" value="Login"></li>
			</ul>
		</form>
	</section>

	<script>
		$(document).ready(function() {
			/* $("form").submit(function(e) {
				alert("asdds");
				e.preventDefault();
				
			}); */
		});
	</script>
</body>
</html>