//01�� �u���d��

package com.report_comment.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.comment.model.CommentService;
import com.comment.model.CommentVO;
import com.expectation.model.ExpectationService;
import com.expectation.model.ExpectationVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.movie.model.MovieService;
import com.movie.model.MovieVO;
import com.rating.model.RatingService;
import com.rating.model.RatingVO;
import com.report_comment.model.*;

public class ReportCommentServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

		if ("getAll".equals(action)) {
			/***************************�}�l�d�߸�� ****************************************/
			ReportCommentService reportCommentSvc = new ReportCommentService();
			List<ReportCommentVO> list= reportCommentSvc.getAll();

			/***************************�d�ߧ���,�ǳ����(Send the Success view)*************/
			HttpSession session = req.getSession();
			session.setAttribute("list", list);    // ��Ʈw���X��list����,�s�Jsession
			// Send the Success view
			String url = "/back-end/report_comment/listAllReportComment.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// ���\���listAllComment2_getFromSession.jsp
			successView.forward(req, res);
			return;
		}


		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_report_comment_page.jsp���ШD //���g�b�e�� �Ҥp�����d��

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("reportno");
				if (str == null || (str.trim()).length() == 0) { //�[str == null ���bgetParameter("reportno")��reportno����ŭȪ����p
					errorMsgs.add("�п�J���|���׽s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Integer reportno = null;
				try {
					reportno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("���|���׽s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��*****************************************/
				ReportCommentDAO dao = new ReportCommentDAO();
				ReportCommentVO reportcommentVO = dao.findByPrimaryKey(reportno);
				if (reportcommentVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("reportcommentVO", reportcommentVO); // ��Ʈw���X��reportcommentVO����,�s�Jreq
				String url = "/01MVC/report_commentVAR01/listOneReportComment.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneReportComment.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
				failureView.forward(req, res);
			}
		}
		
//�s�W���|�����٥���		
		 if ("insert".equals(action)) { // �Ӧ�addComment.jsp���ШD  
				
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
System.out.println(requestURL);
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				Integer commentno = new Integer(req.getParameter("commentno").trim());
				
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("���|���e�ФŪť�");
				}

				Integer memberno = new Integer(req.getParameter("memberno").trim());
			
				
				ReportCommentVO reportcommentVO = new ReportCommentVO();
				
				reportcommentVO.setCommentno(commentno);
				reportcommentVO.setContent(content);
				reportcommentVO.setMemberno(memberno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportcommentVO", reportcommentVO);
					
					CommentService commentSvc = new CommentService();
					Integer movieno = commentSvc.getOneComment(commentno).getMovieno(); 
					
					MovieService movieSvc = new MovieService();
					MovieVO movieVO = movieSvc.getOneMovie(movieno);
					req.setAttribute("movieVO", movieVO);// �t����J�榡���~��commentVO����,�]�s�Jreq
					
					RatingService ratingSvc = new RatingService();
					RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(movieno);
					req.setAttribute("ratingCount", ratingCount);

					ExpectationService expectationSvc = new ExpectationService();
					ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(movieno);
					req.setAttribute("expectationCount", expectationCount);
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				ReportCommentService reportcommentSvc = new ReportCommentService();
				reportcommentVO = reportcommentSvc.addReportComment(commentno, content, memberno);
				
				CommentService commentSvc = new CommentService();
				Integer movieno = commentSvc.getOneComment(commentno).getMovieno(); 
				
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				req.setAttribute("movieVO", movieVO);
				
				RatingService ratingSvc = new RatingService();
				RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(movieno);
				req.setAttribute("ratingCount", ratingCount);

				ExpectationService expectationSvc = new ExpectationService();
				ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(movieno);
				req.setAttribute("expectationCount", expectationCount);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\����^�쥻����
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/comment/addComment.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
