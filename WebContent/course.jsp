<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tritonlink Home</title>
</head>
<body style="width: 1000px; height: 600px; text-align:center; margin-left: auto; margin-right: auto;margin-top: 30px;">
<table border="1" style = "text-align:left;">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page language="java" import="db.Config" %>
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load JDBC Driver class file
                    DriverManager.registerDriver
                        (new com.microsoft.sqlserver.jdbc.SQLServerDriver());
    
                    // Make a connection to the MS SQL Server datasource "tritonlink"
                    Connection conn = DriverManager.getConnection(Config.connectionURL);
            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {
                    	// Preprocess submitted form data
                    	
                    	String course_id = request.getParameter("course_id");
                    	String department = request.getParameter("department");                    	                        
                    	String is_consent = request.getParameter("is_consent");
                    	String unit_range = request.getParameter("unit_range");
                    	String grade_type = request.getParameter("grade_type");
                    	String labwork = request.getParameter("labwork");
                    	
                    	
                    	System.out.println(course_id);
                    	System.out.println(department);
                    	System.out.println(Boolean.parseBoolean(request.getParameter("is_consent")));
                    	System.out.println(unit_range);
                    	System.out.println(grade_type);
                    	System.out.println(Boolean.parseBoolean(request.getParameter("labwork")));
                    	
                    	// Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Course VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("course_id"));
                        pstmt.setString(2, request.getParameter("department"));
                        pstmt.setBoolean(3, Boolean.parseBoolean(request.getParameter("is_consent")));
                        pstmt.setString(4, request.getParameter("unit_range"));
                        pstmt.setString(5, request.getParameter("grade_type"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("labwork")));
                        

                        int rowCount = pstmt.executeUpdate();
                        
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %> <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>course_id</th>
                        <th>department</th>
                        <th>is_consent</th>
						<th>unit_range</th>
                        <th>grade_type</th>
                        <th>labwork</th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>
                    <tr>
                            <td><%= rs.getInt("course_id") %></td>
                            <td><%= rs.getString("department") %></td>    
                            <td><%= rs.getString("is_consent") %></td>
                            <td><%= rs.getString("unit_range") %></td>
                            <td><%= rs.getString("grade_type") %></td>
                            <td><%= rs.getString("labwork") %></td>
                            <td><input type = "submit" value="Update"></td>
                            <td><input type = "submit" value="Delete"></td>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
     </table>
     <div style="text-align:center;">
        <form action="newcourse.jsp" method="POST" >
			<input type="submit" value="Insert" style = "margin-top: 20px">
		</form>
	</div>
</body>
</html>