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


public class Station_UseDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		/*if (otherArgs.length != 1) {
		    System.err.println("Usage: HBaseSummarisationDriver <out>");
		    System.exit(2);
		}*/
		Scan scan = new Scan();
		Job job = Job.getInstance(conf, "how often a station is used");
		job.setJarByClass(Station_UseDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeMaster", scan, 
				Station_UseMapper.class, 
				                              Text.class, IntWritable.class, 
				                              job);
		job.setReducerClass(Station_UseReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/Station_Use/output"));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

