<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/style.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" >
    <title>Conflict class</title>
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
<%@ page language="java" import="db.ClassSection" %>
<%@ page language="java" import="db.Meeting" %>
<%-- -------- Open Connection Code -------- --%>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);

        String studentId = request.getParameter("studentId");
        String identity = request.getParameter("identity");

        Statement statement = conn.createStatement();
        ResultSet rs;
%>
<body>
    <jsp:include page="tpl/header.html" />

    <div class="container-fluid">
        <div class="row-fluid">
            <jsp:include page="tpl/sub_student.html" />

            <div class="span10">
                <table class="table table-hover">
                    <tr>
                        <th></th>
                        <th colspan="2">Enrolled class</th>
                        <th colspan="2">Conflict class</th>
                    </tr>
                    <tr>
                        <th>#</th>
                        <th>Course ID</th>
                        <th>Title</th>
                        <th>Course ID</th>
                        <th>Title</th>
                    </tr>
                <%
                    String sql = "select enrolled.course_id as e_course_id, enrolled.title as e_title, offered.course_id as o_course_id, offered.title as o_title from" +
                    	         " (select c.course_id, c.title from student_section as ss, class_section as cs, class as c" +
                    	    	 "   where cs.section_id=ss.section_id" +
                    	    	 "   and c.course_id=cs.course_id" +
                    	    	 "   and ss.student_id=" + studentId +
                    	    	 "   and c.quarter='" + Config.currentQuarter + "') enrolled," +
                    	    	 " (select c.course_id, c.title from class as c" +
                    	    	 "   where c.quarter='" + Config.currentQuarter + "') offered" +
                    	    	 " where enrolled.course_id<>offered.course_id";
                    	    	 
                    rs = statement.executeQuery(sql);
                    int i = 1;
                    while ( rs.next() ) {
                    	boolean isConflict = true;
                    	
                        // Get section info of class a and b
						sql = "select m.section_id AS section_id, start_time, end_time, days" +
						" FROM class AS c, class_section AS cs, meeting AS m" +
						" WHERE c.course_id=cs.course_id" +
						" AND c.quarter=cs.quarter" +
						" AND cs.section_id=m.section_id" +
						" AND c.course_id='" + rs.getString("e_course_id") + "'" +
						" AND c.quarter='" + Config.currentQuarter + "'" +
                        " AND m.type<>'RW'";

						Statement innerStatement = conn.createStatement();                        
						ResultSet innerRs = innerStatement.executeQuery(sql);
						
                        ArrayList<ClassSection> enrolledSections = new ArrayList<ClassSection> ();
                        ClassSection section = null;
                        while (innerRs.next()) {
                            String sid = innerRs.getString("section_id");
                            if (enrolledSections.isEmpty()) {
                            	section = new ClassSection(sid);
                            }
                            else if (!section.sectionId.equals(sid)) {
                            	enrolledSections.add(section);
                            	section = new ClassSection(sid);
                            }
                            
                            	section.addMeeting(new Meeting(innerRs.getTime("start_time"), innerRs.getTime("end_time"), innerRs.getString("days")));
                         
                            
                        }
                        
                        enrolledSections.add(section);

                        sql = "select m.section_id AS section_id, start_time, end_time, days" +
                        " FROM class AS c, class_section AS cs, meeting AS m" +
                        " WHERE c.course_id=cs.course_id" +
                        " AND c.quarter=cs.quarter" +
                        " AND cs.section_id=m.section_id" +
                        " AND c.course_id='" + rs.getString("o_course_id") + "'" +
						" AND c.quarter='" + Config.currentQuarter + "'" +
                        " AND m.type<>'RW'";
                        
                        innerRs = innerStatement.executeQuery(sql);
                        
                        ArrayList<ClassSection> offeredSections = new ArrayList<ClassSection> ();
                        section = null;
                        while (innerRs.next()) {
                            String sid = innerRs.getString("section_id");
                            if (offeredSections.isEmpty()) {
                                section = new ClassSection(sid);
                            }
                            else if (!section.sectionId.equals(sid)) {
                            	offeredSections.add(section);
                                section = new ClassSection(sid);
                            }
                            
                            section.addMeeting(new Meeting(innerRs.getTime("start_time"), innerRs.getTime("end_time"), innerRs.getString("days")));
          
                            
                        }
                        offeredSections.add(section);
                        
                        for (ClassSection sectionA : enrolledSections) {
                            for (ClassSection sectionB : offeredSections) {
	                        	if (!sectionA.conflictWith(sectionB)) {
	                        		System.out.println("conflict!");
	                        		isConflict = false;
	                        		break;
	                        	}
                            }
                            if(isConflict == false)
                            	break;
                        }
                        
           
                        if (isConflict) {
                        	String oCourseId = rs.getString("o_course_id");
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= rs.getString("e_course_id") %></td> 
                        <td><%= rs.getString("e_title") %></td>
                        <td onclick="document.location = 'class.jsp?&courseId=<%= oCourseId %>&quarter=<%= Config.currentQuarter %>';">
                            <%= rs.getString("o_course_id") %>
                        </td> 
                        <td><%= rs.getString("o_title") %></td> 
                    </tr>
                <%
                        }
                    }
                %>
                </table>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#nav-student').addClass('active');
            $('#sub-conflictclass').addClass('active');

            var args = '?' + 'studentId=<%= studentId %>' + '&' + 'identity=<%= identity %>';
            $('#sub-newprobation > a').attr('href', 'newprobation.jsp' + args);
            $('#sub-newcourseenrollment > a').attr('href', 'newcourseenrollment.jsp' + args);
            $('#sub-newpastclass > a').attr('href', 'newpastclass.jsp' + args);
            $('#sub-newthesiscommittee > a').attr('href', 'newthesiscommittee.jsp' +  args);
            $('#sub-currentclass > a').attr('href', 'currentclass.jsp' + args);
            $('#sub-gradereport > a').attr('href', 'gradereport.jsp' + args);
            <%
                if (identity.equals("undergraduate")) {
            %>
            $('#sub-checkdegree > a').attr('href', 'checkdegree.jsp' + args);
            <%
                }

                if (identity.equals("graduate")) {
            %>
            $('#sub-checkdegree > a').attr('href', 'checkmsdegree.jsp' + args);
            <%
                }
            %>
            $('#sub-conflictclass > a').attr('href', 'conflictclass.jsp' + args);
            $('#sub-decisionsupport > a').attr('href', 'decisionsupport.jsp' + args);
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
