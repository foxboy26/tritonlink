<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Program</title>
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

        String name = request.getParameter("name");
%>

<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_program.html" />
            <div class="span10">
                <%
                    statement = conn.createStatement();
                    rs = statement.executeQuery("select * from program where name='" + name + "'");
                    rs.next();
                %>
                <form class="form-horizontal" action="programlist.jsp" method="post">
                    <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Program Information</legend>
                        <div class="control-group">
                            <label class="control-label">Name</label>
                            <div class="controls">
                                <input type="text" name="name" value = "<%= rs.getString("name") %>">	  			
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Department</label>
                            <div class="controls">
                            <%
                                statement = conn.createStatement();

                                rs = statement.executeQuery("SELECT * FROM department");
                                ArrayList<String> departmentList = new ArrayList<String>();
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

                        <legend>Requirement</legend>
                        <%
                            statement = conn.createStatement();

                            rs = statement.executeQuery("SELECT units FROM program_requirement where category='all' AND program_name='" + name + "'");

                            if (rs.next()) {
                        %>
                        <div class="control-group">
                            <label class="control-label">Total units</label>
                            <div class="controls">
                                <input type="text" name="total_units" value="<%= rs.getString("units") %>">
                            </div>
                        </div>

                        <table id="category_list" class="table table-hover">
                            <tr>
                                <th>Category</th>
                                <th>Units</th>
                                <th>Min GPA</th>
                            </tr>
                            <%
                                rs = statement.executeQuery("SELECT category, units, min_gpa FROM program_requirement where program_name='" + name + "'");
                                while (rs.next()) {
                                    if (rs.getString("category").equals("all")) continue;
                            %>
                            <tr>
                                <td><input type="text" name="category" value="<%= rs.getString("category") %>"></td>
                                <td><input type="text" name="units" value="<%= rs.getString("units") %>"></td>
                                <td><input type="text" name="min_gpa" value="<%= rs.getString("min_gpa") %>"></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                        <%
                            }
                        %>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Update</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-program').addClass('active');
            $('#sub-newprogramrequirement > a').attr('href', 'newprogramrequirement.jsp?name=<%= name %>');
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
