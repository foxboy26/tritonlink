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
        
        String sectionId = request.getParameter("sectionId");
        
        // insert code
        String action = request.getParameter("action");
        if (action != null) {
            // Preprocess submitted form data
            String type = action.equals("insert-review")? "RW" : request.getParameter("type"); 
            String location = request.getParameter("location");
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            String mandatory = request.getParameter("mandatory");                                            
            // Begin transaction
            conn.setAutoCommit(false);

            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Meeting VALUES (?, ?, ?, ?, ?, ?, ?)");
            
            if (type.equals("RW")) {
                String date = request.getParameter("days");                                            

                pstmt.setString(1, sectionId);
                pstmt.setString(2, type);
                pstmt.setString(3, location);
                pstmt.setString(4, startTime);
                pstmt.setString(5, endTime);
                pstmt.setString(6, date);
                pstmt.setString(7, mandatory);

                int rowCount = pstmt.executeUpdate();
            }
            else {
                String days = request.getParameter("days");                                            

                for (int i = 0; i < days.length(); i+=2) {
                    String weekday = days.substring(i, i+2);
                    pstmt.setString(1, sectionId);
                    pstmt.setString(2, type);
                    pstmt.setString(3, location);
                    pstmt.setString(4, startTime);
                    pstmt.setString(5, endTime);
                    pstmt.setString(6, weekday);
                    pstmt.setString(7, mandatory);

                    int rowCount = pstmt.executeUpdate();
                }
            }

            pstmt.close();
            
            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
        }

        // Close the Connection
        conn.close();
        response.setContentType("text/html");
        out.println("success");
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>