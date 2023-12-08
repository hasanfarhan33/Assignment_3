<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registered Students</title>
</head>
<body>
	<div style = "text-align: center;">
		<h1>Registered Students</h1>
		
		
		<%-- CONNECTING TO THE DATABSE --%>
		<%
		String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
		String user = "hasanfarhan33"; 
		String pass = "Farhan@1998"; 
		
		// Adding JDBC Driver
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace(); 
		}
		
		// Connecting to Database
		try {
			Connection con = DriverManager.getConnection(databaseUrl, user, pass); 
			
			if(con != null) 
				System.out.println("Connected to the database from the courseStudentsPage");
			else 
				System.out.println("Cannot connect to the database");
			
			// Getting parameters from the URL and setting a session 
			String courseID = request.getParameter("courseID");
			System.out.println("COURSE ID in courseStudentsPage.jsp: " + courseID); 
			session.setAttribute("courseID", courseID); 
			
			// Query to get the students registered for the course 
			String getStudentsQuery = "SELECT userID, firstName, lastName FROM user WHERE userID in (SELECT userID from user_course WHERE courseID = '" + courseID + "') AND role = 'student'"; 
			
			// Statement to execute query and ResultSet to store the results 
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(getStudentsQuery); 
			
			// No students registered
			if(!rs.isBeforeFirst()) {%> 
				<h3>No students are registered for this course yet!</h3>
				<a href = "teacherDashboardPage.jsp">Back to Dashboard</a>
				<a href = "teacherDashboardPage.jsp">Login Page</a>
				<% 
			}
			// Students registered
			else {%>
			<h3>Students registered for <%=courseID%></h3>
			<table style = "margin-left: auto; margin-right: auto; border: 1px solid;">
				<tr style = "border: 1px solid;">
					<th style = "border: 1px solid;">Student ID</th>
					<th style = "border: 1px solid;">First Name</th>
					<th style = "border: 1px solid;">Last Name</th>
					<th style = "border: 1px solid;">Assign Grades</th>
				</tr>
			<%  // Printing the table of students registered in the course
				while(rs.next()) {%>
				<tr style = "border: 1px solid;">
					<td style = "border: 1px solid;"><%=rs.getString("userID") %></td>
					<td style = "border: 1px solid;"><%=rs.getString("firstName") %></td>
					<td style = "border: 1px solid;"><%=rs.getString("lastName") %></td>
					<%-- Going to assignGradesPage.jsp and passing the userID in the URL --%>
					<td style = "border: 1px solid;"><a href="assignGradesPage.jsp?userID=<%=rs.getString("userID")%>">Grade</a></td>
				</tr>
				<% } %>
				</table> 
				<%
			}
			
			
		}
		catch(SQLException e){
			e.printStackTrace(); 
		}
		%>
	</div>
</body>
</html>