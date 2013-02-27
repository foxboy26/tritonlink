<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Tritonlink - Classes</title>
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
<%@ page language="java" import="db.ClassSection" %>
<%@ page language="java" import="db.Meeting" %>
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
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_classlist.html" />
            <div class="span10">
            <%
                Statement statement = conn.createStatement();

                ResultSet rs = statement.executeQuery
                    ("SELECT * FROM Class");
            %>
                <table class="table table-hover">
                    <tr>
                        <th>Course ID</th>
                        <th>Quarter</th>
                        <th>Title</th>
                    </tr>
            <%
                    while ( rs.next() ) {
                        String courseId = rs.getString("course_id");
                        String quarter = rs.getString("quarter");
                        String title = rs.getString("title");
            %>
                    <tr onclick="document.location = 'class.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>';">
                        <td><%= courseId %></td>
                        <td><%= quarter %></td>    
                        <td><%= title %></td>                          
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
            $('#nav-class').addClass('active');
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
            String courseId = request.getParameter("course_id");
            String quarter = request.getParameter("quarter");
            quarter += " ";
            quarter += request.getParameter("year");
            String title = request.getParameter("title");

            // Begin transaction
            conn.setAutoCommit(false);
            
            // INSERT the class attributes INTO the Class table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO Class VALUES (?, ?, ?)");
            pstmt.setString(1, courseId);
            pstmt.setString(2, quarter);
            pstmt.setString(3, title);
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
