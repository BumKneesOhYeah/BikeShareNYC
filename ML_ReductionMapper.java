import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class ML_ReductionMapper extends 
       TableMapper<Text, NullWritable> {
	
	private Text outKey= new Text();
	int i = 0;
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		//age, distance, event_count, gender, month, tripduration, usertype
		String age = new String(columns.getValue("cf".getBytes(), "age".getBytes()));
		String distance = new String(columns.getValue("cf".getBytes(), "distance".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		String gender = new String(columns.getValue("cf".getBytes(), "gender".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		String tripduration = new String(columns.getValue("cf".getBytes(), "tripduration".getBytes()));
		String usertype = new String(columns.getValue("cf".getBytes(), "usertype".getBytes()));
		outKey.set(i+","+age+","+distance+","+event_count+","+gender+","+month+","+tripduration+","+usertype);
		
		context.write(outKey, NullWritable.get());
	}

}

