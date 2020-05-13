<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
			<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<title>	Customers </title>
		<link rel="icon" href="../../Images/customer.png"  type = "image/x-icon">
		<style type="text/css">
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
			response.sendRedirect("../login.jsp");
		}
	%>
		<script>
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
	<body onload="changeHeader();">
		
		<%@page import="java.io.*" %>
		<%@page import="java.sql.*" %>
		<%@page import="javax.sql.*" %>
		<%@page import="java.sql.Connection" %>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select * from customer";
			ResultSet rs= st.executeQuery(Query);
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
		<h3 class="center">Customers</h3>
		<div class="container">
		<div style="margin-left:200px; width:800px;">
			<input type="text" id="myInput1" onkeyup="search([1,2])" placeholder="Search By Name" title="Type in Customer Name" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			&emsp;&emsp;
			<input type="text" id="myInput2" onkeyup="search([1,2])" placeholder="Search By Mobile" title="Type in Customer Mobile" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			
			<button class="btn indigo waves-effect waves-light" style="margin:0px 0px 5px 10px;"  onclick="clearSearch([1,2]);">Clear Search</button>
			<script>
			function clearSearch(y) {
				for(j=0;j<y.length;j++)
				  {
				  x=y[j];
				  input = document.getElementById("myInput"+x);
				  input.value="";
				  }
				search(y);
				
			}
			function search(y) {
				  var input, filter, table, tr, td, i, txtValue,j,x;
				  table = document.getElementById("myTable");
				  tr = table.getElementsByTagName("tr");
				  var arr=new Array(tr.length);
				  for (i = 0; i < tr.length; i++)
					  arr[i]=0;
				  for(j=0;j<y.length;j++)
					  {
					  x=y[j];
					  input = document.getElementById("myInput"+x);
					  filter = input.value.toUpperCase();
					  for (i = 0; i < tr.length; i++) {
				    td = tr[i].getElementsByTagName("td")[x];
				    if (td) {
				      txtValue = td.textContent || td.innerText;
				      if (txtValue.toUpperCase().indexOf(filter) == 0) {
				        if(arr[i]!=1)
				    	  arr[i]=0;
				      } else {
				    	arr[i]=1;
				      }
				    }       
				  }
					  
			}
				  arr[0]=0;
				  for (i = 0; i < tr.length; i++)
					  {
					  if(arr[i]==0)
						  tr[i].style.display="";
					  else
						  tr[i].style.display="none";
					  }
				}
			</script>
		</div>
		<table id="myTable">
				<tr>
					<th>S No.</th>
					<th>Name</th>
					<th>Contact</th>
					<th>Address</th>
					<th class="admin1 btn blue darken-3 waves-effect waves-light" style="margin:9px 0px 0px 23px;" colspan="2"><i class="material-icons right">add</i><a href="addcustomer.jsp"><span class="white-text">Add Customers</span></a></th>
				</tr>
			<tbody>
				<%
					int i=1;
					while(rs.next())
					{
				%>
				<tr>
					<td><%=i%></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td onclick="confirmation();" class="btn blue darken-3 waves-effect waves-light" style="margin:7px 7px 7px 0px;"><i class="material-icons right">delete</i><a href="delcustomerdata.jsp?id=<%=rs.getString(1)%>"><span class="white-text">Delete</span></a></td>
					<td class="btn blue darken-3 waves-effect waves-light" style="margin:7px 7px 7px 0px;"><i class="material-icons right">create</i><a href="editcustomer.jsp?id=<%=rs.getString(1)%>"><span class="white-text">Edit</span></a></td>
				</tr>
				<%i++;} %>
			</tbody>
		</table>	
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
    </script>
	</body>
</html>