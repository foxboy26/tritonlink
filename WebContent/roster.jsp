<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Roster</title>
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

 		String courseId = request.getParameter("courseId");
        
        String quarter = request.getParameter("quarter");

        Statement statement = conn.createStatement();
        ResultSet rs;
%>
<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_class.html" />

            <div class="span10">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>Student ID</th>
                         <th>SSN</th>
                         <th>First Name</th>
                         <th>Middle Name</th>
                         <th>Last Name</th>
                         <th>Residency</th>
                         <th>Enrollment</th>
                         <th>Attendances</th>
                         <th>Hold Degrees</th>
                         <th>Unit</th>
                         <th>Grade Type</th>
                    </tr>
                <%
                    String sql = "SELECT student.student_id, firstname, middlename, lastname, ssn, residency, is_enrolled, hold_degrees, attendances, unit, grade_type "
                				+ "FROM student, student_section, class_section WHERE class_section.section_id = student_section.section_id"
                				+ " AND class_section.course_id = '" + courseId + "'"
                				+ " AND class_section.quarter = '" + quarter + "'"
                				+ " AND student.student_id = student_section.student_id";
                    rs = statement.executeQuery(sql);
                    int i = 1;
                    while ( rs.next() ) {
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= rs.getString("student_id") %></td>
                        <td><%= (rs.getString("ssn") == null)? "N/A" : rs.getString("ssn") %></td>
                        <td><%= rs.getString("firstname") %></td>
                        <td><%= rs.getString("middlename") %></td>
                        <td><%= rs.getString("lastname") %></td>
                        <td><%= rs.getString("residency") %></td>
                        <td><%= rs.getBoolean("is_enrolled") %></td>
                        <td><%= rs.getString("attendances") %></td>
                        <td><%= rs.getString("hold_degrees") %></td>
                        <td><%= rs.getString("unit") %></td>
                        <td><%= rs.getString("grade_type") %></td>
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
            $('#sub-roster').addClass('active');
            $('#sub-sectionlist > a').attr('href', 'sessionlist.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
            $('#roster > a').attr('href', 'roster.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
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


















 
