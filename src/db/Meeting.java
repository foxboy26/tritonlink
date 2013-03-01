package db;

import java.sql.Time;

public class Meeting
{
    public String type;
    public String location;
    public Time startTime;
    public Time endTime;
    public String days;
    public Boolean mandatory;

    public Meeting() {
    }

    public Meeting(String type, String location, Time startTime, Time endTime, String days, Boolean mandatory) {
        this.type = type;
        this.location = location;
        this.startTime = startTime;
        this.endTime = endTime;
        this.days = days;
        this.mandatory = mandatory;
    }
    
    public Meeting(Time startTime, Time endTime, String days) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.days = days;;
    }
    
    public boolean conflictWith(Meeting b) {
    	boolean[] weekA = this.splitDays(this.days);
    	boolean[] weekB = this.splitDays(b.days);

    	for (int i = 0; i < weekA.length; i++) {
    		if (weekA[i] && weekB[i] && this.timeConflictWith(b)) {
    			return true;
    		}
    	}
    	
    	return false;
    }

    private boolean[] splitDays(String days) {
        boolean[] week = new boolean[5];
        for (int i = 0; i < 5; i++) week[i] = false;
        for (int i = 0; i < days.length(); i+=2) {
            if (days.substring(i, i+2).equals("Mo"))
            	week[0] = true;
            if (days.substring(i, i+2).equals("Tu"))
            	week[1] = true;
            if (days.substring(i, i+2).equals("We"))
            	week[2] = true;
            if (days.substring(i, i+2).equals("Th"))
            	week[3] = true;
            if (days.substring(i, i+2).equals("Fr"))
            	week[4] = true;
        }
        
        return week;
    }
    
    private boolean timeConflictWith(Meeting b) {
    	return (this.startTime.compareTo(b.startTime) >= 0 && this.startTime.compareTo(b.endTime) < 0) ||
    		   (b.startTime.compareTo(this.startTime) >= 0 && b.startTime.compareTo(this.endTime) < 0);
    }
}
