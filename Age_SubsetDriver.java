import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;


public class Age_SubsetDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		
		Scan scan = new Scan();
		Job job = Job.getInstance(conf, "age by other attributes reduce subset");
		job.setJarByClass(Age_SubsetDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeAgeTemp", scan, 
				Age_SubsetMapper.class, 
				                              Text.class, IntWritable.class, 
				                              job);
		job.setReducerClass(Age_SubsetReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/Age_Subset/output"));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

