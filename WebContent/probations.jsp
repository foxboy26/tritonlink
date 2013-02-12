<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Faculty</title>
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
                        
                        String studentId = request.getParameter("student_id");
                        String startTime = request.getParameter("start_quarter") + request.getParameter("start_year");
                        String endTime = request.getParameter("end_quarter") + request.getParameter("end_year");
                        String reason = request.getParameter("reason");                                            
                        
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Faculty VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(studentId));
                        pstmt.setString(2, startTime);
                        pstmt.setString(3, endTime);
                        pstmt.setString(4, reason);

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
                        ("SELECT * FROM probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" style = "text-align:center; width: 80%; margin:auto">
                    <tr>
                        <th>Student ID</th>
                        <th>Start time</th>
                        <th>End time</th>
                        <th>Reason</th>                       
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>
                    <tr>
                            <td><%= rs.getInt("student_id") %></td>
                            <td><%= rs.getString("start_time") %></td>  
                            <td><%= rs.getString("end_time") %></td>  
                            <td><%= rs.getString("reason") %></td>                               
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
        <form action="newprobation.jsp" method="POST" >
            <input type="submit" value="Insert" style = "margin-top: 20px">
        </form>
    </div>
</body>
</html>