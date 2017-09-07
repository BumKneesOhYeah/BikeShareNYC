import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;


public class Total_Month_DayWeek_HourDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		/*if (otherArgs.length != 1) {
		    System.err.println("Usage: HBaseSummarisationDriver <out>");
		    System.exit(2);
		}*/
		Scan scan = new Scan();
		//scan.setStartRow(Bytes.toBytes("1"));
		//scan.setStopRow(Bytes.toBytes("2"));
		Job job = Job.getInstance(conf, "get a really good subset with categorcials");
		job.setJarByClass(Total_Month_DayWeek_HourDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeMaster", scan, 
				Total_Month_DayWeek_HourMapper.class, 
				                              Text.class, IntWritable.class, 
				                              job);
		job.setReducerClass(Total_Month_DayWeek_HourReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/Total_Month_DayWeek_Hour/output"));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

