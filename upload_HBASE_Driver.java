package upload_HBASE;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class upload_HBASE_Driver {

	public static void main(String[] args) throws Exception {
		
		Path inputpath = new Path("hdfs://localhost:54310/user/hduser/testUploadHBASE/BikeData");
		Path outputpath = new Path("/output2");
		String tableName = "BikeMaster";
		
		Configuration conf = HBaseConfiguration.create();
		conf.set("hbase.table.name", tableName);
		
		//String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		//conf.set("fs.defaultFS", "hdfs://localhost:54310");
		//conf.set("fs.hdfs.imp", "org.apache.hadoop.hdfs.DistributedFileSystem.class.getName()");
		
		//Scan scan = new Scan();
		Job job = Job.getInstance(conf, "dfs to HBase");
		job.setJarByClass(upload_HBASE_Driver.class);
		job.setMapperClass(upload_HBASE_Mapper.class);
		
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		
			TableMapReduceUtil.initTableReducerJob("BikeMaster",
					upload_HBASE_Reducer.class, 
				job);
				
			job.setNumReduceTasks(1);
			
		
		
		//job.setInputFormatClass(TextInputFormat.class);
		
		
		FileInputFormat.addInputPath(job, inputpath);
		FileOutputFormat.setOutputPath(job, outputpath);

		System.out.println("driver");
		System.exit(job.waitForCompletion(true) ? 0 : 1);
		}
	}

