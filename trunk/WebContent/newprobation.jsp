<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New probation</title>
</head>

<body>
    <%
        String studentId = request.getParameter("studentId");
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
                  <li class="active"><a href="studentlist.jsp">Students</a></li>
                  <li><a href="facultylist.jsp">Faculty</a></li>
                  <li><a href="courselist.jsp">Course</a></li>
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
                        <li class="active"><a href="newprobation.jsp?studentId=<%= studentId %>">Add probation</a></li>
                        <li><a href="newCourseEnrollment.jsp?studentId=<%= studentId %>">Enroll new class</a></li>
                        <li><a href="newpastclass.jsp?studentId=<%= studentId %>">Add past class</a></li>
                        <li class="divider"></li>
                        <li><a onclick="window.history.back()">Back</a></li>
                    </ul>
                </div><!--/.well -->
            </div><!--/span-->

            <div class="span10">
                <form class="form-horizontal" action="probations.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Probation Infomation</legend>
                        <div class="control-group">
                            <label class="control-label">Student ID</label>
                            <div class="controls">
                                <span class="uneditable-input"><%= studentId %></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Period</label>
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
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Reason</label>
                            <div class="controls" id="attendace">
                               <textarea rows="4" cols="100" name="reason" placehoder="Write your probation reason..."></textarea>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
