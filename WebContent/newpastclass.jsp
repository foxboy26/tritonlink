<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New Past Class</title>
    <script type="text/javascript">
    function setStudent(){
        var stu = document.getElementsByName('student_id')[0].value;
        document.getElementsByName("rStudentID")[0].value = stu;
        document.getElementsByName("studentID")[0].value = stu;
        document.getElementsByName("studentID")[1].value = stu;
    }


    function setSecion(){
        var sec = (document.getElementsByName('section_id')[0]).options[document.getElementsByName('section_id')[0].selectedIndex].value;
        document.getElementsByName("rSectionID")[0].value = sec;
        alert(sec);
    }

    function setGrade(){
        var g = (document.getElementsByName('grade')[0]).options[document.getElementsByName('grade')[0].selectedIndex].value;
        document.getElementsByName("rGrade")[0].value = g;
    }

    function setUnits(){
        var unit = (document.getElementsByName('units')[0]).options[document.getElementsByName('units')[0].selectedIndex].value;
        document.getElementsByName("rUnits")[0].value = unit;
    }
    </script>
</head>

<body>
    <%-- Import the java.sql package --%>
    <%@ page language="java" import="java.sql.*" %>
    <%@ page language="java" import="java.util.ArrayList" %>
    <%@ page language="java" import="db.Config" %>
    <%
        try {
            // Load JDBC Driver class file
            DriverManager.registerDriver
                (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

            // Make a connection to the MS SQL Server datasource "tritonlink"
            Connection conn = DriverManager.getConnection(Config.connectionURL);
            String action = request.getParameter("action");
            String studentID = "";
            String courseID = "";
            String sectionID = "";
            String quarter = "";
            String grade = "A+";
            String unit = "";
            String currentQuarter = "Winter 2013";

            if(action != null){   
                courseID = request.getParameter("course_id");
                studentID = request.getParameter("studentID");
                if(action.equals("quarterSelect"))
                  quarter = request.getParameter("quarter");
            }

            String studentId = request.getParameter("studentId");
    %>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
              <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="brand" href="#">Tritonlink 132B</a>
              <div class="nav-collapse collapse">
                <ul class="nav">
                  <li><a href="index.jsp">Home</a></li>
                  <li class="active"><a href="studentlist.jsp">Students</a></li>
                  <li><a href="facultylist.jsp">Faculty</a></li>
                  <li><a href="courselist.jsp">Course</a></li>
                  <li><a href="classlist.jsp">Class</a></li>
                  <li><a href="programlist.jsp">Program</a></li>
                </ul>
              </div><!--/.nav-collapse -->
            </div>
        </div>
    </div>

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
                <input type = "hidden" value = "select" name = "action">
                <table>
                    <tr>
                        <th colspan="2">Past Classes Information</th>
                    </tr>
                    <tr>
                        <td>Student ID</td>
                        <td><input value= "<%=studentID%>" name="student_id" size="15" onkeyup = setStudent()>*</td>
                    </tr>
                    <tr>
                        <td>Course ID</td>
                        <td>	  			
                                
                                <%
                                 Statement statement = conn.createStatement();
                                 ResultSet rs = statement.executeQuery("SELECT * FROM course");
                                 ArrayList<String> courseList = new ArrayList<String>();
                                    while (rs.next()) {	  	       
                                            courseList.add(rs.getString("course_id"));
                                    }
                                
                                
                                /* PreparedStatement pstmt = conn.prepareStatement("SELECT course_id FROM class WHERE class.quarter = ?");
                                pstmt.setString(1, currentQuarter);
                                // Use the created statement to SELECT
                                // the student attributes FROM the Student table.
                                ResultSet rs = pstmt.executeQuery();
                                ArrayList<String> courseList = new ArrayList<String>();
                                while (rs.next()) {	  	       
                                        courseList.add(rs.getString("course_id"));
                                } */
                                %>
                                <form action="newpastclass.jsp" method="post"> 
                                    <input type="hidden" name = "action" value= "select">
                                    <input type="hidden" name = "studentID" value= "<%=studentID %>">
                                    <select onchange = "form.submit()" name = "course_id">
                                    <%
                                    
                                    if(action != null){
                                        courseList.remove(courseID);	
                                    %>
                                    <option value="<%= request.getParameter("course_id") %>"><%= request.getParameter("course_id") %></option>
                                    <% 
                                    }
                                    else
                                        courseID = courseList.get(0);
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
                        String exc = "SELECT DISTINCT quarter FROM class WHERE course_id = ? AND quarter != ?";
                    
                        PreparedStatement pstmt = conn.prepareStatement(exc);

                        // Use the created statement to SELECT
                        // the student attributes FROM the Student table.
                        pstmt.setString(1, courseID);
                        pstmt.setString(2, currentQuarter);
                        rs = pstmt.executeQuery();
                        ArrayList<String> quarterList = new ArrayList<String>();               
                        while (rs.next()) {            	         	
                                quarterList.add(rs.getString("quarter"));
                        }                       
                    %>
                    <tr>
                        <td>Quarter</td>
                        <td>
                        <form action="newpastclass.jsp" method="post">
                            <input type = "hidden" name = "action" value = "quarterSelect">
                            <input type = "hidden" name = "course_id" value = "<%= courseID%>">
                            <input type="hidden" name = "studentID" value= "<%=studentID %>">
                            <select name="quarter" onchange="form.submit()">
                            <% 
                            if(action != null && action.equals("quarterSelect")){        
                                quarterList.remove(quarter);
                            %>
                                <option value="<%= quarter %>"><%= quarter %></option>
                            <% 
                            }
                            else 
                                quarter = quarterList.get(0);
                            if(quarterList.size() > 0){
                                for (String q : quarterList){
                            %>
                                <option value="<%= q %>"><%= q %></option>
                            <%
                                }
                            }
                            %>
                            </select>
                        </form>
                        </td>
                    </tr>           
                    <tr>
                        <td>Section</td>
                        <td>
                        
                        <select name="section_id" onchange="setSection()">            
                        <% 
                            // Create the statement
                            pstmt = conn.prepareStatement("SELECT section_id FROM class_section WHERE  course_id = ? AND quarter = ?"); 
                            pstmt.setString(1, courseID);
                            pstmt.setString(2, quarter);
                            // Use the created statement to SELECT
                            // the student attributes FROM the Student table.
                            rs = pstmt.executeQuery(); 
                            ArrayList<String> sectionList = new ArrayList<String>();
                            while (rs.next()) {
                                sectionList.add(rs.getString("section_id"));
                            }
                            if(sectionList.size() > 0){
                                sectionID = sectionList.get(0);
                                for(String sec: sectionList){
                        %>
                                    <option value="<%= sec %>"><%= sec %></option>
                        <%
                                }
                            }
                        %>
                                
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Grade</td>
                        <td>	    	
                            <select name="grade" onchange="setGrade()">				
                                <option value="A+">A+</option>
                                <option value="A">A</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B">B</option>
                                <option value="B-">B-</option>
                                <option value="C+">C+</option>
                                <option value="C">C</option>
                                <option value="C-">C-</option>
                                <option value="D+">D+</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                                <option value="S">S</option>
                                <option value="U">U</option>
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
                                    unit = String.valueOf(unitList.get(0));
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
                </table> 
                <form action="pastclass.jsp" method="post">  
                <input type="hidden" value="insert" name="action">
                <table>
                    <tr>         	
                        <td><input type="hidden" name = "rStudentID" value= "<%= studentID%>"></td>
                        <td><input type="hidden" name = "rCourseID" value= "<%= courseID%>"></td>
                        <td><input type="hidden" name = "rSectionID" value= "<%= sectionID%>"></td>
                        <td><input type="hidden" name = "rQuarter" value=  "<%= quarter%>"></td>
                        <td><input type="hidden" name = "rGrade" value=  "<%= grade%>"></td>
                        <td><input type="hidden" name = "rUnits" value=  "<%= unit%>"></td>
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
        </div>
        </div>
    </div>
</body>
</html>