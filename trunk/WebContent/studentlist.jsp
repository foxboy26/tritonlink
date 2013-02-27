<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Tritonlink - Students</title>
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
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);
%>
<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_studentlist.html" />
            <div class="span10">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#graduate" data-toggle="tab">Graduate</a></li>
                    <li><a href="#undergraduate" data-toggle="tab">Undergraduate</a></li>
                </ul>
                <div class="tab-content">
                    <%-- -------- SELECT Statement Code Graduate-------- --%>
                    <%
                        Statement statement = conn.createStatement();
                        ResultSet rs = statement.executeQuery
                            ("SELECT * FROM graduate, student WHERE student.student_id = graduate.student_id");
                    %>
                    <div class="tab-pane active" id="graduate">
                        <table class="table table-hover">
                            <tr>
                                <th>Student ID</th>
                                <th>SSN</th>
                                <th>First Name</th>
                                <th>Middle Name</th>
                                <th>Last Name</th>
                                <th>Residency</th>
                                <th>Enrollment</th>
                                <th>Attendances</th>
                                <th>Hold Degrees</th>
                                <th>Department</th>
                                <th>Degree</th>
                                <th>State</th>
                            </tr>
                        <%
                            while ( rs.next() ) {
                                String studentId = rs.getString("student_id");
                                int ssn = rs.getInt("ssn");
                                String firstname = rs.getString("firstname");
                                String middlename = rs.getString("middlename");
                                String lastname = rs.getString("lastname");
                                String residency = rs.getString("residency");
                                String attendances = rs.getString("attendances");
                                String holdDegrees = rs.getString("hold_degrees");
                                String isEnrolled = rs.getBoolean("is_enrolled")? "yes" : "no";
                                String department = rs.getString("department");
                                String degree = rs.getString("degree_type");
                                String state = rs.getString("state");
                                if (state == null)
                                    state = "";
                        %>
                            <tr onclick="document.location = 'student.jsp?identity=graduate&studentId=' + <%= studentId %>;">
                                <td><%= studentId %></td>
                                <td><%= ssn  %></td>
                                <td><%= firstname %></td>
                                <td><%= middlename %></td>
                                <td><%= lastname %></td>
                                <td><%= residency %></td>
                                <td><%= isEnrolled %></td>
                                <td><%= attendances %></td>
                                <td><%= holdDegrees %></td>
                                <td><%= department %></td>
                                <td><%= degree %></td>
                                <td><%= state %></td>
                            </tr>
                        <%
                            }
                        %>
                        </table>
                    </div>

                    <%-- -------- SELECT Statement Code Graduate-------- --%>
                    <%
                        statement = conn.createStatement();
                        rs = statement.executeQuery
                            ("SELECT * FROM undergraduate, student WHERE student.student_id = undergraduate.student_id");
                    %>
                    <div class="tab-pane" id="undergraduate">
                        <table class="table table-hover">
                            <tr>
                                <th>Student ID</th>
                                <th>SSN</th>
                                <th>First Name</th>
                                <th>Middle Name</th>
                                <th>Last Name</th>
                                <th>Residency</th>
                                <th>Enrollment</th>
                                <th>Attendance</th>
                                <th>College</th>
                                <th>Major</th>
                                <th>Minor</th>
                                <th>Type</th>
                            </tr>
                        <%
                            while ( rs.next() ) {
                                String studentId = rs.getString("student_id");
                                int ssn = rs.getInt("ssn");
                                String firstname = rs.getString("firstname");
                                String middlename = rs.getString("middlename");
                                String lastname = rs.getString("lastname");
                                String residency = rs.getString("residency");
                                String attendances = rs.getString("attendances");
                                String isEnrolled = rs.getBoolean("is_enrolled")? "yes" : "no";
                                String college = rs.getString("college");
                                String major = rs.getString("major");
                                String minor = rs.getString("minor");
                                String type = rs.getString("type");
                        %>
                            <tr onclick="document.location = 'student.jsp?identity=undergraduate&studentId=' + <%= studentId %>;">
                                <td><%= rs.getString("student_id") %></td>
                                <td><%= ssn  %></td>
                                <td><%= firstname %></td>
                                <td><%= middlename %></td>
                                <td><%= lastname %></td>
                                <td><%= residency %></td>
                                <td><%= isEnrolled %></td>
                                <td><%= attendances %></td>
                                <td><%= college %></td>
                                <td><%= major %></td>
                                <td><%= minor %></td>
                                <td><%= type %></td>
                            </tr>
                        <%
                            }
                        %>
                        </table>
                    </div>
                </div>
            </div><!--/span-->
        </div><!--/row-->
    </div><!--/.fluid-container-->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
        });
    </script>
</body>
</html>

<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            StringBuilder sb;
            
            String[] holdUniversity = request.getParameterValues("university");
            String[] holdDegreeType = request.getParameterValues("degree_type");
            sb = new StringBuilder();
            for (int i = 0; i < holdUniversity.length -1; i++) {
                sb.append(holdUniversity[i]);
                sb.append(' ');
                sb.append(holdDegreeType[i]);
                sb.append(';');
            }
            String holdDegrees = sb.toString();
            
            String[] beginQuarter = request.getParameterValues("begin_quarter");
            String[] beginYear = request.getParameterValues("begin_year");
            String[] endQuarter = request.getParameterValues("end_quarter");
            String[] endYear = request.getParameterValues("end_year");
            sb = new StringBuilder();
            for (int i = 0; i < beginQuarter.length - 1; i++) {
                sb.append(beginQuarter[i]);
                sb.append(' ');
                sb.append(beginYear[i]);
                sb.append('-');
                sb.append(endQuarter[i]);
                sb.append(' ');
                sb.append(endYear[i]);
                sb.append(';');
            }
            String attendances = sb.toString();
            
            System.out.println(holdDegrees);
            System.out.println(attendances);
            System.out.println(Boolean.parseBoolean(request.getParameter("is_enrolled")));
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Student table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, request.getParameter("student_id"));
            pstmt.setString(2, request.getParameter("firstname"));
            pstmt.setString(3, request.getParameter("middlename"));
            pstmt.setString(4, request.getParameter("lastname"));
            if (!request.getParameter("ssn").equals(""))
                pstmt.setInt(5, Integer.parseInt(request.getParameter("ssn")));
            else
                pstmt.setNull(5, Types.INTEGER);
            pstmt.setString(6, request.getParameter("residency"));
            pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("is_enrolled")));
            pstmt.setString(8, holdDegrees);
            pstmt.setString(9, attendances);

            int rowCount = pstmt.executeUpdate();

            
            String identity = request.getParameter("identity");
            
            
            if (identity != null && identity.equals("undergraduate")) {
                pstmt = conn.prepareStatement(
                        "INSERT INTO undergraduate VALUES (?, ?, ?, ?, ?)");

                    pstmt.setString(1, request.getParameter("student_id"));
                    pstmt.setString(2, request.getParameter("college"));
                    pstmt.setString(3, request.getParameter("major"));
                    pstmt.setString(4, request.getParameter("minor"));
                    pstmt.setString(5, request.getParameter("type"));
                    
                    rowCount = pstmt.executeUpdate();                           
            }

            if (identity != null && identity.equals("graduate")) {
                System.out.println(request.getParameter("department"));
                System.out.println(request.getParameter("degree"));
                System.out.println(request.getParameter("state"));
                pstmt = conn.prepareStatement(
                        "INSERT INTO graduate VALUES (?, ?, ?, ?)");

                    pstmt.setString(1, request.getParameter("student_id"));
                    pstmt.setString(2, request.getParameter("department"));
                    pstmt.setString(3, request.getParameter("degree"));
                    if (request.getParameter("state") == null)
                        pstmt.setNull(4, Types.VARCHAR);
                    else
                        pstmt.setString(4, request.getParameter("state"));
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
