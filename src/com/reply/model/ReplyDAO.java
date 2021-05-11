package com.reply.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Reply;

public class ReplyDAO implements ReplyDAO_interface{
	
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
			"INSERT INTO reply (article_no,member_no,content,crt_dt,modify_dt,`status`) VALUES (?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT reply_no,article_no,member_no,content,crt_dt,modify_dt,`status` FROM reply order by reply_no;";
		private static final String GET_ONE_STMT = 
			"SELECT reply_no,article_no,member_no,content,crt_dt,modify_dt,`status` FROM reply where reply_no = ?";
		private static final String DELETE = 
			"DELETE FROM reply where reply_no = ?";
		private static final String UPDATE = 
			"UPDATE reply set article_no=?,member_no=?,content=?,crt_dt=?,modify_dt=?,`status`=? where reply_no = ?";

		public void insert(ReplyVO replyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, replyVO.getArticle_no());
			pstmt.setInt(2, replyVO.getMember_no());
			pstmt.setString(3, replyVO.getContent());
			pstmt.setTimestamp(4, replyVO.getCrt_dt());
			pstmt.setTimestamp(5, replyVO.getModify_dt());
			pstmt.setInt(6, replyVO.getStatus());


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
	public void update(ReplyVO replyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, replyVO.getArticle_no());
			pstmt.setInt(2, replyVO.getMember_no());
			pstmt.setString(3, replyVO.getContent());
			pstmt.setTimestamp(4, replyVO.getCrt_dt());
			pstmt.setTimestamp(5, replyVO.getModify_dt());
			pstmt.setInt(6, replyVO.getStatus());
			pstmt.setInt(7, replyVO.getReply_no());

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
	public void delete(Integer replyno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, replyno);

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
	public ReplyVO findByPrimaryKey(Integer replyno) {
		ReplyVO replyVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, replyno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// replyVO 也稱為 Domain objects
				replyVO = new ReplyVO();
				replyVO.setReply_no(rs.getInt("reply_no"));
				replyVO.setArticle_no(rs.getInt("article_no"));
				replyVO.setMember_no(rs.getInt("member_no"));
				replyVO.setContent(rs.getString("content"));
				replyVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				replyVO.setModify_dt(rs.getTimestamp("modify_dt"));
				replyVO.setStatus(rs.getInt("status"));

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
		return replyVO;
	}


	public List<ReplyVO> getAll() {
		List<ReplyVO> list = new ArrayList<ReplyVO>();
		ReplyVO replyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects

				replyVO = new ReplyVO();
				replyVO.setReply_no(rs.getInt("reply_no"));
				replyVO.setArticle_no(rs.getInt("article_no"));
				replyVO.setMember_no(rs.getInt("member_no"));
				replyVO.setContent(rs.getString("content"));
				replyVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				replyVO.setModify_dt(rs.getTimestamp("modify_dt"));
				replyVO.setStatus(rs.getInt("status"));
				list.add(replyVO); // Store the row in the list
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
	public List<ReplyVO> getAll(Map<String, String[]> map) {
		List<ReplyVO> list = new ArrayList<ReplyVO>();
		ReplyVO replyVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {			
			con = ds.getConnection();
			String finalSQL = "select * from reply "
		          + jdbcUtil_CompositeQuery_Reply.get_WhereCondition(map);
//		          + "order by replyno";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
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
				list.add(replyVO); // Store the row in the List
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


