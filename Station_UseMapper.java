import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Station_UseMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable outValue = new IntWritable();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		//String bike_id = new String(columns.getValue("cf".getBytes(), "bike_id".getBytes()));
		//String birth_year = new String(columns.getValue("cf".getBytes(), "birth_year".getBytes()));
		String day = new String(columns.getValue("cf".getBytes(), "day".getBytes()));
		//String distance = new String(columns.getValue("cf".getBytes(), "distance".getBytes()));
		//String gender = new String(columns.getValue("cf".getBytes(), "gender".getBytes()));
		String hour = new String(columns.getValue("cf".getBytes(), "hour".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		String start_id = new String(columns.getValue("cf".getBytes(), "start_id".getBytes()));
		String stop_id = new String(columns.getValue("cf".getBytes(), "stop_id".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		//String usertype = new String(columns.getValue("cf".getBytes(), "usertype".getBytes()));
		//String year = new String(columns.getValue("cf".getBytes(), "year".getBytes()));
    	
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
		outKey.set("start,"+simpleDateformat.format(date)+","+hour+","+start_id+",");
		outValue.set(Integer.parseInt(event_count));
		context.write(outKey, outValue);
		outKey.set("stop,"+simpleDateformat.format(date)+","+hour+","+stop_id+",");
		outValue.set(Integer.parseInt(event_count));
		context.write(outKey, outValue);
	
		
	}

}

