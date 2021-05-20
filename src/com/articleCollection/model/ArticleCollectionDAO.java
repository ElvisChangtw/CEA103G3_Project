package com.articleCollection.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.like.model.LikeVO;
import com.notify.model.NotifyVO;

public class ArticleCollectionDAO implements ArticleCollectionDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO articlecollection (article_no, member_no) VALUES (?, ?)";
	private static final String DELETE = 
			"DELETE FROM articlecollection where article_no = ? and member_no = ? ";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM articlecollection where member_no = ? ";
	private static final String GET_ONE_STMT1 = 
			"SELECT * FROM articlecollection where article_no = ? and member_no = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM articlecollection order by article_no";
	private static final String SELECT_INSERT_OR_DELETE_STMT = 
			"select IF(EXISTS(select * from articlecollection where article_no = ? and member_no = ?),'delete','insert' )as `action`";
	
	
	
	@Override
	public void insert(ArticleCollectionVO articleCollectionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, articleCollectionVO.getArticle_no());
			pstmt.setInt(2, articleCollectionVO.getMember_no());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	@Override
	public void delete(Integer article_no, Integer member_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, article_no);
			pstmt.setInt(2, member_no);


			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	@Override
	public List<ArticleCollectionVO> findByPrimaryKey(Integer member_no) {
		ArticleCollectionVO articleCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ArticleCollectionVO> list = new ArrayList<ArticleCollectionVO>();
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, member_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				articleCollectionVO = new ArticleCollectionVO();
				articleCollectionVO.setArticle_no(rs.getInt("article_no"));
				articleCollectionVO.setMember_no(rs.getInt("member_no"));
				articleCollectionVO.setCrt_dt(rs.getDate("crt_dt"));
				list.add(articleCollectionVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	@Override
	public List<ArticleCollectionVO> getAll() {
		List<ArticleCollectionVO> list = new ArrayList<ArticleCollectionVO>();
		ArticleCollectionVO articleCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				articleCollectionVO = new ArticleCollectionVO();
				articleCollectionVO.setArticle_no(rs.getInt("article_no"));
				articleCollectionVO.setMember_no(rs.getInt("member_no"));
				articleCollectionVO.setCrt_dt(rs.getDate("crt_dt"));
				list.add(articleCollectionVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	@Override
	public ArticleCollectionVO findByPrimaryKey(Integer article_no, Integer member_no) {
		ArticleCollectionVO articleCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT1);

			pstmt.setInt(1, article_no);
			pstmt.setInt(2, member_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				articleCollectionVO = new ArticleCollectionVO();
				articleCollectionVO.setArticle_no(rs.getInt("article_no"));
				articleCollectionVO.setMember_no(rs.getInt("member_no"));

			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return articleCollectionVO;
	}
	@Override
	public void insertArticlCollectionAndDelete(ArticleCollectionVO articleCollectionVO) {

		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;	
		ResultSet rs = null;

		try {

			con = ds.getConnection();			
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			
			//先搜尋是否有這筆評分
			pstmt1 = con.prepareStatement(SELECT_INSERT_OR_DELETE_STMT);	
			pstmt1.setInt(1, articleCollectionVO.getArticle_no());
			pstmt1.setInt(2, articleCollectionVO.getMember_no());

			rs = pstmt1.executeQuery();
			
			//再判斷是要新增還是更新
			rs.next();
			if(rs.getString("action").equals("insert")) {
				pstmt2 = con.prepareStatement(INSERT_STMT);			
				pstmt2.setInt(1, articleCollectionVO.getArticle_no());
				pstmt2.setInt(2, articleCollectionVO.getMember_no());
//				pstmt2.setDate(3, articleCollectionVO.getCrt_dt());
				pstmt2.executeUpdate();	
			}else {
				pstmt2 = con.prepareStatement(DELETE);	
				pstmt2.setInt(1, articleCollectionVO.getArticle_no());
				pstmt2.setInt(2, articleCollectionVO.getMember_no());
//				pstmt2.setDate(3, articleCollectionVO.getCrt_dt());
				pstmt2.executeUpdate();	
			}				
	
			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			
			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("------------------------------------Transaction is being ");
					System.err.println("rolled back-由-rating");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt1 != null) {
				try {
					pstmt1.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
}
