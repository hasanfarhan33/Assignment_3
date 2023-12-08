<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%--TITLE OF THE PAGE --%>
<title>NUI Galway Login</title>
</head>
<body>
	<div style="text-align: center">
		<h1>NUI Galway Login</h1>
		<%-- LOGIN FORM, USER INPUTS THEIR USERNAME AND PASSWORD, THEN CLICKS ON A BUTTON --%>
		<form action = "/Assignment_3/LoginServlet" method="post">
			<label for = "username">Username: </label>
			<input type = "text", id = "username" name = "username" autocomplete = "off"><br><br>
			
			<label for="password">Password: </label>
			<input type = "password", id = "password", name = "password" autocomplete = "off"><br><br>
			
			<button type = "submit", name = "submit", value = "submit">Sign in</button>
		</form>
	</div>
</body>
</html>