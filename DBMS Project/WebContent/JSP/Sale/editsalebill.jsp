<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Edit sale Bill </title>
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
	<%@page import="java.text.DecimalFormat" %>
	<%
            Class.forName("com.mysql.jdbc.Driver");
    		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
    		Statement st = con.createStatement();
    		String billno=request.getParameter("billno");
    		double t=0.0;
    %>
    <script type="text/javascript">
    	var j=0;
    	function changeHeader() {
			var type="<%=userType%>";
			if(type== "user")
				{
					document.getElementById('admin1').style.display = 'none';
					document.getElementById('admin2').style.display = 'none';
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
            codeBox.setAttribute("style", "min-width:120px;border:0px;");
            codeBox.setAttribute("onchange", "setname(this)");
            codeBox.setAttribute("required","required");
            var opt = document.createElement('option');
        	opt.appendChild( document.createTextNode("Select Code"));
    	    opt.value =""; 
	        codeBox.appendChild(opt);
            <%
            String Query ="select code from product order by code";
    		ResultSet rs= st.executeQuery(Query);
            while(rs.next())
    		{
            %>
            var opt = document.createElement('option');
        	opt.appendChild( document.createTextNode(<%=rs.getString(1)%>) );
    	    opt.value = <%=rs.getString(1)%>; 
	        codeBox.appendChild(opt);
	        <%
    		}%>
    		
    		var nameBox = document.createElement("select");
    		nameBox.setAttribute("class","browser-default");
            nameBox.setAttribute("id", "name "+j);
            nameBox.setAttribute("style", "min-width:150px;border:0px;");
            nameBox.setAttribute("onchange", "setcode(this)");
            nameBox.setAttribute("required","required");
            var opt = document.createElement('option');
        	opt.appendChild( document.createTextNode("Select Name"));
    	    opt.value =""; 
	        nameBox.appendChild(opt);
            <%
            String Query4 ="select name from product order by name";
    		ResultSet rs4= st.executeQuery(Query4);
            while(rs4.next())
    		{
            %>
            var opt = document.createElement('option');
        	opt.appendChild( document.createTextNode("<%=rs4.getString(1)%>") );
    	    opt.value = "<%=rs4.getString(1)%>"; 
	        nameBox.appendChild(opt);
	        <%
    		}%>
    		
    		var expiryBox = document.createElement("input");
            expiryBox.setAttribute("name", "expiry");
            expiryBox.setAttribute("id", "expiry "+j);
            expiryBox.setAttribute("style", "min-width:168px;border:0px;");
            expiryBox.setAttribute("class", "input");
            expiryBox.setAttribute("type","date");
    		
	        var quantityBox = document.createElement("input");
	        quantityBox.setAttribute("name","quantity");
	        quantityBox.setAttribute("id", "quantity "+j);
            quantityBox.setAttribute("type","number");
            quantityBox.setAttribute("class", "input");
            quantityBox.setAttribute("required","required");
            quantityBox.setAttribute("oninput", "setamount(this)");
            quantityBox.setAttribute("onchange", "setamount(this)");
            quantityBox.setAttribute("oninput", "settotalq(this)");

            var mrpBox = document.createElement("input");
	        mrpBox.setAttribute("name","mrp");
	        mrpBox.setAttribute("id", "mrp "+j);
            mrpBox.setAttribute("type","number");
            mrpBox.setAttribute("class", "input");
            mrpBox.setAttribute("required","required");
            mrpBox.setAttribute("readonly", "readonly");
            mrpBox.setAttribute("oninput", "changeSPbyMRP(this);");
            mrpBox.setAttribute("onchange", "changeSPbyMRP(this);");
            
            var discountBox = document.createElement("input");
	        discountBox.setAttribute("name","discount");
	        discountBox.setAttribute("id", "discount "+j);
            discountBox.setAttribute("class", "input");
            discountBox.setAttribute("required","required");
            discountBox.setAttribute("oninput", "changeSPbyDiscount(this);");
            discountBox.setAttribute("onchange", "changeSPbyDiscount(this);");
            
            var priceBox = document.createElement("input");
            priceBox.setAttribute("name","price");
            priceBox.setAttribute("id", "price "+j);
            priceBox.setAttribute("class", "input");
            priceBox.setAttribute("required","required");
            priceBox.setAttribute("oninput", "setamount(this),changeDiscount(this);");
            priceBox.setAttribute("onchange","setamount(this),changeDiscount(this);");
                        
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
            currentCell.appendChild(expiryBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(quantityBox);

            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(mrpBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(discountBox);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.appendChild(priceBox);
            
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
    		String Query9 ="select * from sale where bill_no="+billno;
    		ResultSet rs9= st2.executeQuery(Query9);
    		rs9.next();
    		%>
    		document.getElementById("billno").value="<%=rs9.getString(1)%>";
    		document.getElementById("datepicker").value="<%=rs9.getString(4)%>";
    		var net="<%=rs9.getString(3)%>";
    		var val="<%=rs9.getString(2)%>";
			var element=document.getElementById("Customerid");
        	for (var i = 0;i < element.length; i++) 
			    if (element[i].value == val) element[i].selected = true;
    		setCustomername();
    		<%
           	Statement st1 = con.createStatement();
    		String Query3 ="select * from sale_details where bill_no="+billno;
    		ResultSet rs3= st1.executeQuery(Query3);
            while(rs3.next())
    		{
            %>
            	addField();
            	var code="code "+j;
            	var val="<%=rs3.getString(2)%>";
				var element=document.getElementById(code);
            	for (var i = 0;i < element.length; i++) 
				    if (element[i].value == val) element[i].selected = true;
            	setname(element);
            	var quantity="quantity "+j;
            	document.getElementById(quantity).value="<%=rs3.getString(3)%>";
            	var price="price "+j;
            	document.getElementById(price).value="<%=rs3.getString(4)%>";
            	var expiry="expiry "+j;
            	document.getElementById(expiry).value="<%=rs3.getString(6)%>";
            	var amount="amount "+j;
            	document.getElementById(amount).value="<%=rs3.getString(5)%>";
	        <%
    		}%>
    		setCustomercon();
    		settotalq();
    		settotal();
    		document.getElementById("net").value=net;
    		setdiscountbynet();
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
		    			String c=rs1.getString("mrp");
		    			String d=rs1.getString("discount");
		    			String e=rs1.getString("sale_price");/* 
		    			String f=rs1.getString("expiry_dt");   */  			
				%>
						var s="<%=a%>";
						if(co.localeCompare(s)==0)
						{
							var val="<%=b%>";
							for (var i = 0;i < element.length; i++) 
							    if (element[i].value == val) element[i].selected = true;
							
							document.getElementById("quantity "+n[1]).value=1;
							document.getElementById("mrp "+n[1]).value=<%=c%>;
							document.getElementById("discount "+n[1]).value=<%=d%>;
							document.getElementById("price "+n[1]).value=<%=e%>;
							<%
							Statement st3 = con.createStatement();
							String Query10 ="select min(expiry_dt) from purchase_details where code="+a;
				    		ResultSet rs10= st3.executeQuery(Query10);
				    		rs10.next();
							%>
							document.getElementById("expiry "+n[1]).value="<%=rs10.getString(1)%>";
							settotalq(document.getElementById("quantity "+n[1]));
							setamount(document.getElementById("price "+n[1]));
						}
				<%
					}
				%>
			
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
		    			String c=rs5.getString("mrp");
		    			String d=rs5.getString("discount");
		    			String e=rs5.getString("sale_price");
				%>
						var s="<%=b%>";
						if(co.localeCompare(s)==0)
						{
							var val="<%=a%>";
							for (var i = 0;i < element.length; i++) 
							    if (element[i].value == val) element[i].selected = true;
						
							document.getElementById("quantity "+n[1]).value=1;
							document.getElementById("mrp "+n[1]).value=<%=c%>;
							document.getElementById("discount "+n[1]).value=<%=d%>;
							document.getElementById("price "+n[1]).value=<%=e%>;
							<%
							Statement st3 = con.createStatement();
							String Query10 ="select min(expiry_dt) from purchase_details where code="+a;
				    		ResultSet rs10= st3.executeQuery(Query10);
				    		rs10.next();;
							%>
							document.getElementById("expiry "+n[1]).value="<%=rs10.getString(1)%>";
							settotalq(document.getElementById("quantity "+n[1]));
							setamount(document.getElementById("price "+n[1]));
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
				document.getElementById(na).value=((p*q)).toFixed(2);
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
			setnetbytotal();
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
		function setCustomername()
		{
			var co=document.getElementById("Customerid").value;
			var element=document.getElementById("Customername");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query6 ="select * from Customer";
		    		ResultSet rs6= st.executeQuery(Query6);
		    		while(rs6.next())
		    		{
		    			int a=rs6.getInt("id");
		    			String b=rs6.getString("name");
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
			setCustomercon();
		}
		function setCustomernamemob()
		{
			var co=document.getElementById("Customercon").value;
			var element=document.getElementById("Customername");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query12 ="select * from Customer";
		    		ResultSet rs12= st.executeQuery(Query6);
		    		while(rs12.next())
		    		{
		    			String a=rs12.getString("contact");
		    			String b=rs12.getString("name");
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
			setCustomerid();
		}
		function setCustomercon()
		{
			var co=document.getElementById("Customername").value;
			var element=document.getElementById("Customercon");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query13 ="select * from Customer";
		    		ResultSet rs13= st.executeQuery(Query13);
		    		while(rs13.next())
		    		{
		    			String a=rs13.getString("contact");
		    			String b=rs13.getString("name");
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
		function setCustomerid()
		{
			var co=document.getElementById("Customername").value;
			var element=document.getElementById("Customerid");
			if(co.localeCompare("")==0)
			{
				element.value="";
			}
			else
			{
				<%
					String Query7 ="select * from Customer";
		    		ResultSet rs7= st.executeQuery(Query7);
		    		while(rs7.next())
		    		{
		    			int a=rs7.getInt("id");
		    			String b=rs7.getString("name");
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
		function changeSPbyMRP(x)
		{
			var ab=x.id;
			var n=ab.split(" ");
			document.getElementById("price "+n[1]).value=x.value;
		}
		function changeDiscount(x)
		{
			var ab=x.id;
			var n=ab.split(" ");
			var mrp=document.getElementById("mrp "+n[1]).value;
			var sp=document.getElementById("price "+n[1]).value;
			document.getElementById("discount "+n[1]).value=(((mrp-sp)*100)/mrp).toFixed(2);
		}
		function changeSPbyDiscount(x)
		{
			var ab=x.id;
			var n=ab.split(" ");
			var mrp=document.getElementById("mrp "+n[1]).value;
			var disc=document.getElementById("discount "+n[1]).value;
			document.getElementById("price "+n[1]).value=(mrp-((disc/100)*mrp)).toFixed(2);
			setamount(x);
		}
		function setnetbytotal()
		{
			var a=document.getElementById("totalp").value;
			var dis=document.getElementById("discount").value;
			if(dis == 0 || dis=="null")
				{
					dis=0;
					document.getElementById("discount").value="0.0";
				}
				
			document.getElementById("net").value=(a-((dis/100)*a)).toFixed(0);
		}
		function setdiscountbynet()
		{
			var a=document.getElementById("totalp").value;
			var net=document.getElementById("net").value;				
			document.getElementById("discount").value=(((a-net)/a)*100).toFixed(2);
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
<body onload="changeHeader(),originalvalues();">
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
	
			<h3 class="center">Edit Sale Bill</h3>
			<br><br>
			<div>
			<form action="esalebilldata.jsp" method="post">
				<div style="width:1000px;margin: auto;text-align: center;">
					<label style="font-size: 15px;">Bill No.</label>&ensp;
					
					<input id="billno" name="billno" type="text" style="font-family: 'raleway';font-size:18px;width: 180px;height: 20px;padding-left: 10px;" required="required" readonly="readonly">
					&emsp;&emsp;&emsp;
					<label style="font-size: 20px;">Bill Date</label>&ensp;
					<input id="datepicker" name="billdate" type="date" style="font-family: 'raleway';font-size:16.7px;width: auto;height: 30px;padding-left: 10px;"  required="required" readonly="readonly">
					</div>
					<div class="input-field col s12 inline" style="margin:0px 10px 0px 450px;">
					<select class="browser-default" onchange="setCustomername()" id="Customerid" name="Customerid" style="font-size:13px;width: auto;height: 30px;padding-left: 10px;background: white;" required="required">
						<option value="">Select Customer Id</option>
						<% 
						String Query2 ="select id from Customer";
			    		ResultSet rs2= st.executeQuery(Query2);
			            while(rs2.next())
			    		{
						%>
						<option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
						<%
			    		}
						%>
					</select>
					</div>
					<div class="input-field col s12 inline" >
					<select class="browser-default" onchange="setCustomernamemob()" id="Customercon" name="Customercon" style="font-size:13px;width: auto;height: 30px;padding-left: 10px;background: white;" required="required">
						<option value="">Select Contact</option>
						<% 
						String Query11 ="select contact from Customer";
			    		ResultSet rs11= st.executeQuery(Query11);
			            while(rs11.next())
			    		{
						%>
						<option value="<%=rs11.getString(1)%>"><%=rs11.getString(1)%></option>
						<%
			    		}
						%>
					</select>
					</div>
					<div class="input-field col s12 inline" >
					
					<select class="browser-default" onchange="setCustomerid(),setCustomercon()" id="Customername" style="font-family: 'raleway';font-size:13px;width: auto;height: 30px;background: white;padding-left: 10px;" required="required">
						<option value="">Select Name</option>
						<% 
						String Query8 ="select name from Customer";
			    		ResultSet rs8= st.executeQuery(Query8);
			            while(rs8.next())
			    		{
						%>
						<option value="<%=rs8.getString(1)%>"><%=rs8.getString(1)%></option>
						<%
			    		}
						%>
					</select>
				</div>
				<br/>
				<div>
				<table id="myTable" class="center">
					<tr style="height: 35px;">
						<th style="min-width:120px; max-width:120px; ">Code</th>
						<th style="min-width:150px; ">Name</th>
						<th>Expiry Date</th>
						<th>Quantity</th>
						<th>MRP</th>
						<th>Discount</th>
						<th>Price</th>
						<th>Amount</th>
						<th class="btn blue darken-3 waves-effect waves-light mybtn" colspan="3" style="margin:15px 4px 10px 35px;"><a href="../Customer/addcustomer.jsp"><span class="white-text">Add Customer<i class="material-icons right">add</i></span></a></th>
					</tr>
				</table>
				</div>
				<div>
				<table class="center">
					<tr>
					
					 <td><pre>                      </pre>    </td>
						
						<td colspan="1"><label style="font-size:15px;"><b>Total Quantity</b></label>
						<td><input style="font-size:18px;width: 50px;height: 20px;" class="input" id="totalq" type="number" readonly="readonly"></td>
						<td><button class="btn blue darken-3 waves-effect waves-light mybtn2" onclick="addField();"  style="margin:0px 15px 0px 0px;">Row<i class="material-icons right">add</i></button></td>
						<td><label style="font-size:15px;"><b>Total</b></label>
						<input style="font-size:18px;width: 50px;height: 20px;" class="input" id="totalp" name="totalp" type="number" readonly="readonly"></td>
						</tr>
					<tr>
						<td style="min-width:120px;"> </td>
						<td style="min-width:120px;"> </td>
						
						<td></td>
						<td ><label style="font-size: 20px;"><b>Discount</b></label>
						<td><input style="font-size:18px;width: 60px;height: 20px;" class="input" id="discount" onchange="setnetbytotal();"></td>
						<td ></td>
					</tr>
					<tr>
						<td style="min-width:160px; "></td>
						<th style="min-width:170px; "></th>
						
						<td> </td>
						
						<td ><label style="font-size: 20px;"><b>Net</b></label>
						<td><input style="font-size:18px;width: 90px;height: 20px;" class="input" id="net" name="net" onchange="setdiscountbynet();"></td>
						<td ></td>
						</tr>
				</table>
				</div>
				<br>
				<div class="center">
						<button   class="btn indigo waves-effect waves-light" type="submit">Save Bill<i class="material-icons right">save</i></button>
				</div>
			</form>
		</div>
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
    $(document).ready(function(){
        $('select').formSelect();
      });
    </script>
</body>
<%
rs.close();
st.close();
con.close();
%>
</html>