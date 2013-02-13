package db;

public class ClassSection
{
    public String sectionId;
    public String facultyId;
    public int limit;
    public Meeting[] meetingList; 

    public ClassSection(String sectionId, String facultyId, int limit) {
        this.sectionId = sectionId;
        this.facultyId = facultyId;
        this.limit = limit;
    }

    public ClassSection(){
    }
}
