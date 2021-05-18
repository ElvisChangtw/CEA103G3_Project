/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *     所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package jdbc.util.CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_Member {

	public static String get_aCondition_For_myDB(String columnName, String value) {

		String aCondition = null;
		if ("member_no".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
//		else if ("mb_name".equals(columnName) ) // 用於varchar
//			aCondition = columnName + " like '%" + value + "%'";
		else if ("mb_name".equals(columnName) ) // 用於varchar
			aCondition = getDisassembledCondition(columnName, value);
		
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

	public static String getDisassembledCondition(String columnName, String str) {
		String tmpStr = "(";
		
		for (int i = 0 ; i < str.length(); i++) {
			tmpStr +=  columnName + " like '%" + str.charAt(i) + "%'";
			tmpStr = ( i == (str.length()-1) )? tmpStr : tmpStr+" or ";
			System.out.println("tmpStr = " + tmpStr);
		}
		tmpStr += ")";
		return tmpStr;
	}
	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("member_no", new String[] { "3" });
		map.put("mb_name", new String[] { "Tony" });		
//		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from `member` "
				          + jdbcUtil_CompositeQuery_Member.get_WhereCondition(map)
				          + "order by member_no";
		System.out.println("●●finalSQL = " + finalSQL);

	}
}
