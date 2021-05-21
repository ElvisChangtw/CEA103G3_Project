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

	public static void updateRead(String sender) {
		String key = sender;
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.lset(key, -1, "Y");
		jedis.close();
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
