<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New course</title>
</head>
<body>

    <script>
        function addPrerequisite() {
            $('#course').append(
                '<tr> \
                    <td></td> \
                    <td> \
                        <input name="prerequisite" value = ""> \
                        <button type="button">Add</button> \
                    </td> \
                </tr>'
            );
        }
    </script>

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


<form action="course.jsp" method="post">
    <input type="hidden" value="insert" name="action">
    <table id="course">
        <tr>
          	<th colspan="2">Course Information</th>
        </tr>
		<tr>
    	  	<td>Course ID</td>
	  		<td><input value="" name="course_id" size="15">*</td>
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
	    </td>
	</tr>
        <tr>
            <td>Need Consent</td>
            <td>	 	    
	    		<select name="is_consent">	  
	            	<option value="True">True</option>	   
	            	<option value="False">False</option>	   
           		</select>
	    	*</td>
        </tr>
        <tr>
            <td>units</td>
            <td>
                <input name="unit_range" value = "">
		     *</td>
        </tr>
        <tr>
            <td>Grade Type</td>
            <td>	 	    
	    		<select name="grade_type">	  
	            	<option value="Grade">Letter</option>	   
	            	<option value="S/U">S/U</option>	
	            	<option value="Both">Both</option>	   
	            	<option value="S/U Only">S/U Only</option>   
           		</select>
	    	*</td>
	    </tr>
		<tr id="labwork">
		    <td>Labwork</td>
		    <td>
		        <select name="labwork">
                   <option value="True">True</option>	   
	               <option value="False">False</option>	
                </select>
		    *</td>
		</tr>
        <tr>
            <td>Prerequisite</td>
            <td>
                <input name="prerequisite" value = "">
                <button type="button" onclick="addPrerequisite()">Add</button>
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
