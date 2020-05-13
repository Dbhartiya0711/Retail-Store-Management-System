<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@page import="java.io.*" %>
	<%@page import="java.sql.*" %>
	<%@page import="javax.sql.*" %>
	<%@page import="java.sql.Connection" %>
	<%
		String billno = request.getParameter("billno");
		String dealerid = request.getParameter("dealerid");
		String total = request.getParameter("totalp");
		String billdate = request.getParameter("billdate");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select count(*) from purchase where Bill_no="+billno;
		ResultSet rs= st.executeQuery(Query);
		rs.next();
		int a=rs.getInt(1);
		if(a==0)
		{
			String Query1 ="insert into purchase values('"+billno+"','"+dealerid+"','"+total+"','"+billdate+"')";
			int f= st.executeUpdate(Query1);
			if(f==1)
			{
				String[] code = request.getParameterValues("code");
				String[] quantity = request.getParameterValues("quantity");
				String[] price = request.getParameterValues("price");
				String[] expiry = request.getParameterValues("expiry");
				String[] amount = request.getParameterValues("amount");
				
				for(int i=0;i< code.length;i++)
				{
					String Query2 ="insert into purchase_details values('"+billno+"','"+code[i]+"','"+quantity[i]+"','"+price[i]+"','"+amount[i]+"','"+expiry[i]+"')";
					int g= st.executeUpdate(Query2);
					String Query3 = "update product set quantity=quantity+"+quantity[i]+" where code="+code[i];
					int h= st.executeUpdate(Query3);
					if(g!=1 || h!=1)
					{
						out.println("<script type=\"text/javascript\">");
					   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
					   	out.println("location='addpurchasebill.jsp';");
					   	out.println("</script>");
					}
				}
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Purchase Bill Added!!!');");
			   	out.println("location='purchasebills.jsp';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='addpurchasebill.jsp';");
			   	out.println("</script>");
			}
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Bill already present!!!');");
		   	out.println("location='purchasebills.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>