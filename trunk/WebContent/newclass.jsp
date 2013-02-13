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
    <script>
        function checkMandatory() {
            //if ($('.type').val() == "LE") {
            //    $('.mandatory').attr("disabled", true);            
            //}
            //else {
            //    $('.mandatory').attr("disabled", false);            
            //}
        }

        function addSection() {
            var num = parseInt($('#section_num').val());
            $('#section_num').val(num+1);
            $('#section_list').append($('.section').last());
        }

        function addMeeting(sectionId) {
            var sectionId = '#' + sectionId;
            var num = parseInt($(sectionId).val());
            $(sectionId).val(num+1);
            $(sectionId + '_meeting').append(
                '<tr> \
                    <td> \
                        <select name="year" onchange="checkMandatory()"> \
                            <option value="LE">LE</option> \
                            <option value="DI">DI</option> \
                        </select> \
                    </td> \
                    <td><input name="location"></td> \
                    <td><input name="start_time" size="5"> - <input name="end_time" size="5"></td> \
                    <td><input name="days"></td> \
                    <td><input type="checkbox" name="mandatory" value="1" checked="true"></td> \
                    <td></td> \
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
                    %>
                            <option value="<%= course %>"><%= course %></option>
                    <%
                        }
                    %>
                   </select>
               </td>
            </tr>
            <tr>
                <td>Title</td>
                <td>	 	    
                    <input name="title" value = "">
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
        </table> 

        <input type="hidden" value="2" id="section_num" name="section_num">
        <div id="section_list"> 
            Section List
            <button type="button" onclick="addSection()">Add</button>
            <table class='section'>
                <tr colspan="2">
                    <th>Section 1</th>
                </tr>
                <tr>
                    <td>Section ID</td>
                    <td><input name="section_id" size="5"></td>
                </tr>
                <tr>
                    <td>Instructor</td>
                    <td>
                        <select name="faculty_id">
                        <%
                            rs = statement.executeQuery("SELECT * FROM faculty");
                            while (rs.next()) {
                        %>
                            <option value="<%= rs.getString("faculty_id") %>"><%= rs.getString("name") %></option>
                        <%
                            }
                        %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Limit</td>
                    <td><input name="limit" size="5"></td>
                </tr>
                <tr>
                    <td>Weekly Meetings</td>
                    <td>
                        <input id="section1" type="hidden" value="1" name="meeting_num">
                        <table id="section1_meeting">
                            <tr>
                                <th>Type</th>
                                <th>Location</th>
                                <th>Time</th>
                                <th>Days</th>
                                <th>Mandatory</th>
                            </tr>
                            <tr>
                                <td>
                                    <select name="type" onchange="checkMandatory()">
                                        <option value="LE">LE</option>
                                        <option value="DI">DI</option>
                                    </select>
                                </td>
                                <td><input name="location"></td>
                                <td><input name="start_time" size="5"> - <input name="end_time" size="5"></td>
                                <td><input name="days"></td>
                                <td><input type="checkbox" name="mandatory" value="1" checked="true"></td>
                                <td><button type="button" onclick="addMeeting('section1')">Add</button></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <table class='section'>
                <tr colspan="2">
                    <th>Section 2</th>
                <tr>
                <tr>
                    <td>Section ID</td>
                    <td><input name="section_id" size="5"></td>
                </tr>
                <tr>
                    <td>Instructor</td>
                    <td>
                        <select name="faculty_id">
                        <%
                            rs = statement.executeQuery("SELECT * FROM faculty");
                            while (rs.next()) {
                        %>
                                <option value="<%= rs.getString("faculty_id") %>"><%= rs.getString("name") %></option>
                        <%
                            }
                        %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Limit</td>
                    <td><input name="limit" size="5"></td>
                </tr>
                <tr>
                    <td>Weekly Meetings</td>
                    <td>
                        <input id="section2" type="hidden" value="1" name="meeting_num">
                        <table id="section2_meeting">
                            <tr>
                                <th>Type</th>
                                <th>Location</th>
                                <th>Time</th>
                                <th>Days</th>
                                <th>Mandatory</th>
                            </tr>
                            <tr>
                                <td>
                                    <select name="type" onchange="checkMandatory()">
                                        <option value="LE">LE</option>
                                        <option value="DI">DI</option>
                                    </select>
                                </td>
                                <td><input name="location"></td>
                                <td><input name="start_time" size="5"> - <input name="end_time" size="5"></td>
                                <td><input name="days"></td>
                                <td><input type="checkbox" name="mandatory" value="1" checked="true"></td>
                                <td><button type="button" onclick="addMeeting('section2')">Add</button></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div> 

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
