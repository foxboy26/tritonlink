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
            <jsp:include page="tpl/sub_class.html" />
            <div class="span10">
                <form class="form-horizontal" action="sessionlist.jsp?&sectionId=<%= sectionId %>&courseId= <%= courseId%>&quarter=<%= quarter%>" method="post">
                    <input type="hidden" value="insert-weekly" name="action">
                    <fieldset>
                        <legend>Weekly Meeting</legend>
                        <div class="control-group">
                            <label class="control-label">Type</label>
                            <div class="controls">
                                <select class="input-mini" name="type">
                                    <option value="LE">LE</option>
                                    <option value="DI">DI</option>
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
    <script>
        $(document).ready(function() {
            $('#nav-class').addClass('active');
            $('#sub-newsession').addClass('active');
        });
    </script>
</body>
</html>
