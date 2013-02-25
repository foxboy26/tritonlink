<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New Course Enrollment</title>
</head>

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
      String courseID = "";
      String sectionID = "";
      String units = "";
      String studentID = "";
      String gradeType = "Letter";
      String currentQuarter = "Winter 2013";
      if(action != null && action.equals("select")){
          courseID = request.getParameter("course_id");
          studentID = request.getParameter("studentID");
      }
%>
<body>
    <jsp:include page="header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span2">
                <div class="well sidebar-nav">
                    <ul class="nav nav-list">
                        <li class="nav-header">Actions</li>
                        <li><a href="newprobation.jsp?studentId=<%= studentId %>">Add probation</a></li>
                        <li><a href="newCourseEnrollment.jsp?studentId=<%= studentId %>">Enroll new class</a></li>
                        <li class="active"><a href="newpastclass.jsp?studentId=<%= studentId %>">Add past class</a></li>
                        <li class="divider"></li>
                        <li><a href="student.jsp">Back</a></li>
                    </ul>
                </div><!--/.well -->
            </div><!--/span-->

            <div class="span10">
                <form action="newpastclass.jsp" method="post"> 
    <input type = "hidden" value = "select" name = "action">
    <table>
        <tr>
          	<th colspan="2">Course Enrollment Information</th>
        </tr>
        <tr>
    	  	<td>Student ID</td>
	  		<td><input value= "<%=studentID%>" name="student_id" size="15" onkeyup = setStudent()>*</td>
		</tr>
		<tr>
    	  	<td>Course ID</td>
	  		<td>	  			
	  				
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
	  				<form action="newCourseEnrollment.jsp" method="post"> 
	  					<input type="hidden" name = "action" value= "select">
	  					<input type="hidden" name = "studentID" value= "<%=studentID%>">
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
	        String exc = "SELECT course.course_id, section_id, unit_range FROM course, class_section WHERE class_section.quarter = ? AND  course.course_id = class_section.course_id";
	    
	    	pstmt = conn.prepareStatement(exc);

            // Use the created statement to SELECT
            // the student attributes FROM the Student table.
            pstmt.setString(1, currentQuarter);
            rs = pstmt.executeQuery();
            ArrayList<String> sectionList = new ArrayList<String>();               
            if(action == null)
            	courseID = courseList.get(0);
            while (rs.next()) {
            	if(rs.getString("course_id").equals(courseID)){	            	
            		sectionList.add(rs.getString("section_id"));
            	}
            }
            
            if(sectionList.size() > 0){        
            	sectionID = sectionList.get(0);
        %>
	    <tr>
	    	<td>Section</td>
	    	<td>
	    		
	    		<select name="section_id" onchange="setSecion()">
				<% 	    		 			
	        	for (String section : sectionList) {
	    		%>
	            	<option value="<%= section %>"><%= section %></option>
	    		<%
	        	}
            }
	    		%>
	    		</select>
	    	</td>
	    </tr>           
        <tr>
	    	<td>Units</td>
	    	<td>
	    	
            <select name="units" onchange="setUnits()">            
        	<% 
        		// Create the statement
            	pstmt = conn.prepareStatement("SELECT unit_range FROM course WHERE course_id = ?"); 
         		pstmt.setString(1, courseID);

            	// Use the created statement to SELECT
            	// the student attributes FROM the Student table.
            	rs = pstmt.executeQuery(); 
            	String result = null;
            	ArrayList<Integer> unitList = new ArrayList<Integer>();
            	while (rs.next()) {
            		result = rs.getString("unit_range");
           	 	}
            	if(result != null){
					int index = result.indexOf("~");	
					int first = 0;
					int second = 0;
	            	if(index != -1){
	            		first = Integer.parseInt(result.substring(0, index));
	            		second = Integer.parseInt(result.substring(index+1, result.length()));
	            	}
	            	else{
	            		first = Integer.parseInt(result);
	            		second = first;
	            	}
        				    			
	    			for(int i = first; i <= second; ++i){
	    				unitList.add(i);
	    			}	    			
	 				if(unitList.size() > 0){
	 					units = String.valueOf(unitList.get(0));
	 					for(int i : unitList){
	 				%>
	            		<option value="<%= i %>"><%= i %></option>
	            	<%
	 					}
	 				}
            	}
	            	%>
	    			
           		</select>
	    	</td>
	    </tr>
	     <tr>
            <td>Grade Type</td>
            <td>	 	    
	    		<select name="type" onchange = "setType()">	  
	            	<option value="Grade">Letter</option>	   
	            	<option value="S/U">S/U</option>	
	            	<option value="Both">Both</option>	   
	            	<option value="S/U Only">S/U Only</option>   
           		</select>
	    	*</td>
	    </tr>
    </table> 
    <form action="courseenrollment.jsp" method="post">  
    <input type="hidden" value="insert" name="action">
    <table>
        <tr>         	
         	<td><input type="hidden" name = "rStudentID" value= "<%= studentID%>"></td>
         	<td><input type="hidden" name = "rCourseID" value= "<%= courseID%>"></td>
         	<td><input type="hidden" name = "rSectionID" value= "<%= sectionID%>"></td>
         	<td><input type="hidden" name = "rUnits" value=  "<%= units%>"></td>
         	<td><input type="hidden" name = "rType" value=  "<%= gradeType%>"></td>
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
    <script type="text/javascript">
    function setStudent(){
        var stu = document.getElementsByName('student_id')[0].value;
        document.getElementsByName("rStudentID")[0].value = stu;
        document.getElementsByName("studentID")[0].value = stu;
    }

    function setSecion(){
        var sec = (document.getElementsByName('section_id')[0]).options[document.getElementsByName('section_id')[0].selectedIndex].value;
        document.getElementsByName("rSectionID")[0].value = sec;
    }

    function setUnits(){
        var unit = (document.getElementsByName('units')[0]).options[document.getElementsByName('units')[0].selectedIndex].value;
        document.getElementsByName("rUnits")[0].value = unit;
    }

    function setType(){
        var t = (document.getElementsByName('type')[0]).options[document.getElementsByName('type')[0].selectedIndex].value;
        document.getElementsByName("rType")[0].value = t;
    }
    </script>
</body>
</html>
