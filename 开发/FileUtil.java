package com.jano;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;

enum codetype {
	GB2312, UTF8, GBK
}

public class FileUtil {

	/**
	 * @param path   	路径
	 * @param filname	文件名
	 * @param buf		数据
	 * @return  1、成功	0失败
	 */
	public int saveFile(String path, String filname, StringBuffer buf) {
		return saveFile(path, filname, buf, codetype.UTF8, true);
	}

	/**
	 * 
	 * @param path   	路径
	 * @param filname	文件名
	 * @param buf		数据
	 * @param codetype	编码格式
	 * @return  1、成功	0失败
	 */
	public int saveFile(String path, String filname, StringBuffer buf, codetype codetype) {
		return saveFile(path, filname, buf, codetype, true);
	}

	/**
	 * 
	  * @param path   	路径
	 * @param filname	文件名
	 * @param buf		数据
	 * @param codetype	编码格式
	 * @param append	是否追加
	 * @return  1、成功	0失败
	 */
	public int saveFile(String path, String filname, StringBuffer buf, codetype codetype, boolean append) {
		int waka = 0;
		FileOutputStream fout = null;
		OutputStreamWriter writer = null;
		try {
			fout = new FileOutputStream(path + "/" + filname, append);

			switch (codetype) {
			case GB2312:
				writer = new OutputStreamWriter(fout, "gb2312");
				break;
			case UTF8:
				writer = new OutputStreamWriter(fout, "UTF-8");
				break;
			case GBK:
			default:
				writer = new OutputStreamWriter(fout, "GBK");
				break;
			}
			writer.write(buf.toString());
			writer.flush();
			waka = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				writer.flush();
				writer.close();

				fout.flush();
				fout.close();
			} catch (Exception e) {
			}
		}

		return waka;
	}

}
