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


public class ML_ReductionDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		
		Scan scan = new Scan();
		Job job = Job.getInstance(conf, "Used to get subset for R to do ML on for fun!");
		job.setJarByClass(ML_ReductionDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeAgeTemp", scan, 
				ML_ReductionMapper.class, 
				                              Text.class, NullWritable.class, 
				                              job);
		job.setReducerClass(ML_ReductionReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(NullWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(NullWritable.class);
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/ML_Reduction/output"));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

