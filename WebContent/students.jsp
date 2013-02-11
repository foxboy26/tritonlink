<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<title>Tritonlink Home</title>
</head>
<body>
    <table border="1">
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
                    	StringBuilder sb;
                    	
                    	String[] holdUniversity = request.getParameterValues("university");
                    	String[] holdDegreeType = request.getParameterValues("degree_type");
                    	sb = new StringBuilder();
                        for (int i = 0; i < holdUniversity.length; i++) {
                            sb.append(holdUniversity[i]);
                            sb.append(' ');
                            sb.append(holdDegreeType[i]);
                            sb.append(';');
                        }
                        String holdDegrees = sb.toString();
                        
                    	String[] beginQuarter = request.getParameterValues("begin_quarter");
                    	String[] beginYear = request.getParameterValues("begin_year");
                    	String[] endQuarter = request.getParameterValues("end_quarter");
                    	String[] endYear = request.getParameterValues("end_year");
                    	sb = new StringBuilder();
                    	for (int i = 0; i < beginQuarter.length; i++) {
                    		sb.append(beginQuarter[i]);
                    		sb.append(beginYear[i]);
                    		sb.append('-');
                            sb.append(endQuarter[i]);
                            sb.append(endYear[i]);
                            sb.append(';');
                    	}
                    	String attendances = sb.toString();
                    	
                    	System.out.println(holdDegrees);
                    	System.out.println(attendances);
                    	System.out.println(Boolean.parseBoolean(request.getParameter("is_enrolled")));
                    	// Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_id"));
                        pstmt.setString(2, request.getParameter("firstname"));
                        pstmt.setString(3, request.getParameter("middlename"));
                        pstmt.setString(4, request.getParameter("lastname"));
                        if (!request.getParameter("ssn").equals(""))
                            pstmt.setInt(5, Integer.parseInt(request.getParameter("ssn")));
                        else
                        	pstmt.setNull(5, Types.INTEGER);
                        pstmt.setString(6, request.getParameter("residency"));
                        pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("is_enrolled")));
                        pstmt.setString(8, holdDegrees);
                        pstmt.setString(9, attendances);

                        int rowCount = pstmt.executeUpdate();

                        
                        String identity = request.getParameter("identity");
                        
                        
                        if (identity != null && identity.equals("undergraduate")) {
                            pstmt = conn.prepareStatement(
                                    "INSERT INTO undergraduate VALUES (?, ?, ?, ?, ?)");

                                pstmt.setString(1, request.getParameter("student_id"));
                                pstmt.setString(2, request.getParameter("college"));
                                pstmt.setString(3, request.getParameter("major"));
                                pstmt.setString(4, request.getParameter("minor"));
                                pstmt.setString(5, request.getParameter("type"));
                                
                                rowCount = pstmt.executeUpdate();                        	
                        }

                        if (identity != null && identity.equals("graduate")) {
                        	System.out.println(request.getParameter("department"));
                        	System.out.println(request.getParameter("degree"));
                        	System.out.println(request.getParameter("state"));
                            pstmt = conn.prepareStatement(
                                    "INSERT INTO graduate VALUES (?, ?, ?, ?)");

                                pstmt.setString(1, request.getParameter("student_id"));
                                pstmt.setString(2, request.getParameter("department"));
                                pstmt.setString(3, request.getParameter("degree"));
                                if (request.getParameter("state") == null)
                                	pstmt.setNull(4, Types.VARCHAR);
                                else
                                	pstmt.setString(4, request.getParameter("state"));
                                rowCount = pstmt.executeUpdate();
                        }
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Student SET STUDENT_ID = ?, FIRSTNAME = ?, " +
                            "MIDDLENAME = ?, LASTNAME = ?, RESIDENCY = ? WHERE SSN = ?");

                        pstmt.setString(1, request.getParameter("ID"));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        pstmt.setString(3, request.getParameter("MIDDLENAME"));
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        pstmt.setString(5, request.getParameter("RESIDENCY"));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE SSN = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="0">
                    <tr>
                        <th>SSN</th>
                        <th>ID</th>
                        <th>First</th>
			<th>Middle</th>
                        <th>Last</th>
                        <th>Residency</th>
                        <th>Action</th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("STUDENT_ID") %>" 
                                    name="ID" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FIRSTNAME") %>"
                                    name="FIRSTNAME" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("MIDDLENAME") %>" 
                                    name="MIDDLENAME" size="15">
                            </td>
    
			    <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LASTNAME") %>" 
                                    name="LASTNAME" size="15">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("RESIDENCY") %>" 
                                    name="RESIDENCY" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("SSN") %>" name="SSN">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
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
</body>

</html>
