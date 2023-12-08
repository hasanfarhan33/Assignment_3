

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*; 

/**
 * Servlet implementation class AddGradesServlet
 */
@WebServlet("/AddGradesServlet")
public class AddGradesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// Variables to connect to the database
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
		pw.println("<title>Adding Grades...</title>");
		
		// Getting info using getAttribute and getParameter 
		HttpSession session = req.getSession(); 
		String courseID = (String) session.getAttribute("courseID"); 
		String userID = (String) session.getAttribute("userID"); 
		int quizGrade = Integer.parseInt(req.getParameter("quizGrade")); 
		int assignmentGrade = Integer.parseInt(req.getParameter("assignmentGrade")); 
		int finalGrade = Integer.parseInt(req.getParameter("finalGrade")); 
		
//		System.out.println("\n__INFORMATION__"); 
//		System.out.println("Course ID: " + courseID); 
//		System.out.println("User ID: " + userID); 
//		System.out.println("Quiz Grade: " + quizGrade); 
//		System.out.println("Assignment Grade: " + assignmentGrade); 
//		System.out.println("Final Grade: " + finalGrade); 
		
		// CONNECTING TO DATABASE 
		// Adding JDBC 
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
				System.out.println("CONNECTED TO THE DATABASE"); 
			else 
				System.out.println("There is something wrong!"); 
			
			String primaryKey = userID + "_" + courseID; 
			// Query to insert grades into the table 
			String insertGradeQuery = "INSERT INTO assessment (pKey, user_ID, course_ID, quiz, assignment, finals) VALUES ('" + primaryKey + "', '" + userID + "', '" + courseID + "', '" + quizGrade + "', '" + assignmentGrade + "', '" + finalGrade + "')"; 
			
			// Statement to execute query and ResultSet to store the result
			Statement st = con.createStatement();
			ResultSet rs = null; 
			
			
			st.executeUpdate(insertGradeQuery);
			
			// CHECKING IF THE GRADES HAVE BEEN ADDED TO THE DATABASE 
			String checkGradesQuery = "SELECT pKey, user_ID, course_ID, quiz, assignment, finals FROM assessment WHERE pKey = '" + primaryKey + "'"; 
			
			rs = st.executeQuery(checkGradesQuery); 
			
			// Grades not added
			if(!rs.isBeforeFirst()) 
				System.out.println("The grades were not added, there is something wrong in AddGradesServlet"); 
			// Grades added
			else {
				pw.println("<h3>The grades have been added</h3>");
				// Printing the grades and user info 
				while(rs.next()) {
					pw.println("<p>User ID: " + rs.getString("user_ID") + "</p>"); 
					pw.println("<p>Course ID: " + rs.getString("course_ID") + "</p>"); 
					pw.println("<p>Quiz Grade: " + rs.getString("quiz") + "</p>"); 
					pw.println("<p>Assignment Grade: " + rs.getString("assignment") + "</p>"); 
					pw.println("<p>Finals Grade: " + rs.getString("finals") + "</p>"); 					
				}
				
				System.out.println("THE GRADES HAVE BEEN SUCCESSFULLY ADDED"); 
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		
		
	}

}
