<%-- Set the scripting language to Java and --%>
<%-- Import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="db.Config" %>
<%@ page language="java" import="db.ClassSection" %>
<%@ page language="java" import="db.Meeting" %>
<%
    try {
        // Load JDBC Driver class file
        DriverManager.registerDriver
            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

        // Make a connection to the MS SQL Server datasource "tritonlink"
        Connection conn = DriverManager.getConnection(Config.connectionURL);
        
        String courseId = request.getParameter("courseId");
        
        String quarter = request.getParameter("quarter");

        String action = request.getParameter("action");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Preprocess submitted form data
            String sectionId = request.getParameter("section_id");
            String facultyId = request.getParameter("faculty_id");
            String limit = request.getParameter("limit");

            // Begin transaction
            conn.setAutoCommit(false);
            
            // INSERT INTO the Section table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO section VALUES (?, 0, 0, ?)");
            pstmt.setString(1, sectionId);
            pstmt.setInt(2, Integer.parseInt(limit));
            int rowCount = pstmt.executeUpdate();
            
            // INSERT INTO the Class_Section table.
            pstmt = conn.prepareStatement(
                "INSERT INTO class_section VALUES (?, ?, ?)");
            pstmt.setString(1, courseId);
            pstmt.setString(2, sectionId);
            pstmt.setString(3, quarter);
            rowCount = pstmt.executeUpdate();

            pstmt = conn.prepareStatement(
                "INSERT INTO teach VALUES (?, ?)");
            pstmt.setString(1, facultyId);
            pstmt.setString(2, sectionId);
            rowCount = pstmt.executeUpdate();
            
            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
        }
        
        conn.close();
        
        response.setContentType("text/html");
        out.println("success");
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>