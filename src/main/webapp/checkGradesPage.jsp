<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Grades</title>
</head>
<body>
	<div style = "text-align: center;">
		<h1>Check Grades</h1>
		<%-- CONNECTING TO DATABASE --%>
		<%
		String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
		String user = "hasanfarhan33"; 
		String pass = "Farhan@1998"; 
		
		// Adding JDBC to file 
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace(); 
		}
		
		// Connecting to Database 
		try {
			Connection con = DriverManager.getConnection(databaseUrl, user, pass);	
			
			if(con != null)
				System.out.println("Connected to the database from checkGradesPage.jsp"); 
			else 
				System.out.println("Cannot connect to DB from checkGradesPage.jsp"); 
			
			// Getting the variables from the URL using getParameter(); 
			String userID = request.getParameter("studentID"); 
			String courseID = request.getParameter("courseID"); 
			
			// System.out.println("USER ID in checkGradesPage: " + userID); 
			// System.out.println("COURSE ID in checkGradesPage: " + courseID); 
			
			// Getting the name of the student 
			String getStudentNameQuery = "SELECT firstName, lastName from user WHERE userID = '" + userID + "'"; 
			
			// Statement to execute query and ResultSet to store the result 
			Statement st = con.createStatement(); 
			ResultSet rs = st.executeQuery(getStudentNameQuery);
			
			// Printing the name of the student and the course 
			while(rs.next()) {%>
			<h3><%=rs.getString("firstName") %> <%=rs.getString("lastName") %>'s grades in <%=courseID%></h3>
			<% 
			}
			
			// Checking the grades 
			String primaryKey = userID + "_" + courseID; 
			String getGradesQuery = "SELECT quiz, assignment, finals FROM assessment WHERE pKey = '" + primaryKey + "'"; 
			
			rs = st.executeQuery(getGradesQuery); 
			
			// No grades found 
			if(!rs.isBeforeFirst()) {%>
				<p>You have not been graded yet!</p>
				<% 
			}
			// Grades found 
			else {
				// Printing the results
				while(rs.next()) {%>
					<p>Quiz: <%=rs.getString("quiz")%></p>
					<p>Assignment: <%=rs.getString("assignment") %></p>
					<p>Finals: <%=rs.getString("finals") %></p>
					<% 
				}
			}
			
			// Closing ResultSet, Statement and Connection 
			rs.close(); 
			st.close(); 
			con.close(); 
			
		} catch(SQLException e) {
			e.printStackTrace(); 
		}
		  
		
		%>
		
	</div>
</body>
</html>