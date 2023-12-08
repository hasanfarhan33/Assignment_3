<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Teacher Dashboard</title>
</head>
<body>
	<div style = "text-align: center;">
		<%-- CONNECTING TO THE DATABASE --%>
		<% 
			String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
			String user = "hasanfarhan33"; 
			String pass = "Farhan@1998"; 
			
			// Adding JDBC Driver to the file
			try {
				Class.forName("com.mysql.jdbc.Driver"); 
			} catch (ClassNotFoundException e1) {
				e1.printStackTrace(); 
			}
			
			// Connecting to the database
			try {
				Connection con = DriverManager.getConnection(databaseUrl, user, pass); 
				
				if(con != null) 
					System.out.println("Connected to the database from the teacher dashboard page");
				else 
					System.out.println("Cannot connect to the database"); 
				
				// GETTING THE NAME OF THE TEACHER 
				String getNameQuery = "SELECT firstName, lastName FROM user WHERE userID = '" + request.getAttribute("userID") + "'"; 
				
				// Statement to execute query and ResultSet to store the result
				Statement st = con.createStatement(); 
				ResultSet rs = st.executeQuery(getNameQuery); 	
				
				// Teacher not found
				if(!rs.isBeforeFirst()) {
					System.out.println("THERE IS SOMETHING WRONG"); 
				}
				// Teacher found
				else {
					// Printing the name of the teacher
					while(rs.next()) {
						%>
						<h1>Welcome <%=rs.getString("firstName") %> <%=rs.getString("lastName") %></h1>
						<% 
					} 
				} 
				
				// GETTING THE REGISTERED COURSES
				String courseQuery = "SELECT course.courseID, course.courseName, course.semester from course WHERE course.courseID IN (SELECT user_course.courseID FROM user INNER JOIN user_course ON user.userID = user_course.userID WHERE user_course.userID = '" + request.getAttribute("userID") + "')"; 
				
				// Executing SQL query 
				rs = st.executeQuery(courseQuery); 
				
				if(!rs.isBeforeFirst()) {
					// NO REGISTERED COURSES 
					%>
					<h3>You are not registered in any of the courses</h3> 
					<% session.setAttribute("userID", request.getAttribute("userID")); %>
					<p>Click <a href = "registerCoursesPage.jsp">here</a> to register for courses.</p>
					<% 
				}
				// Courses found
				else {%>
					<h3>You have been registered for the following courses: </h3>
					<table style = "margin-left: auto; margin-right: auto; border: 1px solid;">
						<tr style = "border: 1px solid;">
							<th style = "border: 1px solid;">Course ID</th>
							<th style = "border: 1px solid;">Course Name</th>
							<th style = "border: 1px solid;">Semester</th>
							<th style = "border: 1px solid;">Registered Students</th>
						</tr>
						<%-- Printing the table of the courses the teacher is registered in --%>
						<%while(rs.next()) { 
			%>
							<tr style = "border: 1px solid;">
								<td style = "border: 1px solid;"><%=rs.getString("course.courseID")%></td>
								<td style = "border: 1px solid;"><%=rs.getString("course.courseName")%></td>
								<td style = "border: 1px solid;"><%=rs.getString("course.semester")%></td>
								<%-- Going to courseStudentsPage.jsp and passing the course ID in the URL --%>
								<td style = "border: 1px solid;"><a href = "courseStudentsPage.jsp?courseID=<%=rs.getString("course.courseID")%>">Registered Students</a></td>
								
							</tr>
							<% } %>
					</table>
				<%
				}
				// Closing Statement, ResultSet and Connection 
				st.close(); 
				rs.close(); 
				con.close(); 
				
				} catch(SQLException e) {
					e.printStackTrace(); 
				}%>
				<%-- Going back to login page --%>
		<br><a href = "loginPage.jsp">Login Page</a>
	</div>
</body>
</html>