import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class When_Stations_CreatedMapper extends 
       TableMapper<Text, Text> {
	
	private Text outKey= new Text();
	private Text outValue = new Text();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		String day = new String(columns.getValue("cf".getBytes(), "day".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		String start_id = new String(columns.getValue("cf".getBytes(), "start_id".getBytes()));
		String stop_id = new String(columns.getValue("cf".getBytes(), "stop_id".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		//String year = new String(columns.getValue("cf".getBytes(), "year".getBytes()));
		
		//String bike_id = new String(columns.getValue("cf".getBytes(), "bike_id".getBytes()));
		//outKey.set(bike_id+",");
		//outValue.set(month+","+day);
		//context.write(outKey, outValue);
		
    	
		outKey.set(start_id+",");
		outValue.set(month+","+day);
		context.write(outKey, outValue);

		outKey.set(stop_id+",");
		outValue.set(month+","+day);
		context.write(outKey, outValue);
	
		
	}

}

