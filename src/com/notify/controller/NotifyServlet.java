package com.notify.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import websocket.jedis.JedisHandleMessage;
import com.google.gson.Gson;
@WebServlet("/NotifyServlet")
public class NotifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		
		if("insert_For_Ajax".equals(action)) {
			String member_no = req.getParameter("member_no");
			
			try {
				List<String> historyData = JedisHandleMessage.getHistoryMsg(member_no);
				JSONArray a = new JSONArray(historyData);
				JSONObject jsonobj=new JSONObject();
				jsonobj.put("all", a);
				out.print(jsonobj);
				return;
			}catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				out.flush();
				out.close();
			}
			
		}
		
		if("readNotify".equals(action)) {
			String member_no = req.getParameter("member_no");
			try {
				JedisHandleMessage.updateRead(member_no);
				out.print("success");
				return;
			}finally {
				out.flush();
				out.close();
			}
			
		}

		
	}

}
