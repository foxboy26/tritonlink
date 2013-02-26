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
        String studentId = request.getParameter("rStudentID");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            String courseId = request.getParameter("rCourseID");
            String sectionId = request.getParameter("rSectionID");
            String units = request.getParameter("rUnits");                       
            String type = request.getParameter("rType");    

            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Student table.
            pstmt = conn.prepareStatement(
                "INSERT INTO student_section VALUES (?, ?, 'enrolled', ?, null, ?)");

            pstmt.setInt(1, Integer.parseInt(studentId));
            pstmt.setString(2, sectionId);
            pstmt.setInt(3, Integer.parseInt(units));
            pstmt.setString(4, type);
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

        response.sendRedirect("currentclass.jsp?studentId=" + studentId);
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
