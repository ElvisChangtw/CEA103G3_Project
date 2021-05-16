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
				// empVo ¤]ºÙ¬° Domain objects
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
}
