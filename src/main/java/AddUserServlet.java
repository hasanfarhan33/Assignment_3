

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
@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// Variables to log into the database
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
		// TODO Auto-generated method stub
		res.setContentType("text/html"); 
		// PrintWriter to write on the page 
		PrintWriter pw = res.getWriter(); 
		pw.println("<title>Adding to database...</title>");
		
		// Getting form data 
		String firstName = req.getParameter("firstName"); 
		String lastName = req.getParameter("lastName"); 
		String phoneNo = req.getParameter("phoneNo"); 
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");  
		String role = req.getParameter("role");
		
//		System.out.println("First Name: " + firstName); 
//		System.out.println("Last Name: " + lastName); 
//		System.out.println("Phone Number: " + phoneNo); 
//		System.out.println("Username: " + userName); 
//		System.out.println("Password: " + password);
//		System.out.println("Role: " + role); 
		
		// Adding the JDBC Driver to the file 
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
				System.out.println("Connected to the database!"); 
			
			// SQL query to get the user details 
			String query = "SELECT * FROM user WHERE userID = '" + userName + "'";
			
			//Statement to execute query and ResultSet to store the result 
			Statement st = con.createStatement(); 
			ResultSet rs = st.executeQuery(query); 
			
			// Checking if the user already exists in the database 
			if(!rs.isBeforeFirst()) {
				// TODO: Add the user to the database 
				String insertQuery = "INSERT INTO user (userID, firstName, lastName, phone, role, password) VALUES ('" + userName + "', '" + firstName + "', '" + lastName + "', '" + phoneNo + "', '" + role + "', '" + password + "')"; 
				st.executeUpdate(insertQuery);  
				
				// Checking if the user has been added 
				query = "SELECT * FROM user WHERE userID = '" + userName + "'"; 
				rs = st.executeQuery(query);
				
				if(rs.isBeforeFirst()) {
					pw.println("<p>The following user has been added to the database: </p><br>"); 
					
					String dbUserName = null; 
					String dbFirstName = null; 
					String dbLastName = null;
					String dbPhone = null; 
					String dbRole = null; 
					
					//Getting the variables of the new user
					while(rs.next()) {
						dbUserName = rs.getString("userID"); 
						dbFirstName = rs.getString("firstName"); 
						dbLastName = rs.getString("lastName");
						dbPhone = rs.getString("phone"); 
						dbRole = rs.getString("role"); 
					}
					
					// Printing out the information of the new user to the page 
					pw.println("<p>Username: " + dbUserName + "</p>"); 
					pw.println("<p>First Name: " + dbFirstName + "</p>"); 
					pw.println("<p>Last Name: " + dbLastName + "</p>"); 
					pw.println("<p>Phone Number: " + dbPhone + "</p>"); 
					pw.println("<p>Role: " + dbRole + "</p><br>"); 
					
					System.out.println("INSERTED INTO THE DATABASE!");
					
					// Closing the connection 
					con.close(); 
					
					// Link to go back to the addUserPage.jsp
					pw.println("<a href = \"addUserPage.jsp\">Add User Page</a>"); 
					
				}
				
				 
			}
			// Username already exists!
			else {
				pw.println("<h3 style = \"color: red;\">Username already taken!</h3>"); 
				pw.println("<a href = \"addUserPage.jsp\">Add User Page</a>"); 
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		
		
		
		
	}

}
