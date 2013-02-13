<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Thesis committee</title>
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
                        String studentId = request.getParameter("student_id");
                        String[] facultyIdList = request.getParameterValues("faculty_id");
                        
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        PreparedStatement pstmt = conn.prepareStatement(
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
            
            <%-- -------- SELECT Statement Code -------- --%>
            
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    ResultSet rs = statement.executeQuery("SELECT * FROM committee");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" style = "text-align:center; width: 80%; margin:auto">
                    <tr>
                        <th>Student ID</th>
                        <th> Professor </th>
                    </tr>
                    
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    while ( rs.next() ) {
        
            %>
                    <tr>
                            <td><%= rs.getInt("student_id") %></td>
                            <td><%= rs.getInt("faculty_id") %></td>
                            <td><input type = "submit" value="Update"></td>
                            <td><input type = "submit" value="Delete"></td>
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
        <form action="newthesiscommittee.jsp" method="POST" >
            <input type="submit" value="Insert" style = "margin-top: 20px">
        </form>
    </div>
</body>
</html>
