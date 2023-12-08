<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Assign Grades</title>
</head>
<body>
	<div style = "text-align: center;">
		<h1>Assign Grades</h1>
		<%-- CONNECTING TO THE DATABASE --%>
		<%
		String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
		String user = "hasanfarhan33"; 
		String pass = "Farhan@1998"; 
		
		// Adding JDBC
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace(); 
		}
		
		// Connecting to DB 
		try {
			Connection con = DriverManager.getConnection(databaseUrl, user, pass); 
			if(con != null)
				System.out.println("Connected to the database from assignGradesPage"); 
			else 
				System.out.println("CANNOT connect to DB from assignGradesPage"); 
			
			// Getting userID from URL 
			String userID = request.getParameter("userID"); 
			session.setAttribute("userID", userID); 
			System.out.println("USER ID: " + userID); 
			
			// Getting courseID form session 
			String courseID = (String) session.getAttribute("courseID"); 
			System.out.println("COURSE ID: " + courseID);
			
			// Query to get user info 
			String getUserInfoQuery = "SELECT userID, firstName, lastName FROM user WHERE userID = '" + userID + "'"; 
			
			// Statement to execute query and ResultSet to store the result 
			Statement st = con.createStatement(); 
			ResultSet rs = st.executeQuery(getUserInfoQuery); 
			
			// User does not exist 
			if(!rs.isBeforeFirst())
				System.out.println("The user does not exist. There is something wrong"); 
			// User found 
			else {
				while(rs.next()) {%>
					<h3>Enter the grades for <%=rs.getString("firstName") %> <%=rs.getString("lastName")%></h3>
					<% 
				}
				// CREATING THE FORM TO ENTER THE GRADES
				%>
				<%-- The form uses POST method and send the grades to AddGradesServlet after clicking on the submit button --%>
				<form action = "/Assignment_3/AddGradesServlet" method = "post">
					<label for="quizGrade">Quiz: </label>
					<input type = "text" id = "quizGrade" name = "quizGrade"><br><br>
					
					<label for="assignmentGrade">Assignment: </label>
					<input type = "text" id = "assignmentGrade" name = "assignmentGrade"><br><br>
					
					<label for="finalGrade">Finals: </label>
					<input type = "text" id = "finalGrade" name = "finalGrade"><br><br>
					
					<button type = "submit" name = "submit" id = "submit">Submit Grades</button>
				</form>
				<% 
				
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace(); 
		}
			
		%>
		
	</div>
</body>
</html>