<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/datepicker.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Schedule</title>
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
<%@ page language="java" import="db.Meeting" %>
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);
        
        Statement statement = conn.createStatement();
        
        String sectionId = request.getParameter("sectionId");

        ResultSet rs = statement.executeQuery("SELECT student_id FROM student_section WHERE section_id = '" + sectionId + "'");
        
        ArrayList<>
        
    %>
%>
<body>
	<jsp:include page="tpl/header.html" />
    	<div class="container-fluid">
        	<div class="row-fluid">
            <jsp:include page="tpl/sub_section.html" />
            <div class="span10">
            	<div class="control-group">
                            <label class="control-label" for="course_id">Start Date</label>
                            <div class="input-append date" id="dpd1" data-date="01-04-2013" data-date-format="dd-mm-yyyy">
  								<input class="span2" size="100" type="text" value="01-04-2013">
  								<span class="add-on"><i class="icon-th"></i></span>
							</div>
            	</div>
			
			
			
				<div class="control-group">
                            <label class="control-label" for="course_id">End Date</label>
                            <div class="input-append date" id="dpd2" data-date="01-04-2013" data-date-format="dd-mm-yyyy">
  								<input class="span2" size="100" type="text" value="01-04-2013">
  								<span class="add-on"><i class="icon-th"></i></span>
							</div>
            	</div>
            	
			</div>
			</div>
		</div>
		
		<script src="js/jquery-1.9.1.js"></script>
    	<script src="js/bootstrap.min.js"></script>
    	<script src="js/bootstrap-datepicker.js"></script>
    	<script>
        	$(document).ready(function() {
            	$('#nav-course').addClass('active');
            	 
            	var now = new Date(2013, 03, 01, 0, 0, 0, 0);
            	var end = new Date(2013, 05, 07, 0, 0, 0, 0);
            	 
            	var checkin = $('#dpd1').datepicker({
            	  onRender: function(date) {
            	    return date.valueOf() < now.valueOf() ? 'disabled' : '';
            	  }
            	}).on('changeDate', function(ev) {
            	  if (ev.date.valueOf() > checkout.date.valueOf()) {
            	    var newDate = new Date(ev.date);
            	    newDate.setDate(newDate.getDate());
            	    checkout.setValue(newDate);
            	  }
            	  checkin.hide();
            	  $('#dpd2')[0].focus();
            	}).data('datepicker');
            	var checkout = $('#dpd2').datepicker({
            	  onRender: function(date) {
            	    return (date.valueOf() <= checkin.date.valueOf() || date.valueOf() > end.valueOf()) ? 'disabled' : '';
            	  }
            	}).on('changeDate', function(ev) {
            	  checkout.hide();
            	}).data('datepicker');	    	
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