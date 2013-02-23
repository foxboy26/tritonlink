<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Tritonlink - Students</title>
    <style>
        .table th {
            vertical-align: middle;
        }
    </style>
</head>

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

<body>
    <jsp:include page="header.html" />

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span2">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">Actions</li>
              <li><a href="newfaculty.jsp">Add faculty</a></li>
              <li class="divider"></li>
              <li><a onclick="window.history.back()">Back</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->

        <div class="span10">
            <%
                Statement statement = conn.createStatement();

                ResultSet rs = statement.executeQuery
                    ("SELECT * FROM faculty");
            %>
            <table class="table table-hover">
                <tr>
                    <th>Faculty ID</th>
                    <th>Name</th>
                    <th>Title</th>
                    <th>Department</th>                       
                </tr>
                    
            <%
                    while ( rs.next() ) {
                        String facultyId = rs.getString("faculty_id");
        
            %>
                <tr onclick="document.location = 'faculty.jsp?&facultyId=' + <%= facultyId %>;">
                    <td><%= rs.getInt("faculty_id") %></td>
                    <td><%= rs.getString("name") %></td>  
                    <td><%= rs.getString("title") %></td>  
                    <td><%= rs.getString("department") %></td>                               
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
            $('#nav-faculty').addClass('active');
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
            
            String faculty_id = request.getParameter("faculty_id");
            String name = request.getParameter("name");  
            String title = request.getParameter("title");  
            String department = request.getParameter("department");                    	                        
                                                        
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Student table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO Faculty VALUES (?, ?, ?, ?)");

            pstmt.setInt(1, Integer.parseInt(faculty_id));
            pstmt.setString(2, name);
            pstmt.setString(3, title);
            pstmt.setString(4, department);

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
