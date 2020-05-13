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
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
		Statement st = con.createStatement();
		String Query ="select count(*) from sale where Bill_no="+billno;
		ResultSet rs= st.executeQuery(Query);
		rs.next();
		int a=rs.getInt(1);
		if(a==1)
		{
			Statement st1 = con.createStatement();
			String Query3 ="select * from sale_details where Bill_no="+billno;
			ResultSet rs3= st1.executeQuery(Query3);
			int h=0;
			while(rs3.next())
			{
				String code=rs3.getString("code");
				String q=rs3.getString("quantity");
				String Query4 = "update product set quantity=quantity+"+q+" where code="+code;
				h= st.executeUpdate(Query4);
			}
			rs3.close();
			st1.close();
			if(h!=0)
			{
				Statement st2 = con.createStatement();				
				String Query1 ="delete from sale_details where Bill_no="+billno;
				int f= st2.executeUpdate(Query1);
				if(f!=0)
				{
					String Query4 ="delete from sale where Bill_no="+billno;
					int g= st.executeUpdate(Query4);
					if(g==1)
					{
						out.println("<script type=\"text/javascript\">");
					   	out.println("alert('Bill Deleted and Product Quantity Updated!!!');");
					   	out.println("location='salebills.jsp';");
					   	out.println("</script>");
					}
					else
					{
						out.println("<script type=\"text/javascript\">");
					   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
					   	out.println("location='salebills.jsp';");
					   	out.println("</script>");
					}
				}
				else
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
				   	out.println("location='salebills.jsp';");
				   	out.println("</script>");
				}
				st2.close();
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='salebills.jsp';");
			   	out.println("</script>");
			}
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
		   	out.println("location='salebills.jsp';");
		   	out.println("</script>");
		}
		rs.close();
		st.close();
		con.close();
	%>
</body>
</html>