<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New Degree Requirement</title>
</head>

<script>
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

<body>
    <%-- Set the scripting language to Java and --%>
    <%-- Import the java.sql package --%>
    <%@ page language="java" import="java.sql.*" %>
    <%@ page language="java" import="db.Config" %>
    <%-- -------- Open Connection Code -------- --%>
    <%
        try {
            // Load JDBC Driver class file
            DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

            // Make a connection to the MS SQL Server datasource "tritonlink"
            Connection conn = DriverManager.getConnection(Config.connectionURL);
    %>

    <form action="degreerequirements.jsp" method="post">
        <input type="hidden" value="insert" name="action">
        <table>
            <tr>
                <th colspan="2">Degree Requirement Information</th>
            </tr>
            <tr>
                <td>Program</td>
                <td>
                    <select name="program_name">
                    <%
                        Statement statement = conn.createStatement();

                        ResultSet rs = statement.executeQuery("SELECT name FROM program");
                        while (rs.next()) {
                    %>
                            <option value="<%= rs.getString("name") %>"><%= rs.getString("name") %></option>
                    <%
                        }
                    %>
                   </select>
               </td>
            </tr>
            <tr>
                <td>Total units</td>
                <td><input name="total_units" size="5"></td>
            </tr>   
        </table> 
        <table id="category_list">
            <tr>
                <th>Category</th>
                <th>Units</th>
                <th>Min GPA</th>
                <th><button type="button" onclick="addCategory()">Add</button></th>
            </tr>
            <tr>
                <td><input name="category" size="10"></td>
                <td><input name="units" size="4"></td>
                <td><input name="min_gpa" size="4"></td>
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
