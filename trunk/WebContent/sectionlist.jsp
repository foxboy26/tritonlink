<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Session List</title>
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
        
		String courseId = request.getParameter("courseId");
        
        String quarter = request.getParameter("quarter");
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_class.html" />
            <div class="span10">
            <%
                Statement statement = conn.createStatement();
            	String sql = "SELECT section.section_id, faculty.name, enrolled_num, waitlist_num, limit_num FROM section, class_section, class, teach, faculty"
            			+ " Where class.course_id = class_section.course_id"
            			+ " AND class.quarter = class_section.quarter"
            			+ " AND section.section_id = class_section.section_id"
            			+ " AND teach.section_id = class_section.section_id"
            			+ " AND teach.faculty_id = faculty.faculty_id"
            			+ " AND class.course_id = '" + courseId + "'"
            			+ " AND class.quarter = '" + quarter + "'";

                ResultSet rs = statement.executeQuery(sql);
            %>
                <table class="table table-hover">
                    <tr>
                        <th>Section ID</th>
                        <th>Lecturer</th>
                        <th>Enrolled</th>
                        <th>WaitList</th>
                        <th>Capacity</th>
                    </tr>
            <%
                    while ( rs.next() ) {
                    	String sectionId = rs.getString("section_id");
            %>
                    <tr onclick="document.location = 'sessionlist.jsp?&sectionId=<%= sectionId%>&courseId=<%= courseId %>&quarter=<%= quarter %>';">
                        <td><%= sectionId %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("enrolled_num") %></td>
                        <td><%= rs.getString("waitlist_num") %></td> 
                        <td><%= rs.getString("limit_num") %></td>                   
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
              $('#sub-sectionlist > a').addClass('active');
              $('#sub-newsection > a').attr('href', 'newsection.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
              $('#sub-sectionlist > a').attr('href', 'sectionlist.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
              $('#roster > a').attr('href', 'roster.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
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
            String sectionId = request.getParameter("section_id");
            String facultyId = request.getParameter("faculty_id");
            String limit = request.getParameter("limit");

            // Begin transaction
            conn.setAutoCommit(false);
            
            // INSERT INTO the Section table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO section VALUES (?, 0, 0, ?)");
            pstmt.setString(1, sectionId);
            pstmt.setInt(2, Integer.parseInt(limit));
            int rowCount = pstmt.executeUpdate();
            
            // INSERT INTO the Class_Section table.
            pstmt = conn.prepareStatement(
                "INSERT INTO class_section VALUES (?, ?, ?)");
            pstmt.setString(1, courseId);
            pstmt.setString(2, sectionId);
            pstmt.setString(3, quarter);
            rowCount = pstmt.executeUpdate();

            pstmt = conn.prepareStatement(
                "INSERT INTO teach VALUES (?, ?)");
            pstmt.setString(1, facultyId);
            pstmt.setString(2, sectionId);
            rowCount = pstmt.executeUpdate();
            
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
