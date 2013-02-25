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
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_facultylist.html" />
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
                </form>
            </div><!--/row-->
        </div>
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-faculty').addClass('active');
            $('#sub-newfaculty').addClass('active');
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
