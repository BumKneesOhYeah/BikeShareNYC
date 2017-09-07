import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Missing_ValuesMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable ONE = new IntWritable(1);
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		//String bike_id = new String(columns.getValue("cf".getBytes(), "bike_id".getBytes()));
		String birth_year = new String(columns.getValue("cf".getBytes(), "birth_year".getBytes()));
		//String day = new String(columns.getValue("cf".getBytes(), "day".getBytes()));
		//String distance = new String(columns.getValue("cf".getBytes(), "distance".getBytes()));
		//String gender = new String(columns.getValue("cf".getBytes(), "gender".getBytes()));
		//String hour = new String(columns.getValue("cf".getBytes(), "hour".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));
		//String start_id = new String(columns.getValue("cf".getBytes(), "start_id".getBytes()));
		//String stop_id = new String(columns.getValue("cf".getBytes(), "stop_id".getBytes()));
		//String tripduration = new String(columns.getValue("cf".getBytes(), "tripduration".getBytes()));
		//String usertype = new String(columns.getValue("cf".getBytes(), "usertype".getBytes()));
		//String year = new String(columns.getValue("cf".getBytes(), "year".getBytes()));

		
		if (birth_year.equals("empty"))
		{
			outKey.set("empty_birth_year,"+month+",");
			context.write(outKey, ONE);
		}
		else
		{
			outKey.set("NON-empty_birth_year,"+month+",");
			context.write(outKey, ONE);
		}
		
		
		/*if (bike_id.equals("empty"))
		{
			outKey.set("bike_id,");
			context.write(outKey, ONE);
		}
		if (day.equals("-1"))
		{
			outKey.set("day,");
			context.write(outKey, ONE);
		}
		if (distance.equals("empty"))
		{
			outKey.set("distance,");
			context.write(outKey, ONE);
		}
		if (gender.equals("empty"))
		{
			outKey.set("gender,");
			context.write(outKey, ONE);
		}
		if (hour.equals("-1"))
		{
			outKey.set("hour,");
			context.write(outKey, ONE);
		}
		if (month.equals("-1"))
		{
			outKey.set("month,");
			context.write(outKey, ONE);
		}
		if (start_id.equals("empty"))
		{
			outKey.set("start_id,");
			context.write(outKey, ONE);
		}
		if (stop_id.equals("empty"))
		{
			outKey.set("stop_id,");
			context.write(outKey, ONE);
		}
		if (tripduration.equals("empty"))
		{
			outKey.set("tripduration");
			context.write(outKey, ONE);
		}
		if (usertype.equals("empty"))
		{
			outKey.set("usertype");
			context.write(outKey, ONE);
		}
		if (year.equals("-1"))
		{
			outKey.set("year");
			context.write(outKey, ONE);
		}*/
		
	}

}

