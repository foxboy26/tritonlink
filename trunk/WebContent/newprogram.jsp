<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New Program</title>
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
            DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

            // Make a connection to the MS SQL Server datasource "tritonlink"
            Connection conn = DriverManager.getConnection(Config.connectionURL);

            Statement statement;

            ResultSet rs;
    %>

    <form action="programs.jsp" method="post">
        <input type="hidden" value="insert" name="action">
        <table>
            <tr>
                <th colspan="2">Program Information</th>
            </tr>
            <tr>
                <td>Program name</td>
                <td><input name="program_name"></td>
            </tr>
            <tr>
                <td>Degree Type</td>
                <td>
                    <select name="degree_type">
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
               </td>
            </tr>   
            <tr>
                <td>Department</td>
                <td>
                    <select name="department">
                    <%
                        statement = conn.createStatement();

                        rs = statement.executeQuery("SELECT name FROM department");
                        while (rs.next()) {
                    %>
                            <option value="<%= rs.getString("name") %>"><%= rs.getString("name") %></option>
                    <%
                        }
                    %>
                   </select>
               </td>
            </tr>   
        </table>   
        <table>
            <tr>
                <td><input type="submit" value="Save"></td>
                <td><button type="button" value="Cancel">Cancel</button></td>
            </tr>
        </table>
    </form>

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
