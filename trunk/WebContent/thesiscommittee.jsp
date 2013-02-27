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
        String studentId = request.getParameter("student_id");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            String[] facultyIdList = request.getParameterValues("faculty_id");
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement(
                "INSERT INTO committee VALUES (?, ?)");

            for (String facultyId : facultyIdList) {
                pstmt.setInt(1, Integer.parseInt(studentId));
                pstmt.setInt(2, Integer.parseInt(facultyId));

                int rowCount = pstmt.executeUpdate();
            }

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

        response.sendRedirect("student.jsp?studentId=" + studentId);
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
