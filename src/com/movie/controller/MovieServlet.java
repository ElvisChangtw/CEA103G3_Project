package com.movie.controller;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.movie.model.*;
import com.comment.model.*;
import com.rating.model.*;
import com.expectation.model.*;
import com.mem.model.MemService;
import com.mem.model.MemVO;


@WebServlet("/MovieServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MovieServlet extends HttpServlet {
//	private MovieTimer movieTimer;
	long count = 0;
	Timer movieTimer = new Timer();
	Calendar cal = new GregorianCalendar(2021, Calendar.MAY, 19, 00, 01);
	
	public void init() throws ServletException {

		movieTimer.scheduleAtFixedRate(new TimerTask() {
			public void run() {
				MovieService movieSvc = new MovieService();
				movieSvc.updateMovieStatus();
				System.out.println("update movie status = " + count);
				System.out.println(new Date(scheduledExecutionTime()));
				count++;
			}
		}, cal.getTime(), 24*60*60*1000);
	}
	
	public void destroy() {
		movieTimer.cancel();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("movieno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入電影編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/movie/error.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer movieno = null;
				try {
					movieno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("電影編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/movie/error.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				if (movieVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/movie/error.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				RatingService ratingSvc = new RatingService();
				RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(movieno);
				req.setAttribute("ratingCount", ratingCount);

				ExpectationService expectationSvc = new ExpectationService();
				ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(movieno);
				req.setAttribute("expectationCount", expectationCount);
				
//				Integer openModal=1;
//				req.setAttribute("openModal",openModal );

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("movieVO", movieVO); // 資料庫取出的movieVO物件,存入req
				String url = "/front-end/movie/listOneMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneMovie.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/movie/error.jsp");
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
							.getRequestDispatcher("/front-end/mem/memberSys.jsp");
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
							.getRequestDispatcher("/front-end/mem/memberSys.jsp");
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
							.getRequestDispatcher("/front-end/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				MemService memSvc = new MemService();
				double allRating=movieVO.getRating();
				JSONArray allComment = new JSONArray(comVO);  //
				
				for(int i = 0; i< allComment.length(); i++) {
					JSONObject obj = allComment.getJSONObject(i);
					int memberno = obj.getInt("memberno");
					MemVO vo = memSvc.getOneMem(memberno);
					if(vo != null) {
						String mb_name = vo.getMb_name();
						obj.put("mb_name", mb_name);
					}
				}

				
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
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllMovie.jsp
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer movieno = new Integer(req.getParameter("movieno"));

				/*************************** 2.開始查詢資料 ****************************************/
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("movieVO", movieVO); // 資料庫取出的movieVO物件,存入req
				String url = "/back-end/movie/update_movie_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_movie_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "修改資料取出時失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_movie_input.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
//			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllMovie.jsp】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer movieno = new Integer(req.getParameter("movieno").trim());
				String moviename = req.getParameter("moviename");
				if (moviename == null || moviename.trim().length() == 0) {
					errorMsgs.put("moviename", "電影名稱: 請勿空白");
				}
			
				Part part = req.getPart("moviepicture1");
				String filenameExtension = getServletContext().getMimeType(part.getSubmittedFileName());
				InputStream in = part.getInputStream();
				byte[] moviepicture1 = new byte[in.available()];
				// 判斷是否有更新圖片
				if (in.available() == 0) {

					MovieService movieSvc = new MovieService();
					MovieVO movieVO = movieSvc.getOneMovie(movieno);
					moviepicture1 = movieVO.getMoviepicture1();
					in.read(moviepicture1);
					in.close();

				} else {
					if (filenameExtension.equals("image/apng") || filenameExtension.equals("image/avif")
							|| filenameExtension.equals("image/gif") || filenameExtension.equals("image/jpeg")
							|| filenameExtension.equals("image/png") || filenameExtension.equals("image/svg+xml")
							|| filenameExtension.equals("image/webp")) {
						in.read(moviepicture1);
						in.close();
					} else {
						errorMsgs.put("moviepicture1",
								"上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}
				
				Part part2 = req.getPart("moviepicture2");
				String filenameExtension2 = getServletContext().getMimeType(part2.getSubmittedFileName());
				InputStream in2 = part2.getInputStream();
				byte[] moviepicture2 = new byte[in2.available()];
				// 判斷是否有更新圖片
				if (in2.available() == 0) {
					MovieService movieSvc = new MovieService();
					MovieVO movieVO = movieSvc.getOneMovie(movieno);
					moviepicture2 = movieVO.getMoviepicture2();
					in2.read(moviepicture2);
					in2.close();
				} else {
					if (filenameExtension2.equals("image/apng") || filenameExtension2.equals("image/avif")
							|| filenameExtension2.equals("image/gif") || filenameExtension2.equals("image/jpeg")
							|| filenameExtension2.equals("image/png") || filenameExtension2.equals("image/svg+xml")
							|| filenameExtension2.equals("image/webp")) {
						in2.read(moviepicture2);
						in2.close();
					} else {
						errorMsgs.put("moviepicture2",
								"上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}
				String director = req.getParameter("director").trim();
				if (director == null || director.trim().length() == 0) {
					errorMsgs.put("director", "導演名字請勿空白");
				}

				String actor = req.getParameter("actor").trim();
				if (actor == null || actor.trim().length() == 0) {
					errorMsgs.put("actor", "演員名字請勿空白");
				}

				String category = "";
				if (req.getParameterValues("category") == null || req.getParameterValues("category").length == 0) {
					errorMsgs.put("category", "電影類型請勿空白");
				} else {
					String values[] = req.getParameterValues("category");
					for (int i = 0; i < values.length; i++) {
						if (i == values.length - 1) {
							category += values[i];
						} else {
							category = category + values[i] + ",";
						}
					}
				}

				Integer length = null;
				try {
					length = new Integer(req.getParameter("length").trim());
				} catch (NumberFormatException e) {
					length = 0;
					errorMsgs.put("length", "電影長度請填數字.");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.put("status", "電影狀態請勿空白");// 給input type="TEXT"用的
				} else if (status.equals("9")) {
					errorMsgs.put("status", "請選擇電影狀態");// 給select下拉式選單低一個留空白用的
				}

				SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
				java.sql.Date premiredate = null;
				java.sql.Date offdate = null;
				try {
					premiredate = java.sql.Date.valueOf(req.getParameter("premiredate").trim());

				} catch (Exception e) {
					premiredate = null;
				}
				try {
					offdate = java.sql.Date.valueOf(req.getParameter("offdate").trim());
				} catch (Exception e) {
					offdate = null;
				}
				if (premiredate == null && offdate == null) {
				} else if (premiredate == null && offdate != null) {
					errorMsgs.put("premiredate", "有下映日期就要有上映日期");
				} else if (premiredate != null && offdate != null) {
					if (offdate.before(premiredate)) {
						errorMsgs.put("offdate", "下映日期要比上映日期晚");
					}
					if (fmt.format(premiredate).equals(fmt.format(offdate))) {
						errorMsgs.put("offdate", "上映當天就下映,可以這樣上上下下嗎?可以嗎?????");
					}
				}

//				String trailor = req.getParameter("trailor").trim();
//				String embed = req.getParameter("embed").trim();
//				String trailorReg = "^(https?\\:\\/\\/)?(www\\.)?(youtube\\.com|youtu\\.?be)\\/.+$";
//				
//				if(trailor.length() ==0  && embed.length() ==0) {
//					trailor = null;
//					embed = null;
//				}else if(trailor.length() !=0  && embed.length() ==0) {
//					if (!trailor.trim().matches(trailorReg)) {
//						errorMsgs.put("trailor", "請輸入正確格式網址");
//					}
//					errorMsgs.put("embed", "有輸入預告片網址,記得附上短網址");
//				}else if(trailor.length() ==0  && embed.length() !=0) {
//					errorMsgs.put("trailor", "請記得輸入預告片網址");
//				}else if(trailor.length() !=0  && embed.length() !=0) {
//					if (!trailor.trim().matches(trailorReg)) {
//						errorMsgs.put("trailor", "請輸入正確格式網址");
//					}
//				}
				
				String trailor = req.getParameter("trailor").trim();
				String trailorReg = "^(https?\\:\\/\\/)?(www\\.)?(youtube\\.com|youtu\\.?be)\\/.+$";
				String embed = null;
				if(trailor.length() ==0) {
					trailor = "https://www.youtube.com/watch?v=";
					embed = "26Q8duJW11s";
				}else {
					if (trailor.trim().matches(trailorReg)) {
						if(trailor.equals("https://www.youtube.com/watch?v=")) {
							embed = "26Q8duJW11s";
						}else {
							String[] strs= trailor.split("=");
							int len=strs.length;
							for(int i=0;i<len;i++  ){
								embed = strs[1].toString();
							}
						}
					}else {
						errorMsgs.put("trailor", "請輸入正確格式網址");
					}
				}


				String grade = req.getParameter("grade").trim();
				if (grade == null || grade.trim().length() == 0) {
					errorMsgs.put("grade", "電影分級請勿空白");// 給input type="TEXT"用的
				} else if (grade.equals("9")) {
					errorMsgs.put("grade", "請選擇電影分級");// 給select下拉式選單用的
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				MovieService movieSvc = new MovieService();
				movieVO = movieSvc.updateMovie(movieno, moviename, moviepicture1, moviepicture2, director, actor,
						category, length, status, premiredate, offdate, trailor, embed, grade);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("movieVO", movieVO); // 資料庫update成功後,正確的的movieVO物件,存入req

				if (requestURL.equals("/back-end/movie/backEndlistMovies_ByCompositeQuery.jsp")) {
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>) session.getAttribute("map");
					List<MovieVO> list = movieSvc.getAll(map);
					req.setAttribute("listMovies_ByCompositeQuery", list); // 複合查詢, 資料庫取出的list物件,存入request
				}

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneMovie.jsp
//				RequestDispatcher successView = req.getRequestDispatcher("/back-end/movie/backEndlistAllMovie.jsp");
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
System.out.println("updatemovie錯了"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
				failureView.forward(req, res);
				
			}
		}

		if ("insert".equals(action)) { // 來自addMovie.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
//缺驗證
				String moviename = req.getParameter("moviename");
//					String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (moviename == null || moviename.trim().length() == 0) {
					errorMsgs.put("moviename", "電影名稱: 請勿空白");
//				} else if(!moviename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("電影名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到30之間");
				}

				Part part = req.getPart("moviepicture1");
				String filenameExtension = getServletContext().getMimeType(part.getSubmittedFileName());
				InputStream in = part.getInputStream();
				byte[] moviepicture1 = new byte[in.available()];
				if (!(in.available() == 0)) {
					if (filenameExtension.equals("image/apng") || filenameExtension.equals("image/avif")
							|| filenameExtension.equals("image/gif") || filenameExtension.equals("image/jpeg")
							|| filenameExtension.equals("image/png") || filenameExtension.equals("image/svg+xml")
							|| filenameExtension.equals("image/webp")) {
						in.read(moviepicture1);
						in.close();
					} else {
						errorMsgs.put("moviepicture1",
								"上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}

				Part part2 = req.getPart("moviepicture2");
				String filenameExtension2 = getServletContext().getMimeType(part2.getSubmittedFileName());
				InputStream in2 = part2.getInputStream();
				byte[] moviepicture2 = new byte[in2.available()];
				if (!(in2.available() == 0)) {
					if (filenameExtension2.equals("image/apng") || filenameExtension2.equals("image/avif")
							|| filenameExtension2.equals("image/gif") || filenameExtension2.equals("image/jpeg")
							|| filenameExtension2.equals("image/png") || filenameExtension2.equals("image/svg+xml")
							|| filenameExtension2.equals("image/webp")) {
						in2.read(moviepicture2);
						in2.close();
					} else {
						errorMsgs.put("moviepicture2",
								"上傳圖片附檔名必須是.apng,.avif,.gif,.jpg,.jpeg,.jfif,.pjpeg,.pjp,.png,.svg,.webp");
					}
				}

				String director = req.getParameter("director").trim();
				if (director == null || director.trim().length() == 0) {
					errorMsgs.put("director", "導演名字請勿空白");
				}

				String actor = req.getParameter("actor").trim();
				if (actor == null || actor.trim().length() == 0) {
					errorMsgs.put("actor", "演員名字請勿空白");
				}

				String category = "";
				if (req.getParameterValues("category") == null || req.getParameterValues("category").length == 0) {
					errorMsgs.put("category", "電影類型請勿空白");
				} else {
					String values[] = req.getParameterValues("category");
					for (int i = 0; i < values.length; i++) {
						if (i == values.length - 1) {
							category += values[i];
						} else {
							category = category + values[i] + ",";
						}
					}
				}

				Integer length = null;
				try {
					length = new Integer(req.getParameter("length").trim());
				} catch (NumberFormatException e) {
					length = 0;
					errorMsgs.put("length", "請重新輸入電影長度");
				}
//				System.out.println(length.intValue());

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.put("status", "電影狀態請勿空白");// 給input type="TEXT"用的
				} else if (status.equals("9")) {
					errorMsgs.put("status", "請選擇電影狀態");// 給select下拉式選單低一個留空白用的
				}

				SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
				java.sql.Date premiredate = null;
				java.sql.Date offdate = null;
				try {
					premiredate = java.sql.Date.valueOf(req.getParameter("premiredate").trim());

				} catch (Exception e) {
					premiredate = null;
				}
				try {
					offdate = java.sql.Date.valueOf(req.getParameter("offdate").trim());
				} catch (Exception e) {
					offdate = null;
				}
				if (premiredate == null && offdate == null) {
				} else if (premiredate == null && offdate != null) {
					errorMsgs.put("premiredate", "有下映日期就要有上映日期");
				} else if (premiredate != null && offdate != null) {
					if (offdate.before(premiredate)) {
						errorMsgs.put("offdate", "下映日期要比上映日期晚");
					}
					if (fmt.format(premiredate).equals(fmt.format(offdate))) {
						errorMsgs.put("offdate", "上映當天就下映,可以這樣上上下下嗎?可以嗎?????");
					}
				}

//				String trailor = req.getParameter("trailor").trim();
//				String embed = req.getParameter("embed").trim();
//				String trailorReg = "^(https?\\:\\/\\/)?(www\\.)?(youtube\\.com|youtu\\.?be)\\/.+$";
//				
//				if(trailor.length() ==0  && embed.length() ==0) {
//					trailor = null;
//					embed = null;
//				}else if(trailor.length() !=0  && embed.length() ==0) {
//					if (!trailor.trim().matches(trailorReg)) {
//						errorMsgs.put("trailor", "請輸入正確格式網址");
//					}
//					errorMsgs.put("embed", "有輸入預告片網址,記得附上短網址");
//				}else if(trailor.length() ==0  && embed.length() !=0) {
//					errorMsgs.put("trailor", "請記得輸入預告片網址");
//				}else if(trailor.length() !=0  && embed.length() !=0) {
//					if (!trailor.trim().matches(trailorReg)) {
//						errorMsgs.put("trailor", "請輸入正確格式網址");
//					}
//				}
				
				String trailor = req.getParameter("trailor").trim();
				String trailorReg = "^(https?\\:\\/\\/)?(www\\.)?(youtube\\.com|youtu\\.?be)\\/.+$";
				String embed = null;
				if(trailor.length() ==0) {
					trailor = "https://www.youtube.com/watch?v=";
					embed = "26Q8duJW11s";
				}else {
					if (trailor.trim().matches(trailorReg)) {
						if(trailor.equals("https://www.youtube.com/watch?v=")) {
							embed = "26Q8duJW11s";
						}else {
							String[] strs= trailor.split("=");
							int len=strs.length;
							for(int i=0;i<len;i++  ){
								embed = strs[1].toString();
							}
						}
					}else {
						errorMsgs.put("trailor", "請輸入正確格式網址");
					}
				}

				String grade = req.getParameter("grade").trim();
				if (grade == null || grade.trim().length() == 0) {
					errorMsgs.put("grade", "電影分級請勿空白");// 給input type="TEXT"用的
				} else if (grade.equals("9")) {
					errorMsgs.put("grade", "請選擇電影分級");// 給select下拉式選單用的
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
				movieVO = movieSvc.addMovie(moviename, moviepicture1, moviepicture2, director, actor, category, length,
						status, premiredate, offdate, trailor, embed, grade);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/movie/backEndlistAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllMovie.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
System.out.println("insertMovie出錯了"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/addMovie.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或 /dept/listEmps_ByDeptno.jsp的請求

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

				String url = "/back-end/movie/backEndlistAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/backEndlistAllMovie.jsp");
				failureView.forward(req, res);
			}
		}

		if ("listMovies_ByCompositeQuery".equals(action) || "listMovies_ByCompositeQuery_back".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				/*************************** 1.將輸入資料轉為Map **********************************/
				// 採用Map<String,String[]> getParameterMap()的方法
				// 注意:an immutable java.util.Map
				// Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>) session.getAttribute("map");

				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null) {
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map", map1);
					map = map1;
				}

				/*************************** 2.開始複合查詢 ***************************************/
				MovieService movieSvc = new MovieService();
				List<MovieVO> list = movieSvc.getAll(map);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listMovies_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				
				String url = null;
				if ("listMovies_ByCompositeQuery".equals(action)) {
					url = "/front-end/movie/listMovies_ByCompositeQuery.jsp"; 
				}
				else if ("listMovies_ByCompositeQuery_back".equals(action)) {
					url = "/back-end/movie/backEndlistMovies_ByCompositeQuery.jsp"; 
				}//這要改成後端複合查詢
					
				
				RequestDispatcher successView = req
						.getRequestDispatcher(url); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/backEndlistAllMovie.jsp");
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
				req.setAttribute("listComments_ByMovieno", set); // 資料庫取出的list物件,存入request

				String url = null;
				if ("listComments_ByMovieno_A".equals(action))
					url = "/front-end/movie/listOneMovie.jsp"; // 成功轉交 dept/listEmps_ByDeptno.jsp
				else if ("listComments_ByMovieno_B".equals(action))
					url = "/front-end/movie/listAllMovie.jsp"; // 成功轉交 dept/listAllDept.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}

		if ("getPicForDisplay".equals(action)) {
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
				/*************************** 2.開始複合查詢 ***************************************/
				MovieService movieSvc = new MovieService();
				List<MovieVO> list = (List<MovieVO>) req.getAttribute("list");
				list = movieSvc.getYearMovie(year);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("list", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/movie/listAllMovie.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/movie/error.jsp");
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
		if ("search_Ajax".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
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
				
				for( MovieVO movieVO : list) {
					movieVO.setMoviepicture1(null);
					movieVO.setMoviepicture2(null);
				}
				JSONArray results = new JSONArray(list);  //
				JSONObject jsonobj=new JSONObject();
				try {
					jsonobj.put("results", results);
					out.print(jsonobj.toString());
					return;
				}catch(JSONException e) {
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/movie/error.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
