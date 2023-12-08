

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*; 

/**
 * Servlet implementation class AddCourseServlet
 */
@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// Variables to login to the database
	static final String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
	static final String user = "hasanfarhan33"; 
	static final String pass = "Farhan@1998"; 


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html"); 
		// PrintWriter to write on the page 
		PrintWriter pw = res.getWriter(); 
		pw.println("<title>Adding to database... </title>"); 
		
		// Getting course info 
		String courseID = req.getParameter("courseID"); 
		String courseName = req.getParameter("courseName"); 
		String semester = req.getParameter("semester"); 
			
//		System.out.println("Course ID: " + courseID); 
//		System.out.println("Course Name: " + courseName); 
//		System.out.println("Semester: " + semester); 
		
		// Connecting to the database
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		
		try {
			Connection con = DriverManager.getConnection(databaseUrl, user, pass);
			
			if(con != null)
				System.out.println("Connected to the database!");
			
			// SQL Query to get the course details
			String query = "SELECT * FROM course WHERE courseID = '" + courseID + "'"; 
			
			// Statement to execute queries and ResultSet to store the result
			Statement st = con.createStatement(); 
			ResultSet rs = st.executeQuery(query); 
			
			// If the result set is empty, then the course does not exist in the database
			if(!rs.isBeforeFirst()) {
				//SQL query to insert the course into the database using st.executeUpdate()
				String insertQuery = "INSERT INTO course (courseID, courseName, semester) VALUES ('" + courseID + "', '" + courseName + "', '" + semester + "')";  
				st.executeUpdate(insertQuery); 
				
				//SQL query to check if the course has been added to the database
				query = "SELECT * FROM course WHERE courseID = '" + courseID + "'";
				rs = st.executeQuery(query); 
				
				// Executes if the result set is not empty, therefore the course has been added
				if(rs.isBeforeFirst()) {
					pw.println("<p>The following course has been added to the database: </p><br>"); 
					
					String dbCourseID = null; 
					String dbCourseName = null; 
					String dbSemester = null; 
					// Going through the result set 
					while(rs.next()) {
						dbCourseID = rs.getString("courseID"); 
						dbCourseName = rs.getString("courseName"); 
						dbSemester = rs.getString("semester"); 
					}
					// Printing the new course details on the page 
					pw.println("<p>Course ID: " + dbCourseID + "</p>"); 
					pw.println("<p>Course Name: " + dbCourseName + "</p>"); 
					pw.println("<p>Semester: " + dbSemester + "</p>"); 
					
					System.out.println("INSERTED INTO THE DATABASE!");
					
					// Closing the connection 
					con.close(); 
					
					// Going back to add course page 
					pw.println("<a href = \"addCoursePage.jsp\">Add Course Page</a>");
				}
				
			}
			// Course already exists in the database 
			else {
				pw.println("<h3 style = \"color: red;\">Course ID already exists!</h3>"); 
				pw.println("<a href = \"addCoursePage.jsp\">Add Course Page</a>"); 
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}
