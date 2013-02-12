<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New class</title>
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


<form action="class.jsp" method="post">
    <input type="hidden" value="insert" name="action">
    <table>
        <tr>
          	<th colspan="2">Class Information</th>
        </tr>
		<tr>
    	  	<td>Course ID</td>
	  		<td>
	  		<%
	  			
	  			Statement statement = conn.createStatement();

            	//Get all course ID from table course
            	ResultSet rs = statement.executeQuery("SELECT Course_id FROM Course");
            
            	ArrayList<String> courseList = new ArrayList<String>();
            	while (rs.next()) {
            		courseList.add(rs.getString("course_id"));
            	}
	  		%>
	  		<select name="course_id">
	    <%
	        for (String course : courseList) {
	        	System.out.println(course);
	    %>
	            <option value="<%= course %>"><%= course %></option>
	    <%
	        }
	    %>
           </select>
	  			
	  		*</td>
		</tr>
		<tr>
	    	<td>Quarter</td>
	    	<td>
	    		<select name="quarter">	    		
	        		<option value="Fall">Fall</option>
	        		<option value="Winter">Winter</option>
	        		<option value="Spring">Spring</option>
	    		</select>
	    	*</td>
	    	
	    	<td>Year</td>
	    	<td>
	    		<select name="year">
	    		<%
	        		for (int i = 1900; i < 2014; ++i) {
	        	%>	
	        		<option value="<%= i %>"><%= i %></option>
	        	<%
	        		}
	    		%>
	    		</select>
	    	*</td>
		</tr>
        <tr>
            <td>Title</td>
            <td>	 	    
	    		<input name="title" value = "">
	    	*</td>        
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
