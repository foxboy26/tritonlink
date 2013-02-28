package db;

public class Quarter {
	public static boolean greater(String a, String b){
		String[] quarter1 = a.split(" ");
		String[] quarter2 = b.split(" ");
		if(Integer.parseInt(quarter1[1]) > Integer.parseInt(quarter2[1])) 
			return true;
		if(Integer.parseInt(quarter1[1]) < Integer.parseInt(quarter2[1])) 
			return false;
		if(getValue(quarter1[0]) > getValue(quarter2[0]))
			return true;
		else
			return false;
	}
	
	public static int getValue(String q){
		if(q.equals("Fall"))
			return 1;
		if(q.equals("Winter"))
			return 2;
		if(q.equals("Spring"))
			return 3;
		return 0;
	}
}