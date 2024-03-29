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
            <jsp:include page="tpl/sub_courselist.html" />
            <div class="span10">
                <form class="form-horizontal" action="courselist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <legend>Course Information</legend>

                    <div class="control-group">
                        <label class="control-label">Course ID</label>
                        <div class="controls">
                            <input type="text" placeholder="CSE132" value="" name="course_id">
                        </div>
                    </div>

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
                        <label class="control-label">Consent</label>
                        <div class="controls">
                            <select name="is_consent">    
                                <option value="True">True</option>     
                                <option value="False">False</option>       
                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Units</label>
                        <div class="controls">
                            <input type="text" name="unit_range" placeholder="1~8 or 4" value = "">
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Grade type</label>
                        <div class="controls">
                            <select name="grade_type">    
                                <option value="Letter">Letter</option>      
                                <option value="S/U">S/U</option>    
                                <option value="Both">Both</option>     
                                <option value="S/U Only">S/U Only</option>   
                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Lab work</label>
                        <div class="controls">
                            <select name="labwork">
                               <option value="True">True</option>      
                               <option value="False">False</option> 
                            </select>
                        </div>
                    </div>

                    <div class="control-group" id="prerequisitelist">
                        <label class="control-label">Prerequisite</label>
                        <div class="controls">
                        <%
                            statement = conn.createStatement();
                            rs = statement.executeQuery("SELECT course_id FROM course");
                            ArrayList<String> courseList = new ArrayList<String>();
                            while (rs.next()) {
                                courseList.add(rs.getString("course_id"));
                            }
                        %>
                        
                            <select name="prerequisite">
	                            <option value="none"></option>
                        <%
                            for (String course : courseList) {
                        %>
                                <option value="<%= course %>"><%= course %></option>
                        <%
                            }
                        %>
                            </select>
                            <button class="btn" type="button" onclick="addItem('prerequisite', 'prerequisitelist')">Add</button>
                        </div>
                        <div class="controls" id="prerequisite" style="display:none">
                            <select name="prerequisite">
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
    <script src="js/util.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-course').addClass('active');
            $('#sub-newcourse').addClass('active');
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
