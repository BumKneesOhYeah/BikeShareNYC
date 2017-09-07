import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;



public class ML_ReductionReducer extends Reducer<Text, NullWritable, Text, NullWritable> {
private Text outKey = new Text(); 
    @Override
    public void reduce(Text key, Iterable<NullWritable> values, Context context) throws IOException, InterruptedException {
    	//outKey.set(i+","+age+","+distance+","+event_count+","+gender+","+month+","+tripduration+","+usertype);
    	//take 25% of the data
    	String[] token = key.toString().split(",");
    	int count_of_events = Integer.parseInt(token[3]);
    	for (int i = 0; i < count_of_events;i++)
    	{
    		double threshold_25 = Math.random();
    		if (threshold_25 <= 0.25)
    		{
    			outKey.set(token[1]+","+token[2]+","+token[4]+","+token[5]+","+token[6]+","+token[7]);
    			context.write(outKey, NullWritable.get());
    		}
    	}
    	
    }
  }
