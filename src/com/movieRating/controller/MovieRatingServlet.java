package com.movieRating.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.movieRating.model.MovieRatingService;
import com.movieRating.model.MovieRatingVO;


@WebServlet("/MovieRatingServlet")
public class MovieRatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=Big5");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				Integer movie_no = new Integer(req.getParameter("movie_no").trim());
				Float rating = new Float(req.getParameter("rating").trim());
				
				MovieRatingVO ratingVO = new MovieRatingVO();
				ratingVO.setMovie_no(movie_no);
				ratingVO.setMember_no(member_no);
				ratingVO.setRating(rating);

				
				MovieRatingService ratingSvc = new MovieRatingService();
				ratingVO = ratingSvc.addMovieRating(movie_no, member_no, rating);
				
				List<MovieRatingVO>list=new ArrayList<MovieRatingVO>();
				list = ratingSvc.getAllRating(member_no);
				req.setAttribute("list", list);
				
				
				MemVO memVO = new MemVO();
				MemService memSvc = new MemService();
				memVO=memSvc.getOneMem(member_no);
				req.setAttribute("memVO", memVO);
				
				
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				successView.forward(req, res);
				
				
			}catch(Exception e){
				errorMsgs.add("電影評分新增失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}
		if("list_rating_by_memno".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				MovieRatingService ratingSvc = new MovieRatingService();

				
				//設session傳memVO，有等入系統後刪掉
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(member_no);
				req.getSession().setAttribute("memVO", memVO);
				
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				successView.forward(req, res);
			}catch(Exception e){
				errorMsgs.add("查看電影評分失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if("update".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				Integer movie_no = new Integer(req.getParameter("movie_no").trim());
				Float rating = new Float(req.getParameter("rating").trim());
				System.out.println(member_no);
				System.out.println(movie_no);
				System.out.println(rating);
				
				MovieRatingService ratingSvc = new MovieRatingService();
				ratingSvc.updateMovieRating(movie_no,member_no, rating);
				
				out.print("success");
			}catch(Exception e) {
				out.print("fail");
				errorMsgs.add("電影評分修改失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
		}
		if("delete_rating".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				Integer movie_no = new Integer(req.getParameter("movie_no").trim());
				
				MovieRatingService ratingSvc = new MovieRatingService();
				ratingSvc.deleteMovieRating(movie_no,member_no);
				
				out.print("success");
			}catch(Exception e) {
				out.print("fail");
				errorMsgs.add("電影評分刪除失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
		}
		
	}

}
