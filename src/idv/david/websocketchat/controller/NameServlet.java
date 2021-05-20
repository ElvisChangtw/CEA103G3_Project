package idv.david.websocketchat.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NameServlet extends HttpServlet {
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String userName = req.getParameter("userName");
		
//		Integer member_no = new Integer(req.getParameter("member_no"));
		
//		RelationshipService relationshipSvc = new RelationshipService();
//		RelationshipVO relationshipVO = (RelationshipVO) relationshipSvc.getAllFriendno(member_no);
//		
	
//		list=VO.friend   把這個會員的有哪些好友用VO存到list
//		friend_memberNO  在VO取memberno的好友出來做比對  
//		friendMap= (foreach(session)Map=friend_memberNO) 
//		會員的好友用以存的list跟原本的sessionsMap做比對，正確的話再存成friendMap顯示
		
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
