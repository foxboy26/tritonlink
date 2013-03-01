<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Teach list</title>
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

        String facultyId = request.getParameter("facultyId");

        Statement statement = conn.createStatement();
        ResultSet rs;
%>
<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_faculty.html" />

            <div class="span10">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>Course ID</th>
                        <th>Quarter</th>
                        <th>Title</th>
                    </tr>
                <%
                    String sql = "SELECT c.course_id, c.quarter, c.title" +
                                 " FROM class AS c, class_section AS cs, teach AS t" +
                                 " WHERE c.course_id=cs.course_id" + 
                                 " AND c.quarter=cs.quarter" +
                                 " AND cs.section_id=t.section_id" + 
                                 " AND t.faculty_id='" + facultyId + "'" + 
                                 " ORDER BY c.quarter";

                    rs = statement.executeQuery(sql);
                    int i = 1;
                    while ( rs.next() ) {
                        String courseId = rs.getString("course_id");
                        String quarter = rs.getString("quarter");
                %>
                    <tr onclick="document.location = 'class.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>';">
                        <td><%= i++ %></td>
                        <td><%= rs.getString("course_id") %></td>
                        <td><%= rs.getString("quarter") %></td>
                        <td><%= rs.getString("title") %></td>
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
            $('#sub-teachlist').addClass('active');

            $('#sub-teachlist > a').attr('href', 'teachlist.jsp?facultyId=<%= facultyId %>');
        });
    </script>
</body>
</html>
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
