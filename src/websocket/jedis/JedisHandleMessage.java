package websocket.jedis;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleMessage {


	private static JedisPool pool = JedisPoolUtil.getJedisPool();  // like datasource
	public static List<String> updateRead(String sender) {
		String key = sender;

		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		Long count = jedis.llen(key);
		List<String> updateData = new ArrayList<String>();
		for(long i = 0 ; i < count; i++) {
			String fragment = jedis.lindex(key, i);
			int index = fragment.lastIndexOf("read");
			String slice1 = fragment.substring(0,index);
			String slice2 ="read\":\"Y\"}";
//			System.out.println(slice1+slice2);
			String afterRead = slice1+slice2;
			jedis.lset(key, i, afterRead);
			updateData.add(afterRead);
		}
		System.out.println(updateData);
		jedis.close();
		return updateData;
	}
	
	public static List<String> getHistoryMsg(String sender) {
		String key = sender;
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange(key, 0, -1);
		System.out.println(historyData);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String sender, String type, String message) {

		String senderKey = sender;
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.lpush(senderKey, message);

		jedis.close();
	}

}
