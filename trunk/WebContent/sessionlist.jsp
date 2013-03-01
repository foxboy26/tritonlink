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
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);
        
		String sectionId = request.getParameter("sectionId");
		String courseId = request.getParameter("courseId");
		String quarter = request.getParameter("quarter");
%>

<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_section.html" />
            <div class="span10">
            <%
                Statement statement = conn.createStatement();
            	String sql = "SELECT * FROM meeting"
            			+ " Where section_id = '"
            			+ sectionId + "'"
            			+ " ORDER BY type";

                ResultSet rs = statement.executeQuery(sql);
            %>
                <table class="table table-hover">
                    <tr>
                        <th>Type</th>
                        <th>Location</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Days</th>
                        <th>Mandatory</th>
                    </tr>
            <%
                    while ( rs.next() ) {
            %>
                    <tr>
                        <td><%= rs.getString("type") %></td>
                        <td><%= rs.getString("location") %></td>
                        <td><%= rs.getString("start_time") %></td>
                        <td><%= rs.getString("end_time") %></td>
                        <td><%= rs.getString("days") %></td> 
                        <td><%= rs.getBoolean("mandatory") %></td>                   
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
             $('#sub-sessionlist').addClass('active');
             $('#sub-newsession > a').attr('href', 'newsession.jsp?&sectionId=<%= sectionId %>&courseId= <%= courseId%>&quarter=<%= quarter%>');
             $('#sub-sessionlist > a').attr('href', 'sessionlist.jsp?&sectionId=<%= sectionId %>&courseId= <%= courseId%>&quarter=<%= quarter%>');
             $('#sub-newreviewsession > a').attr('href', 'newreviewsession.jsp?&sectionId=<%= sectionId %>&courseId= <%= courseId%>&quarter=<%= quarter%>');
             $('#sub-checkreviewsession > a').attr('href', 'checkreviewsession.jsp?&sectionId=<%= sectionId %>&courseId= <%= courseId%>&quarter=<%= quarter%>');
        });
    </script>
</body>
</html>
<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        if (action != null) {
            // Preprocess submitted form data
            String type = action.equals("insert-review")? "RW" : request.getParameter("type"); 
            String location = request.getParameter("location");
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            String date = request.getParameter("days");                                            
            String mandatory = request.getParameter("mandatory");                                            
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Student table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO Meeting VALUES (?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, sectionId);
            pstmt.setString(2, type);
            pstmt.setString(3, location);
            pstmt.setString(4, startTime);
            pstmt.setString(5, endTime);
            pstmt.setString(6, date);
            pstmt.setString(7, mandatory);

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
