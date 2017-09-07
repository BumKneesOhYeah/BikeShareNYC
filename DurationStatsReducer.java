import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;



public class DurationStatsReducer extends Reducer<Text, Text, Text, Text> {
	private ArrayList<Double> minuteCounts = new ArrayList<Double>();
	private Text outKey = new Text();
	private Text outVal = new Text();
	
	@Override
    public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
		double totalcount=0;
		double totalsum = 0;
	    double mode = -1;
	    double most_minute_count=0;
	    double stddev =0;
	    double mean = 0;
	    double min = Double.POSITIVE_INFINITY;
	    double max = Double.NEGATIVE_INFINITY;
	    double median = -1;
	    minuteCounts.clear();
		
	    
      for (Text value : values) {
    	  String line = value.toString();
          String[] token = line.split(",");
          double minute = Double.parseDouble(token[0]);
          double minute_count = Double.parseDouble(token[1]);

          //sets mode
          if (minute_count>most_minute_count)
          {
        	  mode = minute;
        	  most_minute_count = minute_count;
          }

          //sets max
          if (minute > max)
          {
        	  max = minute;
          }
          //sets min
          if (minute < min)
          {
        	  min = minute;
          }
          
          //get the total addition/sum of each minute and also compile the count
          totalsum = totalsum + (minute * minute_count);
          totalcount = totalcount + minute_count;

          for (int i = 0; i < minute_count; i++)
          {
        	  minuteCounts.add(minute);
          }
          
      }
	  
      Collections.sort(minuteCounts);
	 


      int tc = (int) totalcount;
      if (tc % 2 == 0)
      {

    	  median = (minuteCounts.get(((tc / 2) - 1)) + minuteCounts.get((tc /2))) / 2.0;
      }
      else
      {

    	  median = minuteCounts.get((tc / 2));

      }
      
      mean = totalsum / totalcount;

      double sumOfSquares=0;
      for (double f: minuteCounts)
      {
    	  sumOfSquares += (f-mean)*(f - mean);
      }
      stddev = Math.sqrt(sumOfSquares/totalcount);


      outKey.set("min, max, median, mode, mean, stddev, total minutes, total rentals");
      outVal.set(min+","+max+","+median+","+mode+","+mean+","+stddev+","+totalsum+","+totalcount);
      
      context.write(outKey, outVal);
    }

  }
