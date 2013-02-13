<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New Course Enrollment</title>
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
                  String action = request.getParameter("action");
                  String courseID = null;
                  String currentQuarter = "Winter 2013";
          %>



    <input type="hidden" value="insert" name="action">
    <table>
        <tr>
          	<th colspan="2">Course Enrollment Information</th>
        </tr>
        <tr>
    	  	<td>Student ID</td>
	  		<td><input value="" name="student_id" size="15">*</td>
		</tr>
		<tr>
    	  	<td>Course ID</td>
	  		<td>
	  			<form action="newCourseEnrollment.jsp" method="post">
	  				<input type = "hidden" value = "select" name = "action">
	  				<%
	  				PreparedStatement pstmt = conn.prepareStatement("SELECT course_id FROM class WHERE class.quarter = ?");
					pstmt.setString(1, currentQuarter);
	  	            // Use the created statement to SELECT
	  	            // the student attributes FROM the Student table.
	  	            ResultSet rs = pstmt.executeQuery();
	  	            ArrayList<String> courseList = new ArrayList<String>();
	  	            while (rs.next()) {	  	       
	  	            		courseList.add(rs.getString("course_id"));
	  	            }
	  				%> 
	  				<select onchange = form.submit() name = "course_id">
	  					<%
	  					
	  					if(action != null && action.equals("select")){
	  						courseList.remove(request.getParameter("course_id"));	
	  					%>
	  					<option value="<%= request.getParameter("course_id") %>"><%= request.getParameter("course_id") %></option>
	  					<% 
	  					}
	  					for(String course: courseList){
	  					%>
	  						<option value="<%= course %>"><%= course %></option>
	  					<%
	  					}
	  					%>
	  				</select>				
	  			</form>
	  		</td>
		</tr>	    
	    <%
	        // Create the statement
	        String exc = "SELECT class.course_id, section_id, unit_range FROM course, class, class_section WHERE class.quarter = ? AND course.course_id = class.course_id AND class.course_id = class_section.course_id";
	    
	    	pstmt = conn.prepareStatement(exc);

            // Use the created statement to SELECT
            // the student attributes FROM the Student table.
            pstmt.setString(1, currentQuarter);
            rs = pstmt.executeQuery();
            ArrayList<String> sectionList = new ArrayList<String>();               
            if(action != null && action.equals("select"))
            	courseID = request.getParameter("course_id");
            else
            	courseID = courseList.get(0);
            while (rs.next()) {
            	if(rs.getString("course_id").equals(courseID)){	            	
            		sectionList.add(rs.getString("section_id"));
            	}
            }
            if(sectionList.size() > 0){
            	 
        %>
	    <tr>
	    	<td>Section</td>
	    	<td>
	    	<%
	    		if(sectionList.size() > 1){
	    	%>
	    			<select name="section_id">
	    			<%
	    			
	        			for (String section : sectionList) {
	    			%>
	            			<option value="<%= section %>"><%= section %></option>
	    			<%
	        			}
	    			%>
           			</select>
           	<%
	    		}
	    		else{
	    	%>
	    	        	<select>
	    	        		<option value="<%= sectionList.get(0) %>"><%= sectionList.get(0) %></option>
	    	        	</select>
	    	<%
	    		}
	    	%>
	    	</td>
	    </tr>           
		<% 
            }
         // Create the statement
            pstmt = conn.prepareStatement("SELECT unit_range FROM course WHERE course_id = ?"); 
         	pstmt.setString(1, courseID);

            // Use the created statement to SELECT
            // the student attributes FROM the Student table.
            rs = pstmt.executeQuery();      
            String units = null;
            while (rs.next()) {
            	units = rs.getString("unit_range");
            }
            if(units != null){
				int index = units.indexOf("~");			
	    %>	    	
        <tr>
	    	<td>Units</td>
	    	<td>
	    		<%
	            if(index != -1){
	            	int first = Integer.parseInt(units.substring(0, index));
	            	int second = Integer.parseInt(units.substring(index+1, units.length()));
	    		%>
	    			<select name="units">
	    			<% 
	    				for(int i = first; i <= second; ++i){
	    			%>
	            		<option value="<%= i %>"><%= i %></option>
	            	<%
	    				}
	            	%>
	    		
           			</select>
           		<%
	            }
	            else{	            		            	
           		%>
           		<select name="units">	    			
	            		<option value="<%= units %>"><%= units %></option>	    		
           		</select>
	    	</td>
	    </tr>
	    <%
	    		}
            }
	    %>
    </table> 
    <form action="courseenrollment.jsp" method="post">  
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
            pstmt.close();

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
