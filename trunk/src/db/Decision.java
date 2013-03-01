package db;

public class Decision {
    public static String makeSQL(String gradeAll) {
        String gradeA = "SELECT 'A' as grade, SUM(grade_all.grade_count) AS grade_count FROM" +
                        " (" + gradeAll + ") grade_all" + 
                        " WHERE grade_all.grade LIKE 'A%'";

        String gradeB = "SELECT 'B' as grade, SUM(grade_all.grade_count) AS grade_count FROM" +
                        " (" + gradeAll + ") grade_all" + 
                        " WHERE grade_all.grade LIKE 'B%'";

        String gradeC = "SELECT 'C' as grade, SUM(grade_all.grade_count) AS grade_count FROM" +
                        " (" + gradeAll + ") grade_all" + 
                        " WHERE grade_all.grade LIKE 'C%'";

        String gradeD = "SELECT 'D' as grade, SUM(grade_all.grade_count) AS grade_count FROM" +
                        " (" + gradeAll + ") grade_all" + 
                        " WHERE grade_all.grade LIKE 'D%'";

        String gradeOther = "SELECT 'Other' as grade, SUM(grade_all.grade_count) AS grade_count FROM" +
                        " (" + gradeAll + ") grade_all" + 
                        " WHERE grade_all.grade LIKE 'F%'";

        return gradeA + " union " + gradeB + " union " + gradeC + " union " + gradeD + " union " + gradeOther;
    }
}
