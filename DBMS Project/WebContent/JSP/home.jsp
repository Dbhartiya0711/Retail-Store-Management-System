<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title> Home</title>
		 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<style type="text/css">
			p{
			width: 75%;
			margin: auto;
			text-align: center;
			font-size: 25px;
			}
			.nav1 {
		height: 60px;
		line-height: 60px;
		}
		
		</style>
		<%
		HttpSession log=request.getSession(false);  
		String n = (String)log.getAttribute("user");
		String userType = (String)log.getAttribute("userType");
		if(n == null){
			response.sendRedirect("login.jsp");
		}
	%>
	<script type="text/javascript">
	function changePara() {
		var type="<%=userType%>";
		if(type== "user")
			{
				document.getElementById("admin").style.display="none";
			}
		else
			{
				document.getElementById("user").style.display="none";
			}
	}
	function changeHeader() {
		var type="<%=userType%>";
		if(type== "user")
			{
				document.getElementById('admin1').style.display = 'none';
				document.getElementById('admin2').style.display = 'none';
			}
	}
	</script>
	</head>
	<body onload="changeHeader(),changePara();">
		<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="Purchase/purchasebills.jsp">Purchase Bills</a></li>
   <li class="divider"></li>
  <li><a href="Purchase Return/purchasereturns.jsp">Purchase Returns</a></li>
  <li class="divider"></li>
  <li><a href="Dealer/dealers.jsp">Dealers</a></li>
</ul>
<ul id="dropdown2" class="dropdown-content">
  <li><a href="Sale/salebills.jsp">Sale Bills</a></li>
   <li class="divider"></li>
  <li><a href="Sale Return/salereturns.jsp">Sale Returns</a></li>
  <li class="divider"></li>
  <li><a href="Customer/customers.jsp">Customers</a></li>
</ul>
<nav class="nav1">
  <div class="nav-wrapper head1 indigo">
    <ul class="left hide-on-med-and-down">
      <li><a href="home.jsp">Home</a></li>
      
      <li><a href="Product/products.jsp">Products</a></li>
      </ul>
      <!-- Dropdown Trigger -->
      <div id="admin1">
      <ul>
      <li><a class="dropdown-trigger" href="#!" data-target="dropdown1">Purchases<i class="material-icons right">arrow_drop_down</i></a></li>
    </ul>
    </div>
    <ul>
     <li><a class="dropdown-trigger" href="#!" data-target="dropdown2">Sales<i class="material-icons right">arrow_drop_down</i></a></li>
     <li><a id="admin2" href="Setup/setup.jsp">Setup</a></li>
     <li class="right">
     <a href="logoutdata.jsp">Sign Out</a>
     </li>
    </ul>
  </div>
</nav>
    	<br/><br/><br/><br/><br/><br/><br/><br/>
    	<p id="admin">
    	You are logged in as Administrator.<br/>
    	You can add new products, suppliers and customers as well as make changes in them.<br/>
    	You can setup new users and admin of this Retail Store Management System.<br/>
    	You can add purchase bill, purchase return, sale bill, sale return as well as make changes in them.
    	</p>
    	<p id="user">
    	You are logged in as User.<br/>
    	You can view product stock.<br/>
    	You can add customers, sale bills and sale returns.<br/>
    	</p>
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
    </script>
	</body>
</html>