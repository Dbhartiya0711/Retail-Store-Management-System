<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Edit Purchase Return </title>
<!-- Compiled and minified CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"> 
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
    		String billno=request.getParameter("billno");
            %>
    <script type="text/javascript">
    	var j=0;
    	function showhide(){
    		var bill=document.getElementById("billno").value;
    		if(bill== null || bill==0)
    			{
    				document.getElementById("myTable").style.display="none";
    				document.getElementById("myTable1").style.display="none";
    				document.getElementById("goaway").style.display="block";
    			}
    		else
    			{
    			document.getElementById("myTable").style.display="table";
				document.getElementById("myTable1").style.display="table";
				document.getElementById("goaway").style.display="none";
    			}
    	}
        function addField (argument) {
        	var myTable = document.getElementById("myTable");
            var currentIndex = myTable.rows.length;
            var currentRow = myTable.insertRow(-1);
            j=j+1;
            currentRow.setAttribute("id",j);
            var codeBox = document.createElement("select");
            codeBox.setAttribute("class","browser-default");
            codeBox.setAttribute("name","code");
            codeBox.setAttribute("id", "code "+j);
            codeBox.setAttribute("style", "border:0px;");
            codeBox.setAttribute("onchange", "setname(this),setrest(this);");
            codeBox.setAttribute("required","required");
            var opt = document.createElement('option');
        	opt.appendChild( document.createTextNode("Select Code"));
    	    opt.value =""; 
	        codeBox.appendChild(opt);
            
	        var nameBox = document.createElement("select");
	        nameBox.setAttribute("class","browser-default");
            nameBox.setAttribute("id", "name "+j);
            nameBox.setAttribute("style", "min-width:190px;border:0px;");
            nameBox.setAttribute("onchange", "setcode(this),setrest(this);");
            nameBox.setAttribute("required","required");
            var opt = document.createElement('option');
        	opt.appendChild( document.createTextNode("Select Name"));
    	    opt.value =""; 
	        nameBox.appendChild(opt);
	        
            <%
            Statement st1=con.createStatement();
            String Queryy ="select bill_no from purchase";
    		ResultSet rss= st1.executeQuery(Queryy);
            while(rss.next())
    		{
    		%>
    			var tbill=<%=rss.getString(1)%>
            	var bill=document.getElementById("billno").value;
            	if(bill.localeCompare(tbill)==0)
            		{
            			<%
            			billno=rss.getString(1);
            			String Query ="select code from purchase_details where bill_no="+rss.getString(1)+" order by code";
			    		ResultSet rs= st.executeQuery(Query);
			            while(rs.next())
			    		{
			        	%>
				            var opt = document.createElement('option');
				        	opt.appendChild( document.createTextNode(<%=rs.getString(1)%>) );
				    	    opt.value = <%=rs.getString(1)%>; 
					        codeBox.appendChild(opt);
					        
					        <%
					        Statement st2=con.createStatement();
				            String Query4 ="select name from product where code="+rs.getString(1);
				    		ResultSet rs4= st2.executeQuery(Query4);
				            rs4.next();
				            %>
				            
					        var opt1 = document.createElement('option');
				        	opt1.appendChild( document.createTextNode("<%=rs4.getString(1)%>") );
				    	    opt1.value = "<%=rs4.getString(1)%>"; 
					        nameBox.appendChild(opt1);
					        
				        <%
			    		}%>
            		}
                <%
        		}%>
    		
	        var quantityBox = document.createElement("input");
	        quantityBox.setAttribute("name","quantity");
	        quantityBox.setAttribute("id", "quantity "+j);
            quantityBox.setAttribute("type","number");
            quantityBox.setAttribute("class", "input");
            quantityBox.setAttribute("required","required");
            quantityBox.setAttribute("oninput", "setamount(this)");
            quantityBox.setAttribute("onchange", "setamount(this)");
            quantityBox.setAttribute("oninput", "settotalq(this)");

            var priceBox = document.createElement("input");
            priceBox.setAttribute("name","price");
            priceBox.setAttribute("id", "price "+j);
            priceBox.setAttribute("type","number");
            priceBox.setAttribute("class", "input");
            priceBox.setAttribute("required","required");
            priceBox.setAttribute("oninput", "setamount(this)");
            
            var expiryBox = document.createElement("input");
            expiryBox.setAttribute("name", "expiry");
            expiryBox.setAttribute("id", "expiry "+j);
            expiryBox.setAttribute("class", "input");
            expiryBox.setAttribute("type","date");
            
            var amountBox = document.createElement("input");
            amountBox.setAttribute("name", "amount");
            amountBox.setAttribute("id", "amount "+j);
            amountBox.setAttribute("class", "input");
            amountBox.setAttribute("required","required");
            amountBox.setAttribute("readonly","readonly");
            
            var currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(codeBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(nameBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(quantityBox);

            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(priceBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(expiryBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(amountBox);

            currentCell = currentRow.insertCell(-1);
            currentCell.setAttribute("id", "cell "+j);
            currentCell.setAttribute("style", "margin:25px 0px 0px 0px; ");
            currentCell.setAttribute("class", "btn blue darken-3 waves-effect waves-light ");
            currentCell.setAttribute("onclick", "deleteField(this)");
            currentCell.innerHTML="Delete Row";
        }
        function originalvalues(){
        	<%
        	Statement st2 = con.createStatement();
    		String Query9 ="select * from purchase where bill_no="+billno;
    		ResultSet rs9= st2.executeQuery(Query9);
    		rs9.next();
    		%>
    		document.getElementById("billno").value="<%=rs9.getString(1)%>";
    		document.getElementById("dealerid").value="<%=rs9.getString(2)%>";
    		setdealername();
    		<%
           	Statement stt1 = con.createStatement();
    		String Query3 ="select * from purchase_return where bill_no="+billno;
    		ResultSet rs3= stt1.executeQuery(Query3);
            while(rs3.next())
    		{
            %>
            	document.getElementById("datepicker").value="<%=rs3.getString(4)%>";
            	addField();
            	var code="code "+j;
            	var val="<%=rs3.getString(2)%>";
				var element=document.getElementById(code);
            	for (var i = 0;i < element.length; i++) 
				    if (element[i].value == val) element[i].selected = true;
            	setname(element);
            	var quantity="quantity "+j;
            	document.getElementById(quantity).value=<%=rs3.getString(3)%>;
            	setrest(element);
	        <%
    		}%>
    		settotalq();
    		settotal();
        }
		function setname(x) {
			var a=x.id;
			var co=x.value;
			var n=a.split(" ");
			var na="name "+n[1];
			var element=document.getElementById(na);
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query1 ="select * from product";
		    		ResultSet rs1= st.executeQuery(Query1);
		    		while(rs1.next())
		    		{
		    			int a=rs1.getInt("code");
		    			String b=rs1.getString("name");
				%>
						var s="<%=a%>";
						if(co.localeCompare(s)==0)
						{
							var val="<%=b%>";
							for (var i = 0;i < element.length; i++) 
							    if (element[i].value == val) element[i].selected = true;
						}
				<%
					}
				%>
			}
		}
		function setrest(x) {
			var a=x.id;
			var n=a.split(" ");
			var na="code "+n[1];
			var co=document.getElementById(na).value;
			var q="quantity "+n[1];
			var pr="price "+n[1];
			var exp="expiry "+n[1];
			if(co.localeCompare("")==0)
			{
				document.getElementById(q).value="";
				document.getElementById(pr).value="";
				document.getElementById(exp).value="";
			}
			else
			{
				<%
					String Query15 ="select * from purchase_details where bill_no="+billno;
		    		ResultSet rs15= st.executeQuery(Query15);
		    		while(rs15.next())
		    		{
		    			int a=rs15.getInt("code");
		    			String c=rs15.getString("price");
		    			String d=rs15.getString("expiry_dt");
		    			String e=rs15.getString("quantity");
				%>
						var s="<%=a%>";
						if(co.localeCompare(s)==0)
						{
							document.getElementById(pr).value="<%=c%>";
							document.getElementById(exp).value="<%=d%>";
							document.getElementById(q).setAttribute("min","1");
							document.getElementById(q).setAttribute("max","<%=e%>");
						}
				<%
					}
				%>
				setamount(x);
			}
		}
		
		function setcode(x) {
			var a=x.id;
			var co=x.value;
			var n=a.split(" ");
			var na="code "+n[1];
			var element=document.getElementById(na);
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query5 ="select * from product";
		    		ResultSet rs5= st.executeQuery(Query5);
		    		while(rs5.next())
		    		{
		    			int a=rs5.getInt("code");
		    			String b=rs5.getString("name");
				%>
						var s="<%=b%>";
						if(co.localeCompare(s)==0)
						{
							var val="<%=a%>";
							for (var i = 0;i < element.length; i++) 
							    if (element[i].value == val) element[i].selected = true;
						}
				<%
					}
				%>
			}
		}
		function setamount(x) {
			var ab=x.id;
			var n=ab.split(" ");
			var na="amount "+n[1];
			var nq="quantity "+n[1];
			var np="price "+n[1];
			var q=document.getElementById(nq).value;
			var p=document.getElementById(np).value;
			if(q!= null && p!=null && q!=0 && p!=0)
				{
				document.getElementById(na).value=(p*q);
				settotal();
				}
		}
		function settotalq(x) {
			var sum=0;
			for(var i=1;i<=j;i++)
				{
				var b=document.getElementById("quantity "+i);
					if(typeof(b) != 'undefined' && b != null)
					{
						var c=document.getElementById("quantity "+i).value;
						var a=parseInt(c);
						if(!isNaN(a))
							sum=sum+a;
					}
				}
			document.getElementById("totalq").value=sum;
		}
		function settotal(x) {
			var sum=0;
			for(var i=1;i<=j;i++)
				{
					var b=document.getElementById("amount "+i);
					if(typeof(b) != 'undefined' && b != null)
					{
						var c=document.getElementById("amount "+i).value;
						var a=parseInt(c);
						if(!isNaN(a))
							sum=sum+a;
					}
				}
			document.getElementById("totalp").value=sum;
		}
		function deleteField(x){
			if(document.getElementById("myTable").rows.length >2)
				{
					var ab=x.id;
					var n=ab.split(" ");
					document.getElementById(n[1]).remove();
					settotalq();
					settotal();
				}
		}
		function setdealername()
		{
			var co=document.getElementById("dealerid").value;
			var element=document.getElementById("dealername");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query6 ="select * from dealer";
		    		ResultSet rs6= st.executeQuery(Query6);
		    		while(rs6.next())
		    		{
		    			int a=rs6.getInt("id");
		    			String b=rs6.getString("name");
				%>
						var s="<%=a%>";
						if(co.localeCompare(s)==0)
						{
							element.value = "<%=b%>";
						}
				<%
					}
				%>
			}
		}
		function setdealerid()
		{
			var co=document.getElementById("dealername").value;
			var element=document.getElementById("dealerid");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query7 ="select * from dealer";
		    		ResultSet rs7= st.executeQuery(Query7);
		    		while(rs7.next())
		    		{
		    			int a=rs7.getInt("id");
		    			String b=rs7.getString("name");
				%>
						var s="<%=b%>";
						if(co.localeCompare(s)==0)
						{
							element.value ="<%=a%>";
						}
				<%
					}
				%>
			}
		}
		function setdealeridbybill()
		{
			var co=document.getElementById("billno").value;
			var element=document.getElementById("dealerid");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query14 ="select dealer_id from purchase where bill_no="+billno;
		    		ResultSet rs14= st.executeQuery(Query14);
		    		rs14.next();
		    		int a=rs14.getInt(1);
				%>
						
						element.value="<%=a%>";
			}
			setdealername();
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
   			width:140px;
		}
		
		</style>
</head>
<body onload="originalvalues();">
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
	
			<h3 class="center">Edit Purchase Return</h3>
			<br>
			<div class="container">
			<form action="epurchasereturndata.jsp" method="post">
				<div style="margin:0px 50px 0px 200px;display:inline-block;" >
					<label for="billno" style="font-size:15px;display: inline-block;">Return for bill no.</label>
					<select class="browser-default" onchange="setdealeridbybill(),showhide();" id="billno" name="billno" style="display: inline-block;font-size:15px;width: 150px;height: 30px;" required="required" >
						<option value="">Select Bill</option>
						<% 
						String Queryy1 ="select bill_no from purchase";
			    		ResultSet rss1= st.executeQuery(Queryy1);
			            while(rss1.next())
			    		{
						%>
						<option value="<%=rss1.getString(1)%>"><%=rss1.getString(1)%></option>
						<%
			    		}
						%>
					</select>
					
					<label for="datepicker" style="font-size: 15px;margin-left:20px;">Date Of Return Bill</label>&ensp;
					<input id="datepicker" name="billdate" type="date" style="font-size:16.7px;width: 160px;height: 30px;"  required="required">
					</div>
					<div>
					<br>
					<label style="font-size: 15px;margin-left:230px;">Dealer Id</label>&ensp;
					<input onchange="setdealername()" id="dealerid" name="dealerid" style="font-size:15px;width: 120px;height: 25px;" readonly="readonly"/>
					&emsp;&emsp;&emsp;&emsp;&ensp;
					<label style="font-size: 15px;">Dealer Name</label>&ensp;
					<input onchange="setdealerid()" id="dealername" style="font-size:15px;width: auto;height: 25px;" readonly="readonly">
				</div>
				<br/>
				<div>
				<table id="myTable" class="center">
					<tr style="height: 35px;">
						<th style="min-width:80px; ">Code</th>
						<th style="min-width:100px; ">Name</th>
						<th style="min-width:30px;">Quantity</th>
						<th style="min-width:80px;">Price</th>
						<th>Expiry Date</th>
						<th style="min-width:90px;">Amount</th>
						<td class="btn blue darken-3 waves-effect waves-light mybtn" colspan="3" style="margin:15px 4px 10px 35px;"><a href="../Product/addproduct.jsp"><span class="white-text">Add New Product<i class="material-icons right">add</i></span></a></td>
					</tr>
					
				</table>		
				</div>
				<div>
				<table id="myTable1"  class="center">
				<tr>
				        <td><pre>          </pre>    </td>
				        <td>    </td>
						<td></td>
						<td colspan="3"><label style="font-size:15px;"><b>Total Quantity</b></label>
						<input style="font-size:18px;width: 50px;height: 20px;" class="input" id="totalq" type="number" readonly="readonly">
						<button class="btn blue darken-3 waves-effect waves-light mybtn2" onclick="addField();"  style="margin:3px 25px 0px 50px;">Add Row<i class="material-icons right">add</i></button>
						<label style="font-size:15px;"><b>Total</b></label>
						<input style="font-size:18px;width: 90px;height: 20px;padding-left: 10px;margin-left:5px;" class="input" id="totalp" name="totalp" type="number" readonly="readonly"></td>
						</tr>
						</table>
						</div>
						<br>
						<div class="center">
						<button  class="btn indigo waves-effect waves-light" type="submit">Save Bill<i class="material-icons right">save</i></button>
						</div>
			</form>
		</div>
		<br>
		<div id="goaway" style="display:none;">
		<br><br><br><br><br><br><br><br><br><br>
		</div>
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
    $(document).ready(function(){
        $('select').formSelect();
      });
    </script>
</body>
<%
st.close();
con.close();
%>
</html>