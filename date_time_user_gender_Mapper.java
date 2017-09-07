package date_time_user_gender;

import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class date_time_user_gender_Mapper extends
TableMapper<Text, IntWritable> {
	
	private Text outChar= new Text();
	private final static IntWritable ONE = new IntWritable(1);
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
	String time_date = new String(columns.getValue("cfall".getBytes(), "date_time".getBytes()));
	String user_type = new String(columns.getValue("cfall".getBytes(), "user_type".getBytes()));
	String gender = new String(columns.getValue("cfall".getBytes(), "gender".getBytes()));
	
	//to get the month,day,year,hour,minutes
	int locater = 0;
	int month;
	if (time_date.charAt(2) == '/'){
		month = Integer.parseInt(time_date.substring(1,2));
		locater++;
	}
	else {month = Integer.parseInt(time_date.substring(1,3));}

	int day;
	if (time_date.charAt(5-locater)  == '/'){
		day = Integer.parseInt(time_date.substring(4-locater,5-locater));
		locater++;
	}
	else {day = Integer.parseInt(time_date.substring(4-locater,6-locater));}

	int year = Integer.parseInt(time_date.substring(7-locater,11-locater));

	int hour;
	if (time_date.charAt(13-locater)  == ':'){
		hour = Integer.parseInt(time_date.substring(12-locater,13-locater));
		locater++;
	}
	else {hour = Integer.parseInt(time_date.substring(12-locater,14-locater));}
	

	
	String outputString = month+","+day+","+year+","+hour+","+user_type+","+gender;
	System.out.println(outputString);
	outChar.set(outputString);
	context.write(outChar, ONE);
	}
}