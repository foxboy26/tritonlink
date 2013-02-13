<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Classes</title>
</head>

<body style="text-align:center; margin-left: auto; margin-right: auto;margin-top: 30px;">
    <table border="1" style = "text-align:left; width: 60%; margin:auto">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
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
            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {
                        // Preprocess submitted form data
                        String courseId = request.getParameter("course_id");
                        String quarter = request.getParameter("quarter");
                        quarter += " ";
                        quarter += request.getParameter("year");
                        String title = request.getParameter("title");

                        // section info
                        int sectionNum = Integer.parseInt(request.getParameter("section_num"));
                        System.out.println(sectionNum);
                        String[] sectionIdList = request.getParameterValues("section_id");
                        String[] facultyIdList = request.getParameterValues("faculty_id");
                        String[] limitList = request.getParameterValues("limit");
                        // meeting info
                        String[] meetingNumList = request.getParameterValues("meeting_num");
                        String[] typeList = request.getParameterValues("type");
                        String[] locationList = request.getParameterValues("location");
                        String[] startTimeList = request.getParameterValues("start_time");
                        String[] endTimeList = request.getParameterValues("end_time");
                        String[] daysList = request.getParameterValues("days");
                        String[] mandatoryList = request.getParameterValues("mandatory");

                        ClassSection[] sectionList = new ClassSection[sectionNum];
                        int offset = 0;
                        for (int i = 0; i < sectionNum; i++) {
                        	sectionList[i] = new ClassSection();
                            sectionList[i].sectionId = sectionIdList[i];
                            sectionList[i].facultyId = facultyIdList[i];
                            sectionList[i].limit = Integer.parseInt(limitList[i]);
                            sectionList[i].meetingList = new Meeting[Integer.parseInt(meetingNumList[i])];
                            for (int j = 0; j < sectionList[i].meetingList.length; j++) {
                            	sectionList[i].meetingList[j] = new Meeting();
                                sectionList[i].meetingList[j].type = typeList[offset+j];
                                sectionList[i].meetingList[j].location =locationList[offset+j];
                                sectionList[i].meetingList[j].startTime = startTimeList[offset+j];
                                sectionList[i].meetingList[j].endTime = endTimeList[offset+j];
                                sectionList[i].meetingList[j].days = daysList[offset+j];
                                sectionList[i].meetingList[j].mandatory = Boolean.parseBoolean(mandatoryList[offset+j]);
                            }
                            offset += sectionList[i].meetingList.length;
                        }

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // INSERT the class attributes INTO the Class table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Class VALUES (?, ?, ?)");
                        pstmt.setString(1, courseId);
                        pstmt.setString(2, quarter);
                        pstmt.setString(3, title);
                        int rowCount = pstmt.executeUpdate();

                        for (ClassSection section : sectionList) {
                            // INSERT INTO the Section table.
                            pstmt = conn.prepareStatement(
                                "INSERT INTO Section VALUES (?, 0, 0, ?)");
                            pstmt.setString(1, section.sectionId);
                            pstmt.setInt(2, section.limit);
                            rowCount = pstmt.executeUpdate();

                            // INSERT INTO the Class_Section table.
                            pstmt = conn.prepareStatement(
                                "INSERT INTO class_section VALUES (?, ?)");
                            pstmt.setString(1, courseId);
                            pstmt.setString(2, section.sectionId);
                            rowCount = pstmt.executeUpdate();

                            for (Meeting meeting : section.meetingList) {
                                // INSERT INTO the Meeting table.
                                pstmt = conn.prepareStatement(
                                    "INSERT INTO Meeting VALUES (?, ?, ?, ?, ?, ?, ?)");
                                pstmt.setString(1, section.sectionId);
                                pstmt.setString(2, meeting.type);
                                pstmt.setString(3, meeting.location);
                                pstmt.setString(4, meeting.startTime);
                                pstmt.setString(5, meeting.endTime);
                                pstmt.setString(6, meeting.days);
                                pstmt.setBoolean(7, meeting.mandatory);
                                rowCount = pstmt.executeUpdate();

                                // INSERT INTO the Teach table.
                                pstmt = conn.prepareStatement(
                                    "INSERT INTO Teach VALUES (?, ?)");
                                pstmt.setString(1, section.facultyId);
                                pstmt.setString(2, section.sectionId);
                                rowCount = pstmt.executeUpdate();
                            }
                        }

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %> <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Class");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" style = "text-align:center; width: 80%; margin:auto">
                    <tr>
                        <th>course_id</th>
                        <th>quarter</th>
                        <th>title</th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>
                    <tr>
                            <td><%= rs.getInt("course_id") %></td>
                            <td><%= rs.getString("quarter") %></td>    
                            <td><%= rs.getString("title") %></td>                          
                    </tr>
            <%
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
                </table>
            </td>
        </tr>
     </table>
     <div style="text-align:center;">
        <form action="newclass.jsp" method="POST" >
            <input type="submit" value="Insert" style = "margin-top: 20px">
        </form>
    </div>
</body>
</html>
