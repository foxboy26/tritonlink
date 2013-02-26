<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Tritonlink - Home</title>
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

        statement = conn.createStatement();
        rs = statement.executeQuery("SELECT TABLE_NAME FROM tritonlink.INFORMATION_SCHEMA.TABLES");
        ArrayList<String> tableList = new ArrayList<String> ();
        while (rs.next()) {
            tableList.add(rs.getString("TABLE_NAME"));
        }
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span2">
              <div class="well sidebar-nav">
                <ul class="nav nav-list">
                  <li class="nav-header">Tables</li>
                  <%
                      for (String table: tableList) {
                  %>
                  <li id="sub-<%= table %>"><a href="#<%= table %>"><%= table %></a></li>
                  <%
                      }
                  %>
                  <li class="divider"></li>
                  <li><a onclick="window.history.back()">Back</a></li>
                </ul>
              </div><!--/.well -->
            </div><!--/span-->

            <div class="span10">
            <%
                for (String table : tableList) {
            %>
                <table class="table" id="<%= table %>">
                    <caption><%= table %></caption>
                    <% 
                        ResultSet rs2 = statement.executeQuery("SELECT COLUMN_NAME FROM tritonlink.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'" + table + "'");
                    %>
                    <tr>
                    <%
                        ArrayList<String> columnList = new ArrayList<String> ();
                        while (rs2.next()) {    
                            columnList.add(rs2.getString("COLUMN_NAME"));
                    %>
                        <th><%= rs2.getString("COLUMN_NAME") %></th>
                    <%
                        }
                    %>
                    </tr>
                    <%
                        statement = conn.createStatement();
                        rs = statement.executeQuery("SELECT * FROM " + table);
                        while (rs.next()) {
                    %>
                    <tr>
                        <%
                            for (String column : columnList) {
                        %>
                        <td><%= rs.getString(column) %></td>
                        <%
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </table>
            <%
                }
            %>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-index').addClass('active');
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
