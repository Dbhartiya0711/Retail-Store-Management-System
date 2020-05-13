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
		String name = request.getParameter("name");
		String mob = request.getParameter("mobile");
		String add = request.getParameter("add");
		String url=(String)session.getAttribute("redirect");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select count(*) from customer where name='"+name+"';";
		ResultSet rs= st.executeQuery(Query);
		rs.next();
		int a=rs.getInt(1);
		if(a==0)
		{
			String Query1 ="insert into customer (name,contact,address)values('"+name+"','"+mob+"','"+add+"')";
			int f= st.executeUpdate(Query1);
			if(f==1)
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Customer Added!!!');");
			   	out.println("location='"+url+"';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='addcustomer.jsp';");
			   	out.println("</script>");
			}
		}
		
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Customer already present!!!');");
		   	out.println("location='customers.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>