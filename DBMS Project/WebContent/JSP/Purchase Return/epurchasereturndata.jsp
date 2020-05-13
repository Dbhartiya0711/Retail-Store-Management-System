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
		String Query1 ="select count(*) from purchase where Bill_no="+billno;
		ResultSet rs1= st.executeQuery(Query1);
		rs1.next();
		int a=rs1.getInt(1);
		if(a==1)
		{
			Statement st1 = con.createStatement();
			String Query2 ="select * from purchase_return where Bill_no="+billno;
			ResultSet rs2= st1.executeQuery(Query2);
			int h=0;
			while(rs2.next())
			{
				String code=rs2.getString("code");
				String q=rs2.getString("quantity");
				String Query3 = "update product set quantity=quantity+"+q+" where code="+code;
				h= st.executeUpdate(Query3);
			}
			rs2.close();
			if(h!=0)
			{
				Statement st2 = con.createStatement();				
				String Query4 ="delete from purchase_return where Bill_no="+billno;
				int f= st2.executeUpdate(Query4);
				if(f!=0)
				{
					String billdate = request.getParameter("billdate");
					String Query ="select count(*) from purchase where Bill_no="+billno;
					ResultSet rs= st.executeQuery(Query);
					rs.next();
					int b=rs.getInt(1);
					if(b==1)
					{
							String[] code = request.getParameterValues("code");
							String[] quantity = request.getParameterValues("quantity");
							
							for(int i=0;i< code.length;i++)
							{
								String Query5 ="insert into purchase_return values('"+billno+"','"+code[i]+"','"+quantity[i]+"','"+billdate+"')";
								int g= st.executeUpdate(Query5);
								String Query3 = "update product set quantity=quantity-"+quantity[i]+" where code="+code[i];
								int j= st.executeUpdate(Query3);
								if(g!=1 || j!=1)
								{
									out.println("<script type=\"text/javascript\">");
								   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
								   	out.println("location='addpurchasereturn.jsp';");
								   	out.println("</script>");
								}
							}
							out.println("<script type=\"text/javascript\">");
						   	out.println("alert('Purchase Return Edited!!!');");
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
				}
				else
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
				   	out.println("location='purchasereturns.jsp';");
				   	out.println("</script>");
				}
				st2.close();
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
			   	out.println("location='purchasereturns.jsp';");
			   	out.println("</script>");
			}
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
		   	out.println("location='purchasereturns.jsp';");
		   	out.println("</script>");
		}
		rs1.close();
		st.close();
		con.close();
	%>
</body>
</html>