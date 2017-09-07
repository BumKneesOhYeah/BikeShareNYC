import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.util.GenericOptionsParser;


public class BikeAgeTempDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		
		Scan scan = new Scan();
		//scan.setStartRow(Bytes.toBytes("1"));
		//scan.setStopRow(Bytes.toBytes("1"));
		
		Job job = Job.getInstance(conf, "Get subset getting daily info and distance transform.");
		job.setJarByClass(BikeAgeTempDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeMaster", scan, 
											  BikeAgeTempMapper.class, 
				                              Text.class, NullWritable.class, 
				                              job);
		
		TableMapReduceUtil.initTableReducerJob("BikeAgeTemp", BikeAgeTempReducer.class, job);
		job.setNumReduceTasks(1);

		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

