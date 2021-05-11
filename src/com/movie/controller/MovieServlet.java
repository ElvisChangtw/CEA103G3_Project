package com.movie.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.movie.model.*;
import com.comment.model.*;



@WebServlet("/MovieServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MovieServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("movieno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入電影編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer movieno = null;
				try {
					movieno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("電影編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				if (movieVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("movieVO", movieVO); // 資料庫取出的movieVO物件,存入req
				String url = "/front-end/movie/listOneMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneMovie.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display_Ajax".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("movieno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入電影編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontend/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer movieno = null;
				try {
					movieno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("電影編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontend/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				CommentService comSvc = new CommentService();
				List<CommentVO> comVO = comSvc.getOneMovieComment(movieno);
				if (movieVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontend/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				double allRating=movieVO.getRating();
				JSONArray allComment = new JSONArray(comVO);  //
				JSONObject jsonobj=new JSONObject();
				try {
					jsonobj.put("allRating", allRating);
					jsonobj.put("allComment", allComment);
					out.print(jsonobj.toString());
					return;
				}catch(JSONException e) {
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontend/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllMovie.jsp 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】			

			try {
				/***************************1.接收請求參數****************************************/
				Integer movieno = new Integer(req.getParameter("movieno"));
				
				/***************************2.開始查詢資料****************************************/
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("movieVO", movieVO); // 資料庫取出的movieVO物件,存入req
				String url = "/back-end/movie/update_movie_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_movie_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_movie_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllMovie.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer movieno = new Integer(req.getParameter("movieno").trim());
//缺驗證
				String moviename = req.getParameter("moviename");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (moviename == null || moviename.trim().length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
//				} else if(!moviename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("電影名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到30之間");
	            }
				
//測試副檔名驗證(MD檔)
				Part part = req.getPart("moviepicture1");
				String filenameExtension = getServletContext().getMimeType(part.getSubmittedFileName()); 
				InputStream in = part.getInputStream();
				byte[] moviepicture1 = new byte[in.available()];
				//判斷是否有更新圖片	
				if(in.available() == 0) {
					MovieService movieSvc = new MovieService();
					MovieVO movieVO = movieSvc.getOneMovie(movieno);
					moviepicture1 = movieVO.getMoviepicture1();
					in.read(moviepicture1);
					in.close();
				}else {
					if(filenameExtension.equals("image/apng") || filenameExtension.equals("image/avif") 
					|| filenameExtension.equals("image/gif") || filenameExtension.equals("image/jpeg") 
					|| filenameExtension.equals("image/png") ||filenameExtension.equals("image/svg+xml") 
					|| filenameExtension.equals("image/webp")){
						in.read(moviepicture1);
						in.close();
					}
					else {
						errorMsgs.add("上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}
				
				Part part2 = req.getPart("moviepicture2");
				String filenameExtension2 = getServletContext().getMimeType(part.getSubmittedFileName()); 
				InputStream in2 = part2.getInputStream();
				byte[] moviepicture2 = new byte[in2.available()];
				//判斷是否有更新圖片	
				if(in2.available() == 0) {
					MovieService movieSvc = new MovieService();
					MovieVO movieVO = movieSvc.getOneMovie(movieno);
					moviepicture2 = movieVO.getMoviepicture2();
					in2.read(moviepicture2);
					in2.close();
				}else {
					if(filenameExtension2.equals("image/apng") || filenameExtension2.equals("image/avif") 
					|| filenameExtension2.equals("image/gif") || filenameExtension2.equals("image/jpeg") 
					|| filenameExtension2.equals("image/png") ||filenameExtension2.equals("image/svg+xml") 
					|| filenameExtension2.equals("image/webp")){
						in.read(moviepicture2);
						in.close();
					}
					else {
						errorMsgs.add("上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}
			
				//等同下方
//				req.getPart("moviepicture1").getInputStream().read(new byte[req.getPart("moviepicture1").getInputStream().available()]);
//				req.getPart("moviepicture1").getInputStream().close();
				
				String director = req.getParameter("director").trim();
				if (director == null || director.trim().length() == 0) {
					errorMsgs.add("導演名字請勿空白");
				}
				
				String actor = req.getParameter("actor").trim();
				if (actor == null || actor.trim().length() == 0) {
					errorMsgs.add("演員名字請勿空白");
				}	
				
				String category = req.getParameter("category").trim();
				if (category == null || category.trim().length() == 0) {
					errorMsgs.add("電影類型請勿空白");
				}
				
				Integer length = null;
				try {
					length = new Integer(req.getParameter("length").trim());
				} catch (NumberFormatException e) {
					length = 0;
					errorMsgs.add("電影長度請填數字.");
				}
				
				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0 ) {
					errorMsgs.add("電影狀態請勿空白");//給input type="TEXT"用的
				}else if(status.equals("9")) {
					errorMsgs.add("請選擇電影狀態");//給select下拉式選單低一個留空白用的
				}
								
				java.sql.Date premiredate = null;
				try {
					premiredate = java.sql.Date.valueOf(req.getParameter("premiredate").trim());
				} catch (IllegalArgumentException e) {
					premiredate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請重新輸入上映日期!");
				}
				
				java.sql.Date offdate = null;
				try {
					offdate = java.sql.Date.valueOf(req.getParameter("offdate").trim());
					if(offdate.before(premiredate)){
						errorMsgs.add("下檔日期要比上映日期晚");
					}
				} catch (IllegalArgumentException e) {
					offdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請重新輸入下檔日期!");
				}
				
				String trailor = req.getParameter("trailor").trim();
				
				String embed = req.getParameter("embed").trim();
				
				String grade = req.getParameter("grade").trim();
				if (grade == null || grade.trim().length() == 0) {
					errorMsgs.add("電影分級請勿空白");//給input type="TEXT"用的
				}else if(grade.equals("9")) {
					errorMsgs.add("請選擇電影分級");//給select下拉式選單用的
				}
				

				MovieVO movieVO = new MovieVO();				
				movieVO.setMovieno(movieno);
				movieVO.setMoviename(moviename);
				movieVO.setMoviepicture1(moviepicture1);
				movieVO.setMoviepicture2(moviepicture2);
				movieVO.setDirector(director);
				movieVO.setActor(actor);
				movieVO.setCategory(category);
				movieVO.setLength(length);
				movieVO.setStatus(status);
				movieVO.setPremiredate(premiredate);
				movieVO.setOffdate(offdate);
				movieVO.setTrailor(trailor);
				movieVO.setEmbed(embed);
				movieVO.setGrade(grade);

				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("movieVO", movieVO); // 含有輸入格式錯誤的movieVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				MovieService movieSvc = new MovieService();
				movieVO = movieSvc.updateMovie(movieno,moviename,moviepicture1,moviepicture2,director,actor,category,
							length,status,premiredate,offdate,trailor,embed,grade);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				req.setAttribute("movieVO", movieVO); // 資料庫update成功後,正確的的movieVO物件,存入req

				if(requestURL.equals("/front-end/movie/listMovies_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<MovieVO> list  = movieSvc.getAll(map);
					req.setAttribute("listMovies_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
				
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneMovie.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
				failureView.forward(req, res);
			}
		}

		if("insert".equals(action)){ // 來自addMovie.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
//缺驗證
				String moviename = req.getParameter("moviename");
//					String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (moviename == null || moviename.trim().length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
//				} else if(!moviename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("電影名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到30之間");
				}

				Part part = req.getPart("moviepicture1");
				String filenameExtension = getServletContext().getMimeType(part.getSubmittedFileName());
				InputStream in = part.getInputStream();
				byte[] moviepicture1 = new byte[in.available()];
				if(!(in.available() == 0)) {
					if(filenameExtension.equals("image/apng") || filenameExtension.equals("image/avif") 
							|| filenameExtension.equals("image/gif") || filenameExtension.equals("image/jpeg") 
							|| filenameExtension.equals("image/png") ||filenameExtension.equals("image/svg+xml")
							|| filenameExtension.equals("image/webp")){
						in.read(moviepicture1);
						in.close();
					}else {
						errorMsgs.add("上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}
				
				Part part2 = req.getPart("moviepicture2");
				String filenameExtension2 = getServletContext().getMimeType(part.getSubmittedFileName());
				InputStream in2 = part2.getInputStream();
				byte[] moviepicture2 = new byte[in2.available()];
				if(!(in2.available() == 0)) {
					if(filenameExtension2.equals("image/apng") || filenameExtension2.equals("image/avif") 
							|| filenameExtension2.equals("image/gif") || filenameExtension2.equals("image/jpeg") 
							|| filenameExtension2.equals("image/png") ||filenameExtension2.equals("image/svg+xml")
							|| filenameExtension2.equals("image/webp")){
						in2.read(moviepicture2);
						in2.close();
					}else {
						errorMsgs.add("上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}
		
				String director = req.getParameter("director").trim();
				if (director == null || director.trim().length() == 0) {
					errorMsgs.add("導演名字請勿空白");
				}

				String actor = req.getParameter("actor").trim();
				if (actor == null || actor.trim().length() == 0) {
					errorMsgs.add("演員名字請勿空白");
				}

				String values[] = req.getParameterValues("category");
			    String category = "";
			    for (int i = 0; i < values.length; i++) {
			    	if (i == values.length - 1) {
			    		category += values[i];
			    	} else {
			    		category = category + values[i] + ",";
			    	}
			    }
			    if (category == null || category.trim().length() == 0) {
					errorMsgs.add("電影類型請勿空白");
				}

				Integer length = new Integer(req.getParameter("length").trim());

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("電影狀態請勿空白");// 給input type="TEXT"用的
				} else if (status.equals("9")) {
					errorMsgs.add("請選擇電影狀態");// 給select下拉式選單低一個留空白用的
				}

				java.sql.Date premiredate = null;
				try {
					premiredate = java.sql.Date.valueOf(req.getParameter("premiredate").trim());
				} catch (IllegalArgumentException e) {
					premiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請重新輸入上映日期!");
				}

				java.sql.Date offdate = null;
				try {
					offdate = java.sql.Date.valueOf(req.getParameter("offdate").trim());
					if(offdate.before(premiredate)){
						errorMsgs.add("下檔日期要比上映日期晚");
					}
				} catch (IllegalArgumentException e) {
					offdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請重新輸入下檔日期!");
				}

				String trailor = req.getParameter("trailor").trim();
				
				String embed = req.getParameter("embed").trim();

				String grade = req.getParameter("grade").trim();
				if (grade == null || grade.trim().length() == 0) {
					errorMsgs.add("電影分級請勿空白");// 給input type="TEXT"用的
				} else if (grade.equals("9")) {
					errorMsgs.add("請選擇電影分級");// 給select下拉式選單用的
				}


				MovieVO movieVO = new MovieVO();
				movieVO.setMoviename(moviename);
				movieVO.setMoviepicture1(moviepicture1);
				movieVO.setMoviepicture2(moviepicture2);
				movieVO.setDirector(director);
				movieVO.setActor(actor);
				movieVO.setCategory(category);
				movieVO.setLength(length);
				movieVO.setStatus(status);
				movieVO.setPremiredate(premiredate);
				movieVO.setOffdate(offdate);
				movieVO.setTrailor(trailor);
				movieVO.setEmbed(embed);
				movieVO.setGrade(grade);


			// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("movieVO", movieVO); // 含有輸入格式錯誤的movieVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/addMovie.jsp");
					failureView.forward(req, res);
					return;
				}

			/*************************** 2.開始新增資料 ***************************************/
				MovieService movieSvc = new MovieService();
				movieVO = movieSvc.addMovie(moviename, moviepicture1, moviepicture2, director, actor, category, length, status, premiredate,
					offdate, trailor, embed, grade);
				
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/movie/listAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllMovie.jsp
				successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/addMovie.jsp");
				failureView.forward(req, res);
			}
		}

		if("delete".equals(action)){ // 來自listAllEmp.jsp 或 /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer movieno = new Integer(req.getParameter("movieno"));

				/*************************** 2.開始刪除資料 ***************************************/
				MovieService movieSvc = new MovieService();
				movieSvc.deleteMovie(movieno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/

				String url = "/front-end/movie/listAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/movie/listAllMovie.jsp");
				failureView.forward(req, res);
			}
		}
	
		if ("listMovies_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
			
			/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				//Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
			
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
			
				/***************************2.開始複合查詢***************************************/
				MovieService movieSvc = new MovieService();
				List<MovieVO> list  = movieSvc.getAll(map);
			
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listMovies_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/movie/listMovies_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
			
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listComments_ByMovieno_A".equals(action) || "listComments_ByMovieno_B".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer movieno = new Integer(req.getParameter("movieno"));

				/*************************** 2.開始查詢資料 ****************************************/
				MovieService movieSvc = new MovieService();
				Set<CommentVO> set = movieSvc.getCommentsByMovieno(movieno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listComments_ByMovieno", set);    // 資料庫取出的list物件,存入request

				String url = null;
				if ("listComments_ByMovieno_A".equals(action))
					url = "/front-end/movie/listOneMovie.jsp";        // 成功轉交 dept/listEmps_ByDeptno.jsp
				else if ("listComments_ByMovieno_B".equals(action))
					url = "/front-end/movie/listAllMovie.jsp";              // 成功轉交 dept/listAllDept.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}

		if("getPicForDisplay".equals(action)){
			Integer movieno = new Integer(req.getParameter("movieno"));
			MovieService movieSvc = new MovieService();
			MovieVO movieVO = movieSvc.getOneMovie(movieno);
			byte[] moviepicture1 = movieVO.getMoviepicture1();
			if (moviepicture1 != null) {
				res.getOutputStream().write(moviepicture1);
			} else {
				InputStream in = getServletContext().getResourceAsStream("/images/NoData/none2.jpg");
				byte[] b = new byte[in.available()];
				in.read(b);
				res.getOutputStream().write(b);
				in.close();
			}
		}
		
		if ("listMovies_ByYear".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String year = req.getParameter("year");
				/***************************2.開始複合查詢***************************************/
				MovieService movieSvc = new MovieService();
				List<MovieVO> list  = (List<MovieVO>)req.getAttribute("list");
				list =	movieSvc.getYearMovie(year);
			
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("list", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/movie/listAllMovie.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
			
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
//		if ("getNewExpectation_Ajax".equals(action)) { // 來自select_page.jsp的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			PrintWriter out = res.getWriter();
//
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String str = req.getParameter("movieno");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入電影編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				Integer movieno = null;
//				try {
//					movieno = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("電影編號格式不正確");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				/***************************2.開始查詢資料*****************************************/
//				MovieService movieSvc = new MovieService();
//				MovieVO movieVO = movieSvc.getOneMovie(movieno);
////				CommentService comSvc = new CommentService();
////				List<CommentVO> comVO = comSvc.getOneMovieComment(movieno);
//				if (movieVO == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//
//				double newExpectation=movieVO.getExpectation();
//				JSONObject jsonobj=new JSONObject();
//				try {
//					jsonobj.put("newExpectation", newExpectation);
//					out.print(jsonobj.toString());
//					return;
//				}catch(JSONException e) {
//					e.printStackTrace();
//				}finally {
//					out.flush();
//					out.close();
//				}
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
	}
}
