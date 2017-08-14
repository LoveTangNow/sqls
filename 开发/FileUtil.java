import java.io.FileOutputStream;
import java.io.OutputStreamWriter;

/**
 * @Copyright: Copyright (c) 2014
 * @Company:sj
 * @author: wangkb,Thomas Liu
 * @version: 1.0
 * @time: 2014-10-5
 */

public class FileUtil {

	/**
	 * @param path
	 * @param filname
	 * @param buf
	 * @return
	 */

	public static int saveFile(String path, String filname, StringBuffer buf) {
		int r = -1;
		FileOutputStream fout = null;
		OutputStreamWriter writer = null;
		try {
			fout = new FileOutputStream(path + "/" + filname);
			writer = new OutputStreamWriter(fout, "gb2312");
			writer.write(buf.toString());
			writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				writer.flush();
				writer.close();
			} catch (Exception e) {
			}
			try {
				writer.flush();
				writer.close();
				if (fout != null)
					fout.close();
			} catch (Exception e) {
			}
		}
		return r;
	}
}