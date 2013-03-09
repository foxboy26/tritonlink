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
    String student = "";
    String studentId = request.getParameter("studentId");
    String identity = request.getParameter("identity");
    if(action != null && action.equals("select")) {
    	name = request.getParameter("name");
    	student = request.getParameter("student");
    }
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
            <fieldset>
                <form class="form-horizontal" action="checkmsdegree.jsp" method="post"> 
                    <input type = "hidden" value = "select" name = "action">
                    <input type = "hidden" value = "<%= studentId %>" name = "studentId">
                    <input type = "hidden" value = "<%= identity %>" name = "identity">
                    
                    <legend>Choose a student</legend>
                    <div class="control-group">
                        <label class="control-label">Student</label>
                        <div class="controls">
                        <%
                            statement = conn.createStatement();
                            rs = statement.executeQuery("SELECT student.student_id, firstname, middlename, lastname FROM student, graduate WHERE student.student_id = graduate.student_id");
                            //rs = statement.executeQuery("SELECT name FROM program");
                            ArrayList<String> studentList = new ArrayList<String>();
                            while (rs.next()) {            
                                    studentList.add(rs.getString("student_id"));
                        }
                        %>
                            <select  onfocus="this.selectedIndex = -1;" name = "student">
                            <%
                            
                            for(String s : studentList){
                            	Statement statement2 = conn.createStatement();
                            	ResultSet r = statement2.executeQuery("SELECT firstname, middlename, lastname FROM student WHERE student_id =" + s);
                            	if(r.next()){ 
                            %>
                            	
                                <option value="<%= s %>"><%= r.getString("firstname") + " " + r.getString("middlename") + " " + r.getString("lastname")%></option>
                            <%
                            	}
                            }
                            %>
                            </select>   
                        </div>
                    </div>
                    
                    
                    
                    <legend>Choose a program</legend>
                    <div class="control-group">
                        <label class="control-label">Program</label>
                        <div class="controls">
                        <%
                            statement = conn.createStatement();
                            rs = statement.executeQuery("SELECT name FROM program WHERE name LIKE 'M%'");
                            //rs = statement.executeQuery("SELECT name FROM program");
                            ArrayList<String> programList = new ArrayList<String>();
                            while (rs.next()) {            
                                    programList.add(rs.getString("name"));
                        }
                        %>
                            <select  onfocus="this.selectedIndex = -1;" name = "name">
                           <%
                            for(String program : programList){
                            %>
                                <option value="<%= program %>"><%= program %></option>
                            <%
                            }
                            %>
                            </select>   
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Confirm</button>
                </form> 
                <%
                	if(action != null){
                %>
                 <legend>Student Info</legend>
                <table class="table table-hover">
                            <tr>
                                <th>SSN</th>
                                <th>First Name</th>
                                <th>Middle Name</th>
                                <th>Last Name</th>                             
                            </tr>
                 <%
                 	rs = statement.executeQuery("SELECT ssn, firstname, middlename, lastname FROM student WHERE student_id = '" + student + "'");
                    rs.next();
                 %>
                  			<tr>
                                <th><%= rs.getString("ssn")%></th>
                                <th><%= rs.getString("firstname")%></th>
                                <th><%= rs.getString("middlename")%></th>
                                <th><%= rs.getString("lastname")%></th>                             
                            </tr>
                </table>
                
                  <legend>Degree Info</legend>
                <table class="table table-hover">
                            <tr>
                                <th>Name</th>
                                <th>Type</th>                                                  
                            </tr>
                 <%
                 	rs = statement.executeQuery("SELECT * FROM program WHERE name = '" + name + "'");
                    rs.next();
                 %>
                  			<tr>
                                <th><%= rs.getString("name")%></th>
                                <th><%= rs.getString("degree_type")%></th>                           
                            </tr>
                </table>

                <%
                    
                    	int total = 0, totalRequired = 0;
                        String sql = "SELECT * FROM" +
                                        " (SELECT SUM(unit) AS total FROM student_section WHERE student_id=" + studentId + " AND grade IS NOT NULL) owned, " +
                                        " (SELECT units FROM program_requirement" + 
                                        " WHERE program_name='" + name + "'" +
                                        " AND category='all') required";
                        rs = statement.executeQuery(sql);
                        if (rs.next()) {
                            total = rs.getInt("total");
                            totalRequired = rs.getInt("units");
                        }
                        
                        sql = "SELECT units FROM program_requirement" + 
                                " WHERE program_name='" + name + "'" +
                                " AND category='all'";
                        

                        String required = "SELECT category, units FROM program_requirement" + 
                              " WHERE program_name='" + name + "'" +
                              " AND NOT category LIKE 'c-%'";

                        String owned = "SELECT p.category AS category, SUM(ss.unit) AS units" +
                              " FROM student_section AS ss, class_section AS cs, plans AS p" +
                              " WHERE ss.section_id=cs.section_id" +
                              " AND cs.course_id=p.course_id" +
                              " AND ss.student_id=" + studentId +
                              " AND p.program_name='" + name + "'" +
                              " AND NOT p.category LIKE 'c-%'" +
                              " GROUP BY category";
                        
                        sql = "SELECT owned.category AS category, owned.units AS o_units, required.units AS r_units FROM" +
                              " (" + owned + ") owned, " +
                              " (" + required + ") required" +
                              " WHERE owned.category=required.category";

                        rs = statement.executeQuery(sql);
                %>
                <legend>Status</legend>
                <div>
                    <h3>Total units: <%= totalRequired %>, <%= totalRequired - total %> remains.</h3>
                </div>
                <table class="table">
                    <tr>
                        <th>Category</th>
                        <th>Required Units</th>
                        <th>Completed Units</th>
                        <th>Remaining Units</th>
                    </tr>
                    <%
                        int i = 0;
                        while (rs.next()) {
                            String category = rs.getString("category");
                            int rUnits = rs.getInt("r_units");
                            int oUnits = rs.getInt("o_units");
                    %>
                    <tr>
                        <td><%= category %></td>
                        <td><%= rUnits %></td>
                        <td><%= oUnits %></td>
                        <td><%= (rUnits - oUnits > 0)? rUnits - oUnits : 0 %></td>
                    </tr>
                    <%
                        }
                        sql = "SELECT R.category, units FROM (" + required +  ") AS R" +
                        	  " WHERE R.category NOT IN (SELECT category FROM (" + owned + ") AS O)" +
                        	  " AND R.category <> 'all'";
                        rs = statement.executeQuery(sql);
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getInt("units")%></td>
                        <td><%= 0 %></td>
                        <td><%= rs.getInt("units") %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                    	
                <%    	
                    	
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
                        <th>Concentration</th>
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
                        String next = Config.currentQuarter;
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
                                if(Quarter.greater( Config.currentQuarter, next))
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
                            else if(Quarter.greater(next, quarter) && Quarter.greater(quarter,  Config.currentQuarter)){
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

            var args = '?' + 'studentId=<%= studentId %>' + '&' + 'identity=<%= identity %>';
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp' + args);
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp' + args);
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp' + args);
            $('#sub-newthesiscommittee > a').attr('href', 'newthesiscommittee.jsp' +  args);
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp' + args);
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp' + args);
            <%
                if (identity.equals("undergraduate")) {
            %>
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp' + args);
            <%
                }

                if (identity.equals("graduate")) {
            %>
            $('#sub-checkdegree > a').attr('href', 'checkmsdegree.jsp' + args);
            <%
                }
            %>
            $('#sub-conflictclass > a').attr('href', 'conflictclass.jsp' + args);
            $('#sub-decisionsupport > a').attr('href', 'decisionsupport.jsp' + args);
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
