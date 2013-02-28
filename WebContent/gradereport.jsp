<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Grade Report</title>
    <style>
        .table th {
            vertical-align: middle;
        }
    </style>
</head>

<%-- Set the scripting language to Java and --%>
<%-- Import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="db.Config" %>
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);

 		String studentId = request.getParameter("studentId");

        Statement statement = conn.createStatement();
        ResultSet rs;
%>
<body>
     <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
                <div class="control-group">
                	<label class="control-label">Classes</label>
                	<div class="controls">
                	<table class="table table-hover">
                    	<tr>
                        	<th>#</th>
                        	<th>Course ID</th>
                         	<th>Quarter</th>
                         	<th>Title</th>
                         	<th>Units</th>
                         	<th>Grade</th>                         
                    	</tr>
                		<%
                    	String basic = "SELECT student_id, class.course_id, class.quarter, title, unit, grade"
                				+ " FROM student_section, class_section, class WHERE"
                				+ " class_section.course_id = class.course_id"
                				+ " AND class_section.quarter = class.quarter"
                				+ " AND class_section.section_id = student_section.section_id"
                				+ " AND student_section.student_id = '" + studentId + "'";
                		String sql	=	basic	+ " ORDER BY class.quarter";
                	
                
                    	rs = statement.executeQuery(sql);
                    	int i = 1;
                   	 	while ( rs.next() ) {
                		%>
                    	<tr>
                        	<td><%= i++ %></td>
                        	<td><%= rs.getString("course_id") %></td>
                        	<td><%= rs.getString("quarter") %></td>
                        	<td><%= rs.getString("title") %></td>
                        	<td><%= rs.getString("unit") %></td>
                        	<td><%= rs.getString("grade") %></td>                        
                    	</tr>
                	<%
                    	}
                	%>
                </table>
            </div>
            <label class="control-label">GPA</label>
                <div class="controls">
            	<table class="table table-hover">
                    	<tr>
                        	<th>Quarter</th>
                        	<th>GPA</th>
                   	 	</tr>
                    	<%
                    	String gpa = "SELECT quarter, (SUM(number_grade*unit)/SUM(unit)) AS gpa FROM grade_conversion AS G, ( "
                    			+	basic + " ) AS T"
                    			+	" WHERE G.letter_grade = T.grade"
                    			+	" GROUP BY quarter";
                	
                    	String cumulativegpa = "SELECT (SUM(number_grade*unit)/SUM(unit)) AS gpa FROM grade_conversion AS G, ("
                			+	basic + " ) AS T"
                			+	" WHERE G.letter_grade = T.grade"
                			+	" GROUP BY student_id";
                
                    	rs = statement.executeQuery(gpa);
                    	while ( rs.next() ) {
                		%>
                      	<tr>
                        	<td><%= rs.getString("quarter") %></td>
                        	<td><%= rs.getFloat("gpa") %></td>                        
                      	</tr>
                		<%
                    	}
                    	rs = statement.executeQuery(cumulativegpa);
                    	while ( rs.next() ) {
                	%>   
                 	<tr>
                    	<td>Cumulative</td>
                    	<td><%= rs.getFloat("gpa") %></td>                        
                 	</tr> 
                	 <%
                    	}
                 	%>
            </table>            
        </div>
    </div>
    </div>
    </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
        	$('#nav-student').addClass('active');
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp?studentId=<%= studentId %>');
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp?studentId=<%= studentId %>');
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp?studentId=<%= studentId %>');
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp?studentId=<%= studentId %>');
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp?studentId=<%= studentId %>');
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp?studentId=<%= studentId %>');
            $('#sub-checkmsdegree > a').attr('href', 'checkmsdegree.jsp?studentId=<%= studentId %>');
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


















 
