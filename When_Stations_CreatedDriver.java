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


public class When_Stations_CreatedDriver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		/*if (otherArgs.length != 1) {
		    System.err.println("Usage: HBaseSummarisationDriver <out>");
		    System.exit(2);
		}*/
		Scan scan = new Scan();
		//scan.setStartRow(Bytes.toBytes("1"));
		//scan.setStopRow(Bytes.toBytes("3"));
		Job job = Job.getInstance(conf, "how often a station is used");
		job.setJarByClass(When_Stations_CreatedDriver.class);
		TableMapReduceUtil.initTableMapperJob("BikeMaster", scan, 
				When_Stations_CreatedMapper.class, 
				                              Text.class, Text.class, 
				                              job);
		job.setReducerClass(When_Stations_CreatedReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(Text.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:54310/user/hduser/When_Stations_Created/output"));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

