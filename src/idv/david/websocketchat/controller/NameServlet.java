package idv.david.websocketchat.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NameServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		
		if ("ueser".equals(action)) {
			
		String userName = req.getParameter("userName");
		
//		Integer member_no = new Integer(req.getParameter("member_no"));
		
//		RelationshipService relationshipSvc = new RelationshipService();
//		RelationshipVO relationshipVO = (RelationshipVO) relationshipSvc.getAllFriendno(member_no);
//		
	
//		list=VO.friend   ��������鈭末��VO摮list
//		friend_memberNO  �VO��emberno��末��靘����  
//		friendMap= (foreach(session)Map=friend_memberNO) 
//		����末��隞亙��ist頝���essionsMap�����迤蝣箇�店����riendMap憿舐內
		
//		for(RelationshipVO relationshipVO  : List1) {
//			if(sessionsMap == relationshipVO) {
//				
//			}	
//		}
//		for(int i = 0; i < list1.size(); i++) {
//		for(int j = 0; j < userNames.size();j++) {
//			if(list1.get(i).getMember_no() )
//		}
//	}
		
		req.setAttribute("userName", userName);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/chat.jsp");
		dispatcher.forward(req, res);
		}
	}
}
