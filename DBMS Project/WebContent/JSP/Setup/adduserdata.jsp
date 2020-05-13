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
		String name = request.getParameter("username");
		String pass = request.getParameter("pass");
		String cpass = request.getParameter("cpass");
		String role = request.getParameter("role");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select count(*) from login where login_username='"+name+"';";
		ResultSet rs= st.executeQuery(Query);
		rs.next();
		int a=rs.getInt(1);
		if(a==0)
		{
			if(pass.equals(cpass))
			{
			String Query1 ="insert into login (login_username,login_password,login_role)values('"+name+"','"+pass+"','"+role+"')";
			int f= st.executeUpdate(Query1);
			if(f==1)
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('"+role+" Added!!!');");
			   	out.println("location='setup.jsp';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='adduser.jsp';");
			   	out.println("</script>");
			}
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Passwords don't Match');");
			   	out.println("location='adduser.jsp';");
			   	out.println("</script>");
			}
		}
		
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('User already present!!!');");
		   	out.println("location='setup.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>