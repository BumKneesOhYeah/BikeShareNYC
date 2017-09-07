import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class DurationTimesMapper extends 
       TableMapper<Text, Text> {
	
	private Text outKey= new Text();
	private Text outValue = new Text();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		System.out.println("Mapper");

		String day = new String(columns.getValue("cf".getBytes(), "day".getBytes()));
		String hour = new String(columns.getValue("cf".getBytes(), "hour".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		String tripduration = new String(columns.getValue("cf".getBytes(), "tripduration".getBytes()));
		String year = new String(columns.getValue("cf".getBytes(), "year".getBytes()));

		outKey.set(month+","+day+","+year+","+hour+",");
		outValue.set(tripduration+","+"1");
		
		context.write(outKey, outValue);
	}

}

