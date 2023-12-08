

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;
import java.sql.*; 
import java.sql.*;
/**
 * Servlet implementation class RegisterCoursesServlet
 */
@WebServlet("/RegisterCoursesServlet")
public class RegisterCoursesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// Variables to connect to the DB 
	static final String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
	static final String user = "hasanfarhan33"; 
	static final String pass = "Farhan@1998"; 
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		res.setContentType("text/html"); 
		// PrintWriter to write on page 
		PrintWriter pw = res.getWriter(); 
		
		pw.println("<title>Registering...</title>"); 
		
		// Create session to get variables from the session 
		HttpSession session = req.getSession(); 
		String userID = (String) session.getAttribute("userID"); 
		
//		System.out.println("USERNAME IN SERVLET: " + userID); 
		
		// Getting the courses selected by the student
		String[] selectedCourses = req.getParameterValues("courseCheckbox"); 
//		System.out.println("This is the username: " + userID); 
//		System.out.println("The user has selected the following courses"); 
		for(String curCourse: selectedCourses) 
			System.out.println(curCourse);
		
		// ADDING THE COURSES TO DB  
		// Adding JDBC Driver 
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// Connecting to DB 
		try {
			Connection con = DriverManager.getConnection(databaseUrl, user, pass); 
			
			if(con != null)
				System.out.println("Connected to the database from RegisterCourses Servlet!"); 
			
			String insertQuery = null; 
			Statement st = null; 
			ResultSet rs = null;
			// Insert query for each course is different, therefore insert query in for loop
			for(int i = 0; i < selectedCourses.length; i++) {
				String uniqueIDToEnter = userID + "_" + selectedCourses[i]; 
				insertQuery = "INSERT INTO user_course (uniqueID, userID, courseID) VALUES ('" + uniqueIDToEnter + "', '" + userID + "', '" + selectedCourses[i] + "')";
				st = con.createStatement(); 
				st.executeUpdate(insertQuery); 
			}
			
			// CHECKING IF THE USER HAS BEEN REGISTERED 
			String checkUserQuery = "SELECT * FROM user_course WHERE userID = '" + userID + "'"; 
			rs = st.executeQuery(checkUserQuery); 
			
			String dbUniqueID = null; 
			String dbUserID = null; 
			String dbCourseID = null; 
			int querySize = 0; 
			
			if(!rs.isBeforeFirst())
				System.out.println("The user has not been added, there is something wrong."); 
			else {
				while(rs.next()) {
					querySize++; 
				}
			}
			// If the querySize is the same as the length of selected courses, then all the courses have been added successfully
			if(querySize == selectedCourses.length) {
				System.out.println("The user has been registered to the courses");
				pw.println("<p>You have been registered for the following courses:</p>");
				for(String curCourse : selectedCourses) 
					pw.println("<p>" + curCourse + "</p>"); 
				
				pw.println("<p>Click here to go back to the <a href = \"loginPage.jsp\">login</a> page.</p>"); 
			}
			else 
				System.out.println("There is something wrong with your code."); 
				 
			
			
			
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
	}

}
