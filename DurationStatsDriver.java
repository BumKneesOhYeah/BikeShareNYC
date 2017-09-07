import java.io.IOException;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class DurationStatsDriver {


	public static void main(String[] args) throws Exception {
		
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		
		conf.set("fs.defaultFS", "hdfs://localhost:54310");
		conf.set("fs.hdfs.impl", org.apache.hadoop.hdfs.DistributedFileSystem.class.getName() );

		Job job = new Job(conf, "StackOverflow Distinct Users");
		
		job.setJarByClass(DurationStatsDriver.class);
		job.setMapperClass(DurationStatsMapper.class);
		job.setReducerClass(DurationStatsReducer.class);
		
		//&&&&&&&&&&&&&&&&&&&&&&
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(Text.class);
		
		//^^^^^^^^^^^^^^^^^^^^^^^^^^
		
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		
		FileInputFormat.addInputPath(job, new Path("hdfs://localhost:54310/user/hduser/DurationCounts_Minute"));
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/DurationCounts_Minute/output"));

		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
