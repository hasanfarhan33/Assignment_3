<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add User</title>
</head>
<body>
	<div style = "text-align: center;">
		<h1>Add User</h1>
		<%-- FORM to add the user, uses POST method, sends user details - firstName, lastName, phoneNo, userName, password and role to the AddUserServlet after clicking on the button --%>
		<form action = "/Assignment_3/AddUserServlet" method = "post" autocomplete = "off">
			<label for = "firstName">First Name: </label>
			<input type = "text" id = "firstName" name = "firstName" placeholder = "Enter your first name"><br><br>
			
			<label for = "lastName">Last Name: </label>
			<input type = "text" id = "lastName" name = "lastName" placeholder = "Enter your last name"><br><br>
			
			<label for = "phoneNo">Phone No: </label>
			<input type = "tel" id = "phoneNo" name = "phoneNo" pattern = "[0-9]{10}"><br><br>
			
			<label for = "username">Username: </label>
			<input type = "text" id = "userName" name = "userName" placeholder = "Enter your username"><br><br>
			
			<label for = "password">Password: </label>
			<input type = "password" id = "password" name = "password" placeholder = "Enter your password"><br><br>
			
			<label for = "role">Role: </label>
			<select id = "role" name = "role">
				<option value = "Student">Student</option>
				<option value = "Teacher">Teacher</option>
				<option value = "Admin">Admin</option>
			</select><br><br>
			<button type = "submit" name = "submit" value = "submit">Add User</button>
		</form>
	</div>
	
	<a href = "adminPage.jsp">Back</a>
</body>
</html>