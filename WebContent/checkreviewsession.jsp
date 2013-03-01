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
<%@ page language="java" import="java.util.ArrayList" %>
<%@ page language="java" import="java.util.Calendar" %>
<%@ page language="java" import="java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.util.Locale" %>
<%@ page language="java" import="java.text.DateFormat" %>
<%@ page language="java" import="db.Config" %>
<%@ page language="java" import="db.Meeting" %>
<%@ page language="java" import="db.ReviewSession" %>
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);
        
        Statement statement1 = conn.createStatement();
        
       
        
        String sectionId = request.getParameter("sectionId");
        
        String action = request.getParameter("action");
        
        String startdate = "07-12-2012";
        
        String enddate = "23-02-2013";

        ResultSet rs = statement1.executeQuery("SELECT student_id FROM student_section WHERE section_id = '" + sectionId + "'");
        
        ArrayList<Meeting> meetinglist = new  ArrayList<Meeting>();
        
        ArrayList<ReviewSession> reviewlist = new  ArrayList<ReviewSession>();
        
        String[] dic  = {"Su", "Mo","Tu", "We", "Th", "Fr", "Sa"};
        
        DateFormat df = new SimpleDateFormat("MMM d EEE", Locale.US);
        


        while(rs.next()){
        	
        	Statement statement2 = conn.createStatement();
        	String id = rs.getString("student_id");
        	ResultSet r = statement2.executeQuery("SELECT type, start_time, end_time, days FROM student_section, meeting WHERE student_id = '" + id + "'" + 
        										 " AND student_section.section_id = meeting.section_id");
        	while(r.next()){
        		if(r.getString("type").equals("RW"))
        			reviewlist.add(new ReviewSession(r.getTime("start_time"), r.getTime("end_time"), new SimpleDateFormat("dd-MM-yyyy").parse(r.getString("days"))));
        		else
        			meetinglist.add(new Meeting(r.getTime("start_time"), r.getTime("end_time"), r.getString("days")));   			
        	}
        	
        	r.close();
            statement2.close();
        } 
        
    %>
<body>
	<jsp:include page="tpl/header.html" />
    	<div class="container-fluid">
        	<div class="row-fluid">
            <jsp:include page="tpl/sub_section.html"/>
            <div class="span10">
             	<form class="form-inline" action="checkreviewsession.jsp?sectionId=<%= sectionId %>" method="post"> 
             		<input type = "hidden" value = "confirm" name = "action">
                    <div class="control-group">
                        <label class="control-label" for="course_id">Start Date</label>
                        <div class="input-append date" id="dpd1" data-date=<%=startdate%> data-date-format="dd-mm-yyyy">
                            <input id = "start" name= "start" class="span2" size="100" type="text" value="01-04-2013">
                            <span class="add-on"><i class="icon-th"></i></span>
                        </div>
                    </div>
        
        
        
                    <div class="control-group">
                        <label class="control-label" for="course_id">End Date</label>
                        <div class="input-append date" id="dpd2" data-date=<%=enddate%> data-date-format="dd-mm-yyyy">
                            <input id = "end" name = "end" class="span2" size="100" type="text" value="01-04-2013">
                            <span class="add-on"><i class="icon-th"></i></span>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Confirm</button>
            	</form>
           
                <%
                    if(action != null){
                 %>
                 	<div class="control-group">
                	<label class="control-label">Available Times</label>
                	<div class="controls">
                	<table class="table table-hover">
                    	<tr>
                        	<th>Date</th>
                        	<th>Day</th>
                         	<th>Time</th>                         	                    
                    	</tr>
         
                 <%
                        String start = request.getParameter("start");
                        String end = request.getParameter("end");
                        Calendar cstart = Calendar.getInstance();
                        cstart.setTime(new SimpleDateFormat("dd-MM-yyyy").parse(start));
                        Calendar cend = Calendar.getInstance();                       
                        cend.setTime(new SimpleDateFormat("dd-MM-yyyy").parse(end));
                        cstart.setFirstDayOfWeek(Calendar.MONDAY);
                        cend.setFirstDayOfWeek(Calendar.MONDAY);
                        int startdayOfWeek = cstart.get(Calendar.DAY_OF_WEEK) - 1;
                        int enddayOfWeek = cend.get(Calendar.DAY_OF_WEEK) - 1;
                        int dif = (int)((cend.getTimeInMillis() - cstart.getTimeInMillis())/(1000*60*60*24));
                        //Regular Meeting
                        for(int i = 0; i <= dif; ++i){
                        	Calendar nextDay = (Calendar) cstart.clone();
                        	nextDay.add (Calendar.DAY_OF_YEAR, i);
                        	int day = (startdayOfWeek+i)%7;
                        	if(day < 6 && day > 0){
                        	for(int j = 8; j < 20; ++j){                        		
                        		
                        		Meeting temp = new Meeting(new Time(j,0,0), new Time(j+1,0,0), dic[day] );
                        		boolean isConflict = false;
                        		for(Meeting m: meetinglist){
                        			if(temp.conflictWith(m)){
                        				isConflict = true;
                        				break;
                        			}
                        		}
                        		if(isConflict == false){                       			
                        			for(ReviewSession r: reviewlist){
                        				ReviewSession re = new ReviewSession(new Time(j, 0, 0), new Time(j+1, 0, 0), nextDay.getTime());
                            			if(re.conflictWith(r)){
                            				isConflict = true;
                            				break;
                            			}
                            		}
                        		}
                        		if(isConflict == false){
                        	%>
                        		<tr>
                        			<th><%= df.format(nextDay.getTime())%></th>
                        			<th><%= new Time(j,0,0)%></th>
                         			<th><%= new Time(j+1,0,0)%></th>                         	                    
                    			</tr>
                        	
                        	<%
                        		}
                        	}
                        	}
                        }

                %>
            	  	 </table>
                	</div> 
                <%
                    }
                %>
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
            	 
            	var now = new Date(2012, 12, 07, 0, 0, 0, 0);
            	var end = new Date(2013, 02, 23, 0, 0, 0, 0);
            	 
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
        statement1.close();


        // Close the Connection
        conn.close(); 
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
