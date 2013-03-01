<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Check Degree Requirement</title>
</head>

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

    Statement statement = null;
    ResultSet rs = null;

    String action = request.getParameter("action");
    String name = "";
    String studentId = request.getParameter("studentId");
    if(action != null && action.equals("select")) {
    	name = request.getParameter("name");
    }
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
                <!-- i) -->
                <form class="form-inline" action="decisionsupport.jsp?studentId=<%= studentId %>" method="post"> 
                    <input type = "hidden" value = "i" name = "action">
                    <legend>Decision Support i)</legend>
                    <%
                        statement = conn.createStatement();

                        rs = statement.executeQuery("SELECT course_id FROM Course");
                    
                        ArrayList<String> courseList = new ArrayList<String>();
                        while (rs.next()) {
                            courseList.add(rs.getString("course_id"));
                        }
                    %>

                    <select class="input-small" name="course_id">
                    <%
                        for (String course : courseList) {
                    %>
                            <option value="<%= course %>"><%= course %></option>
                    <%
                        }
                    %>
                    </select>

                    <select class="input-small" name="quarter">	    		
                        <option value="Fall">Fall</option>
                        <option value="Winter">Winter</option>
                        <option value="Spring">Spring</option>
                    </select>
                    <select class="input-small" name="year">
                    <%
                        for (int i = 2014; i >= 1900; --i) {
                    %>	
                        <option value="<%= i %>"><%= i %></option>
                    <%
                        }
                    %>
                    </select>

                    <select name="faculty_id">
                    <%
                        statement = conn.createStatement();
                        rs = statement.executeQuery("SELECT faculty_id, name FROM faculty");
                        while (rs.next()) {
                    %>
                        <option value="<%= rs.getString("faculty_id") %>"><%= rs.getString("name") %></option>
                    <%
                        }
                    %>
                    </select>

                    <button type="submit" class="btn btn-primary">Show</button>
                </form>         
                <%
                    if (action != null && action.equals("i")) {
                        String sql = "";

                        rs = statement.executeQuery(sql);
                %>
                <table class="table">
                    <tr>
                        <th>Grade Type</th>
                        <th>Count</th>
                    </tr>
                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= " " %></td>
                        <td><%= " " %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <%
                    }
                %>

                <!-- ii) -->
                <form class="form-inline" action="decisionsupport.jsp?studentId=<%= studentId %>" method="post"> 
                    <input type = "hidden" value = "ii" name = "action">
                    <legend>Decision Support ii)</legend>
                    <%
                        statement = conn.createStatement();

                        rs = statement.executeQuery("SELECT course_id FROM Course");
                    
                        ArrayList<String> courseList2 = new ArrayList<String>();
                        while (rs.next()) {
                            courseList2.add(rs.getString("course_id"));
                        }
                    %>

                    <select class="input-small" name="course_id">
                    <%
                        for (String course : courseList2) {
                    %>
                            <option value="<%= course %>"><%= course %></option>
                    <%
                        }
                    %>
                    </select>

                    <select name="faculty_id">
                    <%
                        statement = conn.createStatement();
                        rs = statement.executeQuery("SELECT faculty_id, name FROM faculty");
                        while (rs.next()) {
                    %>
                        <option value="<%= rs.getString("faculty_id") %>"><%= rs.getString("name") %></option>
                    <%
                        }
                    %>
                    </select>

                    <button type="submit" class="btn btn-primary">Show</button>
                </form>         

                <!-- iii) -->
                <form class="form-inline" action="decisionsupport.jsp?studentId=<%= studentId %>" method="post"> 
                    <input type = "hidden" value = "iii" name = "action">
                    <legend>Decision Support iii)</legend>
                    <%
                        statement = conn.createStatement();

                        rs = statement.executeQuery("SELECT course_id FROM Course");
                    
                        ArrayList<String> courseList3 = new ArrayList<String>();
                        while (rs.next()) {
                            courseList3.add(rs.getString("course_id"));
                        }
                    %>

                    <select class="input-small" name="course_id">
                    <%
                        for (String course : courseList3) {
                    %>
                            <option value="<%= course %>"><%= course %></option>
                    <%
                        }
                    %>
                    </select>

                    <button type="submit" class="btn btn-primary">Show</button>
                </form>         

                <!-- iv) -->
                <form class="form-inline" action="decisionsupport.jsp?studentId=<%= studentId %>" method="post"> 
                    <input type = "hidden" value = "iv" name = "action">
                    <legend>Decision Support iv)</legend>
                    <%
                        statement = conn.createStatement();

                        rs = statement.executeQuery("SELECT course_id FROM Course");
                    
                        ArrayList<String> courseList4 = new ArrayList<String>();
                        while (rs.next()) {
                            courseList4.add(rs.getString("course_id"));
                        }
                    %>

                    <select class="input-small" name="course_id">
                    <%
                        for (String course : courseList4) {
                    %>
                            <option value="<%= course %>"><%= course %></option>
                    <%
                        }
                    %>
                    </select>

                    <select name="faculty_id">
                    <%
                        statement = conn.createStatement();
                        rs = statement.executeQuery("SELECT faculty_id, name FROM faculty");
                        while (rs.next()) {
                    %>
                        <option value="<%= rs.getString("faculty_id") %>"><%= rs.getString("name") %></option>
                    <%
                        }
                    %>
                    </select>

                    <button type="submit" class="btn btn-primary">Show</button>
                </form>         
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-checkdegree').addClass('active');

            $('#sub-newprobation > a').attr('href', 'newprobation.jsp?studentId=<%= studentId %>');
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp?studentId<%= studentId %>');
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp?studentId=<%= studentId %>');
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp?studentId=<%= studentId %>');
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp?studentId=<%= studentId %>');
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp?studentId=<%= studentId %>');
            $('#sub-checkmsdegree > a').attr('href', 'checkmsdegree.jsp?studentId=<%= studentId %>');
            $('#sub-conflictclass > a').attr('href', 'conflictclass.jsp?studentId=<%= studentId %>');
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
