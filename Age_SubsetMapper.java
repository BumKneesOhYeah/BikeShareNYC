import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Age_SubsetMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable outValue = new IntWritable(1);
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		//age, distance, event_count, gender, month, tripduration, usertype
		String age = new String(columns.getValue("cf".getBytes(), "age".getBytes()));
		String event_count = new String(columns.getValue("cf".getBytes(), "event_count".getBytes()));
		String gender = new String(columns.getValue("cf".getBytes(), "gender".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		String usertype = new String(columns.getValue("cf".getBytes(), "usertype".getBytes()));
		outKey.set(age+","+gender+","+month+","+usertype+",");
		outValue.set(Integer.parseInt(event_count));
		context.write(outKey, outValue);
	}

}

