package upload_HBASE;

import java.io.IOException;

import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableReducer;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;

public class upload_HBASE_Reducer extends
TableReducer<Text, IntWritable, ImmutableBytesWritable>{

	int count = 0;

public void reduce(Text key, Iterable<IntWritable> values, Context context)
    throws IOException, InterruptedException {

	String[] tokenKEY = key.toString().split(",");
	
	int event_count = 0;
	for (IntWritable value : values) {
		event_count += value.get();
	      }


	Put put = new Put(Bytes.toBytes(count+""));
	count++;
	put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(tokenKEY[0]));
	put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(tokenKEY[1]));
	put.addColumn("cf".getBytes(), "day".getBytes(), Bytes.toBytes(tokenKEY[2]));
	put.addColumn("cf".getBytes(), "year".getBytes(), Bytes.toBytes(tokenKEY[3]));
	put.addColumn("cf".getBytes(), "hour".getBytes(), Bytes.toBytes(tokenKEY[4]));
	put.addColumn("cf".getBytes(), "start_id".getBytes(), Bytes.toBytes(tokenKEY[5]));
	put.addColumn("cf".getBytes(), "stop_id".getBytes(), Bytes.toBytes(tokenKEY[6]));
	put.addColumn("cf".getBytes(), "bike_id".getBytes(), Bytes.toBytes(tokenKEY[7]));
	put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(tokenKEY[8]));
	put.addColumn("cf".getBytes(), "birth_year".getBytes(), Bytes.toBytes(tokenKEY[9]));
	put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(tokenKEY[10]));
	put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(tokenKEY[11]));
	put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(event_count+""));
	context.write(null, put);
}


}