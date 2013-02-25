<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>New program requirement</title>
</head>

<%-- Set the scripting language to Java and --%>
<%-- Import the java.sql package --%>
<%
    String name = request.getParameter("name");
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_program.html" />
            <div class="span10">
                <form class="form-horizontal" action="programrequirementlist.jsp" method="post">

                <input type="hidden" value="insert" name="action">
                    <fieldset>
                        <legend>Requirement</legend>
                        <div class="control-group">
                            <label class="control-label">Program</label>
                            <div class="controls">
                                <input type="text" class="uneditable-input" name="program_name" value="<%= name %>">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Total units</label>
                            <div class="controls">
                                <input type="text" name="total_units">
                            </div>
                        </div>
                        <table id="category_list" class="table table-hover">
                            <tr>
                                <th>Category</th>
                                <th>Units</th>
                                <th>Min GPA</th>
                            </tr>
                            <tr>
                                <td><input type="text" name="category"></td>
                                <td><input type="text" name="units"></td>
                                <td><input type="text" name="min_gpa"></td>
                            </tr>
                        </table>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div><!--/row-->
        </div>
    </div><!--/.fluid-container-->

    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-program').addClass('active');
            $('#sub-newprogramrequirement').addClass('active');
        });

        function addCategory() {
            $('#category_list').append(
                '<tr> \
                    <td><input name="category" size="10"></td> \
                    <td><input name="units" size="4"></td> \
                    <td><input name="min_gpa" size="4"></td> \
                </tr>'
            );
        }
    </script>
</body>
</html>
