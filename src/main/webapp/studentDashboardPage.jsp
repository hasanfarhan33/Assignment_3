<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Dashboard</title>
</head>
<body>
	<%-- CONNECTING TO THE DATABASE --%>
	<%
	String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
	String user = "hasanfarhan33"; 
	String pass = "Farhan@1998"; 
	
	// Adding JDBC Driver to the File 
	try {
		Class.forName("com.mysql.jdbc.Driver"); 
	} catch (ClassNotFoundException e1) {
		e1.printStackTrace(); 
	}
	
	// Connecting to the Database 
	try {
		Connection con = DriverManager.getConnection(databaseUrl, user, pass); 
		
		if(con != null)
			System.out.println("Connected to the database from JSP FILE"); 
		else 
			System.out.println("Cannot connect to the database!"); 
		
		// GETTING THE NAME OF THE STUDENT
		String nameQuery = "SELECT firstName, lastName FROM user WHERE userID = '" + request.getAttribute("userID") + "'";
		
		// Statement to execute query and ResultSet to store the result
		Statement st = con.createStatement(); 
		ResultSet rs = st.executeQuery(nameQuery); 	
		
		// User not found
		if(!rs.isBeforeFirst()) {
			System.out.println("THERE IS SOMETHING WRONG"); 
		}
		// User found
		else {
			// Printing the name of the user to the page 
			while(rs.next()) { %>
				
	<div style = "text-align: center;">
		<h1>Welcome <%=rs.getString("firstName") %> <%=rs.getString("lastName") %></h1>
		<%}
			}
		
		// GETTING THE REGISTERED COURSES
		String courseQuery = "SELECT course.courseID, course.courseName, course.semester from course WHERE course.courseID IN (SELECT user_course.courseID FROM user INNER JOIN user_course ON user.userID = user_course.userID WHERE user_course.userID = '" + request.getAttribute("userID") + "')"; 
		
		rs = st.executeQuery(courseQuery); 
		// User not enrolled in any courses 
		if(!rs.isBeforeFirst()) {
			System.out.println("NOT ENROLLED IN ANY COURSES!");
			%>
			<h3>You are not registered in any of the courses!</h3>
			<% session.setAttribute("userID", request.getAttribute("userID")); %>
			<%-- Going to registerCoursesPage.jsp since the user is not enrolled in any courses --%>
			<p>Click <a href = "registerCoursesPage.jsp">here</a> to register for available courses.</p>
			
			<% 
			
		}
		// User is registered in a course or more 
		else { %>
			<h3>You are registered for the following courses</h3>
			<table style = "margin-left: auto; margin-right: auto; border: 1px solid;">
				<tr style = "border: 1px solid;">
					<th style = "border: 1px solid;">Course ID</th>
					<th style = "border: 1px solid;">Course Name</th>
					<th style = "border: 1px solid;">Semester</th>
					<th style = "border: 1px solid;">Grades</th>
				</tr>
				<%-- Creating a table with all the courses the user is enrolled in --%>
				<%while(rs.next()) { %>
				<tr style = "border: 1px solid;">
					<td style = "border: 1px solid;"><%=rs.getString("course.courseID") %></td>
					<td style = "border: 1px solid;"><%=rs.getString("course.courseName") %></td>
					<td style = "border: 1px solid;"><%=rs.getString("course.semester") %></td>
					<%-- ADD CHECK GRADES PAGE AND REDIRECT --%>
					<td style = "border: 1px solid;"><a href = "checkGradesPage.jsp?courseID=<%=rs.getString("course.courseID")%>&studentID=<%=request.getAttribute("userID")%>">Check Grades</a></td>
				</tr>
				<% } %>
			</table>

			<%
		}
		
		// Closing the statement, ResultSet and connection. 
		st.close(); 
		rs.close(); 
		con.close(); 
		
			} catch(SQLException e) {
				e.printStackTrace(); 
			}%>
			<%-- GOING BACK TO THE LOGIN PAGE --%>
		<br><a href = "loginPage.jsp">Login Page</a>
	</div>

</body>
</html>