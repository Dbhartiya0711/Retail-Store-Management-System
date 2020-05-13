<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Edit Product </title>
<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style>
select{
		border:ridge 5px;
		width:316px;
		height: 40px;
		border-radius:7px;
		font-size: 18px;
		}
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
		<script>
		function changeSPbyMRP()
		{
			var mrp=document.getElementsByName("pmrp")[0].value;
			document.getElementsByName("psprice")[0].value=mrp;
		}
		function changeDiscount()
		{
			var mrp=document.getElementsByName("pmrp")[0].value;
			var sp=document.getElementsByName("psprice")[0].value;
			document.getElementsByName("pdiscount")[0].value=(((mrp-sp)*100)/mrp).toFixed(2);
		}
		function changeSPbyDiscount()
		{
			var mrp=document.getElementsByName("pmrp")[0].value;
			var disc=document.getElementsByName("pdiscount")[0].value;
			document.getElementsByName("psprice")[0].value=mrp-((disc/100)*mrp);
		}
		</script>
</head>
<body onload="changeHeader();">
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
      
      <li><a href="products.jsp">Products</a></li>
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
		<%@page import="java.io.*" %>
		<%@page import="java.sql.*" %>
		<%@page import="javax.sql.*" %>
		<%@page import="java.sql.Connection" %>
		<%
			String code = request.getParameter("code");
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
			Statement st = con.createStatement();
			String Query1 ="select * from product where code='"+code+"'";
			ResultSet rs=st.executeQuery(Query1);
			rs.next();
			String a=rs.getString(3);
			%>
	<div class="container">
			<h3 class="center">Edit Product</h3>
			<form class="forms1" action="eproductdata.jsp" method="post">
				<div class="input-field">
					<input class="input" type="text" name="pcode" required="required" value="<%=rs.getString(1) %>" readonly="readonly"/>
					<label class="label">
						Code
					</label>
				</div>
				<div class="input-field">
					<input class="input" type="text" name="pname" required="required" value="<%=rs.getString(2) %>"/>
					<label class="label">
						Name
					</label>
				</div>
				<div class="input-field">
					<select name="pcategory">
										<option <%if(a.equals("FMCG")) out.print("selected");%> value="FMCG">Fast Moving Consumer Goods</option>
										<option <%if(a.equals("Groceries")) out.print("selected");%> value="Groceries">Groceries</option>
										<option <%if(a.equals("Cosmetics")) out.print("selected");%> value="Cosmetics">Cosmetics</option>
										</select>
										<label class="label">
						Category
					</label>
				</div>
				<div class="input-field">
					<input class="input" type="text" name="pmrp" required="required" value="<%=rs.getString(5) %>" oninput="changeSPbyMRP();" />
					<label class="label">
						MRP
					</label>
				</div>
				<div class="input-field">
					<input class="input" type="text" name="psprice" required="required" value="<%=rs.getString(6) %>" oninput="changeDiscount();"/>
					<label class="label">
						Sale Price
					</label>
				</div>
				<div class="input-field">
					<input class="input" type="text" name="pdiscount" required="required" value="<%=rs.getString(7) %>" oninput="changeSPbyDiscount();"/>
					<label class="label">
						Discount
					</label>
				</div>
				<div class="center">
					<button class="btn blue darken-3 waves-effect waves-light" type="submit"><i class="material-icons right">save</i>Save</button>
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