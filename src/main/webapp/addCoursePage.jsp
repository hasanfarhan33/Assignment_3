<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Course</title>
</head>
<body>
	<div style="text-align: center;">
	<h1>Add Course</h1>
	<%-- FORM to fill course details, uses POST method, sends the details - courseID, courseName and semester to AddCourseServlet --%>
	<form action = "/Assignment_3/AddCourseServlet" method = "post" autocomplete = "off">
		<label for="courseID">Course ID: </label>
		<input type = "text" id = "courseID" name = "courseID" placeholder = "Enter Course ID"><br><br>
		
		<label for = "courseName">Course Name: </label>
		<input type = "text" id = "courseName" name = "courseName" placeholder = "Enter the name of the course"><br><br>
		
		<label for = "semester">Semester: </label>
		<select id = "semester" name = "semester">
				<option value = "Spring">Spring</option>
				<option value = "Fall">Fall</option>
				<option value = "Summer">Summer</option>
		</select><br><br>
		
		<button type = "submit" id = "submit" value = "submit">Add Course</button>
	</form>
	</div>
	<%-- Going back to admin page --%>
	<a href = "adminPage.jsp">Back</a>
	
</body>
</html>