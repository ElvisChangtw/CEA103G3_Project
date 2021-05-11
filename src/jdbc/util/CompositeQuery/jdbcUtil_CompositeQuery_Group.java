/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *     所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package jdbc.util.CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_Group {

	public static String get_aCondition_For_myDB(String columnName, String value) {
		String aCondition = null;
		// 用於其他
		if ("group_no".equals(columnName) || "showtime_no".equals(columnName) || 
				"member_no".equals(columnName) || "required_cnt".equals(columnName) ||
				 "member_cnt".equals(columnName)) 
			aCondition = "S0." + columnName + "=" + value;
		// 用於varchar
		else if ("group_title".equals(columnName) ) 
			aCondition = getDisassembledCondition("S0", columnName, value);
		//for 其它DB  的 date
		else if ("crt_dt".equals(columnName) || "modify_dt".equals(columnName)|| "deadline_dt".equals(columnName))                          // 用於date
			aCondition = "S0." + columnName + "=" + "'"+ value +"'";   
		else if ("mb_name".equals(columnName))                         
//			aCondition = "S3." + columnName + "=" + "'"+ value +"'";      
			aCondition = getDisassembledCondition("S3", columnName, value);
		else if ("movie_name".equals(columnName) )                          
			aCondition = "S2." + columnName + "=" + "'"+ value +"'"; 
		else if ("showtime_time".equals(columnName))                          // 用於date
			aCondition = "DATE(S1." + columnName + ") =" + "DATE('"+ value +"')";   
		else if ("category".equals(columnName))            // 用於category
			aCondition = getDisassembledCondition("S2", columnName, value);
		
		//for Oracle 的 date
		//aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";  
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
		map.put("group_no", new String[] { "1" });
		map.put("member_no", new String[] { "3" });
		map.put("showtime_no", new String[] { "1" });
		map.put("group_title", new String[] { "早起團" });
		map.put("required_cnt", new String[] { "2" });
		map.put("member_cnt", new String[] { "2" });
		map.put("group_status", new String[] { "1" });
		map.put("crt_dt", new String[] { "2021-03-27 00:00:00" });
		map.put("modify_dt", new String[] { "2021-03-28 00:00:00" });
		map.put("deadline_dt", new String[] { "2021-03-31 00:00:00" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = 
				"select S0.GROUP_NO, S0.SHOWTIME_NO,S0.MEMBER_NO, S3.MB_NAME, "
				+ "S1.SHOWTIME_TIME, S1.MOVIE_NO, S2.MOVIE_NAME, "
				+ " S0.GROUP_TITLE, S0.REQUIRED_CNT, S0.MEMBER_CNT, S0.GROUP_STATUS, "
				+ "S0.`DESC`, S0.CRT_DT, S0.MODIFY_DT, S0.DEADLINE_DT "
				+ "from `group` S0 "
				+ "LEFT JOIN SHOWTIME S1 ON S0.SHOWTIME_NO = S1.SHOWTIME_NO "
				+ "LEFT JOIN MOVIE S2 ON S1.MOVIE_NO = S2.MOVIE_NO "
				+ "LEFT JOIN `MEMBER` S3 ON S0.MEMBER_NO = S3.MEMBER_NO "
				+ jdbcUtil_CompositeQuery_Group.get_WhereCondition(map)
				+ " order by group_no";
		System.out.println("●●finalSQL = " + finalSQL);
	}
}
