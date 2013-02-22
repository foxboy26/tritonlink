<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New faculty</title>
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
              <li class="active"><a href="facultylist.jsp">Faculty</a></li>
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
              <li class="active"><a href="newfaculty.jsp">Add faculty</a></li>
              <li class="divider"></li>
              <li><a href="facultylist.jsp">Back</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->

        <div class="span10">
                <form class="form-horizontal" action="facultylist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <legend>Faculty Information</legend>

                        <div class="control-group">
                            <label class="control-label">Faculty ID</label>
                            <div class="controls">
                                <input type="text" name="faculty_id" value = "">	  			
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Name</label>
                            <div class="controls">
                                <input type="text" name="name" value = "">	  			
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Title</label>
                            <div class="controls">
                                <select name="title">	    		
                                    <option value="Lecturer">Lecturer</option>
                                    <option value="Assistant Professor">Assistant Professor</option>
                                    <option value="Associate Professor">Associate Professor</option>
                                    <option value="Professor">Professor</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Department</label>
                            <div class="controls">
                            <%
                                Statement statement = conn.createStatement();

                                ResultSet rs = statement.executeQuery("SELECT * FROM department");
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

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
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
</body>
</html>
