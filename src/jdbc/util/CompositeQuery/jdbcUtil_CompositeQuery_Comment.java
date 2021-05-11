/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *     所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package jdbc.util.CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_Comment {

	public static String get_aCondition_For_myDB(String columnName, String value) {

		String aCondition = null;

		if ("COMMENT_NO".equals(columnName) || "MEMBER_NO".equals(columnName) || "MOVIE_NO".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if ("CONTENT".equals(columnName) || "STATUS".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if ("CRT_DT".equals(columnName) || "MODIFY_DT".equals(columnName))         // 用於date
			aCondition = columnName + "=" + "'"+ value +"'";                          //for 其它DB  的 date
//		    aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";  //for Oracle 的 date
		
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

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("COMMENT_NO", new String[] { "1" });
		map.put("MEMBER_NO", new String[] { "1" });
		map.put("MOVIE_NO", new String[] { "1" });
		map.put("CONTENT", new String[] { "cool" });
		map.put("CRT_DT", new String[] { "1981-11-17" });
		map.put("MODIFY_DT", new String[] { "1981-11-17" });
		map.put("STATUS", new String[] { "1" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from COMMENT "
				          + jdbcUtil_CompositeQuery_Comment.get_WhereCondition(map)
				          + "order by COMMENT_NO";
		System.out.println("●●finalSQL = " + finalSQL);

	}
}
