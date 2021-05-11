package com.relationship.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.omg.CORBA.PUBLIC_MEMBER;

import com.relationship.model.*;

public class RelationshipServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("member_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�T���s��");
				}
				
				String str2 = req.getParameter("friend_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�T���s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}

				Integer member_no = null;
				try {
					member_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("�T���s���榡�����T");
				}
				
				Integer friend_no = null;
				try {
					friend_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("�T���s���榡�����T");
				}
				// Send the user back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��(�I�smodel, ����h�s��*****************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				RelationshipVO relationshipVO = relationshipSvc.getOneRelationship(member_no, friend_no);
				if (relationshipVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("relationshipVO", relationshipVO); // ��Ʈw���X��messageVO����,�s�Jreq
			
				String url = "/front-end/relationship/listOneRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneMessage.jsp
				successView.forward(req, res);
				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllMessage.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer member_no = new Integer(req.getParameter("member_no"));
				Integer friend_no = new Integer(req.getParameter("friend_no"));
				/***************************2.�}�l�d�߸��****************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				RelationshipVO relationshipVO = relationshipSvc.getOneRelationship(member_no, friend_no);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("relationshipVO", relationshipVO); 

				// ��Ʈw���X��messageVO����,�s�Jreq
				String url = "/front-end/relationship/update_relationship_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_message_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/listAllRelationship.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // �Ӧ�update_message_input.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				Integer friend_no = new Integer(req.getParameter("friend_no").trim());
				

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					status = "0";
					errorMsgs.add("���A�ФŪť�");
				}
				
				String isBlock = req.getParameter("isBlock").trim();
				if (isBlock == null || isBlock.trim().length() == 0) {
					isBlock = "0";
					errorMsgs.add("�O�_����ФŪť�");
				}
				
				
				RelationshipVO relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(member_no);;
				relationshipVO.setFriend_no(friend_no);
				relationshipVO.setStatus(status);
				relationshipVO.setIsblock(isBlock);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("relationshipVO", relationshipVO); // �t����J�榡���~��messageVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/update_relationship_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}

				/***************************2.�}�l�ק���*****************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				relationshipVO = relationshipSvc.updateRelationship(member_no, friend_no, status, isBlock);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("relationshipVO", relationshipVO); // ��Ʈwupdate���\��,���T����messageVO����,�s�Jreq
				
				
				String url = "/front-end/relationship/listOneRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneMessage.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/update_relationship_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // �Ӧ�addMessage.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				Integer member_no =null;
				try {
					member_no = new Integer(req.getParameter("member_no").trim());
				} catch (NumberFormatException e) {
					member_no = 0;
					errorMsgs.add("�ж�J���T���|���s��");
				}
				
				
				Integer friend_no =null;
				try {
					friend_no = new Integer(req.getParameter("friend_no").trim());
				} catch (NumberFormatException e) {
					friend_no = 0;
					errorMsgs.add("�ж�J���T���|���s��");
				}
//				�H�W����O�]��addXXX.jsp�S����user��Jmessage_no,�|������ȵL�k����


				RelationshipVO relationshipVO = new RelationshipVO();
				
				relationshipVO.setMember_no(member_no);
				relationshipVO.setFriend_no(friend_no);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("relationshipVO", relationshipVO); // �t����J�榡���~��messageVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationshipVO/addRelationship.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.�}�l�s�W���***************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				relationshipVO = relationshipSvc.add(member_no, friend_no);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/front-end/relationship/listAllRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllMessage.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/addRelationship.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // �Ӧ�listAllMessage.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				Integer member_no = new Integer(req.getParameter("member_no"));
				Integer friend_no = new Integer(req.getParameter("friend_no"));
				/***************************2.�}�l�R�����***************************************/
				RelationshipService relatioinshipSvc = new RelationshipService();
				relatioinshipSvc.deleteRelationship(member_no, friend_no);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								
				String url = "/front-end/relationship/listAllRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/listAllRelationship.jsp");
				failureView.forward(req, res);
			}	
		}
	}
}
