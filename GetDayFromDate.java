import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class GetDayFromDate {
 
    public static void main(String[] args) throws ParseException {
 
    	SimpleDateFormat sdf = new SimpleDateFormat("M-dd-yyyy");
    	String dateInString = "04-5-2017";
    	Date date = sdf.parse(dateInString);
 
    	
    	SimpleDateFormat simpleDateformat = new SimpleDateFormat("EEEE"); // the day of the week spelled out completely
        System.out.println(simpleDateformat.format(date));
    }
}