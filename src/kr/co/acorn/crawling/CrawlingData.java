package kr.co.acorn.crawling;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kr.co.acorn.dao.CrawlingDao;
import kr.co.acorn.dto.CrawlingDto;

public class CrawlingData {
	
	public static void dataUpdate() {
		String url = "https://coinmarketcap.com/currencies/bitcoin/historical-data/?start=20171101&end=20191203";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
			
			CrawlingDao dao = CrawlingDao.getInstance();
			
			Elements elements = doc.select(".cmc-table__table-wrapper-outer table tbody tr");
			
			for (int i = 0; i < elements.size(); i++) {
				Element trElement = elements.get(i);
				String date = KoreanDate.changeDate(trElement.child(0).text());
				double open = Double.parseDouble(trElement.child(2).text().replace(",",""));
				double high = Double.parseDouble(trElement.child(2).text().replace(",",""));
				double low = Double.parseDouble(trElement.child(3).text().replace(",",""));
				double close = Double.parseDouble(trElement.child(4).text().replace(",",""));
				long volume = Long.parseLong(trElement.child(5).text().replace(",",""));
				long cap = Long.parseLong(trElement.child(6).text().replace(",",""));
				CrawlingDto dto = new CrawlingDto(date, open, high, low, close, volume, cap);
				dao.insert(dto);
			}
			
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void newDataUpdate() {
		
	}
}
