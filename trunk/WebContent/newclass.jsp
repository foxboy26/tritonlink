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
%>

<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_class.html" />
            <div class="span10">
                <form class="form-horizontal" action="classlist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Class Information</legend>
                        <div class="control-group">
                            <label class="control-label">Course ID</label>
                            <div class="controls">
                            <%
                                
                                statement = conn.createStatement();

                                rs = statement.executeQuery("SELECT Course_id FROM Course");
                            
                                ArrayList<String> courseList = new ArrayList<String>();
                                while (rs.next()) {
                                    courseList.add(rs.getString("course_id"));
                                }
                            %>
                                <select name="course_id">
                                <%
                                    for (String course : courseList) {
                                %>
                                        <option value="<%= course %>"><%= course %></option>
                                <%
                                    }
                                %>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Title</label>
                            <div class="controls">
                                <input type="text" name="title" value = "">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Quarter</label>
                            <div class="controls">
                                <select class="input-small" name="quarter">	    		
                                    <option value="Fall">Fall</option>
                                    <option value="Winter">Winter</option>
                                    <option value="Spring">Spring</option>
                                </select>
                                <select class="input-small" name="year">
                                <%
                                    for (int i = 1900; i < 2014; ++i) {
                                %>	
                                    <option value="<%= i %>"><%= i %></option>
                                <%
                                    }
                                %>
                                </select>
                            </div>
                        </div>

                        <button class="btn" type="button" onclick="addSection()">Add section</button>
                        <input type="hidden" value="1" id="section_num">
                        <legend>Section 1</legend>
                        <div class="control-group">
                            <label class="control-label">Section ID</label>
                            <div class="controls">
                                <input type="text" name="section_id">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Instructor</label>
                            <div class="controls">
                                <select name="faculty_id">
                                <%
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

                        <table class="table" id="meetinglist">
                            <caption>Weekly Meetings</caption>
                            <tr>
                                <th>Type</th>
                                <th>Location</th>
                                <th>Time</th>
                                <th>Days</th>
                                <th>Mandatory</th>
                            </tr>
                            <tr>
                                <td>
                                    <select class="input-mini" name="type">
                                        <option value="LE">LE</option>
                                        <option value="DI">DI</option>
                                    </select>
                                </td>
                                <td><input type="text" name="location"></td>
                                <td><input type="text" class="input-small" name="start_time"> - <input type="text" class="input-small" name="end_time"></td>
                                <td><input type="text" class="input-small" name="days"></td>
                                <td><input type="checkbox" name="mandatory" value="1" checked="true"></td>
                                <td><button class="btn" type="button" onclick="addMeeting()">Add</button></td>
                            </tr>
                            <tr id="meeting" style="display:none">
                                <td>
                                    <select class="input-mini" name="type">
                                        <option value="LE">LE</option>
                                        <option value="DI">DI</option>
                                    </select>
                                </td>
                                <td><input type="text" name="location"></td>
                                <td><input type="text" class="input-small" name="start_time"> - <input type="text" class="input-small" name="end_time"></td>
                                <td><input type="text" class="input-small" name="days"></td>
                                <td><input type="checkbox" name="mandatory" value="1" checked="true"></td>
                            </tr>
                        </table>

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
            $('#sub-newclass').addClass('active');
        });

        function addSection() {
            $('#section_num')
            addItem('section', 'sectionlist');
        }

        function addMeeting(sectionId) {
            $('#section_num')
            addItem('section', 'sectionlist');
        }
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
