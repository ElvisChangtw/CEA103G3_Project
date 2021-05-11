package com.like.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.article.model.ArticleDAO;
import com.article.model.ArticleService;
import com.article.model.ArticleVO;

public class LikeDAO implements LikeDAO_interface{
	
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
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
			"INSERT INTO `like` (article_no,member_no) VALUES (?,?)";
		private static final String GET_ALL_STMT = 
			"SELECT * FROM `like` order by article_no, member_no";
		private static final String GET_ONE_STMT = 
			"SELECT article_no,member_no FROM `like` where article_no = ? and member_no =?";
		private static final String DELETE = 
			"DELETE FROM `like` where article_no = ? and member_no =?";
		private static final String UPDATE = 
			"UPDATE `like` set article_no = ?,member_no=? where article_no = ? and member_no =?";
		private static final String SELECT_INSERT_OR_UPDATE_STMT = 
				"select IF(EXISTS(select * from `like` where article_no = ? and member_no = ?),'update','insert' )as `action`";
		private static final String GET_LIKE_BY_ARTICLE_STMT = 
				"select count(*) from `like` where article_no = ?";
		
	
	public void insert(LikeVO likeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, likeVO.getArticleno());
			pstmt.setInt(2, likeVO.getMemberno());


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
	public void update(LikeVO likeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, likeVO.getMemberno());
			pstmt.setInt(2, likeVO.getArticleno());

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
	public void delete(Integer articleno,Integer memberno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, articleno);
			pstmt.setInt(2, memberno);


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
	public LikeVO findByPrimaryKey(Integer articleno,Integer memberno) {
		LikeVO likeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, articleno);
			pstmt.setInt(2, memberno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				likeVO = new LikeVO();
				likeVO.setArticleno(rs.getInt("article_no"));
				likeVO.setMemberno(rs.getInt("member_no"));

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
		return likeVO;
	}


	public List<LikeVO> getAll() {
		List<LikeVO> list = new ArrayList<LikeVO>();
		LikeVO likeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				likeVO = new LikeVO();
				likeVO.setArticleno(rs.getInt("article_no"));
				likeVO.setMemberno(rs.getInt("member_no"));
				list.add(likeVO); // Store the row in the list
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
	public void insertLikeAndUpdateLikeCount(LikeVO likeVO) {
		//回傳值true是+1 , false是-1
		
		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;	
		ResultSet rs = null;
		boolean returnValue = true;
		//為了同時更新文章按讚數, 引入article service
		ArticleService articleSvc = new ArticleService();
		
		
		try {

			con = ds.getConnection();			
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			
			//先搜尋是否有這筆評分
			pstmt1 = con.prepareStatement(SELECT_INSERT_OR_UPDATE_STMT);	
			pstmt1.setInt(1, likeVO.getArticleno());
			pstmt1.setInt(2, likeVO.getMemberno());
			rs = pstmt1.executeQuery();
			//再判斷是要新增還是更新
			rs.next();
			if(rs.getString("action").equals("insert")) {
				pstmt2 = con.prepareStatement(INSERT_STMT);			
				pstmt2.setInt(1, likeVO.getArticleno());
				pstmt2.setInt(2, likeVO.getMemberno());
				pstmt2.executeUpdate();	
				
				// 再同時更新文章表格的讚數 +1
				articleSvc.addArticleLike(likeVO.getArticleno() ,con);
				returnValue = true;
			}else {
				pstmt2 = con.prepareStatement(DELETE);	
				pstmt2.setInt(1, likeVO.getArticleno());
				pstmt2.setInt(2, likeVO.getMemberno());
				pstmt2.executeUpdate();	
				// 再同時更新文章表格的讚數 -1
				articleSvc.subtractArticleLike(likeVO.getArticleno() ,con);
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

