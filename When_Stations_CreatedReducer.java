import java.io.IOException;

import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Reducer;;

public class When_Stations_CreatedReducer extends
       Reducer<Text, Text, Text, Text>{
	
	private Text result = new Text();
	
	public void reduce(Text key, Iterable<Text> values, Context context)
	       throws IOException, InterruptedException {
		
		int min_month = 100;
		int max_month = -1;
		int min_month_day = 100;
		int max_month_day = -1;
		
		for (Text val : values) {
			String[] token =  val.toString().split(",");
			int month = Integer.parseInt(token[0]);
			int day = Integer.parseInt(token[1]);
			
			if (month <= min_month)
			{
				min_month = month;
				if (day < min_month_day)
				{
					min_month_day = day;
				}
			}
			if (month >= max_month)
			{
				max_month = month;
				if (day > max_month_day)
				{
					max_month_day = day;
				}
			}
		}
		
		result.set(min_month+"/"+min_month_day+"/2015,begin");
		context.write(key, result);
		result.set(max_month+"/"+max_month_day+"/2015,end");
		context.write(key, result);


	}
	

}

