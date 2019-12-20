package kr.co.acorn.crawling;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class KoreanDate {
	
	public static String changeDate(String us){
		String changeDate = null;
		
		SimpleDateFormat in = new SimpleDateFormat("MMM dd, yyyy", Locale.US);
		SimpleDateFormat out = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date usDate = in.parse(us);
			System.out.println(usDate);
			changeDate = out.format(usDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return changeDate;
	}
	public static void main(String[] args) {
		String date = changeDate("Jul 28, 2018");
		System.out.println(date);
	}
}