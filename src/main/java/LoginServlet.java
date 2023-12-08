
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*; 

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final String databaseUrl = "jdbc:mysql://localhost:3306/programming2_assignment3";
	static final String user = "hasanfarhan33"; 
	static final String pass = "Farhan@1998"; 

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		res.setContentType("text/html"); 
		
		// PrintWriter to write on the page 
		PrintWriter pw = res.getWriter(); 
		pw.println("<title>Logging in...</title>"); 
		
		
		// Getting user inputs 
		String username = req.getParameter("username"); 
		String password = req.getParameter("password"); 
		
		// Username, password and role from the Database
		String dbUsername = null; 
		String dbPassword = null; 
		String dbRole = null; 
		
		// System.out.println("Username: " + username); 
		// System.out.println("Password: " + password); 
		
		// Connecting the jdbc driver to the file
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		
		// Connecting to the database 
		try {
			Connection con = DriverManager.getConnection(databaseUrl, user, pass);
			
			if(con != null)
				System.out.println("Connected!");
			
			// SQL query to get the userID, role and password from the user table 
			String query = "SELECT userID, role, password FROM user WHERE userID = '" + username + "'"; 
			
			// Statement to execute the query and result set to store the result 
			Statement st = con.createStatement(); 
			ResultSet rs = st.executeQuery(query);
			
			// This if statement executes if the result set is empty
			if(!rs.isBeforeFirst()) {
				pw.println("<h3 style = \"color: red;\">User not found!</h3><br>");
				pw.println("<a href = \"loginPage.jsp\">Login Page</a>"); 
				
			} 
			else {
				// Go through the result set and store the information in the variables
				while(rs.next()) {
					System.out.println("User ID: " + rs.getString("userID"));
					System.out.println("Password: " + rs.getString("password")); 
					System.out.println("Role: " + rs.getString("role")); 	
					
					dbUsername = rs.getString("userID"); 
					dbPassword = rs.getString("password"); 
					dbRole = rs.getString("role"); 
				}
				// If the usernname and password is equal to the username and password in the database, then the user can login
				if(username.equals(dbUsername) && password.equals(dbPassword)) {
					pw.println("The user can login"); 
					
					// Go to the student page if the user role is student
					if(dbRole.equalsIgnoreCase("student")) {

						// Sending the userID to student page
						req.setAttribute("userID", dbUsername); 
						req.getRequestDispatcher("studentDashboardPage.jsp").forward(req, res); 
							
//						res.sendRedirect(req.getContextPath()+ "/studentDashboardPage.jsp"); 
					}
					// Go to the teacher dashboard if the user role is teacher
					else if(dbRole.equalsIgnoreCase("teacher")) {
						
						// Sending the userID teacher page
						req.setAttribute("userID", dbUsername); 
						req.getRequestDispatcher("teacherDashboardPage.jsp").forward(req, res);
						
//						res.sendRedirect(req.getContextPath() + "/teacherDashboardPage.jsp"); 
						
					}
					// Go to the admin dashboard
					else if(dbRole.equalsIgnoreCase("admin")) {
						// TODO: REDIRECT TO ADMIN DASHBOARD
						res.sendRedirect(req.getContextPath() + "/adminPage.jsp"); 
					}
				}
				// The username or password is wrong.
				else {
					pw.println("<h3 style = \"color: red;\">Wrong username or password!</h3><br>"); 
					pw.println("<a href = \"loginPage.jsp\">Login Page</a>"); 
				
				}
			}
			
			con.close(); 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		
		
	}

}
