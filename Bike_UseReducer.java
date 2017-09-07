import java.io.IOException;

import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Reducer;;

public class Bike_UseReducer extends
       Reducer<Text, Text, Text, Text>{
	
	private Text result = new Text();
	
	public void reduce(Text key, Iterable<Text> values, Context context)
	       throws IOException, InterruptedException {
		//outValue.set(distance+event_count+tripduration);
		
		double distancesum = 0;
		int eventsum = 0;
		double durationsum= 0;
		for (Text val : values) {
			String[] token = val.toString().split(",");
			distancesum = distancesum + Double.parseDouble(token[0]);
			eventsum = eventsum + Integer.parseInt(token[1]);
			durationsum = durationsum + Double.parseDouble(token[2]);
		}
		
		result.set(distancesum+","+eventsum+","+durationsum);
		
		context.write(key, result);
	}
	

}

