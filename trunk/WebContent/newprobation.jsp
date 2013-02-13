<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="favicon.ico" >
<script src="js/jquery-1.9.1.js">
</script>
<title>New probation</title>
</head>
<body>

<form action="probations.jsp" method="post">
    <input type="hidden" value="insert" name="action">
    <table>
        <tr>
          	<th colspan="2">Probation Information</th>
        </tr>
		<tr>
    	  	<td>Student ID</td>
	  		<td>
	  			<input name="student_id" value = "">	  			
	  		*</td>
		</tr>
        <tr>
            <td>Period</td>
            <td>
                <select name="begin_quarter">             
                    <option value="Fall">Fall</option>
                    <option value="Winter">Winter</option>
                    <option value="Spring">Spring</option>
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
                    <option value="Fall">Fall</option>
                    <option value="Winter">Winter</option>
                    <option value="Spring">Spring</option>
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
            </td>
        </tr>
	    <tr>
	       <td>Reason</td>
	       <td>
	           <textarea rows="4" cols="50" name="reason"></textarea>
	       </td>
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
