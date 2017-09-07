import java.io.IOException;

import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Reducer;;

public class DurationTimesReducer extends
       Reducer<Text, Text, Text, Text>{
	
	private Text result = new Text();
	
	public void reduce(Text key, Iterable<Text> values, Context context)
	       throws IOException, InterruptedException {
		
		int sum_duration=0;
		int event_count = 0;
		for (Text val : values) {
			String[] token = val.toString().split(",");
			sum_duration += Integer.parseInt(token[0].toString());
			event_count += Integer.parseInt(token[1].toString());

		}
		System.out.println("REducer");
		result.set(sum_duration+","+event_count);
		
		context.write(key, result);
	}
	

}

