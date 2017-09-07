import java.io.IOException;

import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableReducer;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.*;


public class BikeAgeTempReducer extends
       TableReducer<Text, NullWritable, ImmutableBytesWritable>{
	
	int rowKey = 0;

	public void reduce(Text key, Iterable<NullWritable> values, Context context)
	       throws IOException, InterruptedException {
		System.out.println("Reducer Check");
		//outKey.set(i+","+age+","+distance+","+ event_count+","+gender+","+month+","+tripduration+","+usertype);
		String[] token = key.toString().split(",",-1);
		//System.out.println(token[1]+","+token[2]);

		double thresholdRand = Math.random();
		int month = Integer.parseInt(token[5]);
		double[] threshold_array = {0.15000, 0.15933, 0.13234, 0.07567, 
		                            0.00923, 0.04325, 0.01805, 0.00000, 0.02419,
		                            0.06402, 0.08019, 0.09367};
		if (month==1 && thresholdRand > threshold_array[0])
		{
			System.out.println(token[1]+","+token[2]);

			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==2 && thresholdRand > threshold_array[1])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==3 && thresholdRand > threshold_array[2])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==4 && thresholdRand > threshold_array[3])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==5 && thresholdRand > threshold_array[4])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==6 && thresholdRand > threshold_array[5])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==7 && thresholdRand > threshold_array[6])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==8 && thresholdRand > threshold_array[7])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==9 && thresholdRand > threshold_array[8])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==10 && thresholdRand > threshold_array[9])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==11 && thresholdRand > threshold_array[10])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
		else if (month==12 && thresholdRand > threshold_array[11])
		{
			Put put = new Put(Bytes.toBytes(rowKey+""));
			put.addColumn("cf".getBytes(), "age".getBytes(), Bytes.toBytes(token[1]));
			put.addColumn("cf".getBytes(), "distance".getBytes(), Bytes.toBytes(token[2]));
			put.addColumn("cf".getBytes(), "event_count".getBytes(), Bytes.toBytes(token[3]));
			put.addColumn("cf".getBytes(), "gender".getBytes(), Bytes.toBytes(token[4]));
			put.addColumn("cf".getBytes(), "month".getBytes(), Bytes.toBytes(token[5]));
			put.addColumn("cf".getBytes(), "tripduration".getBytes(), Bytes.toBytes(token[6]));
			put.addColumn("cf".getBytes(), "usertype".getBytes(), Bytes.toBytes(token[7]));

			rowKey++;
			context.write(null, put);
		}
	}

}

