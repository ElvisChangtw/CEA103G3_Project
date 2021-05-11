package com.payment.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.payment.model.PaymentService;
import com.payment.model.PaymentVO;


@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PaymentServlet() {
        super();

    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req,res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text; charset=utf-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action").trim();

		if ("insert_credit_card".equals(action)) { 
			try {
				int mb_no = new Integer(req.getParameter("mb_no"));
				String card_no = req.getParameter("card_no").trim();
				String card_name = req.getParameter("card_name").trim();
				String exp_mon = req.getParameter("exp_mon").trim();
				String exp_year = req.getParameter("exp_year").trim();
				String csc = req.getParameter("csc").trim();
				PaymentService paySvc = new PaymentService();
				PaymentVO payvo = paySvc.addCard(mb_no, card_no, card_name, exp_mon, exp_year, csc);
				JSONObject json = new JSONObject();
				json.put("status", "success");
				json.put("payno", payvo.getPay_no());
				out.print(json.toString());
				return;
			} catch (Exception e) {
				e.printStackTrace(System.err);
				out.print("fail");
			}
			finally {
				out.flush();
				out.close();
			}
		}

		if ("delete_credit_card".equals(action)) {
			try {
				int pay_no = new Integer(req.getParameter("pay_no"));
				PaymentService paySvc = new PaymentService();
				boolean result = paySvc.deleteCard(pay_no);
				if(result) {
					out.print("success");
				} else {
					out.print("failure");
				}
				return;
			} catch (Exception e) {
				e.printStackTrace();
				out.print("fail");
			} finally {
				out.flush();
				out.close();
			}
		}
		
		if ("getall_crdt_by_mbid".equals(action)) {
			RequestDispatcher dispatcher = req.getRequestDispatcher(req.getContextPath() + "/back-end/payment/paymentInfo.jsp");
			try {
				int mb_id = new Integer(req.getParameter("mb_id"));
				PaymentService paySvc = new PaymentService();
				req.setAttribute("creditCars", paySvc.getAllCard(mb_id));
				req.setAttribute("msg", "已成功移除資料");
				dispatcher.forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				req.setAttribute("msg", "移除資料失敗");
				dispatcher.forward(req, res);
			}
			  finally {
				out.flush();
				out.close();
			}
		}
	
	}

}
