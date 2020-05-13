<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
	<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<meta charset="ISO-8859-1">
		<title> Login</title>
		<style type="text/css">
		.forms1 {
		   margin: 50px auto;
		   width: 30%;
		   height: 400px;
		   padding:10px;
		}
		nav {
		height: 40px;
		line-height: 40px;
		}
		</style>
		</head>
	<body class="white">
		<nav class="nav-wrapper indigo">
		     <div class="container">
				<ul class="right">
				<li><a href="../index.jsp">
				<span>Home</span>
				</a></li>
				<li><a href="login.jsp">
				<span>Login</span>
				</a></li>
				</ul>
				</div>
		</nav>
		
  <div class="container forms1">
    <h4 class="blue-text text-darken-2 center-align">Sign in</h4>
			<form action="logindata.jsp" method="post">
  <div class="input-field">
  <i class="material-icons prefix">person</i>
    <input type="text" name="username"  id="email1" required="required" >
    <label for="email1">Username</label>
  </div>
  <div class="input-field">
  <i class="material-icons prefix">vpn_key</i>
    <input type="password" name="password" id="password1" required="required">
    <label for="password1">Password</label>
  </div>
  <div class="center">
  <button type="submit" class="btn blue darken-3 waves-effect waves-light">Submit</button>
  </div>
</form>
</div>
<div class="indigo"  style=" position:fixed;bottom:0px;overflow: hidden;bborder-radius:0px;width: 101.05%;color: white;height: 25px;">
<span style="float: right;padding-right: 25px;font-size: 20px;">&copy;Archade</span>

</div>
		<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
		 <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
	</body>
</html>