<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Courses</title>
</head>
<body style="text-align:center; margin-left: auto; margin-right: auto;margin-top: 30px;">
<table border="1" style = "text-align:left; width: 60%; margin:auto">
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
                        String[] prerequisiteList = request.getParameterValues("prerequisite");

                        for (String prerequisite : prerequisiteList) {
                            System.out.println(prerequisite);
                        }
                    	
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

                        pstmt = conn.prepareStatement("INSERT INTO prerequisite VALUES (?, ?)");

                        for (String prerequisite : prerequisiteList) {
                            pstmt.setString(1, course_id);
                            pstmt.setString(2, prerequisite);
                            rowCount = pstmt.executeUpdate();
                        }
                        
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
                <table border="1" style = "text-align:center; width: 80%; margin:auto">
                    <tr>
                        <th>Course ID</th>
                        <th>Department</th>
                        <th>Consent</th>
						<th>Unit Range</th>
                        <th>Grade Type</th>
                        <th>Labwork</th>
                        <th>Prerequisite</th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
                        String prerequisite = "";
        
            %>
                    <tr>
                            <td><%= rs.getString("course_id") %></td>
                            <td><%= rs.getString("department") %></td>    
                            <td><%= rs.getString("is_consent") %></td>
                            <td><%= rs.getString("unit_range") %></td>
                            <td><%= rs.getString("grade_type") %></td>
                            <td><%= rs.getBoolean("labwork") %></td>

                            <%
                            PreparedStatement pstmt = conn.prepareStatement(
                            "SELECT pre_course_id FROM prerequisite WHERE prerequisite.course_id=?");
                                pstmt.setString(1, rs.getString("course_id"));
                                ResultSet rsPre = pstmt.executeQuery();
                                //String sql = "SELECT pre_course_id FROM prerequisite WHERE prerequisite.course_id='CSE202'";
                                //ResultSet rsPre = statement.executeQuery(sql);
                                //System.out.println("SELECT pre_course_id FROM prerequisite as p WHERE p.course_id='" + rs.getString("course_id")+"'");
                                prerequisite = "";
                                System.out.println(prerequisite);
                                while (rsPre.next()) {
                                    prerequisite += rsPre.getString("pre_course_id");
                                    prerequisite += ";";
                                }
                            %>

                            <td><%= prerequisite %></td>
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