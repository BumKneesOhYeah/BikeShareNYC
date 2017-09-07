package upload_HBASE;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class upload_HBASE_Mapper extends Mapper<LongWritable, Text, Text, IntWritable> {

	private Text outKey = new Text();
	private IntWritable one = new IntWritable(1);
	 int cccount=0;
	
	public void map(LongWritable key, Text value, Mapper.Context context) 
			throws IOException, InterruptedException
	{
		//System.out.println("MApper"+cccount);

		if(cccount!=0){
		// n=-1 so empty strings created for missing values
		String[] token = value.toString().split(",",-1);
		int strlen;
		// This gets rid of quotations at begin/end if not empty string
		for (int i =0; i < 15; i++)
		{
			strlen = token[i].length();
			if(strlen == 0)
			{	
				token[i]="empty";
			}
			if(strlen == 2 && token[i].charAt(0)=='"')
			{	
				token[i]="empty";
			}
				
			if (token[i].charAt(0)=='"')
				token[i] = token[i].substring(1,strlen-1);
			
		}
		
		///////////////////////////////////////////////////////////		
		String distance = "";
		if(token[5].equals("empty") || token[6].equals("empty") ||
				token[9].equals("empty") || token[10].equals("empty"))
			distance = "empty";
		else
		{
			double lat0 = Double.parseDouble(token[5]);
			double long0 = Double.parseDouble(token[6]);
			double lat1 = Double.parseDouble(token[9]);
			double long1 = Double.parseDouble(token[10]);
			double d_ew = (long1 - long0) * Math.cos(lat0*2 * Math.PI / 360);
			double d_ns = (lat1 - lat0);
	        double num_distance = Math.sqrt(d_ew * d_ew + d_ns * d_ns)*69.17181;
	        distance = (Math.round(num_distance *100.0) / 100.0)+"";
		}	

		///////////////////////////////////////////////////////////		
		//to get the month,day,year,hour,minutes
        String starttime = token[1];
        int month=-1;int day=-1;int year=-1; int hour=-1;
        if (!starttime.equals("empty"))
        {
        	int locater = 0;
			if (starttime.charAt(1) == '/'){
				month = Integer.parseInt(starttime.substring(0,1));
				locater++;
			}
			else {month = Integer.parseInt(starttime.substring(0,2));}
	
			if (starttime.charAt(4-locater)  == '/'){
				day = Integer.parseInt(starttime.substring(3-locater,4-locater));
				locater++;
			}
			else {day = Integer.parseInt(starttime.substring(3-locater,5-locater));}
	
			year = Integer.parseInt(starttime.substring(6-locater,10-locater));
	
			if (starttime.charAt(12-locater)  == ':'){
				hour = Integer.parseInt(starttime.substring(11-locater,12-locater));
				locater++;
			}
			else {hour = Integer.parseInt(starttime.substring(11-locater,13-locater));}
        }

        ///////////////////////////////////////////////////////////
		
		
		//0trip_duration  start_time,month,day,year,hour
		//3start_id 7stop_id  11bike_id 12user_type 
		//13birth_year 14gender
		//trip duration empty cells
		String KEY = token[0]+","+month+","+day+","+year+","+hour+","+token[3]+","+token[7]+","+
				token[11]+","+token[12]+","+token[13]+","+token[14]+","+distance;
		//System.out.println(KEY+"--"+VALUE);
		outKey.set(KEY);
		
			context.write(outKey, one);
			}		
		cccount++;

			
	}
	
	
}
