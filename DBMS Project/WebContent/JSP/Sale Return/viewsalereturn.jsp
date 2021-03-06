<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> View Sale Return </title>
<!-- Compiled and minified CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"> 
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<%
		HttpSession log=request.getSession(false);  
		String n = (String)log.getAttribute("user");
		String userType = (String)log.getAttribute("userType");
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
    		Statement stt = con.createStatement();
    		Statement stt1 = con.createStatement();
			%>
    <script type="text/javascript">
    function changeHeader() {
		var type="<%=userType%>";
		if(type== "user")
			{
				document.getElementById('admin1').style.display = 'none';
				document.getElementById('admin2').style.display = 'none';
			}
	}
    	function addField (argument) {
        	
            <%
            String bill=request.getParameter("billno");
            String Query1 ="select customer_id,total from sale where bill_no="+bill;
    		ResultSet rs1= st.executeQuery(Query1);
            rs1.next();
            double net=rs1.getDouble(2);
            double total=0;
            String date="";
    		String did = rs1.getString(1);
            String Query ="select * from sale_return where bill_no="+bill+" order by code";
    		ResultSet rs= st.executeQuery(Query);
            while(rs.next())
    		{
            	date = rs.getString(4);
            %>
            var myTable = document.getElementById("myTable");
            var currentIndex = myTable.rows.length;
            var currentRow = myTable.insertRow(-1);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=rs.getString("code")%>";
            
            <%
            
            String Query2 ="select name,mrp from product where code="+rs.getString("code");
    		ResultSet rs2= stt.executeQuery(Query2);
            rs2.next();
    		String name = rs2.getString(1);
    		double mrp=rs2.getDouble(2);
    		
            String Query3 ="select * from sale_details where bill_no="+bill+" and code="+rs.getString("code");
    		ResultSet rs3= stt1.executeQuery(Query3);
            rs3.next();
    		double price = rs3.getDouble(4);
    		String exp=rs3.getString(6);
    		double quantity = rs.getDouble("quantity");
    		double am=price*quantity;
    		total=total+am;
    		double discount=((mrp-price)/mrp)*100;
            %>
    		currentCell = currentRow.insertCell(-1);
    		currentCell.innerHTML="<%=name%>";
    		
    		currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=exp%>";
    		
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=rs.getString("quantity")%>";
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML=<%=mrp%>.toFixed(2);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML=<%=discount%>.toFixed(2);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=price%>";
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=am%>";
            

			<%
    		}
            String Query4 ="select total from sale_details where bill_no="+bill;
    		ResultSet rs4= stt1.executeQuery(Query4);
    		double ttt=0;
            while(rs4.next())
            	ttt=ttt+rs4.getDouble(1);
            
            double di=((ttt-net)/ttt)*100;
    		%>
    		document.getElementById("discount").innerHTML=<%=di%>.toFixed(2);
        }
    	function printDiv(divName) {
    	     var printContents = document.getElementById(divName).innerHTML;
    	     var originalContents = document.body.innerHTML;

    	     document.body.innerHTML = printContents;

    	     window.print();

    	     document.body.innerHTML = originalContents;
    	}
    </script>
    <style type="text/css">
    .nav1 {
		height: 60px;
		line-height: 60px;
		}
		
		[type="date"]
		{
  			font-family: 'raleway';
  			font-size: 16.7px;
		}
		.mybtn {
    		width:210px;
		}
		.mybtn2 {
   			width:100px;
		}
		</style>
</head>
<body onload="changeHeader(),addField();">
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
	<div id="printablearea">
			<h3 class="center">Sale Return</h3>
				<br>
				<div style="width:1000px;margin: auto;text-align: center;">
					<label style="font-size: 20px;">Return For Bill No.</label>&ensp;
					<input id="billno" type="text" style="font-family: 'raleway';font-size:18px;width: 170px;height: 25px;padding-left: 10px;" readonly="readonly" value="<%=bill%>">
					&emsp;&emsp;&emsp;&emsp;&nbsp;
					<label style="font-size: 20px;">Date of Return Bill</label>&ensp;
					<input id="datepicker" type="date" style="font-family: 'raleway';font-size:18px;width: 170px;height: 30px;padding-left: 10px;"  readonly="readonly"  value="<%=date%>">
					<br/><br/>
					<%
					String Query3 ="select name,contact from customer where id="+did;
		    		ResultSet rs3= st.executeQuery(Query3);
		            rs3.next();
		    		String cname = rs3.getString(1);
		    		String ccon=rs3.getString(2);
					%>
					<label style="font-size: 20px;">Customer Mobile</label>&ensp;
					<input id="dealerid" type="text" style="font-family: 'raleway';font-size:18px;width: 170px;height: 25px;padding-left: 10px;" readonly="readonly"  value="<%=ccon%>">
					&emsp;&emsp;&emsp;
					
					
					<label style="font-size: 20px;">Customer Name</label>&ensp;
					<input id="dealername" type="text" style="font-family: 'raleway';font-size:18px;width: 170px;height: 25px;padding-left: 10px;" readonly="readonly" value="<%=cname%>">
					</div>
					<br/>
				<div>
				<table id="myTable" style="align-content: center;">
					<tr style="height: 35px;">
						<th style="min-width:165px; ">Code</th>
						<th style="min-width:190px; ">Name</th>
						<th>Expiry Date</th>
						<th>Quantity</th>
						<th>MRP</th>
						<th>Discount</th>
						<th>Price</th>
						<th>Amount</th>
					</tr>
				</table>
				<table style="align-content: center;">
					<tr  style="height: 35px;">
						<td style="min-width:165px; "></td>
						<th style="min-width:190px; "></th>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<th>Total</th>
						<td><%=total%></td>
					</tr>
					<tr  style="height: 35px;">
						<td style="min-width:165px; "></td>
						<th style="min-width:190px; "></th>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<th>Discount</th>
						<td id="discount"></td>
					</tr>
					<%
					net=total-((total*di)/100);
					%>
					<tr  style="height: 35px;">
						<td style="min-width:165px; "></td>
						<th style="min-width:190px; "></th>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<th>Net</th>
						<td><%=net%></td>
					</tr>
				</table>
				</div>
		</div>
		<div style="text-align: center;">
		<br>
		<button class="btn indigo waves-effect waves-light center white-text" style="width: 150px;" onclick="printDiv('printablearea');" >Print<i class="material-icons right">print</i></button>
		</div>
		<br>
		<br>
		<div class="indigo"  style=" postion:fixed; bottom:0px;overflow: hidden;border-radius:0px;width: 101.05%;color: white;height: 25px;">
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
<%
st.close();
con.close();
%>
</html>