<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New plan</title>
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

      String name = request.getParameter("name");
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_program.html" />
            <div class="span10">
                <form class="form-horizontal" action="plan.jsp" method="post">
                <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Plan</legend>
                        <div class="control-group">
                            <label class="control-label">Program</label>
                            <div class="controls">
                                <input type="text" class="uneditable-input" name="program_name" value="<%= name %>">
                            </div>
                        </div>
                        <table id="planlist" class="table table-hover">
                            <tr>
                                <th>Course ID</th>
                                <th>Category</th>
                            </tr>
                            <tr>
                                <td>
                                <%
                                    Statement statement = conn.createStatement();

                                    ResultSet rs = statement.executeQuery("SELECT course_id FROM course");
                                    ArrayList<String> courseList = new ArrayList<String>();
                                    while (rs.next()) {
                                        courseList.add(rs.getString("course_id"));
                                    }

                                    rs = statement.executeQuery("SELECT DISTINCT category FROM program_requirement WHERE program_name='" + name + "'");
                                    ArrayList<String> categoryList = new ArrayList<String>();
                                    while (rs.next()) {
                                        String category = rs.getString("category");
                                        if (!category.equals("all")) {
                                            categoryList.add(rs.getString("category"));
                                        }
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
                                </td>
                                <td>
                                    <%
                                    %>
                                    <select name="category">
                                    <%
                                        for (String category : categoryList) {
                                    %>
                                            <option value="<%= category %>"><%= category %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </td>
                                <td><button type="button" class="btn" onclick="addItem('plan', 'planlist')">Add</button></td>
                            </tr>
                            <tr id="plan">
                                <td>
                                    <select name="course_id">
                                    <%
                                        for (String course : courseList) {
                                    %>
                                            <option value="<%= course %>"><%= course %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </td>
                                <td>
                                    <select name="category">
                                    <%
                                        for (String category : categoryList) {
                                    %>
                                            <option value="<%= category %>"><%= category %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div><!--/row-->
        </div>
    </div><!--/.fluid-container-->

    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/util.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-program').addClass('active');
            $('#sub-newprogramrequirement').addClass('active');
        });

        function addCategory() {
            $('#category_list').append(
                '<tr> \
                    <td><input name="category" size="10"></td> \
                    <td><input name="units" size="4"></td> \
                    <td><input name="min_gpa" size="4"></td> \
                </tr>'
            );
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
