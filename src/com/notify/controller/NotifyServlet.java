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
			String type = req.getParameter("type");
			try {
				List<String> historyData = JedisHandleMessage.getHistoryMsg(member_no, type);
				JSONArray a = new JSONArray(historyData);
				JSONObject jsonobj=new JSONObject();
				jsonobj.put("friend", a);
				out.print(jsonobj);
				return;
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				out.flush();
				out.close();
			}
			
		}
		
	}

}
