<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Check Degree Requirement</title>
</head>

<%-- Import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@ page language="java" import="db.Config" %>
<%@ page language="java" import="db.Quarter" %>
<%-- -------- Open Connection Code -------- --%>
<%
try {
    // Load JDBC Driver class file
    DriverManager.registerDriver
      (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

    // Make a connection to the MS SQL Server datasource "tritonlink"
    Connection conn = DriverManager.getConnection(Config.connectionURL);

    Statement statement = null;
    ResultSet rs = null;

    String action = request.getParameter("action");
    String name = "";
    String studentId = request.getParameter("studentId");
    if(action != null && action.equals("select")) {
    	name = request.getParameter("name");
    }
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
            <fieldset>
            <legend>Choose a program</legend>
                <form class="form-horizontal" action="checkmsdegree.jsp?studentId=<%= studentId %>" method="post"> 
                    <input type = "hidden" value = "select" name = "action">
                    
                    <div class="control-group">
                        <label class="control-label">Program</label>
                        <div class="controls">
                        <%
                            statement = conn.createStatement();
                            rs = statement.executeQuery("SELECT name FROM program WHERE name LIKE 'M%'");
                            ArrayList<String> programList = new ArrayList<String>();
                            while (rs.next()) {            
                                    programList.add(rs.getString("name"));
                        }
                        %>
                            <select onchange = form.submit() name = "name">
                            <%
                            if(action != null && action.equals("select")){
                            	programList.remove(request.getParameter("name"));   
                            %>
                                <option value="<%= request.getParameter("name") %>"><%= request.getParameter("name") %></option>
                            <% 
                            }
                            for(String program : programList){
                            %>
                                <option value="<%= program %>"><%= program %></option>
                            <%
                            }
                            %>
                            </select>   
                        </div>
                    </div>
                </form>         
                <legend>Status</legend>
                <%
                    if (action != null && action.equals("select")) {
						
                    	//Find all courses a student has taken
                    	String table1 = "SELECT course_id, unit, grade FROM student_section, class_section" +
                    				    " WHERE student_section.student_id = '" + studentId + "'" + 
                    				    " AND student_section.section_id = class_section.section_id";
                    	
                    	//Find all the courses belong to some concentration of the selected degree 
                    	String table2 = "SELECT course_id, category FROM plans" +
            				    		" WHERE plans.program_name = '" + name + "'" +
                    					" AND  category LIKE 'c-%'";
                    	
                    	//Find completed units of each concentration
                    	String table3 = "SELECT SUM(unit) AS sunit, category FROM (" + table1 + ") AS S, (" + table2 + ") AS C" +
                    				    " WHERE S.course_id = C.course_id" +
                    					" GROUP BY category";
                    	
                    	//Find GPA of each concentration
                    	String table4 = "SELECT (SUM(number_grade* unit)/SUM(unit)) AS gpa, category" +
                    					" FROM (" + table1 + ") AS S, (" + table2 + ") AS C, grade_conversion" +
                    					" WHERE S.course_id = C.course_id" +
                    					" AND S.grade = grade_conversion.letter_grade" +
                    					" GROUP BY category";
                    	
                    	//Find all completed concentrations
                    	String table5 = "SELECT COM.category, sunit, gpa, units, min_gpa" +
                    					" FROM (" + table3 + ") AS COM, (" + table4 + ") AS G, program_requirement" +
                    					" WHERE COM.category = G.category" +
                    					" AND COM.category = program_requirement.category" +
                    					" AND program_name = '" + name + "'" +
                    					" AND sunit >= units" +
                    					" AND gpa >= min_gpa";
                        
                        rs = statement.executeQuery(table5);                                       
                %>
                <div class="control-group">
                	<label class="control-label">Completed Concentrations</label>
                	<div class="controls">
                <table class="table">
                    <tr>
                        <th>Category</th>
                        <th>Required Units</th>
                        <th>Completed Units</th>
                        <th>Required GPA</th>
                        <th>Completed GPA</th>
                    </tr>
                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getInt("units") %></td>
                        <td><%= rs.getInt("sunit") %></td>
                        <td><%= rs.getString("min_gpa") %></td>
                        <td><%= rs.getString("gpa") %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                	<%
                	//Find all courses that have not taken yet from every concentration
                	String table6 = "SELECT course_id, category FROM (" + table2 + ") AS C" +
                					" WHERE course_id NOT IN (SELECT course_id FROM (" + table1 + ") AS S)" +
                					" AND category LIKE 'c-%'";
                	
                	String table7 = "SELECT N.course_id, category, quarter FROM class, (" + table6 + ") AS N" +
                					" WHERE N.course_id = class.course_id" +
                        			" ORDER BY  N.course_id";
                	
                	rs = statement.executeQuery(table7);   
                	              	                	
               	 	%>
                 	
                <div class="control-group">
                <label class="control-label">Courses to choose</label>
                <div class="controls">
                <table class="table">
                	<tr>
                        <th>Course ID</th>
                        <th>concentration</th>    
                        <th>Given time</th>                       
                    </tr>
                    <% 
                    String next = "Spring 2005";
                    String courseId = "";
                    String category = "";
                    	
                	while (rs.next()) {
                		
                		String quarter =  rs.getString("quarter");
                		if(courseId == ""){
                			courseId = rs.getString("course_id");
                			category = rs.getString("category");
                			next = quarter;
                		}
                		if(!courseId.equals(rs.getString("course_id"))){
                			if(Quarter.greater("Spring 2005", next))
								next = "";
                	%>
                    	<tr>
                    		<td><%= courseId %></td>
                        	<td><%= category %></td>
                        	<td><%= next %></td>
                    	</tr>
                    <%
                    		courseId = rs.getString("course_id");
                    		category = rs.getString("category");
                    		next = quarter;
                		}
                		else if(Quarter.greater(next, quarter) && Quarter.greater(quarter, "Spring 2005")){
                			next =  quarter;
                		}
                	}
                	%>
                	<tr>
                    		<td><%= courseId %></td>
                        	<td><%= category %></td>
                        	<td><%= next %></td>
                    	</tr>
                    <% 
                    }
                    %>              
                    	
                </table>
                </div>
                </div>
            	</div>
        	</div>
        </fieldset>
    </div>
    </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-checkmsdegree').addClass('active');

            $('#sub-newprobation > a').attr('href', 'newprobation.jsp?studentId=<%= studentId %>');
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp?studentId<%= studentId %>');
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp?studentId=<%= studentId %>');
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp?studentId=<%= studentId %>');
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp?studentId=<%= studentId %>');
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp?studentId=<%= studentId %>');
            $('#sub-checkmsdegree > a').attr('href', 'checkmsdegree.jsp?studentId=<%= studentId %>');
            $('#sub-conflictclass > a').attr('href', 'conflictclass.jsp?studentId=<%= studentId %>');
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
