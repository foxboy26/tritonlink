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
</head>

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
        String studentId = request.getParameter("studentId");
        String courseID = "";
        String sectionID = "";
        String quarter = "";
        String grade = "A+";
        String unit = "";
        String currentQuarter = "Winter 2013";

        if(action != null){   
            courseID = request.getParameter("course_id");
            studentId = request.getParameter("studentId");
            if(action.equals("quarterSelect"))
              quarter = request.getParameter("quarter");
        }

%>
<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
                <form action="newpastclass.jsp" method="post"> 
                    <input type = "hidden" value = "select" name = "action">
                    <legend>Past Classes Information</legend>
                    <div class="control-group">
                        <label class="control-label">Student ID</label>
                        <div class="controls" id="student_id">
                            <input class="uneditable-input" type="text" value="<%= studentId %>" name="student_id" onkeyup=setStudent()>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Course ID</label>
                        <div class="controls" id="course_id">
                        <%
                            Statement statement = conn.createStatement();
                            ResultSet rs = statement.executeQuery("SELECT * FROM course");
                            ArrayList<String> courseList = new ArrayList<String>();
                            while (rs.next()) {	  	       
                                    courseList.add(rs.getString("course_id"));
                            }
                        %>
                            <form action="newpastclass.jsp" method="post"> 
                                <input type="hidden" name = "action" value= "select">
                                <input type="hidden" name = "studentId" value= "<%=studentId %>">
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
                        </div>
                    </div>

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
                    <div class="control-group">
                        <label class="control-label">Quarter</label>
                        <div class="controls" id="course_id">
                            <form action="newpastclass.jsp" method="post">
                                <input type = "hidden" name = "action" value = "quarterSelect">
                                <input type = "hidden" name = "course_id" value = "<%= courseID%>">
                                <input type="hidden" name = "studentId" value= "<%=studentId %>">
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
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Section</label>
                        <div class="controls" id="course_id">
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
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Grade</label>
                        <div class="controls" id="course_id">
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
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Units</label>
                        <div class="controls" id="course_id">
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
                        </div>
                    </div>
                </form>

                <form action="pastclass.jsp" method="post">  
                    <input type="hidden" value="insert" name="action">
                    <table>
                        <tr>         	
                            <td><input type="hidden" name = "rStudentId" value= "<%= studentId%>"></td>
                            <td><input type="hidden" name = "rCourseID" value= "<%= courseID%>"></td>
                            <td><input type="hidden" name = "rSectionID" value= "<%= sectionID%>"></td>
                            <td><input type="hidden" name = "rQuarter" value=  "<%= quarter%>"></td>
                            <td><input type="hidden" name = "rGrade" value=  "<%= grade%>"></td>
                            <td><input type="hidden" name = "rUnits" value=  "<%= unit%>"></td>
                        </tr>
                    </table>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="button" class="btn">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-newpastclass').addClass('active');
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp?studentId=<%= studentId %>');
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp?studentId=<%= studentId %>');
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp?studentId=<%= studentId %>');
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp?studentId=<%= studentId %>');
        });

        function setStudent(){
            var stu = document.getElementsByName('student_id')[0].value;
            document.getElementsByName("rStudentId")[0].value = stu;
            document.getElementsByName("studentId")[0].value = stu;
            document.getElementsByName("studentId")[1].value = stu;
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
</body>
</html>
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
