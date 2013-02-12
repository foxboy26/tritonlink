<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
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


<form action="faculty.jsp" method="post">
    <input type="hidden" value="insert" name="action">
    <table>
        <tr>
          	<th colspan="2">Faculty Information</th>
        </tr>
		<tr>
    	  	<td>Faculty ID</td>
	  		<td>
	  			<input name="faculty_id" value = "">	  			
	  		*</td>
		</tr>
		<tr>
	    	<td>Name</td>
	    	<td>
	  			<input name="name" value = "">	  			
	    	*</td>	    		    	
		</tr>
        <tr>
            <td>Title</td>
            <td>	 	    
	    		<select name="title">	    		
	        		<option value="Lecturer">Lecturer</option>
	        		<option value="Assistant Professor">Assistant Professor</option>
	        		<option value="Associate Professor">Associate Professor</option>
	        		<option value="Professor">Professor</option>
	    		</select>
	    	*</td>   
	    </tr>
	    <tr>
	    	<td>Department</td>
	    	<td>
	    	<%
	        	// Create the statement
            	Statement statement = conn.createStatement();

            	// Use the created statement to SELECT
            	// the student attributes FROM the Student table.
            	ResultSet rs = statement.executeQuery("SELECT * FROM department");
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
	    	</td>
	    </tr>    
    </table>   
    <table>
        <tr>
            <td><input type="submit" value="Save"></td>
            <td><button type="button" value="Cancel">Cancel</button></td>
        </tr>
    </table>
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
</form>
</body>
</html>
