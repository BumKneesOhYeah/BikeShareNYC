import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;


public class Age_CountDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		
		Scan scan = new Scan();
		Job job = Job.getInstance(conf, "Get Age_birthdate distribution");
		job.setJarByClass(Age_CountDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeMaster", scan, 
				Age_CountMapper.class, 
				                              Text.class, IntWritable.class, 
				                              job);
		job.setReducerClass(Age_CountReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/Age_Count/output"));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

