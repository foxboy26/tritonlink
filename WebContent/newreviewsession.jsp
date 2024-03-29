<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/datepicker.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New Review Session</title>
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
<%@ page language="java" import="db.Config" %>
<%-- -------- Open Connection Code -------- --%>
<%

		
        String sectionId = request.getParameter("sectionId");
        String courseId = request.getParameter("courseId");
		String quarter = request.getParameter("quarter");
        
%>

<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_section.html" />
            <div class="span10">
                <form class="form-horizontal" action="sessionlist.jsp" method="post">
                    <input type="hidden" value="insert-review" name="action">
                    <fieldset>
                        <legend>New Review Session</legend>                       

                        <div class="control-group">
                            <label class="control-label">Section ID</label>
                            <div class="controls">
                                <input class="uneditable-input" type="text" name="sectionId" value = "<%= sectionId %>">
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label">Location</label>
                            <div class="controls">
                                <input type="text" name="location" value = "">
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label">Time</label>
                            <div class="controls">
                                <input class="input-small" type="text" name="start_time" value = ""> - <input class="input-small" type="text" name="end_time" value = "">
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label">Date</label>
                            <div class="input-append date" id="dpd1" data-date="" data-date-format="dd-mm-yyyy">
                            	<input id = "start" name= "days" class="span2" size="100" type="text" value="01-03-2013">
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                        </div>
                        
                         <div class="control-group">
                            <label class="control-label">Mandatory</label>
                            <div class="controls">
                        		<input type="checkbox" name="mandatory" value="1">
                        	</div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/util.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script>
        $(document).ready(function() {
        	 $('#nav-class').addClass('active');
             $('#sub-newreviewsession').addClass('active');

             var args = '?' + 'sectionId=<%= sectionId %>&courseId=<%= courseId%>&quarter=<%= quarter%>';
             $('#sub-newsession > a').attr('href', 'newsession.jsp' + args);
             $('#sub-sessionlist > a').attr('href', 'sessionlist.jsp' + args);
             $('#sub-newreviewsession > a').attr('href', 'newreviewsession.jsp' + args);
             $('#sub-checkreviewsession > a').attr('href', 'checkreviewsession.jsp' + args);
         	 
         	 $('#dpd1').datepicker().on('changeDate', function(ev) {
         	    if (ev.date.valueOf() > checkout.date.valueOf()) {
         	        var newDate = new Date(ev.date);
         	        newDate.setDate(newDate.getDate());
         	        checkout.setValue(newDate);
         	    }       	           	 
         	 }).data('datepicker');
        });
    </script>
</body>
</html>


