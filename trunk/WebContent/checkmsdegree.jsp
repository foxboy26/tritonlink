<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Check Degree Requirement</title>
</head>

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

    Statement statement = null;
    ResultSet rs = null;

    String action = request.getParameter("action");
    String name = "";
    String studentId = request.getParameter("studentId");
    if(action != null && action.equals("select")) {
    	name = request.getParameter("name");
    }
%>
<body>
    <jsp:include page="tpl/header.html" />
    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />
            <div class="span10">
                <form class="form-horizontal" action="checkdegree.jsp?studentId=<%= studentId %>" method="post"> 
                    <input type = "hidden" value = "select" name = "action">
                    <legend>Choose a program</legend>
                    <div class="control-group">
                        <label class="control-label">Program</label>
                        <div class="controls">
                        <%
                            statement = conn.createStatement();
                            rs = statement.executeQuery("SELECT name FROM program");
                            ArrayList<String> programList = new ArrayList<String>();
                            while (rs.next()) {            
                                    programList.add(rs.getString("name"));
                        }
                        %>
                            <select onchange = form.submit() name = "name">
                            <%
                            if(action != null && action.equals("select")){
                            	programList.remove(request.getParameter("name"));   
                            %>
                                <option value="<%= request.getParameter("name") %>"><%= request.getParameter("name") %></option>
                            <% 
                            }
                            for(String program : programList){
                            %>
                                <option value="<%= program %>"><%= program %></option>
                            <%
                            }
                            %>
                            </select>   
                        </div>
                    </div>
                </form>         
                <legend>Status</legend>
                <%
                    if (action != null && action.equals("select")) {
                        int total = 0;
                        String sql = "SELECT SUM(unit) AS total FROM student_section WHERE student_id=" + studentId;
                        rs = statement.executeQuery(sql);
                        if (rs.next()) {
                            total = rs.getInt("total");
                        }

                        sql = "SELECT category, units FROM program_requirement WHERE program_name='" + name + "'";
                        rs = statement.executeQuery(sql);
                        int totalRequired = 0;
                        ArrayList<Integer> requiredUnitList = new ArrayList<Integer> ();
                        while (rs.next()) {
                            if(rs.getString("category").equals("all"))
                                totalRequired = rs.getInt("units");
                            else
                                requiredUnitList.add(rs.getInt("units"));
                        }

                        sql = "SELECT p.category AS category, SUM(ss.unit) AS units " +
                              "FROM student_section AS ss, class_section AS cs, plans AS p " +
                              "WHERE ss.section_id=cs.section_id " +
                              "AND cs.course_id=p.course_id " +
                              "AND ss.student_id=" + studentId + " " +
                              "AND p.program_name='" + name + "' " +
                              "GROUP BY category";

                        rs = statement.executeQuery(sql);
                %>
                <div>
                    <h3>Total units: <%= totalRequired %>, <%= totalRequired - total %> remains.</h3>
                </div>
                <table class="table">
                    <tr>
                        <th>Category</th>
                        <th>Required Units</th>
                        <th>Completed Units</th>
                        <th>Remaining Units</th>
                    </tr>
                    <%
                        int i = 0;
                        while (rs.next()) {
                            String category = rs.getString("category");
                            int requiredUnits = requiredUnitList.get(i++);
                            int units = rs.getInt("units");
                    %>
                    <tr>
                        <td><%= category %></td>
                        <td><%= requiredUnits %></td>
                        <td><%= units %></td>
                        <td><%= requiredUnits - units %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-checkmsdegree').addClass('active');
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp?studentId=<%= studentId %>');
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp?studentId<%= studentId %>');
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp?studentId=<%= studentId %>');
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp?studentId=<%= studentId %>');
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp?studentId=<%= studentId %>');
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp?studentId=<%= studentId %>');
            $('#sub-checkmsdegree > a').attr('href', 'checkmsdegree.jsp?studentId=<%= studentId %>');
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
