package stations;
import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.*;

public class stations_Mapper extends 
       TableMapper<Text, Text> {
	
	private Text outChar= new Text();
	private Text value = new Text();
	
	public void map(ImmutableBytesWritable row, Result columns, Context context)
	       throws IOException, InterruptedException {
		
		String row_key = Bytes.toString(row.get());
		value.set(row_key);
		String id   = new String(columns.getValue("cf".getBytes(), "id".getBytes()));
		String name = new String(columns.getValue("cf".getBytes(), "name".getBytes()));
		String lat  = new String(columns.getValue("cf".getBytes(), "lat".getBytes()));
		String longi = new String(columns.getValue("cf".getBytes(), "longi".getBytes()));
		
		
		outChar.set(id + "," + name + "," + lat + "," + longi);
		context.write(outChar, value);
	}

}

