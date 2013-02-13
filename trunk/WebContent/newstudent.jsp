<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js"></script>
<title>New student</title>
</head>

<body>
<script>
    function showGraduateForm()
    {
        graduateForm = document.getElementById("graduate");
        undergraduateForm = document.getElementById("undergraduate");
        graduateForm.style.display = 'block';
        undergraduateForm.style.display = 'none';
    }
    
    function showUndergraduateForm()
    {
        graduateForm = document.getElementById("graduate");
        undergraduateForm = document.getElementById("undergraduate");
        graduateForm.style.display = 'none';
        undergraduateForm.style.display = 'block';
    }
    
    function addUniversity() {
        $('#background').append(
        	'<tr> \
                <td><input value="" name="university" size="30"></td> \
                <td> \
                    <select name="degree_type"> \
                      <option value="Bachelor">Bachelor</option> \
                      <option value="Master">Master</option> \
                      <option value="Ph.D">Ph.D</option> \
                    </select> \
                 </td> \
            </tr>');
    }
    
    function addAttendance() {
        $('#attendance').after(
	    	'<tr> \
	    	<td></td> \
	    	<td> \
		        <select name="begin_quarter"> \
		            <option value="Spring">Spring</option> \
		            <option value="Summer">Summer</option> \
		            <option value="Fall">Fall</option> \
		            <option value="Winter">Winter</option> \
		        </select> \
			    <input value="" name="begin_year" size="5">  \
			    -  \
			        <select name="end_quarter"> \
			            <option value="Spring">Spring</option>\
			            <option value="Summer">Summer</option>\
			            <option value="Fall">Fall</option>\
			            <option value="Winter">Winter</option>\
			        </select>\
			    <input value="" name="end_year" size="5">\
		    </td>\
		    </tr>');
    }
    
    function showPhdState()
    {
        //TODO: zhiheng
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

        Statement statement;

        ResultSet rs;
%>

<form action="students.jsp" method="post">
    <input type="hidden" value="insert" name="action">
    <table id="basic">
        <tr>
          <th colspan="2">Basic information</th>
        </tr>
       <tr>
           <td>Identity</td>
           <td>
                <input type="radio" name="identity" value="undergraduate" onchange="showUndergraduateForm()">Undergraduate
                <input type="radio" name="identity" value="graduate" onchange="showGraduateForm()">Graduate
           </td>
        </tr>
	<tr>
    	  <td>Student ID</td>
	  <td><input value="" name="student_id" size="15">*</td>
	</tr>
        <tr>
            <td>First name</td>
            <td><input value="" name="firstname" size="15">*</td>
        </tr>
        <tr>
            <td>Middle name</td>
            <td><input value="" name="middlename" size="15"></td>
        </tr>
        <tr>
            <td>Last name</td>
            <td><input value="" name="lastname" size="15">*</td>
        </tr>
        <tr>
          <td>SSN</td>
          <td><input value="" name="ssn" size="15"></td>
        </tr>
        <tr>
            <td>Residency</td>
            <td>
                <select name="residency">
                  <option value="California resident">California resident</option>
                  <option value="Foreign student">Foreign student</option>
                  <option value="Non-CA US student">Non-CA US student</option>
                </select>  
		     *</td>
        </tr>
        <tr>
            <td>Enrollment</td>
            <td>
                <input type="radio" name="is_enrolled" value="true">Yes
                <input type="radio" name="is_enrolled" value="false">No
		    </td>
		<tr id="attendance">
		    <td>Attendance</td>
		    <td>
		        <select name="begin_quarter">
                    <option value="Spring">Spring</option>
                    <option value="Summer">Summer</option>
                    <option value="Fall">Fall</option>
                    <option value="Winter">Winter</option>
                </select>
                <select name="begin_year">		        
		        <%
                    for (int i = 1900; i < 2014; ++i) {
                %>  
                    <option value="<%= i %>"><%= i %></option>
                <%
                    }
                %>
                </select>
		        - 
                <select name="end_quarter">
                    <option value="Spring">Spring</option>
                    <option value="Summer">Summer</option>
                    <option value="Fall">Fall</option>
                    <option value="Winter">Winter</option>
                </select>
                <select name="end_year">              
                <%
                    for (int i = 1900; i < 2014; ++i) {
                %>  
                    <option value="<%= i %>"><%= i %></option>
                <%
                    }
                %>
                </select>
		    <button type="button" onclick="addAttendance()">Add</button></td>
		</tr>
    </table>

    <table id="background">
	<tr>
	    <th colspan="2">Educational background</th>
	</tr>
	<tr>
	    <td>Name of school</td>
	    <td>Degree</td>
	</tr>
	<tr>
	    <td><input value="" name="university" size="30"></td>
        <td>
            <select name="degree_type">
            <%
                statement = conn.createStatement();
                rs = statement.executeQuery("SELECT degree_type FROM degree");

                while (rs.next()) {
            %>
            <option value="<%= rs.getString("degree_type") %>"><%= rs.getString("degree_type") %></option>
            <%
                }
            %>
            </select>
         </td>
	     <td><button type="button" onclick="addUniversity()">Add</button></td>
	</tr>
    </table>
    
    <table id="graduate"> 
        <tr>
          <th colspan="2">Graduate information</th>
        </tr>
	<tr>
	    <td>Department</td>
	    <td>
	    <%
            statement = conn.createStatement();

            rs = statement.executeQuery("SELECT * FROM department");
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
            <td>Degree type</td>
            <td>
                <select name="degree" onchange="showPhdState()">
                  <option value="MS">Master</option>
                  <option value="MSE">Master</option>
                  <option value="Ph.D">PhD</option>
                </select>  
             *</td>
        </tr>
        <tr id="state">
            <td>State</td>
            <td>
                <input type="radio" name="state" value="PhD candidates">PhD candidates
                <input type="radio" name="state" value="PhD precandidacy">PhD precandidacy
            </td>
        </tr>
    </table>
    
    <table id="undergraduate" style="display:none">
        <tr>
	    <th colspan="2">Undergraduate information</th>
        </tr>
	<tr>
	    <td>College</td>
            <td>
                <select name="college">
                  <option value="Revelle">Revelle</option>
                  <option value="John Muir">John Muir</option>
                  <option value="Thrugood Marshall">Thrugood Marshall</option>
                  <option value="Earl Warren">Earl Warren</option>
                  <option value="Eleanor Roosevelt">Eleanor Roosevelt</option>
                  <option value="Sixth">Sixth</option>
                </select>  
             *</td>
	</tr>
	<tr>
	    <td>Major</td>
	    <td>
            <select name="major">
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
	    <td>Minor</td>
        <td>
            <select name="minor">
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
            <td>Program type</td>
            <td>
                <select name="type">
                  <option value="normal">Normal</option>
                  <option value="5-year">5-year Bachelor's/MS program</option>
                </select>  
             *</td>
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
