package com.comment.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import com.movie.model.MovieVO;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Comment;

public class CommentDAO implements CommentDAO_interface{
	
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
			"insert into COMMENT (MEMBER_NO,MOVIE_NO,CONTENT,STATUS) values (?, ?, ?, ?)";
	private static final String UPDATE_STMT = 
			"update COMMENT set CONTENT=?, MOVIE_NO=?, MODIFY_DT=default where COMMENT_NO = ?";
	private static final String UPDATE_COMMENTSTATUS_OFF_STMT = 
			"update COMMENT set STATUS=1 where COMMENT_NO = ?";
	private static final String UPDATE_COMMENTSTATUS_ON_STMT = 
			"update COMMENT set STATUS=0 where COMMENT_NO = ?";
	private static final String DELETE_REPORTCOMMENTS = 
			"delete from REPORT_COMMENT where COMMENT_NO = ?";	
	private static final String DELETE_COMMENT = 
			"delete from COMMENT where COMMENT_NO = ?";
	private static final String GET_ONE_STMT = 
			"select * from COMMENT where COMMENT_NO = ?";
	private static final String GET_ALL_STMT = 
			"select * from COMMENT order by COMMENT_NO";
	private static final String GET_MOVIE_COMMENT_STMT = 
			"select * from COMMENT where MOVIE_NO = ? and STATUS = 0 order by CRT_DT desc";
//	private static final String GET_MEMBER_COMMENT_STMT = 
//	"select * from COMMENT where MEMBER_NO = ?";
	private static final String GET_MOVIE_COMMENT_BY_MEM = 
			"select * from COMMENT where MEMBER_NO = ?";
	private static final String UPDATE_BY_COMMENTNO_STMT = 
			"update COMMENT set CONTENT=? where COMMENT_NO = ?";
	
	
	
	@Override
	public void insert(CommentVO commentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, commentVO.getMemberno());
			pstmt.setInt(2, commentVO.getMovieno());
			pstmt.setString(3, commentVO.getContent());
			pstmt.setString(4, commentVO.getStatus());

			pstmt.executeUpdate();

			// Handle any SQL errors
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
	public void update(CommentVO commentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, commentVO.getContent());
			pstmt.setInt(2, commentVO.getMovieno());
			pstmt.setInt(3, commentVO.getCommentno());

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
	public void updateCommentStatusOff(CommentVO commentVO , Connection con) {
		
		PreparedStatement pstmt = null;

		try {
     		pstmt = con.prepareStatement(UPDATE_COMMENTSTATUS_OFF_STMT);

			pstmt.setDouble(1, commentVO.getCommentno());	
			
			pstmt.executeUpdate();
//			System.out.println("11");	
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
		}
	}
	
	@Override
	public void updateCommentStatusOn(CommentVO commentVO , Connection con) {
		
		PreparedStatement pstmt = null;

		try {
     		pstmt = con.prepareStatement(UPDATE_COMMENTSTATUS_ON_STMT);

			pstmt.setDouble(1, commentVO.getCommentno());	
			
			pstmt.executeUpdate();
//			System.out.println("11");	
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
		}
	}
	
//	@Override
//	public void delete(Integer commentno) {
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(DELETE_STMT);
//
//			pstmt.setInt(1, commentno);
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
//	}
	
	@Override
	public void delete(Integer commentno) {
		int updateCount_ReportComments = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();

			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);

			// 先刪除檢舉評論
			pstmt = con.prepareStatement(DELETE_REPORTCOMMENTS);
			pstmt.setInt(1, commentno);
			updateCount_ReportComments = pstmt.executeUpdate();
			// 再刪除評論
			pstmt = con.prepareStatement(DELETE_COMMENT);
			pstmt.setInt(1, commentno);
			pstmt.executeUpdate();

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除評論編號" + commentno + "時,共有檢舉評論" + updateCount_ReportComments
					+ "則同時被刪除");
			
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
	public CommentVO findByPrimaryKey(Integer commentno) {
		
		CommentVO commentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, commentno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// commentVo 也稱為 Domain objects
				commentVO = new CommentVO();
				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
				commentVO.setContent(rs.getString("CONTENT"));
				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				commentVO.setStatus(rs.getString("STATUS"));
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
		return commentVO;
	}
	
//	@Override
//	public List<CommentVO> findByMemberNo(Integer memberno) {
//		List<CommentVO> list = new ArrayList<CommentVO>();
//		CommentVO commentVO = null;
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_MEMBER_COMMENT_STMT);
//
//			pstmt.setInt(1, memberno);
//
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// commentVo 也稱為 Domain objects
//				commentVO = new CommentVO();
//				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
//				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
//				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
//				commentVO.setContent(rs.getString("CONTENT"));
//				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
//				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
//				commentVO.setStatus(rs.getString("STATUS"));
//				list.add(commentVO);
//			}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
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
//		return list;
//	}


	@Override
	public List<CommentVO> getAll() {
		List<CommentVO> list = new ArrayList<CommentVO>();
		CommentVO commentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// commentVO 也稱為 Domain objects
				commentVO = new CommentVO();
				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
				commentVO.setContent(rs.getString("CONTENT"));
				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				commentVO.setStatus(rs.getString("STATUS"));
				list.add(commentVO); // Store the row in the list
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
	public List<CommentVO> getAll(Map<String, String[]> map) {
		List<CommentVO> list = new ArrayList<CommentVO>();
		CommentVO commentVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from COMMENT "
		          + jdbcUtil_CompositeQuery_Comment.get_WhereCondition(map)
		          + "order by COMMENT_NO desc";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				commentVO = new CommentVO();
				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
				commentVO.setContent(rs.getString("CONTENT"));
				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				commentVO.setStatus(rs.getString("STATUS"));
				list.add(commentVO); // Store the row in the List
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
	
	
	@Override
	public List<CommentVO> findByMovieNo(Integer movieno) {
		List<CommentVO> list = new ArrayList<CommentVO>();
		CommentVO commentVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MOVIE_COMMENT_STMT);

			pstmt.setInt(1, movieno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// commentVo 也稱為 Domain objects
				commentVO = new CommentVO();
				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
				commentVO.setContent(rs.getString("CONTENT"));
				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				commentVO.setStatus(rs.getString("STATUS"));
				list.add(commentVO);
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
	public List<CommentVO> findByMemberNo(Integer memberno) {
		List<CommentVO> list = new ArrayList<CommentVO>();
		CommentVO commentVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MOVIE_COMMENT_BY_MEM);

			pstmt.setInt(1, memberno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// commentVo 也稱為 Domain objects
				commentVO = new CommentVO();
				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
				commentVO.setContent(rs.getString("CONTENT"));
				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				commentVO.setStatus(rs.getString("STATUS"));
				list.add(commentVO);
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
	public void update_bycommentno(CommentVO commentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_BY_COMMENTNO_STMT);
			
			pstmt.setString(1, commentVO.getContent());
			pstmt.setInt(2, commentVO.getCommentno());

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
}
