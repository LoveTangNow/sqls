package com.jano;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Mycalendar {

	//requires API 24
	//Android 7.0

	public void gettime() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 可以方便地修改日期格式
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMMdd");// 可以方便地修改日期格式

		Calendar calendar = Calendar.getInstance();
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), 1, 0, 0, 0);

		System.out.println(dateFormat.format(calendar.getTime()));
		System.out.println(dateFormat2.format(calendar.getTime()));

		System.out.println(calendar.get(Calendar.ALL_STYLES));
		System.out.println(calendar.get(Calendar.MONTH));
		System.out.println(calendar.get(Calendar.DATE));
		System.out.println(calendar.get(Calendar.DAY_OF_MONTH));
	}
    	
}
