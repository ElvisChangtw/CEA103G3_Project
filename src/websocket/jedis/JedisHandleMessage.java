package websocket.jedis;

import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleMessage {


	private static JedisPool pool = JedisPoolUtil.getJedisPool();  // like datasource

	public static List<String> getHistoryMsg(String sender, String type) {
		String key = new StringBuilder(sender).append(":").append(type).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange(key, 0, -1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String sender, String type, String message) {

		String senderKey = new StringBuilder(sender).append(":").append(type).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.rpush(senderKey, message);

		jedis.close();
	}

}
