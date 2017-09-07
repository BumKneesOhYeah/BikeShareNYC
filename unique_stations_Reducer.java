package unique_stations_to_txt_file;

import java.io.IOException;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class unique_stations_Reducer extends Reducer<Text, NullWritable, Text, NullWritable> {

	public void reduce(Text _key, Iterable<NullWritable> values, Context context)
			throws IOException, InterruptedException {
		// process values

		context.write(_key, NullWritable.get());
	}

}
