package db;

import java.sql.Time;

public class ReviewSession extends Meeting{
	public ReviewSession(Time startTime, Time endTime, String days) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.days = days;
    }
	
}
