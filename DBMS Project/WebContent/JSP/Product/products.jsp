<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%
		HttpSession log=request.getSession(false);  
		String n = (String)log.getAttribute("user");
		String userType = (String)log.getAttribute("userType");
		if(n == null){
			response.sendRedirect("../login.jsp");
		}%>
	<head>
		<meta charset="ISO-8859-1">
		<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<title> Products </title>
		<style type="text/css">
		
		.nav1 {
		height: 60px;
		line-height: 60px;
		}
		</style>
		<script type="text/javascript">
		
			function changeTable() {
			var type="<%=userType%>";
			if(type== "user")
				{
					var n = document.getElementById("myTable").rows.length;
					var w=document.getElementsByClassName('admin1');
					w[0].style.display = 'none';
					var x=document.getElementsByClassName('admin2');
					var y=document.getElementsByClassName('admin3');
					for(i=0;i<=n;i++)
					{
						x[i].style.display = 'none';
						y[i].style.display = 'none';
					}
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
	<body onload="changeHeader();">
		<%@page import="java.io.*" %>
		<%@page import="java.sql.*" %>
		<%@page import="javax.sql.*" %>
		<%@page import="java.sql.Connection" %>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select * from product";
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
		<h3 class="center">Products</h3>
		<div class="container">
		<div style="margin:auto; width:800px;">
			<input type="text" id="myInput1" onkeyup="search([1,2,3])" placeholder="Search By Code" title="Type in Product Code" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			&emsp;&emsp;
			<input type="text" id="myInput2" onkeyup="search([1,2,3])" placeholder="Search By Name" title="Type in Product Name" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			&emsp;&emsp;
			<input type="text" id="myInput3" onkeyup="search([1,2,3])" placeholder="Search By Category" title="Type in Product Category" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
		
			<button class="btn indigo waves-effect waves-light" style="margin:0px 0px 5px 10px;"  onclick="clearSearch([1,2,3]);">Clear Search</button>
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
					<th>Code</th>
					<th>Name</th>
					<th>Category</th>
					<th>Quantity</th>
					<th>MRP</th>
					<th>Discount</th>
					<th>Sale Price</th>
					<th class="admin1 btn blue darken-3 waves-effect waves-light" style="margin:9px 0px 0px 2px;" colspan="2" ><i class="material-icons right">add</i><a href="addproduct.jsp"><span class="white-text">Add New Product</span></a></th>
				</tr>
			<tbody>
				<%
					int i=1;
					while(rs.next())
					{
				%>
				<tr>
					<td><%=i%></td>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td>Rs. <%=rs.getString(5) %></td>
					<td><%=rs.getString(7) %>%</td>
					<td>Rs. <%=rs.getString(6) %></td>
					<td class="admin2 btn blue darken-3 waves-effect waves-light" style="margin:7px 1px 7px 0px;"><i class="material-icons right">delete</i><a href="delproductdata.jsp?code=<%=rs.getString(1)%>"><span class="white-text">Delete</span></a></td>
					<td class="admin3 btn blue darken-3 waves-effect waves-light" style="margin:7px 1px 7px 5px;"><i class="material-icons right">create</i><a href="editproduct.jsp?code=<%=rs.getString(1)%>"><span class="white-text">Edit</span></a></td>
				</tr>
				<% i++;}%>
			</tbody>
		</table>	
		</div>
		<script>
				changeTable();
		</script>
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
		<%
		rs.close();
		st.close();
		con.close();
		%>
	</body>
</html>