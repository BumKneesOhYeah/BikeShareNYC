import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Station_RepeatMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable outValue = new IntWritable();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		String start_id = new String(columns.getValue("cf".getBytes(), "start_id".getBytes()));
		String stop_id = new String(columns.getValue("cf".getBytes(), "stop_id".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
    	if (start_id.equals(stop_id))
    	{
    		outKey.set(start_id+",");
    		outValue.set(Integer.parseInt(event_count));
    		context.write(outKey, outValue);
    	}
		
	}

}

