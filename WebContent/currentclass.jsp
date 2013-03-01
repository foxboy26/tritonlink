<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Current class</title>
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

        String studentId = request.getParameter("studentId");
        String identity = request.getParameter("identity");
        
        Statement statement = conn.createStatement();
        
        ResultSet rs;
%>
<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />

            <div class="span10">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>Course ID</th>
                        <th>Quarter</th>
                        <th>Title</th>
                        <th>Section</th>
                        <th>Unit</th>
                        <th>Grade Type</th>
                    </tr>
                <%
                    String sql = "SELECT class.course_id, class.quarter, class.title, student_section.section_id, student_section.unit, student_section.grade_type" +
                                 " FROM class, class_section, student_section" +
                                 " WHERE class.course_id=class_section.course_id" + 
                                 " AND class_section.section_id=student_section.section_id" +
                                 " AND class.quarter='" + Config.currentQuarter + "'" +
                                 " AND student_section.student_id=" + studentId;
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
                        <td><%= rs.getString("section_id") %></td>
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
            $('#nav-student').addClass('active');
            $('#sub-currentclass').addClass('active');

            var args = '?' + 'studentId=<%= studentId %>' + '&' + 'identity=<%= identity %>';
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp' + args);
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp' + args);
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp' + args);
            $('#sub-newthesiscommittee > a').attr('href', 'newthesiscommittee.jsp' +  args);
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp' + args);
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp' + args);
            <%
                if (identity.equals("undergraduate")) {
            %>
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp' + args);
            <%
                }

                if (identity.equals("graduate")) {
            %>
            $('#sub-checkdegree > a').attr('href', 'checkmsdegree.jsp' + args);
            <%
                }
            %>
            $('#sub-conflictclass > a').attr('href', 'conflictclass.jsp' + args);
            $('#sub-decisionsupport > a').attr('href', 'decisionsupport.jsp' + args);
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
