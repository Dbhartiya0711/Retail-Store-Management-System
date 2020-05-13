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
			String Query2 ="select * from purchase_details where Bill_no="+billno;
			ResultSet rs2= st1.executeQuery(Query2);
			int h=0;
			while(rs2.next())
			{
				String code=rs2.getString("code");
				String q=rs2.getString("quantity");
				String Query3 = "update product set quantity=quantity-"+q+" where code="+code;
				h= st.executeUpdate(Query3);
			}
			rs2.close();
			if(h!=0)
			{
				Statement st2 = con.createStatement();				
				String Query4 ="delete from purchase_details where Bill_no="+billno;
				int f= st2.executeUpdate(Query4);
				if(f!=0)
				{
					String Query5 ="delete from purchase where Bill_no="+billno;
					int g= st.executeUpdate(Query5);
					if(g==1)
					{
						String dealerid = request.getParameter("dealerid");
						String total = request.getParameter("totalp");
						String billdate = request.getParameter("billdate");
						Class.forName("com.mysql.jdbc.Driver");
						Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","root");
						Statement st3 = con1.createStatement();
						String Query6 ="select count(*) from purchase where Bill_no="+billno;
						ResultSet rs3= st.executeQuery(Query6);
						rs3.next();
						int ab=rs3.getInt(1);
						if(ab==0)
						{
							String Query7 ="insert into purchase values('"+billno+"','"+dealerid+"','"+total+"','"+billdate+"')";
							int fg= st.executeUpdate(Query7);
							if(fg==1)
							{
								String[] code = request.getParameterValues("code");
								String[] quantity = request.getParameterValues("quantity");
								String[] price = request.getParameterValues("price");
								String[] expiry = request.getParameterValues("expiry");
								String[] amount = request.getParameterValues("amount");
								
								for(int i=0;i< code.length;i++)
								{
									String Query8 ="insert into purchase_details values('"+billno+"','"+code[i]+"','"+quantity[i]+"','"+price[i]+"','"+amount[i]+"','"+expiry[i]+"')";
									int gh= st.executeUpdate(Query8);
									String Query9 = "update product set quantity=quantity+"+quantity[i]+" where code="+code[i];
									int hi= st.executeUpdate(Query9);
									if(gh!=1 || hi!=1)
									{
										out.println("<script type=\"text/javascript\">");
									   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!');");
									   	out.println("location='addpurchasebill.jsp';");
									   	out.println("</script>");
									}
								}
								out.println("<script type=\"text/javascript\">");
							   	out.println("alert('Purchase Bill Updated!!!');");
							   	out.println("location='purchasebills.jsp';");
							   	out.println("</script>");
							}
							else
							{
								out.println("<script type=\"text/javascript\">");
							   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!1');");
							   	out.println("location='addpurchasebill.jsp';");
							   	out.println("</script>");
							}
						}
						else
						{
							out.println("<script type=\"text/javascript\">");
						   	out.println("alert('Bill already present!!!');");
						   	out.println("location='purchasebills.jsp';");
						   	out.println("</script>");
						}
					}
					else
					{
						out.println("<script type=\"text/javascript\">");
					   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!2');");
					   	out.println("location='purchasebills.jsp';");
					   	out.println("</script>");
					}
				}
				else
				{
					out.println("<script type=\"text/javascript\">");
				   	out.println("alert('Sorry, some error has occurred, Please Try Again!!!3');");
				   	out.println("location='purchasebills.jsp';");
				   	out.println("</script>");
				}
				st2.close();
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Sorry, some error has occurred, Please Try Again4!!!');");
			   	out.println("location='purchasebills.jsp';");
			   	out.println("</script>");
			}
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Please Try Again5!!!');");
		   	out.println("location='purchasebills.jsp';");
		   	out.println("</script>");
		}
		rs1.close();
		st.close();
		con.close();
	%>
</body>
</html>