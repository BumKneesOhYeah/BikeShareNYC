//http://askubuntu.com/questions/376404/how-to-make-text-file-created-in-ubuntu-compatible-with-windows-notepad
package convert_date;
import java.text.SimpleDateFormat;
import java.util.*;
public class conv_date {
	public static void main(String[] args){
String time_date = "33/92/2004 01:7:00 PM";
System.out.println(time_date);

//to get the month,day,year,hour,minutes
int locater = 0;

int month;
int day;
int year;
int hour;
int minute;

if (time_date.charAt(1) == '/'){
	month = Integer.parseInt(time_date.substring(0,1));
	locater++;
}
else
{
	month = Integer.parseInt(time_date.substring(0,2));
}



if (time_date.charAt(4-locater)  == '/'){
	day = Integer.parseInt(time_date.substring(3-locater,4-locater));
	locater++;
}
else
{
	day = Integer.parseInt(time_date.substring(3-locater,5-locater));
}


	year = Integer.parseInt(time_date.substring(6-locater,10-locater));


	
	if (time_date.charAt(12-locater)  == ':'){
	hour = Integer.parseInt(time_date.substring(11-locater,12-locater));
	locater++;
}
else
{
	hour = Integer.parseInt(time_date.substring(11-locater,13-locater));
}

	
	
if (time_date.charAt(15-locater)  == ':'){
	minute = Integer.parseInt(time_date.substring(14-locater,15-locater));
}
else
{
	minute = Integer.parseInt(time_date.substring(14-locater,16-locater));
}



String thing ="date" + month + "-" +day+"-"+year+"   time = "+hour+":"+minute;
System.out.println(thing);




Calendar cal1 = new GregorianCalendar();
Calendar cal2 = new GregorianCalendar();

SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss a");
//String y = x.substring(0,10);
System.out.println(time_date);
try{
Date date = sdf.parse(time_date);
cal1.setTime(date);
System.out.println(cal1);
date = sdf.parse("05/09/2004 10:37:00 PM");
cal2.setTime(date);
} catch(Exception e) {}
//cal1.set(2008, 8, 1); 
//cal2.set(2008, 9, 31);
System.out.println("Days= "+daysBetween(cal1.getTime(),cal2.getTime()));

	double ccc = Double.parseDouble("4.56");
	System.out.println(ccc);
	
	String bike_id = "\"45\"";
	System.out.println(bike_id);
    if (bike_id.charAt(0) == '"')
    {
    	int strlength = bike_id.length();
    	bike_id = bike_id.substring(1,strlength-1);
    }
    System.out.println(bike_id);
    System.out.println(Integer.parseInt("33"));
    String cat = ",,,,,";
    String[] catoken = cat.split(",",-1);
    System.out.print(catoken.length);
    if (catoken[0].length() == 0)
    	{System.out.println(" ");}
    if (catoken[1].length() == 0)
    System.out.println(catoken[1].length());
    if (catoken[2].length() != 0)
    System.out.println(catoken[2]);
    if (catoken[3].length() != 0)
    System.out.println(catoken[3]);
    if (catoken[4].length() != 0)
    System.out.println(catoken[4]);
    if (catoken[5].length() != 0)
    System.out.println(catoken[5]);


    
    
    int strlen;
    String[] token ="72,\"54\",,\"\"".split(",",-1);
    for (int i =0; i < 4; i++)
	{
		System.out.println(token[i]);

		strlen = token[i].length();
		if(strlen == 0)
		{	
			token[i]="empty";
		}
		System.out.println(token[i]);

		if(strlen == 2 && token[i].charAt(0)=='"')
		{	
			token[i]="empty";
		}
		System.out.println(token[i]);
	
		if (token[i].charAt(0)=='"')
			token[i] = token[i].substring(1,strlen-1);
		System.out.println(token[i]);
	}
    
    
    
    
    

    Random rand = new Random();
    int  n;
    for (int i=0;i<10;i++){
    	n = rand.nextInt(1) + 1;
    	System.out.println(Math.random());
    }
    
	}
public static double daysBetween(Date d1, Date d2){
    return (double)( (d2.getTime() - d1.getTime()) / (1000.0 * 60 * 60 * 24));


	}
}
