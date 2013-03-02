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
<%@ page language="java" import="db.Decision" %>
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
    String identity = request.getParameter("identity");
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
                        String facultyId = request.getParameter("faculty_id");
                        String courseId = request.getParameter("course_id");
                        String quarter = request.getParameter("quarter") + " " + request.getParameter("year");

                        String gradeAll = "SELECT ss.grade as grade, COUNT(ss.grade) as grade_count FROM teach AS t, class_section AS cs, student_section AS ss" +
                                            " WHERE t.section_id=cs.section_id" +
                                            " AND cs.section_id=ss.section_id" +
                                            " AND t.faculty_id='" + facultyId + "'" +
                                            " AND cs.course_id='" + courseId + "'" +
                                            " AND cs.quarter='" + quarter + "'" +
                                            " GROUP BY ss.grade";
                        
                        rs = statement.executeQuery(Decision.makeSQL(gradeAll));
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
                        <td><%= rs.getString("grade") %></td>
                        <td><%= (rs.getString("grade_count") == null)? 0 : rs.getInt("grade_count") %></td>
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
                <%
                    if (action != null && action.equals("ii")) {
                        String facultyId = request.getParameter("faculty_id");
                        String courseId = request.getParameter("course_id");

                        String gradeAll = "SELECT ss.grade as grade, COUNT(ss.grade) as grade_count FROM teach AS t, class_section AS cs, student_section AS ss" +
                                " WHERE t.section_id=cs.section_id" +
                                " AND cs.section_id=ss.section_id" +
                                " AND t.faculty_id='" + facultyId + "'" +
                                " AND cs.course_id='" + courseId + "'" +
                                " GROUP BY ss.grade";
                        
                        rs = statement.executeQuery(Decision.makeSQL(gradeAll));
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
                        <td><%= rs.getString("grade") %></td>
                        <td><%= (rs.getString("grade_count") == null)? 0 : rs.getInt("grade_count") %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <%
                    }
                %>

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
                <%
                    if (action != null && action.equals("iii")) {
                        String courseId = request.getParameter("course_id");
                        String gradeAll = "SELECT ss.grade as grade, COUNT(ss.grade) as grade_count FROM teach AS t, class_section AS cs, student_section AS ss" +
                                " WHERE t.section_id=cs.section_id" +
                                " AND cs.section_id=ss.section_id" +
                                " AND cs.course_id='" + courseId + "'" +
                                " GROUP BY ss.grade";
                        
                        rs = statement.executeQuery(Decision.makeSQL(gradeAll));
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
                        <td><%= rs.getString("grade") %></td>
                        <td><%= (rs.getString("grade_count") == null)? 0 : rs.getInt("grade_count") %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <%
                    }
                %>

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
                <%
                    if (action != null && action.equals("iv")) {
                        String courseId = request.getParameter("course_id");
                        String facultyId = request.getParameter("faculty_id");

                        String sql = "SELECT AVG(gc.number_grade) as grade FROM class AS c, teach AS t, class_section AS cs, student_section AS ss, grade_conversion AS gc" +
                                            " WHERE c.course_id=cs.course_id" +
                                            " AND t.section_id=cs.section_id" +
                                            " AND cs.section_id=ss.section_id" +
                                            " AND gc.letter_grade=ss.grade" +
                                            " AND t.faculty_id='" + facultyId + "'" +
                                            " AND c.course_id='" + courseId + "'";
                        
                        rs = statement.executeQuery(sql);
                        rs.next();
                %>
                <span>Average grade: <%= rs.getFloat("grade") %></span>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-decisionsupport').addClass('active');

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
