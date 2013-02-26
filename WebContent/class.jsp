<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Class</title>
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
                    statement = conn.createStatement();
                    rs = statement.executeQuery("SELECT * FROM class WHERE course_id='" + courseId + "' AND quarter='" + quarter + "'");
                    if (rs.next()) {
                    String title = rs.getString("title");
                %>
                <form class="form-horizontal" action="courselist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Class Information </legend>
                        <div class="control-group">
                            <label class="control-label">Course ID</label>
                            <div class="controls">
                                <input type="text" value="<%= courseId %>" name="course_id">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Quarter</label>
                            <div class="controls">
                                <input type="text" value="<%= quarter %>" name="quarter">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Title</label>
                            <div class="controls">
                                <input type="text" value="<%= title %>" name="title">
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Update</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
                <%
                    }
                %>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-class').addClass('active');
            $('#sub-sessionlist > a').attr('href', 'sessionlist.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
            $('#sub-newreviewsession > a').attr('href', 'newreviewsession.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
            $('#sub-roster > a').attr('href', 'roster.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
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
