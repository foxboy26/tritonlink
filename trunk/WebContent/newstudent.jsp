<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
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
        	'<tr class="university"> \
                <td><input value="" name="university"></td> \
                <td> \
                    <select name="degreetype"> \
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
		        <select name="QUARTER"> \
		            <option value="Spring">Spring</option> \
		            <option value="Summer">Summer</option> \
		            <option value="Fall">Fall</option> \
		            <option value="Winter">Winter</option> \
		        </select> \
			    <input value="" name="start" size="5">  \
			    -  \
			        <select name="QUARTER"> \
			            <option value="Spring">Spring</option>\
			            <option value="Summer">Summer</option>\
			            <option value="Fall">Fall</option>\
			            <option value="Winter">Winter</option>\
			        </select>\
			    <input value="" name="end" size="5">\
		    </td>\
		    </tr>');
    }
</script>

<form action="students.jsp" method="get">
    <input type="hidden" value="insert" name="action">
    <table id="basic">
        <tr>
          <th colspan="2">Basic information</th>
        </tr>
       <tr>
           <td>Identity</td>
           <td>
                <input type="radio" name="identity" value="undergraduate" onclick="showUndergraduateForm()">Undergraduate
                <input type="radio" name="identity" value="graduate" onclick="showGraduateForm()">Graduate
           </td>
        </tr>
	<tr>
    	  <td>Student ID</td>
	  <td><input value="" name="ID" size="15">*</td>
	</tr>
        <tr>
            <td>First name</td>
            <td><input value="" name="FIRSTNAME" size="15">*</td>
        </tr>
        <tr>
            <td>Middle name</td>
            <td><input value="" name="MIDDLETNAME" size="15"></td>
        </tr>
        <tr>
            <td>Last name</td>
            <td><input value="" name="LASTNAME" size="15">*</td>
        </tr>
        <tr>
          <td>SSN</td>
          <td><input value="" name="SSN" size="15"></td>
        </tr>
        <tr>
            <td>Residency</td>
            <td>
                <select name="RESIDENCY">
                  <option value="California resident">California resident</option>
                  <option value="Foreign student">Foreign student</option>
                  <option value="Non-CA US student">Non-CA US student</option>
                </select>  
		     *</td>
        </tr>
        <tr>
            <td>Enrollment</td>
            <td>
                <input type="radio" name="is_enrolled" value="1">Yes
                <input type="radio" name="is_enrolled" value="0">No
		    </td>
		<tr id="attendance">
		    <td>Attendance</td>
		    <td>
		        <select name="QUARTER">
                    <option value="Spring">Spring</option>
                    <option value="Summer">Summer</option>
                    <option value="Fall">Fall</option>
                    <option value="Winter">Winter</option>
                </select>
		    <input value="" name="start" size="5"> 
		    - 
                <select name="QUARTER">
                    <option value="Spring">Spring</option>
                    <option value="Summer">Summer</option>
                    <option value="Fall">Fall</option>
                    <option value="Winter">Winter</option>
                </select>
		    <input value="" name="end" size="5">
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
	<tr class="university">
	    <td><input value="" name="university"></td>
        <td>
            <select name="degreetype">
              <option value="Bachelor">Bachelor</option>
              <option value="Master">Master</option>
              <option value="Ph.D">Ph.D</option>
            </select>
         </td>
	     <td><button type="button" onclick="addUniversity()">Add</button></td>
	</tr>
    </table>
    
    <table id="graduate" style="display:none"> 
        <tr>
          <th colspan="2">Graduate information</th>
        </tr>
	<tr>
	    <td>Department</td>
	    <td><input value="" name="department"></td>
	</tr>
        <tr>
            <td>Degree type</td>
            <td>
                <select name="degreetype">
                  <option value="Master">Master</option>
                  <option value="PhD candidates">PhD candidates</option>
                  <option value="PhD precandidacy">PhD precandidacy</option>
                </select>  
             *</td>
        </tr>
    </table>
    
    <table id="undergraduate" style="display:none">
        <tr>
	    <th colspan="2">Undergradate information</th>
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
	    <td><input value="" name="major"></td>
	</tr>
	<tr>
	    <td>Minor</td>
	    <td><input value="" name="minor"></td>
	</tr>
        <tr>
            <td>Type</td>
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
</form>
</body>
</html>
