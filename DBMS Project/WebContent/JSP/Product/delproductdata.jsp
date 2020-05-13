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
		String code = request.getParameter("code");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		Statement st1 = con.createStatement();
		String Query ="select name from product where code='"+code+"';";
		ResultSet rs= st.executeQuery(Query);
		if(rs.next())
		{
			String Query1 ="select count(*) from purchase_details where code='"+code+"';";
			ResultSet rs1= st1.executeQuery(Query1);
			rs1.next();
			if(rs1.getInt(1) == 0)
			{
				String Query2 ="delete from product where code="+code+";";
				int f= st1.executeUpdate(Query2);
				if(f==1)
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Product Deleted!!!');");
				   	out.println("location='products.jsp';");
				   	out.println("</script>");
				}
				else
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
				   	out.println("location='products.jsp';");
				   	out.println("</script>");
				}
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Cannot Delete an already purchased Product.');");
			   	out.println("location='products.jsp';");
			   	out.println("</script>");
			}
		}
		
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
		   	out.println("location='products.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>