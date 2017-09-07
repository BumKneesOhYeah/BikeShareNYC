import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Bike_UseMapper extends 
       TableMapper<Text, Text> {
	
	private Text outKey= new Text();
	private Text outValue = new Text();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		String bike_id = new String(columns.getValue("cf".getBytes(), "bike_id".getBytes()));
		String distance = new String(columns.getValue("cf".getBytes(), "distance".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		String tripduration = new String(columns.getValue("cf".getBytes(), "tripduration".getBytes()));

		outKey.set(bike_id+",");
		outValue.set(distance+","+event_count+","+tripduration);
		context.write(outKey, outValue);
		
	
		
	}

}

