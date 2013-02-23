<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New course</title>
</head>

<body>

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
%>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
              <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="brand" href="#">Tritonlink 132B</a>
              <div class="nav-collapse collapse">
                <ul class="nav">
                  <li><a href="index.jsp">Home</a></li>
                  <li><a href="studentlist.jsp">Students</a></li>
                  <li><a href="facultylist.jsp">Faculty</a></li>
                  <li class="active"><a href="courselist.jsp">Course</a></li>
                  <li><a href="classlist.jsp">Class</a></li>
                  <li><a href="programlist.jsp">Program</a></li>
                </ul>
              </div><!--/.nav-collapse -->
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span2">
                <div class="well sidebar-nav">
                    <ul class="nav nav-list">
                        <li class="nav-header">Actions</li>
                        <li class="divider"></li>
                        <li><a onclick="window.history.back()">Back</a></li>
                    </ul>
                </div><!--/.well -->
            </div><!--/span-->

            <div class="span10">
                <%
                    statement = conn.createStatement();
                    rs = statement.executeQuery("select * from course where course_id='" + courseId + "'");
                    rs.next();
                %>
                <form class="form-horizontal" action="courselist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Course Information </legend>

                        <div class="control-group">
                            <label class="control-label" for="course_id">course ID</label>
                            <div class="controls">
                                <input type="text" id="course_id" placeholder="course ID" value="" name="course_id">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="name">Name</label>
                            <div class="controls">
                                <input type="text" class="input-small" placeholder="First name" value="" name="firstname">
                                <input type="text" class="input-small" placeholder="Middle name" value="" name="middlename">
                                <input type="text" class="input-small" placeholder="Last name" value="" name="lastname">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="ssn">SSN</label>
                            <div class="controls">
                                <input type="text" id="ssn" placeholder="Student ID" value="" name="ssn">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="residency">Residency</label>
                            <div class="controls">
                                <select name="residency">
                                  <option value="California resident">California resident</option>
                                  <option value="Foreign student">Foreign student</option>
                                  <option value="Non-CA US student">Non-CA US student</option>
                                </select>  
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Enrollment</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="is_enrolled" value="true">Yes
                                </label>
                                <label class="radio inline">
                                    <input type="radio" name="is_enrolled" value="false">No
                                </label>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Attendances</label>
                            <div class="controls" id="attendace">
                                <select class="input-small" name="begin_quarter">
                                    <option value="Spring">Spring</option>
                                    <option value="Summer">Summer</option>
                                    <option value="Fall">Fall</option>
                                    <option value="Winter">Winter</option>
                                </select>
                                <select class="input-small" name="begin_year">		        
                                <%
                                    for (int i = 1900; i < 2014; ++i) {
                                %>  
                                    <option value="<%= i %>"><%= i %></option>
                                <%
                                    }
                                %>
                                </select>
                                - 
                                <select class="input-small" name="end_quarter">
                                    <option value="Spring">Spring</option>
                                    <option value="Summer">Summer</option>
                                    <option value="Fall">Fall</option>
                                    <option value="Winter">Winter</option>
                                </select>
                                <select class="input-small" name="end_year">
                                <%
                                    for (int i = 1900; i < 2014; ++i) {
                                %>  
                                    <option value="<%= i %>"><%= i %></option>
                                <%
                                    }
                                %>
                                </select>
                                <button class="btn" type="button" onclick="addAttendance()">Add</button></td>
                            </div>
                        </div>


                        <div id="background">
                            <legend>Educational Background</legend>
                            <div class="control-group">
                                <label class="control-label">University 1</label>
                                <div class="controls">
                                    <input type="text" value="" name="university" placeholder="University name">
                                    <select class="input-mini" name="degree_type">
                                    <%
                                        statement = conn.createStatement();
                                        rs = statement.executeQuery("SELECT degree_type FROM degree");

                                        while (rs.next()) {
                                    %>
                                        <option value="<%= rs.getString("degree_type") %>"><%= rs.getString("degree_type") %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                    <button class="btn" type="button" onclick="addUniversity()">Add</button>
                                </div>
                             </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Update</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->

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

    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
