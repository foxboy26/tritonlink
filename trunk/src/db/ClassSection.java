package db;

import java.util.ArrayList;

public class ClassSection
{
    public String sectionId;
    public String facultyId;
    public int limit;
    public ArrayList<Meeting> meetingList; 

    public ClassSection(String sectionId, String facultyId, int limit) {
        this.sectionId = sectionId;
        this.facultyId = facultyId;
        this.limit = limit;
    }

    public ClassSection(String sectionId) {
    	this.sectionId = sectionId;
    	this.meetingList = new ArrayList<Meeting>();
    }
    
    public ClassSection(){
    }
    
    public void addMeeting(Meeting m) {
    	this.meetingList.add(m);
    }
    
    public boolean conflictWith(ClassSection b) {
    	for (Meeting m : this.meetingList) {
    		for (Meeting n : b.meetingList) {
    			if (m.conflictWith(n))
    				return true;
    		}
    	}
    	return false;
    }
}
