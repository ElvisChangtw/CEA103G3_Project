package com.article.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.like.model.LikeVO;
import com.reply.model.ReplyVO;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Article;

public class ArticleDAO implements ArticleDAO_interface{
	
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
			"INSERT INTO article (member_no,article_type,content,article_headline,crt_dt,update_dt,`status`,like_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT article_no,member_no,article_type,content,article_headline,crt_dt,update_dt,`status`,like_count FROM article order by article_no;";
		private static final String GET_ONE_STMT = 
			"SELECT article_no,member_no,article_type,content,article_headline,crt_dt,update_dt,`status`,like_count FROM article where article_no = ?";
//		private static final String DELETE = 
//			"DELETE FROM article where article_no = ?";
		private static final String UPDATE = 
			"UPDATE article set member_no=?,article_type=?,content=?,article_headline=?,crt_dt=?,update_dt=?,`status`=?,like_count=? where article_no = ?";
		private static final String GET_Replys_ByArticleno_STMT = 
				"SELECT * FROM reply where article_no = ? order by reply_no";		
		private static final String DELETE_Replys = 
				"DELETE FROM reply where article_no = ?";
		private static final String DELETE_Artcile = 
				"DELETE FROM article where article_no = ?";	
//		private static final String UPDATE_ARTICLE_LIKE_STMT = 
//				"update ARTICLE set LIKE_COUNT=? where ARTICLE_NO = ?";
		
		private static final String ADD_ARTICLE_LIKE_STMT = 
				"update ARTICLE set LIKE_COUNT= LIKE_COUNT+1 where ARTICLE_NO = ?";
		private static final String SUBTRACT_ARTICLE_LIKE_STMT = 
				"update ARTICLE set LIKE_COUNT=LIKE_COUNT-1 where ARTICLE_NO = ?";
		private static final String GET_ARTICLE_LIKE_COUNT_5 = 
				"SELECT * FROM ARTICLE order by LIKE_COUNT desc limit 5";
		private static final String GET_LIKES_BYARTICLE_STMT = 
				"select * from `LIKE` where ARTICLE_NO = ?";
			
		
		
	public void insert(ArticleVO articleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

//			pstmt.setInt(1, articleVO.getArticleno());
			pstmt.setInt(1, articleVO.getMemberno());
			pstmt.setString(2, articleVO.getArticletype());
			pstmt.setString(3, articleVO.getContent());
			pstmt.setString(4, articleVO.getArticleheadline());
			pstmt.setTimestamp(5, articleVO.getCrtdt());
			pstmt.setTimestamp(6, articleVO.getUpdatedt());
			pstmt.setInt(7, articleVO.getStatus());
			pstmt.setInt(8, articleVO.getLikecount());


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
	public void update(ArticleVO articleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, articleVO.getMemberno());
			pstmt.setString(2, articleVO.getArticletype());
			pstmt.setString(3, articleVO.getContent());
			pstmt.setString(4, articleVO.getArticleheadline());
			pstmt.setTimestamp(5, articleVO.getCrtdt());
			pstmt.setTimestamp(6, articleVO.getUpdatedt());
			pstmt.setInt(7, articleVO.getStatus());
			pstmt.setInt(8, articleVO.getLikecount());
			pstmt.setInt(9, articleVO.getArticleno());

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
	public void addArticleLike(int articleno, Connection con) {
		PreparedStatement pstmt = null;
		try {

     		pstmt = con.prepareStatement(ADD_ARTICLE_LIKE_STMT );
			pstmt.setInt(1, articleno);
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
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
		}
	}
	
	
	@Override
	public void subtractArticleLike(int articleno, Connection con) {
		PreparedStatement pstmt = null;
		try {

     		pstmt = con.prepareStatement(SUBTRACT_ARTICLE_LIKE_STMT );
			pstmt.setInt(1, articleno);
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
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
		}
	}

//	@Override
//	public void delete(Integer articleno) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setInt(1, articleno);
//
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//
//		
//	}

	@Override
	public ArticleVO findByPrimaryKey(Integer articleno) {
		ArticleVO articleVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, articleno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				articleVO = new ArticleVO();
				articleVO.setArticleno(rs.getInt("article_no"));
				articleVO.setMemberno(rs.getInt("member_no"));
				articleVO.setArticletype(rs.getString("article_type"));
				articleVO.setContent(rs.getString("content"));
				articleVO.setArticleheadline(rs.getString("article_headline"));
				articleVO.setCrtdt(rs.getTimestamp("crt_dt"));
				articleVO.setUpdatedt(rs.getTimestamp("update_dt"));
				articleVO.setStatus(rs.getInt("status"));
				articleVO.setLikecount(rs.getInt("like_count"));

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
		return articleVO;
	}


	public List<ArticleVO> getAll() {
		List<ArticleVO> list = new ArrayList<ArticleVO>();
		ArticleVO articleVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				articleVO = new ArticleVO();
				articleVO.setArticleno(rs.getInt("article_no"));
				articleVO.setMemberno(rs.getInt("member_no"));
				articleVO.setArticletype(rs.getString("article_type"));
				articleVO.setContent(rs.getString("content"));
				articleVO.setArticleheadline(rs.getString("article_headline"));
				articleVO.setCrtdt(rs.getTimestamp("crt_dt"));
				articleVO.setUpdatedt(rs.getTimestamp("update_dt"));
				articleVO.setStatus(rs.getInt("status"));
				articleVO.setLikecount(rs.getInt("like_count"));
				list.add(articleVO); // Store the row in the list
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
	public List<ArticleVO> getArticleLikeCount() {
		List<ArticleVO> list = new ArrayList<ArticleVO>();
		ArticleVO articleVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ARTICLE_LIKE_COUNT_5);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				// empVO 也稱為 Domain objects
				articleVO = new ArticleVO();
				articleVO.setArticleno(rs.getInt("article_no"));
				articleVO.setMemberno(rs.getInt("member_no"));
				articleVO.setArticletype(rs.getString("article_type"));
				articleVO.setContent(rs.getString("content"));
				articleVO.setArticleheadline(rs.getString("article_headline"));
				articleVO.setCrtdt(rs.getTimestamp("crt_dt"));
				articleVO.setUpdatedt(rs.getTimestamp("update_dt"));
				articleVO.setStatus(rs.getInt("status"));
				articleVO.setLikecount(rs.getInt("like_count"));
				list.add(articleVO); // Store the row in the list
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
	public Set<LikeVO> getLikesByArticle(Integer articleno) {
		Set<LikeVO> set = new LinkedHashSet<LikeVO>();
		LikeVO likeVO = null;
		System.out.println("articleno = " + articleno);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_LIKES_BYARTICLE_STMT);
			pstmt.setInt(1, articleno);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				// empVO 也稱為 Domain objects
				likeVO = new LikeVO();
				System.out.println(rs.getInt("article_no"));
				System.out.println(rs.getInt("member_no"));
				likeVO.setArticleno(rs.getInt("article_no"));
				likeVO.setMemberno(rs.getInt("member_no"));
				set.add(likeVO); // Store the row in the list
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
		return set;
	}

	@Override
	public Set<ReplyVO> getReplysByArticleno(Integer articleno) {
		Set<ReplyVO> set = new LinkedHashSet<ReplyVO>();
		ReplyVO replyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Replys_ByArticleno_STMT);
			pstmt.setInt(1, articleno);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				replyVO = new ReplyVO();
				replyVO.setReply_no(rs.getInt("reply_no"));
				replyVO.setArticle_no(rs.getInt("article_no"));
				replyVO.setMember_no(rs.getInt("member_no"));
				replyVO.setContent(rs.getString("content"));
				replyVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				replyVO.setModify_dt(rs.getTimestamp("modify_dt"));
				replyVO.setStatus(rs.getInt("status"));
				set.add(replyVO);// Store the row in the vector
			}
			
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return set;
	}

	@Override
		public void delete(Integer articleno) {
			int updateCount_REPLYs = 0;

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();

				// 1●設定於 pstm.executeUpdate()之前
				con.setAutoCommit(false);

				// 先刪除員工
				pstmt = con.prepareStatement(DELETE_Replys);
				pstmt.setInt(1, articleno);
				updateCount_REPLYs = pstmt.executeUpdate();
				// 再刪除部門
				pstmt = con.prepareStatement(DELETE_Artcile);
				pstmt.setInt(1, articleno);
				pstmt.executeUpdate();

				// 2●設定於 pstm.executeUpdate()之後
				con.commit();
				con.setAutoCommit(true);
				System.out.println("刪除文章編號" + articleno + "時,共有回復" + updateCount_REPLYs
						+ "個同時被刪除");
				
				// Handle any SQL errors
			} catch (SQLException se) {
				if (con != null) {
					try {
						// 3●設定於當有exception發生時之catch區塊內
						con.rollback();
					} catch (SQLException excep) {
						throw new RuntimeException("rollback error occured. "
								+ excep.getMessage());
					}
				}
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
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
	public List<ArticleVO> getAll(Map<String, String[]> map) {
		List<ArticleVO> list = new ArrayList<ArticleVO>();
		ArticleVO articleVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {			
			con = ds.getConnection();
			String finalSQL = "select * from article "
		          + jdbcUtil_CompositeQuery_Article.get_WhereCondition(map);
//		          + "order by article_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				articleVO = new ArticleVO();
				articleVO.setArticleno(rs.getInt("article_no"));
				articleVO.setMemberno(rs.getInt("member_no"));
				articleVO.setArticletype(rs.getString("article_type"));
				articleVO.setContent(rs.getString("content"));
				articleVO.setArticleheadline(rs.getString("article_headline"));
				articleVO.setCrtdt(rs.getTimestamp("crt_dt"));
				articleVO.setUpdatedt(rs.getTimestamp("update_dt"));
				articleVO.setStatus(rs.getInt("status"));
				articleVO.setLikecount(rs.getInt("like_count"));
				list.add(articleVO); // Store the row in the List
			}
			
	
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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

		
}



