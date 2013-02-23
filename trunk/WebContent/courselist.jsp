<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Courses</title>
    <style>
        .table th {
            vertical-align: middle;
        }
    </style>
</head>

<body>
    <%-- Set the scripting language to Java and --%>
    <%-- Import the java.sql package --%>
    <%@ page language="java" import="java.sql.*" %>
    <%@ page language="java" import="db.Config" %>
    <%-- -------- Open Connection Code -------- --%>
    <%
        try {
            // Load JDBC Driver class file
            DriverManager.registerDriver
                (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

            // Make a connection to the MS SQL Server datasource "tritonlink"
            Connection conn = DriverManager.getConnection(Config.connectionURL);
    %>
    
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">Tritonlink 132B</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li><a href="index.jsp">Home</a></li>
              <li><a href="studentlist.jsp">Students</a></li>
              <li><a href="facultylist.jsp">Faculty</a></li>
              <li class="active"><a href="courselist.jsp">Course</a></li>
              <li><a href="classlist.jsp">Class</a></li>
              <li><a href="programlist.jsp">Program</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span2">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">Actions</li>
              <li><a href="newcourse.jsp">Add course</a></li>
              <li class="divider"></li>
              <li><a onclick="window.history.back()">Back</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->

        <div class="span10">
            <%
                Statement statement = conn.createStatement();

                ResultSet rs = statement.executeQuery
                    ("SELECT * FROM Course");
            %>
            <table class="table table-hover">
                <tr>
                    <th>Course ID</th>
                    <th>Department</th>
                    <th>Consent</th>
                    <th>Unit Range</th>
                    <th>Grade Type</th>
                    <th>Labwork</th>
                    <th>Prerequisite</th>
                </tr>
            <%
                    while ( rs.next() ) {
                        String prerequisite = "";
                        String courseId = rs.getString("course_id");
        
            %>
                <tr onclick="document.location = 'course.jsp?&courseId=' + <%= courseId %>;">
                    <td><%= rs.getString("course_id") %></td>
                    <td><%= rs.getString("department") %></td>    
                    <td><%= rs.getString("is_consent") %></td>
                    <td><%= rs.getString("unit_range") %></td>
                    <td><%= rs.getString("grade_type") %></td>
                    <td><%= rs.getBoolean("labwork") %></td>

                    <%
                    PreparedStatement pstmt = conn.prepareStatement(
                    "SELECT pre_course_id FROM prerequisite WHERE prerequisite.course_id=?");
                        pstmt.setString(1, rs.getString("course_id"));
                        ResultSet rsPre = pstmt.executeQuery();
                        //String sql = "SELECT pre_course_id FROM prerequisite WHERE prerequisite.course_id='CSE202'";
                        //ResultSet rsPre = statement.executeQuery(sql);
                        //System.out.println("SELECT pre_course_id FROM prerequisite as p WHERE p.course_id='" + rs.getString("course_id")+"'");
                        prerequisite = "";
                        System.out.println(prerequisite);
                        while (rsPre.next()) {
                            prerequisite += rsPre.getString("pre_course_id");
                            prerequisite += ";";
                        }
                    %>
                    <td><%= prerequisite %></td>
                </tr>
            <%
                }
            %>
         </table>
     </div>
     </div>
 </div>

    <%-- -------- INSERT Code -------- --%>
    <%
            String action = request.getParameter("action");
            // Check if an insertion is requested
            if (action != null && action.equals("insert")) {
                // Preprocess submitted form data
                
                String course_id = request.getParameter("course_id");
                String department = request.getParameter("department");                    	                        
                String is_consent = request.getParameter("is_consent");
                String unit_range = request.getParameter("unit_range");
                String grade_type = request.getParameter("grade_type");
                String labwork = request.getParameter("labwork");
                String[] prerequisiteList = request.getParameterValues("prerequisite");

                for (String prerequisite : prerequisiteList) {
                    System.out.println(prerequisite);
                }
                
                // Begin transaction
                conn.setAutoCommit(false);
                
                // Create the prepared statement and use it to
                // INSERT the student attributes INTO the Student table.
                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO Course VALUES (?, ?, ?, ?, ?, ?)");

                pstmt.setString(1, request.getParameter("course_id"));
                pstmt.setString(2, request.getParameter("department"));
                pstmt.setBoolean(3, Boolean.parseBoolean(request.getParameter("is_consent")));
                pstmt.setString(4, request.getParameter("unit_range"));
                pstmt.setString(5, request.getParameter("grade_type"));
                pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("labwork")));

                int rowCount = pstmt.executeUpdate();

                pstmt = conn.prepareStatement("INSERT INTO prerequisite VALUES (?, ?)");

                for (String prerequisite : prerequisiteList) {
                    pstmt.setString(1, course_id);
                    pstmt.setString(2, prerequisite);
                    rowCount = pstmt.executeUpdate();
                }
                
                // Commit transaction
                conn.commit();
                conn.setAutoCommit(true);
            }
    %>

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
</body>
</html>
