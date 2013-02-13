package db;

public class Meeting
{
    public String type;
    public String location;
    public String startTime;
    public String endTime;
    public String days;
    public Boolean mandatory;

    public Meeting() {
    }

    public Meeting(String type, String location, String startTime, String endTime, String days, Boolean mandatory) {
        this.type = type;
        this.location = location;
        this.startTime = startTime;
        this.endTime = endTime;
        this.days = days;
        this.mandatory = mandatory;
    }

}
