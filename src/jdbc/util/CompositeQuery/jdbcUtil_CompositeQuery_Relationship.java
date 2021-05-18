/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *     所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package jdbc.util.CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_Relationship {

	public static String get_aCondition_For_myDB(String columnName, String value) {

		String aCondition = null;
		if ("member_no".equals(columnName) || "friend_no".equals(columnName)) // 用於其他
			aCondition = "S0." + columnName + "=" + value;
		else if ("status".equals(columnName) || "isblock".equals(columnName)) // 用於varchar
			aCondition = "S0." + columnName + " = " + value;
//		else if ("status".equals(columnName) || "isblock".equals(columnName)) // 用於varchar
//			aCondition = "S0." + columnName + " like '%" + value + "%'";
		else if ("mb_name".equals(columnName) ) // 用於varchar
			aCondition = getDisassembledCondition("S2", columnName, value);
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
		tableAlias += ".";
		for (int i = 0 ; i < str.length(); i++) {
			tmpStr += tableAlias + columnName + " like '%" + str.charAt(i) + "%'";
			tmpStr = ( i == (str.length()-1) )? tmpStr : tmpStr+" or ";
			System.out.println("tmpStr = " + tmpStr);
		}
		tmpStr += ")";
		return tmpStr;
	}

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("member_no", new String[] { "6" });
//		map.put("friend_no", new String[] { "2" });
		map.put("status", new String[] { "0" });
		map.put("isblock", new String[] { "0" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key
		map.put("mb_name", new String[] { "白精之星" }); // 注意Map裡面會含有action的key

		String finalSQL = "select S0.MEMBER_NO, S1.MB_NAME, S0.FRIEND_NO,"
				+ "S2.MB_NAME, S0.STATUS, S0.ISBLOCK from relationship S0 "
				+ "LEFT JOIN `MEMBER` S1 ON S0.MEMBER_NO = S1.MEMBER_NO "
				+ "LEFT JOIN `MEMBER` S2 ON S0.FRIEND_NO = S2.MEMBER_NO "
				+ jdbcUtil_CompositeQuery_Relationship.get_WhereCondition(map)
				+ "order by S0.member_no, S0.friend_no";
		System.out.println("●●finalSQL = " + finalSQL);

	}
}
