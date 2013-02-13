<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<title>Students</title>
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

            <%-- -------- SELECT Statement Code Graduate-------- --%>
            <%
                    Statement statement = conn.createStatement();

                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM graduate, student WHERE student.student_id = graduate.student_id");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="0">
                    <tr>Graduate</tr>
                    <tr>
                        <th>Student ID</th>
                        <th>SSN</th>
                        <th>First</th>
			            <th>Middle</th>
                        <th>Last</th>
                        <th>Residency</th>
                        <th>Enrollment</th>
                        <th>Attendance</th>
                        <th>Hold Degrees</th>
                        <th>Department</th>
                        <th>Degree</th>
                        <th>State</th>
                        <th>Action</th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    while ( rs.next() ) {
                        String studentId = rs.getString("student_id");
                        int ssn = rs.getInt("ssn");
                        String firstname = rs.getString("firstname");
                        String middlename = rs.getString("middlename");
                        String lastname = rs.getString("lastname");
                        String residency = rs.getString("residency");
                        String attendances = rs.getString("attendances");
                        String holdDegrees = rs.getString("hold_degrees");
                        String isEnrolled = rs.getBoolean("is_enrolled")? "yes" : "no";
                        String department = rs.getString("department");
                        String degree = rs.getString("degree_type");
                        String state = rs.getString("state");
                        if (state == null)
                        	state = "";
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="update" name="action">
                            <td><input value="<%= rs.getString("student_id") %>"  name="student_id" size="8"></td>
                            <td><input value="<%= ssn  %>" name="ssn" size="8"></td>
                            <td>
                                <input value="<%= firstname %>" name="firstname" size="10">
                            </td>
                            <td>
                                <input value="<%= middlename %>" name="middlename" size="10">
                            </td>
                            <td>
                                <input value="<%= lastname %>" name="lastname" size="10">
                            </td>

                            <td>
                                <input value="<%= residency %>" name="residency" size="10">
                            </td>
                            
                            <td>
                                <input value="<%= isEnrolled %>" name="is_enrolled" size="3">
                            </td>

                            <td>
                                <input value="<%= attendances %>" name="attendances" size="15">
                            </td>
                            
                            <td>
                                <input value="<%= holdDegrees %>" name="hold_degrees" size="15">
                            </td>

                            <td>
                                <input value="<%= department %>" name="department">
                            </td>
                            
                            <td>
                                <input value="<%= degree %>" name="degree">
                            </td>                            
                            
                            <td>
                                <input value="<%= state %>" name="state">
                            </td>
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
            
            <%-- -------- SELECT Statement Code Undergraduate -------- --%>

                <%
                    statement = conn.createStatement();

                    rs = statement.executeQuery
                        ("SELECT * FROM undergraduate, student WHERE student.student_id = undergraduate.student_id");
            %>
            <!-- Add an HTML table header row to format the results -->
                <table border="0">
                    <tr>Undergraduate</tr>
                    <tr>
                        <th>Student ID</th>
                        <th>SSN</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
                        <th>Residency</th>
                        <th>Enrollment</th>
                        <th>College</th>
                        <th>Major</th>
                        <th>Minor</th>
                        <th>Type</th>
                        <th>Action</th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    while ( rs.next() ) {
                        String studentId = rs.getString("student_id");
                        int ssn = rs.getInt("ssn");
                        String firstname = rs.getString("firstname");
                        String middlename = rs.getString("middlename");
                        String lastname = rs.getString("lastname");
                        String residency = rs.getString("residency");
                        String attendances = rs.getString("attendances");
                        String isEnrolled = rs.getBoolean("is_enrolled")? "yes" : "no";
                        String college = rs.getString("college");
                        String major = rs.getString("major");
                        String minor = rs.getString("minor");
                        String type = rs.getString("type");
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="update" name="action">
                            <td><input value="<%= rs.getString("student_id") %>"  name="student_id" size="8"></td>
                            <td><input value="<%= ssn  %>" name="ssn" size="8"></td>
                            <td>
                                <input value="<%= firstname %>" name="firstname" size="10">
                            </td>
                            <td>
                                <input value="<%= middlename %>" name="middlename" size="10">
                            </td>
                            <td>
                                <input value="<%= lastname %>" name="lastname" size="10">
                            </td>

                            <td>
                                <input value="<%= residency %>" name="residency" size="10">
                            </td>
                            
                            <td>
                                <input value="<%= isEnrolled %>" name="is_enrolled" size="3">
                            </td>

                            <td>
                                <input value="<%= college %>" name="college">
                            </td>                            

                            <td>
                                <input value="<%= major %>" name="major">
                            </td>                            
                            
                            <td>
                                <input value="<%= minor %>" name="minor">
                            </td>

                            <td>
                                <input value="<%= type %>" name="type">
                            </td>
    
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
    <div style="text-align:center;">
        <form action="newstudent.jsp" method="POST" >
            <input type="submit" value="Insert" style = "margin-top: 20px">
        </form>
    </div>
</body>

</html>
