package com.article.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.mem.model.MemService;

import com.article.model.ArticleDAO;
import com.article.model.ArticleService;
import com.article.model.ArticleVO;
import com.like.model.LikeService;
import com.reply.model.ReplyService;
import com.reply.model.ReplyVO;
@WebServlet("/ArticleServlet")
public class ArticleServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display_Ajax".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				int article_no = new Integer(req.getParameter("article_no"));

				ArticleService articleSvc = new ArticleService();
				MemService memSvc = new MemService();
				ArticleVO articleVO= articleSvc.getOneArticle(article_no);
				if (articleVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					RequestDispatcher failureView = req
							.getRequestDispatcher("/frontend/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}	
				String content = articleVO.getContent();
				String title = articleVO.getArticleheadline();
				String author = memSvc.getOneMem(articleVO.getMemberno()).getMb_name();
				int likecount = articleVO.getLikecount();
				JSONObject jsonobj=new JSONObject();
				try {
					jsonobj.put("content", content);
					jsonobj.put("title", title);
					jsonobj.put("author", author);
					jsonobj.put("likecount", likecount);
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
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("articleno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/article/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer articleno = null;
				try {
					articleno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/article/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ArticleService articleSvc = new ArticleService();
				ArticleVO articleVO = articleSvc.getOneArticle(articleno);
				if (articleVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/article/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("articleVO", articleVO); // 資料庫取出的articleVO物件,存入req
				String url = "/front-end/article/listOneArticle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneArticle.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/article/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllArticle.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer articleno = new Integer(req.getParameter("articleno"));
				
				/***************************2.開始查詢資料****************************************/
				ArticleService articleSvc = new ArticleService();
				ArticleVO articleVO = articleSvc.getOneArticle(articleno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("articleVO", articleVO);         // 資料庫取出的articleVO物件,存入req
				String url = "/front-end/article/update_article_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_article_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/article/listAllArticle.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_article_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer articleno = new Integer(req.getParameter("articleno").trim());

Integer memberno = new Integer(req.getParameter("memberno").trim());


//				Integer memberno = 1;
//				try {
//memberno = new Integer(req.getParameter("memberno").trim());
//				} catch (NumberFormatException e) {
//					memberno = 0;
//					errorMsgs.add("會員編號請填數字.");
//				}
				
				
String articletype = req.getParameter("articletype").trim();
				if (articletype == null || articletype.trim().length() == 0) {
					errorMsgs.add("文章類型請勿空白");
				}	
				
String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("文章內容請勿空白");
				}				
				
String articleheadline = req.getParameter("articleheadline").trim();
				if (articleheadline == null || articleheadline.trim().length() == 0) {
					errorMsgs.add("文章標題請勿空白");
				}
				ArticleService articleSvc1 = new ArticleService();
				ArticleVO articleVO1 = articleSvc1.getOneArticle(articleno);
				java.sql.Timestamp crtdt = articleVO1.getCrtdt();
				
//				ArticleDAO dao = new ArticleDAO();
//				ArticleVO articleVO1 = dao.findByPrimaryKey(articleno);
//				
//				java.sql.Timestamp crtdt = articleVO1.getCrtdt();
//				try {
//crtdt = java.sql.Timestamp.valueOf(req.getParameter("crtdt").trim());
//				} catch (IllegalArgumentException e) {
//					crtdt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
//				crtdt = new java.sql.Timestamp(System.currentTimeMillis());

				java.sql.Timestamp updatedt = null;
//				try {
//updatedt = java.sql.Timestamp.valueOf(req.getParameter("updatedt").trim());
//				} catch (IllegalArgumentException e) {
//					updatedt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
				updatedt = new java.sql.Timestamp(System.currentTimeMillis());
				
				Integer status = 0;
				
//				ArticleService articleSvc1 = new ArticleService();
//				ArticleVO articleVO2 = articleSvc1.getOneArticle(articleno);	
				Integer likecount = articleVO1.getLikecount();
				
//				Integer likecount = 0; 
//Integer status = new Integer(req.getParameter("status").trim());
				
//Integer likecount = new Integer(req.getParameter("likecount").trim());

//				Integer status = null;
//				try {
//status = new Integer(req.getParameter("status").trim());
//				} catch (NumberFormatException e) {
//					status = 0;
//					errorMsgs.add("文章狀態請填數字.");
//				}
//				
//				Integer likecount = null;
//				try {
//likecount = new Integer(req.getParameter("likecount").trim());
//				} catch (NumberFormatException e) {
//					likecount = 0;
//					errorMsgs.add("文章讚數請填數字.");
//				}


				ArticleVO articleVO = new ArticleVO();

				articleVO.setArticleno(articleno);
				articleVO.setMemberno(memberno);
				articleVO.setArticletype(articletype);
				articleVO.setContent(content);
				articleVO.setArticleheadline(articleheadline);
				articleVO.setCrtdt(crtdt);
				articleVO.setUpdatedt(updatedt);
				articleVO.setStatus(status);
				articleVO.setLikecount(likecount);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("articleVO", articleVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/article/update_article_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ArticleService articleSvc = new ArticleService();
				articleVO = articleSvc.updateArticle(articleno, memberno, articletype, content, articleheadline,crtdt, updatedt,status,likecount);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("articleVO", articleVO); // 資料庫update成功後,正確的的articleVO物件,存入req
//				String url = "/article/listOneArticle.jsp";
//				String url = "/front-end/article/listOneArticle2.jsp?articleno=" + articleno;
				String url = req.getParameter("requestURL"); //接到update_article_input.jsp的來源網址
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneAarticle2.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/article/update_article_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addArticle.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//Integer articleno = new Integer(req.getParameter("articleno").trim());

				Integer memberno = null;
				try {
memberno = new Integer(req.getParameter("memberno").trim());
				} catch (NumberFormatException e) {
					memberno = 0;
					errorMsgs.add("會員編號請填數字.");
				}
				
String articletype = req.getParameter("articletype").trim();
				if (articletype == null || articletype.trim().length() == 0) {
					errorMsgs.add("文章類型請勿空白");
				}	
				
String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("文章內容請勿空白");
				}				
				
String articleheadline = req.getParameter("articleheadline").trim();
				if (articleheadline == null || articleheadline.trim().length() == 0) {
					errorMsgs.add("文章標題請勿空白");
				}
				
				java.sql.Timestamp crtdt = null;
//				try {
//crtdt = java.sql.Timestamp.valueOf(req.getParameter("crtdt").trim());
//				} catch (IllegalArgumentException e) {
//					crtdt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
				crtdt = new java.sql.Timestamp(System.currentTimeMillis());

				java.sql.Timestamp updatedt = null;
//				try {
//updatedt = java.sql.Timestamp.valueOf(req.getParameter("updatedt").trim());
//				} catch (IllegalArgumentException e) {
//					updatedt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				Integer status = 0;
//				try {
//status = new Integer(req.getParameter("status").trim());
//				} catch (NumberFormatException e) {
//					status = 0;
//					errorMsgs.add("文章狀態請填數字.");
//				}
				Integer likecount = 0;
//				try {
//likecount = new Integer(req.getParameter("likecount").trim());
//				} catch (NumberFormatException e) {
//					likecount = 0;
//					errorMsgs.add("文章讚數請填數字.");
//				}
				

				ArticleVO articleVO = new ArticleVO();

//				articleVO.setArticleno(articleno);
				articleVO.setMemberno(memberno);
				articleVO.setArticletype(articletype);
				articleVO.setContent(content);
				articleVO.setArticleheadline(articleheadline);
				articleVO.setCrtdt(crtdt);
				articleVO.setUpdatedt(updatedt);
				articleVO.setStatus(status);
				articleVO.setLikecount(likecount);
				
				System.out.println("content =" + content);
				System.out.println("articleheadline =" +articleheadline);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("articleVO", articleVO); // 含有輸入格式錯誤的articleVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/article/addArticle.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ArticleService articleSvc = new ArticleService();
				articleVO = articleSvc.addArticle(memberno, articletype, content, articleheadline, crtdt, updatedt, status, likecount);				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/article/listAllArticle.jsp";
//				String url = req.getParameter("requestURL");
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllArticle.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/article/addArticle.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllArticle.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer articleno = new Integer(req.getParameter("articleno"));
				
				/***************************2.開始刪除資料***************************************/
				ArticleService articleSvc = new ArticleService();
				articleSvc.deleteArticle(articleno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/article/listAllArticle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/article/listAllArticle.jsp");
				failureView.forward(req, res);
			}
		}
		if ("listReplys_ByArticleno_A".equals(action) || "listReplys_ByArticleno_B".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer articleno = new Integer(req.getParameter("articleno"));
				
				/*************************** 2.開始查詢資料 ****************************************/			
				ArticleService articleSvc = new ArticleService();
				Set<ReplyVO> set = articleSvc.getReplysByArticleno(articleno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listReplys_ByArticleno", set);    // 資料庫取出的list物件,存入request

				String url = null;
				if ("listReplys_ByArticleno_A".equals(action))
					url = "/front-end/article/listReplys_ByArticleno.jsp";        // 成功轉交 dept/listEmps_ByDeptno.jsp
				else if ("listReplys_ByArticleno_B".equals(action))
					url = "/front-end/article/listAllArticle.jsp";              // 成功轉交 dept/listAllDept.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		if ("getOne_From06".equals(action)) {

			try {
				// Retrieve form parameters.
				Integer articleno = new Integer(req.getParameter("articleno"));

				ArticleDAO dao = new ArticleDAO();
				ArticleVO articleVO = dao.findByPrimaryKey(articleno);

				req.setAttribute("articleVO", articleVO); // 資料庫取出的empVO物件,存入req
				
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				// 取出的empVO送給listOneEmp.jsp
				RequestDispatcher successView = req
						.getRequestDispatcher("/front-end/article/listAllArticle.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		if ("listArticles_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
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
				ArticleService articleSvc = new ArticleService();
				List<ArticleVO> list  = articleSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listArticles_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/article/listArticles_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/article/listAllArticle.jsp");
				failureView.forward(req, res);
			}
		}
	
	}
	
	
}
