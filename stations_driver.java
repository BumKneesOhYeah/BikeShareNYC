package stations;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.util.GenericOptionsParser;


public class stations_driver {
	public static void main(String[] args) throws Exception {
		Configuration conf = HBaseConfiguration.create();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		/*if (otherArgs.length != 0) {
		    System.err.println("Usage: HBaseSummarisationDriver2");
		    System.exit(2);
		}*/
		Scan scan = new Scan();
		Job job = Job.getInstance(conf, "getting unique stations");
		job.setJarByClass(stations_driver.class);
		TableMapReduceUtil.initTableMapperJob("stations_source", scan, 
				stations_Mapper.class, 
				                              Text.class, Text.class, 
				                              job);
		TableMapReduceUtil.initTableReducerJob("stations_destiny", stations_Reducer.class, job);
		job.setNumReduceTasks(1);

		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
}

