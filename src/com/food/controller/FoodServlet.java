package com.food.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.json.JSONException;
import org.json.JSONObject;

import com.food.model.FoodService;
import com.food.model.FoodVO;


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class FoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FoodServlet() {
        super();
    }
    
  
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("food_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入電影編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer food_no = null;
				try {
					food_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("電影編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				FoodService foodSvc = new FoodService();
				FoodVO foodVO = foodSvc.getOneFood(food_no);
				if (foodVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodVO", foodVO); // 資料庫取出的foodVO物件,存入req
				String url = "/back-end/food/listOneFood.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/food/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllFood.jsp 

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】			
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer food_no = new Integer(req.getParameter("food_no"));
				
				/***************************2.開始查詢資料****************************************/
				FoodService foodSvc = new FoodService();
				FoodVO foodVO = foodSvc.getOneFood(food_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("foodVO", foodVO); // 資料庫取出的foodVO物件,存入req
				String url = "/back-end/food/update_food_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_food_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料取出時失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/food/listAllFood.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getPic".equals(action)) {
			
			Integer food_no = new Integer(req.getParameter("food_no").trim());
			FoodService foodSvc = new FoodService();
			FoodVO foodVO = foodSvc.getOneFood(food_no);
			byte[] food_pic = foodVO.getFood_pic();
			if(food_pic!= null) {
				res.getOutputStream().write(food_pic);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_food_input.jsp的請求
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer food_no = new Integer(req.getParameter("food_no").trim());

				String food_name = req.getParameter("food_name");
				String food_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,10}$";
				if (food_name == null || food_name.trim().length() == 0) {
					errorMsgs.put("food_name","餐點名稱: 請勿空白");
				} else if(!food_name.trim().matches(food_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("food_name","餐點名稱: 只能是中、英文字母、數字和_ , 且長度必需在1到10之間");
	            }
				
				
				String food_type = req.getParameter("food_type").trim();
				
				Integer food_price = null;
				try {
					food_price = new Integer(req.getParameter("food_price").trim());
				} catch (NumberFormatException e) {
					food_price = 0;
					errorMsgs.put("food_price","餐點價格請填數字.");
				}
				
				Part part = req.getPart("food_pic");
				InputStream in = part.getInputStream();
				byte[] food_pic = new byte[in.available()];
				if(in.available() == 0) {
					FoodService foodSvc = new FoodService();
					FoodVO foodVO = foodSvc.getOneFood(food_no);
					food_pic = foodVO.getFood_pic();
				}
				in.read(food_pic);
				in.close();

				String food_status = req.getParameter("food_status");

				FoodVO foodVO = new FoodVO();				
				foodVO.setFood_no(food_no);
				foodVO.setFood_name(food_name);
				foodVO.setFood_type(food_type);
				foodVO.setFood_pic(food_pic);
				foodVO.setFood_status(food_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("foodVO", foodVO); // 含有輸入格式錯誤的foodVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/food/update_food_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				FoodService foodSvc = new FoodService();
				foodVO = foodSvc.updateFood(food_no,food_name,food_type,food_price,food_pic,food_status);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
				req.setAttribute("foodVO", foodVO); // 資料庫update成功後,正確的的foodVO物件,存入req
				String url = "/back-end/food/listAllFood.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneFood.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料取出時失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/food/update_food_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addFood.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String food_name = req.getParameter("food_name");
				String food_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,10}$";
				if (food_name == null || food_name.trim().length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
				} else if(!food_name.trim().matches(food_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("電影名稱: 只能是中、英文字母、數字和_ , 且長度必需在1到10之間");
	            }
				
				
				String food_type = req.getParameter("food_type").trim();
				
				Integer food_price = null;
				try {
					food_price = new Integer(req.getParameter("food_price").trim());
				} catch (NumberFormatException e) {
					food_price = 0;
					errorMsgs.add("餐點價格請填數字.");
				}
				
				Part part = req.getPart("food_pic");
				InputStream in = part.getInputStream();
				byte[] food_pic = new byte[in.available()];
				in.read(food_pic);
				in.close();

				String food_status = req.getParameter("food_status");

				FoodVO foodVO = new FoodVO();				
				foodVO.setFood_name(food_name);
				foodVO.setFood_type(food_type);
				foodVO.setFood_price(food_price);
				foodVO.setFood_pic(food_pic);
				foodVO.setFood_status(food_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("foodVO", foodVO); // 含有輸入格式錯誤的foodVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/food/addFood.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				FoodService foodSvc = new FoodService();
				foodVO = foodSvc.addFood(food_name,food_type,food_price,food_pic,food_status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/food/listAllFood.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllFood.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/food/addFood.jsp");
				failureView.forward(req, res);
			}
		}
		
       
		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數***************************************/
				Integer food_no = new Integer(req.getParameter("food_no"));
				
				/***************************2.開始刪除資料***************************************/
				FoodService foodSvc = new FoodService();
				FoodVO foodVO = foodSvc.getOneFood(food_no);
				foodSvc.deleteFood(food_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/food/listAllFood.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/food/listAllFood.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("updateStatus".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();

			try {
				/***************************1.接收請求參數***************************************/
				Integer food_no = new Integer(req.getParameter("food_no"));
		
				/***************************2.開始修改資料***************************************/
				FoodService foodSvc = new FoodService();
				foodSvc.onOrDownFoodStatus(food_no);
				FoodVO foodVO = foodSvc.getOneFood(food_no);
				
				//將最新的狀態丟回去
				String newStatus=foodVO.getFood_status();
				JSONObject jsonobj = new JSONObject();
				try {
					jsonobj.put("newStatus", newStatus);
					out.print(jsonobj.toString());
					return;
				}catch(JSONException e) {
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/food/listAllFood2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/food/listAllFood.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
