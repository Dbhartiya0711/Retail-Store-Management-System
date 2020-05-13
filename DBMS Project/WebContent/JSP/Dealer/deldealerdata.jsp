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
		String id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select name from dealer where id='"+id+"';";
		ResultSet rs= st.executeQuery(Query);
		if(rs.next())
		{
			String Query1 ="delete from dealer where id='"+id+"'";
			int f= st.executeUpdate(Query1);
			if(f==1)
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Dealer Deleted!!!');");
			   	out.println("location='dealers.jsp';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='dealers.jsp';");
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