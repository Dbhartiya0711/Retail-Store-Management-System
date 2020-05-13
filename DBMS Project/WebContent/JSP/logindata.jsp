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
		String user = request.getParameter("username");
		String pass = request.getParameter("password");		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query1 ="select * from login where login_username='"+user+"' and login_password='"+pass+"'";
		ResultSet rs= st.executeQuery(Query1);
		
		if(rs.next())
		{
			String username = rs.getString(2);
			String password = rs.getString(3);
			if(user.equals(username) && pass.equals(password))
			{
				session.setAttribute("user", username);
				session.setAttribute("userType", rs.getString(4));
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Signed In Successfully!!!');");
			   	out.println("location='home.jsp';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Wrong Credentials, Plz Try Again!!!');");
			   	out.println("location='login.jsp';");
			   	out.println("</script>");
			}
			
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Plz Try Again!!!');");
		   	out.println("location='login.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>