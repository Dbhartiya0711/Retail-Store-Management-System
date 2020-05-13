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
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select id from dealer where name='"+name+"';";
		ResultSet rs= st.executeQuery(Query);
		if(rs.next())
		{
			String Query1 ="update dealer set name='"+name+"',address='"+add+"',contact='"+mob+"'where id='"+rs.getInt(1)+"'";
			int f= st.executeUpdate(Query1);
			if(f==1)
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Dealer Updated!!!');");
			   	out.println("location='dealers.jsp';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='editdealer.jsp';");
			   	out.println("</script>");
			}
		}
		
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
		   	out.println("location='dealers.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>