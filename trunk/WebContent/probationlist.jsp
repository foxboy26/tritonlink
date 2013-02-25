<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Probation list</title>
</head>

<%-- Set the scripting language to Java and --%>
<%-- Import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@ page language="java" import="db.Config" %>
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
          (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);

        Statement statement;

        ResultSet rs;
%>

<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_studentlist.html" />
            <div class="span10">
            <%
                    statement = conn.createStatement();

                    rs = statement.executeQuery
                        ("SELECT * FROM probation");
            %>

                <table class="table table-hover">
                    <tr>
                        <th>Student ID</th>
                        <th>Start time</th>
                        <th>End time</th>
                        <th>Reason</th>                       
                    </tr>
            <% 
                    while ( rs.next() ) {
        
            %>
                    <tr>
                        <td><%= rs.getInt("student_id") %></td>
                        <td><%= rs.getString("start_time") %></td>  
                        <td><%= rs.getString("end_time") %></td>  
                        <td><%= rs.getString("reason") %></td>                     
                    </tr>
            <%
                    }
            %>
                </table>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-probationlist').addClass('active');
        });
    </script>
</body>
</html>
<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            
            String studentId = request.getParameter("student_id");
            String startTime = request.getParameter("begin_quarter") + request.getParameter("begin_year");
            String endTime = request.getParameter("end_quarter") + request.getParameter("end_year");
            String reason = request.getParameter("reason");                                            
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Student table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO Probation VALUES (?, ?, ?, ?)");

            pstmt.setInt(1, Integer.parseInt(studentId));
            pstmt.setString(2, startTime);
            pstmt.setString(3, endTime);
            pstmt.setString(4, reason);

            int rowCount = pstmt.executeUpdate();
            
            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
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
