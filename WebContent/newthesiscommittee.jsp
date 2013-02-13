<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New thesis committee</title>
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

            // Create the statement
            Statement statement = conn.createStatement();

            // Use the created statement to SELECT
            // the student attributes FROM the Student table.
            ResultSet rs = statement.executeQuery("SELECT * FROM faculty WHERE title='professor'");
            ArrayList<String> professorList = new ArrayList<String>();
            ArrayList<String> professorIdList = new ArrayList<String>();
            while (rs.next()) {
                professorList.add(rs.getString("name"));
                professorIdList.add(rs.getString("faculty_id"));
            }
    %>

    <form action="thesiscommittees.jsp" method="post">
        <input type="hidden" value="insert" name="action">
        <table>
            <tr>
                <th colspan="2">Thesis Committee Information</th>
            </tr>
            <tr>
                <td>Student ID</td>
                <td>
                    <input name="student_id" value = "">	  			
                *</td>
            </tr>
            <%
                for (int i = 0; i < 3; i++) {
            %>
            <tr>
                <td>Professor <%= i + 1 %></td>
                <td>
                    <select name="faculty_id">
                    <%
                        for (int j = 0; j < professorList.size(); j++) {
                    %>
                            <option value="<%= professorIdList.get(j) %>"><%= professorList.get(j) %></option>
                    <%
                        }
                    %>
                    </select>
                </td>
            </tr>
            <%
                }    
            %>
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
