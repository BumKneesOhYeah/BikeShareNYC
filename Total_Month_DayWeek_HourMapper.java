import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Total_Month_DayWeek_HourMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable outValue = new IntWritable();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		String birth_year = new String(columns.getValue("cf".getBytes(), "birth_year".getBytes()));
		String day = new String(columns.getValue("cf".getBytes(), "day".getBytes()));
		String distance = (new String(columns.getValue("cf".getBytes(), "distance".getBytes())));
		String gender = new String(columns.getValue("cf".getBytes(), "gender".getBytes()));
		String hour = new String(columns.getValue("cf".getBytes(), "hour".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		String tripduration = (new String(columns.getValue("cf".getBytes(), "tripduration".getBytes())));
		String usertype = new String(columns.getValue("cf".getBytes(), "usertype".getBytes()));
    	
		if (!birth_year.equals("empty"))
		{
			int age = 2015 - Integer.parseInt(birth_year);
			if (age > 70)
				birth_year = "Bad Data";
			else if (age > 55 && age <= 70)
				birth_year = "Old";
			else if (age > 30 && age <= 55)
				birth_year = "Middle-Aged";
			else /*(age > 15 && age <= 30)*/
				birth_year = "Young";
		}
		
		double d = Double.parseDouble(distance);
		if (d >-1 && d <= 0.2)
			distance = "(0.0->0.2]";
		else if (d >.2 && d <= 0.4)
			distance = "(0.2->0.4]";
		else if (d >.4 && d <= 0.6)
			distance = "(0.4->0.6]";
		else if (d >.6 && d <= 0.8)
			distance = "(0.6->0.8]";
		else if (d >.8 && d <= 1)
			distance = "(0.8->1.0]";
		else if (d >1 && d <= 1.2)
			distance = "(1.0->1.2]";
		else if (d >1.2 && d <= 1.4)
			distance = "(1.2->1.4]";
		else if (d >1.4 && d <= 1.6)
			distance = "(1.4->1.6]";
		else if (d >1.6 && d <= 1.8)
			distance = "(1.6->1.8]";
		else if (d >1.8 && d <= 2)
			distance = "(1.8->2.0]";
		else //(d >2)
			distance = "(2.0,  ]";
		
		// d is now for duration in time in minutes
		d = Double.parseDouble(tripduration)/60.0;
		if (d >-1 && d <= 15)
			tripduration = "(0->15]";
		else if (d >15 && d <= 30)
			tripduration = "(15->30]";
		else if (d >30 && d <= 45)
			tripduration = "(30->45]";
		else if (d >45 && d <= 60)
			tripduration = "(45->60]";
		else if (d >60 && d <= 90)
			tripduration = "(60->90]";
		else if (d >90 && d <= 120)
			tripduration = "(90->120]";
		else if (d >120 && d <= 240)
			tripduration = "(120->240]";
		else //(d >240)
			tripduration = "(240->   ]";
			
		SimpleDateFormat sdf = new SimpleDateFormat("M/dd/yyyy");
    	String dateInString = month + "/" + day +"/2015";
    	Date date = null;
		try {
			date = sdf.parse(dateInString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	SimpleDateFormat simpleDateformat = new SimpleDateFormat("EEEE"); // the day of the week spelled out completely
		String weekday = simpleDateformat.format(date)+"";
		
		
		outKey.set(tripduration+","+month+","+hour+","+weekday+","+usertype+","+birth_year+","+gender+","+distance+",");
		outValue.set(Integer.parseInt(event_count));
		context.write(outKey, outValue);
		
	
		
	}

}

