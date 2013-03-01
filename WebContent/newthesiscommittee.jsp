<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New thesis committee</title>
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

        // Create the statement
        Statement statement = conn.createStatement();

        // Use the created statement to SELECT
        // the student attributes FROM the Student table.
        ResultSet rs = statement.executeQuery("SELECT * FROM faculty WHERE title='professor'");
        ArrayList<String> professorList = new ArrayList<String>();
        ArrayList<String> professorIdList = new ArrayList<String>();
        while (rs.next()) {
            professorList.add(rs.getString("name"));
            professorIdList.add(rs.getString("faculty_id"));
        }

        String studentId = request.getParameter("studentId");
        String identity = request.getParameter("identity");
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
                <form class="form-horizontal" action="thesiscommittee.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <legend>Thesis Committee Information</legend>
                    <div class="control-group">
                        <label class="control-label">Student ID</label>
                        <div class="controls">
                            <input type="text" class="uneditable-input" name="student_id" value="<%= studentId %>" >
                        </div>
                    </div>
                    <%
                        for (int i = 0; i < 3; i++) {
                    %>
                    <div class="control-group">
                        <label class="control-label">Professor <%= i + 1 %></label>
                        <div class="controls" id="attendace">
                            <select name="faculty_id">
                            <%
                                for (int j = 0; j < professorList.size(); j++) {
                            %>
                                    <option value="<%= professorIdList.get(j) %>"><%= professorList.get(j) %></option>
                            <%
                                }
                            %>
                            </select>
                        </div>
                    </div>
                    <%
                        }    
                    %>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="button" class="btn">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-newthesiscommittee').addClass('active');
            
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
