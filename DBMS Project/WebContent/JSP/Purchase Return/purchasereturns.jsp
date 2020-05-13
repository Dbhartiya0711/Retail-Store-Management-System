<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
			<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<title>	Purchase Returns </title>
		<style type="text/css">
		.nav1 {
		height: 60px;
		line-height: 60px;
		}
		
		</style>
	</head>
	<body >
		<%
		HttpSession log=request.getSession(false);  
		String n = (String)log.getAttribute("user");
		if(n == null){
			response.sendRedirect("../login.jsp");
		}
	%>
		<%@page import="java.io.*" %>
		<%@page import="java.sql.*" %>
		<%@page import="javax.sql.*" %>
		<%@page import="java.sql.Connection" %>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select distinct(bill_no) from purchase_return";
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
		<h3 class="center">Purchase Returns</h3>
		<div class="container">
		<div style="margin:auto; width:800px;">
			<input type="text" id="myInput0" onkeyup="search([0,1,4])" placeholder="Search By Bill No." title="Type in Bill No." style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			&emsp;&emsp;
			<input type="text" id="myInput1" onkeyup="search([0,1,4])" placeholder="Search By Dealer Id" title="Type in Dealer Id" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			&emsp;&emsp;
			<input type="text" id="myInput4" onkeyup="search([0,1,4])" placeholder="Search By Date" title="Type in Bill Date" style="border:solid 1px black;padding-left:6px;width:180px;height: 25px;border-radius:2px;font-size: 16px;margin-bottom: 12px;">
			
			<button class="btn indigo waves-effect waves-light" style="margin:0px 0px 5px 10px;"  onclick="clearSearch([0,1,4]);">Clear Search</button>
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
					<th>Return for Bill No.</th>
					<th>Dealer ID</th>
					<th>Dealer Name</th>
					<th>Total Return Amount</th>
					<th>Date of Return Bill</th>
					<th colspan="3" class="btn blue darken-3 waves-effect waves-light" style="margin:9px 0px 0px 49px;"><i class="material-icons right">add</i><a href="addpurchasereturn.jsp"><span class="white-text">Add Purchase Return</span></a></th>
				</tr>
			<tbody>
				<%
					while(rs.next())
					{
						Statement st1 = con.createStatement();
						Statement st2 = con.createStatement();
						Statement st3 = con.createStatement();
						String Query1 ="select dealer_id from purchase where bill_no="+rs.getString(1);
						ResultSet rs1= st1.executeQuery(Query1);
						rs1.next();
						String did=rs1.getString(1);
						Query1 ="select name from dealer where id="+rs1.getString(1);
						rs1= st1.executeQuery(Query1);
						rs1.next();
						String dname=rs1.getString(1);
						String Query2 ="select * from purchase_return where bill_no="+rs.getString(1);
						ResultSet rs2= st2.executeQuery(Query2);
						double t=0.0;
						String date="";
						while(rs2.next())
						{
							date=rs2.getString(4);
							String code=rs2.getString(2);
							String Query3 ="select price from purchase_details where bill_no="+rs.getString(1)+" and code="+code;
							ResultSet rs3= st3.executeQuery(Query3);
							rs3.next();
							double p= rs3.getDouble(1);
							double q=rs2.getDouble(3);
							t=t+(p*q);
						}
				%>
				<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=did %></td>
					<td><%=dname %></td>
					<td>Rs <%=t %></td>
					<td><%=date %></td>
					<td class="btn blue darken-3 waves-effect waves-light" style="margin:7px 7px 7px 7px;"><a href="viewpurchasereturn.jsp?billno=<%=rs.getString(1)%>"><span class="white-text">View<i class="material-icons right">visibility</i></span></a></td>
					<td class="btn blue darken-3 waves-effect waves-light" style="margin:7px 7px 7px 0px;"><a href="editpurchasereturn.jsp?billno=<%=rs.getString(1)%>"><span class="white-text">Edit<i class="material-icons right">create</i></span></a></td>
					<td class="btn blue darken-3 waves-effect waves-light" style="margin:7px 7px 7px 0px;"><a href="delpurchasereturndata.jsp?billno=<%=rs.getString(1)%>"><span class="white-text">Delete<i class="material-icons right">delete</i></span></a></td>
				</tr>
				<%} %>
			</tbody>
		</table>	
		</div>
		<br>
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