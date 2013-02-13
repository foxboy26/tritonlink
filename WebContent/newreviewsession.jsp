<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New Review Session</title>
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
    %>

    <form action="reviewsessions.jsp" method="post">
        <input type="hidden" value="insert" name="action">
        <table>
            <tr>
                <th colspan="2">Review Session Information</th>
            </tr>
            <tr>
                <td>Section ID</td>
                <td>
                    <select name="section_id">
                    <%
                        Statement statement = conn.createStatement();

                        ResultSet rs = statement.executeQuery("SELECT section_id FROM section");
                        while (rs.next()) {
                    %>
                            <option value="<%= rs.getString("section_id") %>"><%= rs.getString("section_id") %></option>
                    <%
                        }
                    %>
                   </select>
               </td>
            </tr>
            <tr>
                <td>Location</td>
                <td><input name="location" size="10"></td>
            </tr>   
            <tr>
                <td>Date</td>
                <td><input name="date" size="5"></td>
            </tr>   
            <tr>
                <td>Time</td>
                <td><input name="start_time" size="5"> - <input name="end_time" size="5"></td>
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
