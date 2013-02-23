<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Courses</title>
    <style>
        .table th {
            vertical-align: middle;
        }
    </style>
</head>

<body>
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
    
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">Tritonlink 132B</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li><a href="index.jsp">Home</a></li>
              <li><a href="studentlist.jsp">Students</a></li>
              <li><a href="facultylist.jsp">Faculty</a></li>
              <li><a href="courselist.jsp">Course</a></li>
              <li><a href="classlist.jsp">Class</a></li>
              <li class="active"><a href="programlist.jsp">Program</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span2">
                <div class="well sidebar-nav">
                    <ul class="nav nav-list">
                        <li class="nav-header">Actions</li>
                        <li><a href="newprogram.jsp">Add program</a></li>
                        <li class="divider"></li>
                        <li><a onclick="window.history.back()">Back</a></li>
                    </ul>
                </div><!--/.well -->
            </div><!--/span-->

            <div class="span10">
            <%
                Statement statement = conn.createStatement();

                ResultSet rs = statement.executeQuery
                    ("SELECT * FROM program");
            %>
                <table class="table table-hover">
                    <tr>
                        <th>Program name</th>
                        <th>Degree Type</th>
                        <th>Department</th>
                    </tr>
                    
            <%
                while ( rs.next() ) {
            %>
                    <tr>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("degree_type") %></td>
                        <td><%= rs.getString("department") %></td>  
                    </tr>
            <%
                }
            %>
                </table>
            </div>
        </div>
    </div>
</body>
</html>

<%-- -------- INSERT Code -------- --%>
<%
    String action = request.getParameter("action");
    // Check if an insertion is requested
    if (action != null && action.equals("insert")) {
        // Preprocess submitted form data
        
        String programName = request.getParameter("program_name");
        String degreeType = request.getParameter("degree_type");
        String department = request.getParameter("department");
        
        // Begin transaction
        conn.setAutoCommit(false);
        
        // Create the prepared statement and use it to
        // INSERT the student attributes INTO the Student table.
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO Program VALUES (?, ?, ?)");

        pstmt.setString(1, programName);
        pstmt.setString(2, degreeType);
        pstmt.setString(3, department);

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
