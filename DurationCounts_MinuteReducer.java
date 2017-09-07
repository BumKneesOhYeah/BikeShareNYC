import java.io.IOException;

import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableReducer;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.Reducer.Context;


public class DurationCounts_MinuteReducer extends
	Reducer<Text, IntWritable, Text, IntWritable>{
	
	private IntWritable outValue = new IntWritable();

	public void reduce(Text key, Iterable<IntWritable> values, Context context)
		       throws IOException, InterruptedException {
		
		
		int count = 0;
		
		for (IntWritable val : values) {
			count += val.get();
			
		}
		outValue.set(count);
		
		context.write(key, outValue);
	}
	

}

