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

        PreparedStatement pstmt = null;
%>
<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        String studentId = request.getParameter("rStudentId");
        String identity = request.getParameter("identity");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            String courseId = request.getParameter("rCourseID");
            String sectionId = request.getParameter("rSectionID");
            String quarter = request.getParameter("rQuarter"); 
            String grade = request.getParameter("rGrade"); 
            String units = request.getParameter("rUnits"); 
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Student table.
            pstmt = conn.prepareStatement(
                "INSERT INTO student_section VALUES (?, ?, 'enrolled', ?, ?, ?)");

            pstmt.setInt(1, Integer.parseInt(studentId));
            pstmt.setString(2, sectionId);
            pstmt.setString(3, units);
            pstmt.setString(4, grade);
            if(grade.equals("S") || grade.equals("U"))
                pstmt.setString(5, "S/U");
            else
                pstmt.setString(5, "Letter");
            int rowCount = pstmt.executeUpdate();
            
            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
        }
%>
<%-- -------- Close Connection Code -------- --%>
<%
        // Close the Statement
        pstmt.close();

        // Close the Connection
        conn.close();

        response.sendRedirect("gradereport.jsp?studentId=" + studentId + "&identity=" + identity);
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
