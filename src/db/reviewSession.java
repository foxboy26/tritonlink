package db;

import java.sql.Time;

public class reviewSession extends Meeting{
	public reviewSession(Time startTime, Time endTime, String days) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.days = days;
    }
	
}
