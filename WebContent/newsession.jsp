<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New class</title>
    <style>
        .table th {
            vertical-align: middle;
        }
    </style>
</head>

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
                <form id="newsession" class="form-horizontal" action="sessionlist.jsp?sectionId=<%= sectionId %>&courseId=<%= courseId%>&quarter=<%= quarter%>" method="post">
                    <input type="hidden" value="insert-weekly" name="action">
                    <input type="hidden" value="<%= sectionId %>" name="sectionId">
                    <fieldset>
                        <legend>Weekly Meeting</legend>
                        <div class="control-group">
                            <label class="control-label">Type</label>
                            <div class="controls">
                                <select class="input-mini" name="type">
                                    <option value="LE">LE</option>
                                    <option value="DI">DI</option>
                                    <option value="LAB">LAB</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Location</label>
                            <div class="controls">
                                <input type="text" name="location">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Time</label>
                            <div class="controls">
                                <input type="text" class="input-small" name="start_time"> - <input type="text" class="input-small" name="end_time">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Days</label>
                            <div class="controls">
                                <input type="text" class="input-small" name="days">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Mandatory</label>
                            <div class="controls">
                                <input type="checkbox" name="mandatory" value="1">
                            </div>
                        </div>

                        <div class="form-actions">
                            <button id="submit" type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
                <div id='error' class="alert alert-error" style='display:none'>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
				    <strong>Error!</strong> conflict!
				</div>
				<div id='error2' class="alert alert-error" style='display:none'>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
				    <strong>Error!</strong> A faculty can't have more than one session at the same time!
				</div>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/util.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-class').addClass('active');
            $('#sub-newsession').addClass('active');

             var args = '?' + 'sectionId=<%= sectionId %>&courseId=<%= courseId%>&quarter=<%= quarter%>';
             $('#sub-newsession > a').attr('href', 'newsession.jsp' + args);
             $('#sub-sessionlist > a').attr('href', 'sessionlist.jsp' + args);
             $('#sub-newreviewsession > a').attr('href', 'newreviewsession.jsp' + args);
             $('#sub-checkreviewsession > a').attr('href', 'checkreviewsession.jsp' + args);
        });
        
        $("#submit").click(function() {

            var url = "action/session.jsp"; // the script where you handle the form input.
            $.ajax({
                type: "POST",
                url: url,
                data: $("#newsession").serialize(), // serializes the form's elements.
                success: function(data)
                {
                    data = data.trim();	

                    if (data == 'success') {
                        document.location = 'sessionlist.jsp?sectionId=<%= sectionId %>&courseId=<%= courseId%>&quarter=<%= quarter%>';
                        return true;
                    } 
                    else if(data == 'faculty conflict'){
                    	$('#error2').css('display', 'block');
                    }
                    else {
                        $('#error').css('display', 'block');
                    }
                }
            });

            return false; // avoid to execute the actual submit of the form.
        });
    </script>
</body>
</html>
