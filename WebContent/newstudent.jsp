<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New student</title>
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
%>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_studentlist.html" />
            <div class="span10">
                <form class="form-horizontal" action="studentlist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Basic Information</legend>
                        <div class="control-group">
                            <label class="control-label">Identity</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="identity" value="undergraduate" onchange="showUndergraduateForm()">Undergraduate
                                </label>
                                <label class="radio inline">
                                    <input type="radio" name="identity" value="graduate" onchange="showGraduateForm()">Graduate
                                </label>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Student ID</label>
                            <div class="controls">
                                <input type="text" id="student_id" placeholder="Student ID" value="" name="student_id">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Name</label>
                            <div class="controls">
                                <input type="text" class="input-small" placeholder="First name" value="" name="firstname">
                                <input type="text" class="input-small" placeholder="Middle name" value="" name="middlename">
                                <input type="text" class="input-small" placeholder="Last name" value="" name="lastname">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">SSN</label>
                            <div class="controls">
                                <input type="text" id="ssn" placeholder="SSN" value="" name="ssn">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Residency</label>
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

                        <div class="control-group" id="attendancelist">
                            <label class="control-label">Attendances</label>
                            <div class="controls">
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
                                <button class="btn" type="button" onclick="addItem('attendance', 'attendancelist')">Add</button></td>
                            </div>
                            <div id="attendance" class="controls" style="display: none;">
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
                            </div>
                        </div>

                        <legend>Educational Background</legend>
                        <div class="control-group" id="backgroundlist">
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
                                <button class="btn" type="button" onclick="addItem('background', 'backgroundlist')">Add</button>
                            </div>
                            <div class="controls" id="background" style="display:none">
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
                            </div>
                         </div>
                    
                        <div id="graduate" style="display:none"> 
                            <legend>Graduate information</legend>
                            <div class="control-group">
                                <label class="control-label">Department</label>
                                <div class="controls">
                                <%
                                    statement = conn.createStatement();

                                    rs = statement.executeQuery("SELECT * FROM department");
                                    ArrayList<String> departmentList = new ArrayList<String>();
                                    int i = 0;
                                    while (rs.next()) {
                                        departmentList.add(rs.getString("name"));
                                    }
                                %>
                                
                                    <select name="department">
                                <%
                                    for (String department : departmentList) {
                                %>
                                        <option value="<%= department %>"><%= department %></option>
                                <%
                                    }
                                %>
                                    </select>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Degree</label>
                                <div class="controls">
                                    <select class="input-small" name="degree" onchange="showPhdState()">
                                      <option value="MS">Master</option>
                                      <option value="MSE">MSE</option>
                                      <option value="Ph.D">PhD</option>
                                    </select>  
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">State</label>
                                <div class="controls">
                                    <label class="radio inline">
                                        <input type="radio" name="state" value="PhD candidates">PhD candidates
                                    </label>
                                    <label class="radio inline">
                                        <input type="radio" name="state" value="PhD precandidacy">PhD precandidacy
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <div id="undergraduate" style="display:none">
                            <legend>Undergraduate Information</legend>
                            <div class="control-group">
                                <label class="control-label">College</label>
                                <div class="controls">
                                    <select name="college">
                                      <option value="Revelle">Revelle</option>
                                      <option value="John Muir">John Muir</option>
                                      <option value="Thrugood Marshall">Thrugood Marshall</option>
                                      <option value="Earl Warren">Earl Warren</option>
                                      <option value="Eleanor Roosevelt">Eleanor Roosevelt</option>
                                      <option value="Sixth">Sixth</option>
                                    </select>  
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Major</label>
                                <div class="controls">
                                    <select name="major">
                                    <%
                                    for (String department : departmentList) {
                                    %>
                                        <option value="<%= department %>"><%= department %></option>
                                    <%
                                    }
                                    %>
                                    </select>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Minor</label>
                                <div class="controls">
                                    <select name="minor">
                                    <%
                                    for (String department : departmentList) {
                                    %>
                                        <option value="<%= department %>"><%= department %></option>
                                    <%
                                    }
                                    %>
                                    </select>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Type</label>
                                <div class="controls">
                                    <select name="type">
                                      <option value="normal">Normal</option>
                                      <option value="5-year">5-year Bachelor's/MS program</option>
                                    </select> 
                                </div>
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
            $('#nav-student').addClass('active');
            $('#sub-newstudent').addClass('active');
        });

        function showGraduateForm()
        {
            graduateForm = document.getElementById("graduate");
            undergraduateForm = document.getElementById("undergraduate");
            graduateForm.style.display = 'block';
            undergraduateForm.style.display = 'none';
        }

        function showUndergraduateForm()
        {
            graduateForm = document.getElementById("graduate");
            undergraduateForm = document.getElementById("undergraduate");
            graduateForm.style.display = 'none';
            undergraduateForm.style.display = 'block';
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
