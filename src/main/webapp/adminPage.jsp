<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page</title>
</head>
<body>
	<div style="text-align: center;">
		<h1>Welcome Admin!</h1>
		<%-- Turned the links into a button using CSS, one link goes to addUserPage.jsp and another link goes to addCoursePage.jsp --%>
		<a href="addUserPage.jsp" style = "font: bold 1.5em Arial; text-decoration: none; background-color: #EEEEEE; color: #333333; padding: 2px 6px 2px 6px; border-top: 1px solid #CCCCCC; border-right: 1px solid #333333; border-bottom: 1px solid #333333; border-left: 1px solid #CCCCCC;">Add User</a><br><br>
		<a href="addCoursePage.jsp" style = "font: bold 1.5em Arial; text-decoration: none; background-color: #EEEEEE; color: #333333; padding: 2px 6px 2px 6px; border-top: 1px solid #CCCCCC; border-right: 1px solid #333333; border-bottom: 1px solid #333333; border-left: 1px solid #CCCCCC;">Add Course</a>
	</div>
	
</body>
</html>