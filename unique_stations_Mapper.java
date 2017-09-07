package unique_stations_to_txt_file;

import java.io.IOException;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Mapper.Context;

public class unique_stations_Mapper extends
TableMapper<Text, NullWritable> {
	
private Text outChar= new Text();

public void map(ImmutableBytesWritable row, Result columns, Context context)
     throws IOException, InterruptedException {
	
	String the_row   = new String(columns.getValue("cf".getBytes(), "stations_cat".getBytes()));
	
	outChar.set(the_row);
	context.write(outChar, NullWritable.get());
}

}