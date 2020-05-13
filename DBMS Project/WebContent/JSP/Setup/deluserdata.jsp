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
		String Query3 ="select login_role from login where login_id='"+id+"';";
		ResultSet rs3= st.executeQuery(Query3);
		rs3.next();
		String r=(String)rs3.getString(1);
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement stt = conn.createStatement();
		String Query1 ="select count(*) from login where login_role='admin';";
		ResultSet rs1= stt.executeQuery(Query1);
		rs1.next();
		int a= rs1.getInt(1);
		if(r.equals("admin") && a==1)
		{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Only one admin so cannot be Deleted.');");
			   	out.println("location='setup.jsp';");
			   	out.println("</script>");
			}
		else
		{
			String Query ="select * from login where login_id='"+id+"';";
			ResultSet rs= st.executeQuery(Query);
			if(rs.next())
			{
				String Query2 ="delete from login where login_id='"+id+"'";
				int f= st.executeUpdate(Query2);
				if(f==1)
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Deleted!!!');");
				   	out.println("location='setup.jsp';");
				   	out.println("</script>");
				}
				else
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
				   	out.println("location='setup.jsp';");
				   	out.println("</script>");
				}
			}
			
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='setup.jsp';");
			   	out.println("</script>");
			}
			rs.close();
		}
		
		st.close();
		con.close();
	%>
</body>
</html>