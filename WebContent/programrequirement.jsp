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
            int totalUnits = Integer.parseInt(request.getParameter("total_units"));
            String[] categoryList = request.getParameterValues("category");
            String[] unitsList = request.getParameterValues("units");
            String[] minGPAList = request.getParameterValues("min_gpa");
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement(
                "INSERT INTO program_requirement VALUES (?, ?, ?, ?)");

            pstmt.setString(1, programName);
            pstmt.setString(2, "all");
            pstmt.setInt(3, totalUnits);
            pstmt.setFloat(4, 0);

            int rowCount = pstmt.executeUpdate();

            for (int i = 0; i < categoryList.length; i++) {
                pstmt.setString(1, programName);
                pstmt.setString(2, categoryList[i]);
                pstmt.setString(3, unitsList[i]);
                pstmt.setFloat(4, Float.parseFloat(minGPAList[i]));

                rowCount = pstmt.executeUpdate();
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
