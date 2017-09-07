import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.*;

public class Age_CountMapper extends 
       TableMapper<Text, IntWritable> {
	
	private Text outKey= new Text();
	private IntWritable ONE = new IntWritable(1);
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		
		String birth_year = new String(columns.getValue("cf".getBytes(), "birth_year".getBytes()));
		String month = new String(columns.getValue("cf".getBytes(), "month".getBytes()));

		if (birth_year.equals("empty"))
		{
			outKey.set(month+","+birth_year+",");

		}
		//Calcualte age
		else
		{
			birth_year = (2015 - Integer.parseInt(birth_year)) +"";
			outKey.set(month+","+birth_year+",");
		}
		context.write(outKey, ONE);
	}

}

