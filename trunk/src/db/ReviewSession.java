package db;

import java.sql.Time;
import java.util.Date;

public class ReviewSession extends Meeting{
	Date days;
	public ReviewSession(Time startTime, Time endTime, Date days) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.days = days;
    }
	
	public boolean conflictWith(ReviewSession b) {
    	if(!this.days.equals(b.days))
    		return false;
    	return (this.startTime.compareTo(b.startTime) >= 0 && this.startTime.compareTo(b.endTime) < 0) ||
     		   (b.startTime.compareTo(this.startTime) >= 0 && b.startTime.compareTo(this.endTime) < 0);
    }
}
