import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class DurationCounts_MinuteMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable outValue = new IntWritable();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		
		//String tripduration = new String(columns.getValue("cf".getBytes(), "tripduration".getBytes()));
		//double duration = Math.round(Double.parseDouble(tripduration)/60.0);
		String distance = new String(columns.getValue("cf".getBytes(), "distance".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		
		outValue.set(Integer.parseInt(event_count));
		//outKey.set(duration+",");
		outKey.set(distance+",");
		context.write(outKey, outValue);
	}

}

