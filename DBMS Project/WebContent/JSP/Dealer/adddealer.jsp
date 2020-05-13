<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Add Dealer </title>
<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
		.nav1 {
		height: 60px;
		line-height: 60px;
		}
		.forms1 {
		margin:0px auto 0px auto;
		   width: 40%;
		   height: 200px;
		}
		</style>
</head>
<body>
	<%
		HttpSession log=request.getSession(false);  
		String n = (String)log.getAttribute("user");
		if(n == null){
			response.sendRedirect("../login.jsp");
		}
	%>
	<ul id="dropdown1" class="dropdown-content">
  <li><a href="../Purchase/purchasebills.jsp">Purchase Bills</a></li>
   <li class="divider"></li>
  <li><a href="../Purchase Return/purchasereturns.jsp">Purchase Returns</a></li>
  <li class="divider"></li>
  <li><a href="../Dealer/dealers.jsp">Dealers</a></li>
</ul>
<ul id="dropdown2" class="dropdown-content">
  <li><a href="../Sale/salebills.jsp">Sale Bills</a></li>
   <li class="divider"></li>
  <li><a href="../Sale Return/salereturns.jsp">Sale Returns</a></li>
  <li class="divider"></li>
  <li><a href="../Customer/customers.jsp">Customers</a></li>
</ul>
<nav class="nav1">
  <div class="nav-wrapper head1 indigo">
    <ul class="left hide-on-med-and-down">
      <li><a href="../home.jsp">Home</a></li>
      
      <li><a href="../Product/products.jsp">Products</a></li>
      </ul>
      <!-- Dropdown Trigger -->
      <div id="admin1">
      <ul>
      <li><a class="dropdown-trigger" href="#!" data-target="dropdown1">Purchases<i class="material-icons right">arrow_drop_down</i></a></li>
    </ul>
    </div>
    <ul>
     <li><a class="dropdown-trigger" href="#!" data-target="dropdown2">Sales<i class="material-icons right">arrow_drop_down</i></a></li>
     <li><a id="admin2" href="../Setup/setup.jsp">Setup</a></li>
     <li class="right">
     <a href="../logoutdata.jsp">Sign Out</a>
     </li>
    </ul>
  </div>
</nav>
	<div class="container">
			<h3 class="center">Add Dealer</h3>
			<form action="adddealerdata.jsp" class="forms1" method="post">
				<div class="input-field">
					<label class="label">
						Name
					</label>
					<input class="input" type="text" name="name" required="required"/>
				</div >
				<div class="clear" style="height: 108px;">
					<label class="label">
						Address
					</label>
					<textarea name="add" style="padding-left:6px;float:left;border-radius:7px;font-size: 18px;" rows="4" cols="30"></textarea>
				
				</div>
				<div class="clear input-field">
					<label class="label">
						Mobile
					</label>
					<input class="input" type="text" name="mobile" pattern="^[0]?[6789]\d{9}$" title="Enter valid mobile number." required="required"/>
				</div>
				<div class="clear center">
					<button class="btn blue darken-3 waves-effect waves-light" type="submit"><i class="material-icons right">add</i>Add</button>
				</div>
			</form>
		</div>
		<div class="indigo"  style=" position:fixed;bottom:0px;overflow: hidden;bborder-radius:0px;width: 101.05%;color: white;height: 25px;">
<span style="float: right;padding-right: 25px;font-size: 20px;">&copy;Archade</span>

</div>
		<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
		 <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
    $(document).ready(function(){
    	   $('.modal').modal();
    	   $('.dropdown-trigger').dropdown();
    	});
    $(document).ready(function(){
        $('select').formSelect();
      });
    </script>
</body>
</html>