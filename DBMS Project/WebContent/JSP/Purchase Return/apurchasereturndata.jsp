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
		String billdate = request.getParameter("billdate");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select count(*) from purchase where Bill_no="+billno;
		ResultSet rs= st.executeQuery(Query);
		rs.next();
		int a=rs.getInt(1);
		if(a==1)
		{
				String[] code = request.getParameterValues("code");
				String[] quantity = request.getParameterValues("quantity");
				
				for(int i=0;i< code.length;i++)
				{
					String Query2 ="insert into purchase_return values('"+billno+"','"+code[i]+"','"+quantity[i]+"','"+billdate+"')";
					int g= st.executeUpdate(Query2);
					String Query3 = "update product set quantity=quantity-"+quantity[i]+" where code="+code[i];
					int h= st.executeUpdate(Query3);
					if(g!=1 || h!=1)
					{
						out.println("<script type=\"text/javascript\">");
					   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
					   	out.println("location='addpurchasereturn.jsp';");
					   	out.println("</script>");
					}
				}
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Purchase Return Added!!!');");
			   	out.println("location='purchasereturns.jsp';");
			   	out.println("</script>");
		}
		else
		{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='addpurchasereturn.jsp';");
			   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>