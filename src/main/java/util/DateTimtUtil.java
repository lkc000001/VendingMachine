package util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimtUtil {
	public String getNowDateStr(int index) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		switch (index) {
		case 1:
			dateFormat = new SimpleDateFormat("yyyyMMdd");
			break;
		}
		return dateFormat.format(new Date());
	}
}
