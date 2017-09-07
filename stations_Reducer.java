package stations;
import java.io.IOException;

import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableReducer;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.*;

public class stations_Reducer extends
       TableReducer<Text, Text, ImmutableBytesWritable>{

	public void reduce(Text key, Iterable<Text> values, Context context)
	       throws IOException, InterruptedException {

		String output_key = "";
		
		for(Text value : values)
		{
			output_key = value.toString();
		}
		
		Put put = new Put(Bytes.toBytes(output_key));
		put.addColumn("cf".getBytes(), "stations_cat".getBytes(), Bytes.toBytes(key.toString()));
		context.write(null, put);
	}
	

}

