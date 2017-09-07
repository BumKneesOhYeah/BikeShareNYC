package date_time_user_gender;

import java.io.IOException;

import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableReducer;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Reducer;

public class date_time_user_gender_Reducer extends
TableReducer<Text, IntWritable, ImmutableBytesWritable>{
	
	int the_row_key = 0;	
public void reduce(Text key, Iterable<IntWritable> values, Context context)
    throws IOException, InterruptedException {
	
int sum = 0;
	
for (IntWritable val : values) {
	sum = sum + val.get();
}

String line = key.toString();
String[] fields = line.split(",");

//Put put = new Put(Bytes.toBytes(key.toString()));
Put put = new Put(Bytes.toBytes(the_row_key+""));
put.addColumn("cfall".getBytes(), "month".getBytes(), Bytes.toBytes(fields[0]));
put.addColumn("cfall".getBytes(), "day".getBytes(), Bytes.toBytes(fields[1]));
put.addColumn("cfall".getBytes(), "year".getBytes(), Bytes.toBytes(fields[2]));
put.addColumn("cfall".getBytes(), "hour".getBytes(), Bytes.toBytes(fields[3]));
put.addColumn("cfall".getBytes(), "user_type".getBytes(), Bytes.toBytes(fields[4]));
put.addColumn("cfall".getBytes(), "gender".getBytes(), Bytes.toBytes(fields[5]));

put.addColumn("cfall".getBytes(), "count".getBytes(), Bytes.toBytes(Integer.toString(sum)));
the_row_key++;

context.write(null, put);
}
}