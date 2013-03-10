<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New class</title>
    <style>
        .table th {
            vertical-align: middle;
        }
    </style>
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
                <form class="form-horizontal" action="sectionlist.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>" method="post">
                    <input type="hidden" value="insert" name="action">
                    <input type="hidden" name="course_id" value="<%= courseId %>">
                    <input type="hidden" name="quarter" value="<%= quarter %>">
                    <fieldset>
                        <legend>Section Information</legend>

                        <div class="control-group">
                            <label class="control-label">Section ID</label>
                            <div class="controls">
                            <%
                                statement = conn.createStatement();
                                rs = statement.executeQuery("SELECT COUNT(*) AS num FROM section");
                                rs.next();
                            %>
                                <input type="text" name="section_id" value="<%= rs.getInt("num") + 1 %>">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Instructor</label>
                            <div class="controls">
                                <select name="faculty_id">
                                <%
                                    statement = conn.createStatement();
                                    rs = statement.executeQuery("SELECT * FROM faculty");
                                    while (rs.next()) {
                                %>
                                    <option value="<%= rs.getString("faculty_id") %>"><%= rs.getString("name") %></option>
                                <%
                                    }
                                %>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Limit</label>
                            <div class="controls">
                                <input type="text" name="limit">
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/util.js"></script>
    <script>
	    $(document).ready(function() {
	        $('#nav-class').addClass('active');
	        $('#sub-sectionlist > a').addClass('active');

	        $('#sub-sectionlist > a').attr('href', 'sectionlist.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
            $('#sub-newsection > a').attr('href', 'newsection.jsp?&courseId=<%= courseId %>&quarter=<%= quarter %>');
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
