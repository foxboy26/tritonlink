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
    String studentID = request.getParameter("studentId");
    String gradeType = "Letter";
    if(action != null && action.equals("select")){
        courseID = request.getParameter("course_id");
        studentID = request.getParameter("studentID");
    }
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
                <form action="newcourseenrollment.jsp" method="post"> 
                <input type = "hidden" value = "select" name = "action">
                <legend>Course Enrollment Information</legend>
                <div class="control-group">
                    <label class="control-label">Student ID</label>
                    <div class="controls">
                        <input class="uneditable-input" value= "<%= studentID %>" name="student_id" onkeyup = setStudent()>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">Course ID</label>
                    <div class="controls">
                    <%
                    PreparedStatement pstmt = conn.prepareStatement("SELECT course_id FROM class WHERE class.quarter = ?");
                    pstmt.setString(1, Config.currentQuarter);
                    ResultSet rs = pstmt.executeQuery();
                    ArrayList<String> courseList = new ArrayList<String>();
                    while (rs.next()) {            
                            courseList.add(rs.getString("course_id"));
                    }
                    %>
                        <form action="newcourseenrollment.jsp" method="post"> 
                            <input type="hidden" name = "action" value= "select">
                            <input type="hidden" name = "studentID" value= "<%= studentID %>">
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
                    </div>
                </div>
        <%
            // Create the statement
            String exc = "SELECT course.course_id, section_id, unit_range FROM course, class_section WHERE class_section.quarter = ? AND  course.course_id = class_section.course_id";
        
            pstmt = conn.prepareStatement(exc);

            pstmt.setString(1, Config.currentQuarter);
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
            }
        %>
                <div class="control-group">
                    <label class="control-label">Section</label>
                    <div class="controls">
                        <select name="section_id" onchange="setSecion()">
                        <%                          
                        for (String section : sectionList) {
                        %>
                            <option value="<%= section %>"><%= section %></option>
                        <%
                        }
                        %>
                        </select>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">Units</label>
                    <div class="controls">
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
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">Grade type</label>
                    <div class="controls">
                        <select name="type" onchange = "setType()">   
                            <option value="Letter">Letter</option>      
                            <option value="S/U">S/U</option>    
                            <option value="Both">Both</option>     
                            <option value="S/U Only">S/U Only</option>   
                        </select>
                    </div>
                </div>
                </form>

                <form action="courseenrollment.jsp" method="post">  
                    <input type="hidden" value="insert" name="action">
                    <table>
                        <tr>            
                            <td><input type="hidden" name = "rStudentID" value= "<%= studentID%>"></td>
                            <td><input type="hidden" name = "rCourseID" value= "<%= courseID%>"></td>
                            <td><input type="hidden" name = "rSectionID" value= "<%= sectionID%>"></td>
                            <td><input type="hidden" name = "rUnits" value=  "<%= units%>"></td>
                            <td><input type="hidden" name = "rType" value=  "<%= gradeType%>"></td>
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
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-newcourseenrollment').addClass('active');
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp?studentId=<%= studentID %>');
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp?studentID=<%= studentID %>');
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp?studentId=<%= studentID %>');
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp?studentId=<%= studentID %>');
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp?studentId=<%= studentID %>');
        });

        function setStudent(){
            var stu = document.getElementsByName('student_id')[0].value;
            document.getElementsByName("rStudentID")[0].value = stu;
            document.getElementsByName("studentID")[0].value = stu;
        }

        function setSecion(){
            var sec = (document.getElementsByName('section_id')[0]).options[document.getElementsByName('section_id')[0].selectedIndex].value;
            document.getElementsByName("rSectionId")[0].value = sec;
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