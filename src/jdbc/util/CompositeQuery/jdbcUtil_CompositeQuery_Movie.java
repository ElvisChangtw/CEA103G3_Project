/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *     所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */
package jdbc.util.CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_Movie {

	public static String get_aCondition_For_myDB(String columnName, String value) {

		String aCondition = null;
		
		if ("MOVIE_NO".equals(columnName) || "LENGTH".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if (  //"MOVIE_NAME".equals(columnName) || 
				"DIRECTOR".equals(columnName) || "ACTOR".equals(columnName) 
				|| "CATEGORY".equals(columnName) || "STATUS".equals(columnName) || "TRAILOR".equals(columnName) 
				|| "EMBED".equals(columnName) || "GRADE".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if ("MOVIE_NAME".equals(columnName)){
			aCondition = getDisassembledCondition("S0", columnName, value);
		}
		else if ("MOVIE_NAME_INDEX".equals(columnName)){
			aCondition =getDisassembledCondition("S1", "IDX", value);
		}
		else if("RATING".equals(columnName))
			aCondition = columnName + " >= " +value;
		else if("EXPECTATION".equals(columnName))
			aCondition = columnName + " >= " +value;
		else if("PREMIERE_DT".equals(columnName))
			aCondition = columnName + " <= " + "'" + value + "' and OFF_DT >= '" + value + "'"; 
		else if("OFF_DT".equals(columnName))
			aCondition = "PREMIERE_DT <= '" + value + "' and " + columnName + " >= '" + value + "'"; 
//			aCondition = "'" +value + "'" +" between Premiere_dt and off_dt";        //for 其它DB  的 date
		  //aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";  //for Oracle 的 date
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_myDB(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		return whereCondition.toString();
	}
	
	public static String getDisassembledCondition(String tableAlias, String columnName, String str) {
		String tmpStr = "(";
		
		for (int i = 0 ; i < str.length(); i++) {
			tmpStr += tableAlias+ "." + columnName + " like '%" + str.charAt(i) + "%'";
			tmpStr = ( i == (str.length()-1) )? tmpStr : tmpStr+" or ";
			
		}
		tmpStr += ")";
		return tmpStr;
	}
	
	public static String get_OnCondition(Map<String, String[]> map) {

		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {

			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& "MOVIE_NAME".equals(key)) {
				
				count++;
				String aCondition = get_aCondition_For_myDB("MOVIE_NAME_INDEX", value.trim());
				whereCondition.append(" and " + aCondition);
			}
		}
		return whereCondition.toString();
	}
	
	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("MOVIE_NO", new String[] { "999" });
//		map.put("MOVIE_NAME", new String[] { "星際大戰" });
//		map.put("DIRECTOR", new String[] { "吳永志" });
//		map.put("ACTOR", new String[] { "吳冠宏" });
//		map.put("CATEGORY", new String[] { "CRIME" });
//		map.put("LENGTH", new String[] { "90" });
//		map.put("STATUS", new String[] { "1" });
//		map.put("PREMIERE_DT", new String[] { "1981-11-17" });
//		map.put("OFF_DT", new String[] { "1991-11-17" });
//		map.put("TRAILOR", new String[] { "https://www.youtube.com/watch?v=vM-Bja2Gy04&t=1s" });
//		map.put("EMBED", new String[] { "https://www.youtube.com/watch?v=vM-Bja2Gy04&t=1s" });
//		map.put("GRADE", new String[] { "1" });
//		map.put("RATING", new String[] { "9.6" });
//		map.put("EXPECTATION", new String[] { "10" });
//		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

//				String finalSQL = "select * from MOVIE "
//				          + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
//				          + "order by MOVIE_NO";

		
		String finalSQL =
				"WITH B AS( "
			   +" select S0.MOVIE_NO,  COUNT(*) CNT from "
			   +" `movie` S0 LEFT JOIN MOVIE_NAME_INDEX S1 "
			   + " ON S0.MOVIE_NO = S1.MOVIE_NO "
			   + jdbcUtil_CompositeQuery_Movie.get_OnCondition(map)
			   + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
			   +" GROUP BY S0.MOVIE_NO "
			   + ") "			
			   + "select S0.* from movie S0 LEFT JOIN "
			   +" B ON S0.MOVIE_NO = B.MOVIE_NO "
			   + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
			   +" ORDER BY (CASE WHEN B.CNT IS NULL THEN 0 ELSE B.CNT END) DESC, S0.MOVIE_NO"
			   ;

		System.out.println("●●finalSQL = " + finalSQL);
	
	}
}
