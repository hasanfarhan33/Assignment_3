<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Courses Page</title>
</head>
<body>
	<div style = "text-align: center;">
		<h1>Register</h1>
		<p>This is your username: <%=session.getAttribute("userID") %></p>
		
		<%-- CONNECTING TO THE DATABASE --%>
		<%
		String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
		String user = "hasanfarhan33"; 
		String pass = "Farhan@1998"; 
		
		// Getting the userID from session 
		String userID = (String) session.getAttribute("userID"); 
		
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
				System.out.println("CONNECTED TO THE DATABASE FROM REGISTER COURSES PAGE"); 
			else 
				System.out.println("Cannot connect to the database!"); 
			
			// Getting all courses 
			String availableCoursesQuery = "SELECT * FROM course"; 
			
			// Statement to execute query and ResultSet to store the result 
			Statement st = con.createStatement(); 
			ResultSet rs = st.executeQuery(availableCoursesQuery);
			
			// No courses available
			if(!rs.isBeforeFirst()) {
				System.out.println("THERE ARE NO COURSES AVAILABLE! THE UNIVERSITY HAS BEEN BURNED INTO A CRISP!"); 
			}
			// CREATING THE FORM 
			else {%>
			<p>Choose the courses you'd like to register for: </p>
			<%-- The form uses POST method to send the info to RegisterCoursesServlet when the button is clicked  --%>
			<form action = "/Assignment_3/RegisterCoursesServlet" method = "post">
				<% 
				while(rs.next()) {%>
					<input type = "checkbox" name = "courseCheckbox" value = <%=rs.getString("courseID") %>><%=rs.getString("courseID")%> - <%=rs.getString("courseName") %> - <%=rs.getString("semester") %><br>					
					<%
				}
				%>
				<br><button type = "submit" id = "submit" value = "submit">Register</button>
			</form>
			<%}
			
			// Closing Statement and ResultSet 
			st.close(); 
			rs.close(); 
			
		} catch(SQLException e) {
			e.printStackTrace(); 
		}%>
		
	</div>
</body>
</html>