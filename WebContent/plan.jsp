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
        String programName = request.getParameter("program_name");
%>

<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            String[] courseList = request.getParameterValues("course_id");
            String[] categoryList = request.getParameterValues("category");
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement("INSERT INTO plans VALUES (?, ?, ?)");

            for (int i = 0; i < categoryList.length; i++) {
                pstmt.setString(1, programName);
                pstmt.setString(2, courseList[i]);
                pstmt.setString(3, categoryList[i]);

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

        response.sendRedirect("program.jsp?name=" + programName);
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
