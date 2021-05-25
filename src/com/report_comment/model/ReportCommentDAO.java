package com.report_comment.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import com.comment.model.*;


public class ReportCommentDAO implements ReportCommentDAO_interface{
	
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
			"insert into REPORT_COMMENT (COMMENT_NO,CONTENT,CRT_DT,MEMBER_NO,EXECUTE_DT,STATUS) values (?, ?, default, ?, null, 0)";
	private static final String UPDATE_STMT = 
			"update REPORT_COMMENT set EXECUTE_DT=default, STATUS=?, `DESC`=? where REPORT_NO = ?";
	private static final String UPDATE_ALL_REPORT_FROM_THISCOMMENT_STMT = 
			"update REPORT_COMMENT set EXECUTE_DT=default, STATUS=?, `DESC`=? where COMMENT_NO = ?";
	private static final String SELECT_REPORT_OR_NOTREPORT_STMT = 
			"select IF(EXISTS(select * from REPORT_COMMENT where COMMENT_NO = ? and `STATUS` = 1),'report','notreport') as `action`";
	private static final String DELETE_STMT = 
			"delete from REPORT_COMMENT where REPORT_NO = ?";
	private static final String GET_ONE_STMT = 
			"select * from REPORT_COMMENT where REPORT_NO = ?";	
	private static final String GET_ALL_STMT = 
			"select * from REPORT_COMMENT order by REPORT_NO desc";
	private static final String GET_ALL_OrderByReport_STMT = 
			"select * from REPORT_COMMENT";
	
	@Override
	public void insert(ReportCommentVO reportcommentVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, reportcommentVO.getCommentno());
			pstmt.setString(2, reportcommentVO.getContent());
			pstmt.setInt(3, reportcommentVO.getMemberno());

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
	public void update(ReportCommentVO reportcommentVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, reportcommentVO.getStatus());
			pstmt.setString(2, reportcommentVO.getDesc());
			pstmt.setInt(3, reportcommentVO.getReportno());

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
	public void updateAllReportFromThisComment(ReportCommentVO reportcommentVO) {
		
		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;	
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			
			con.setAutoCommit(false);
			//先更新這筆檢舉
			pstmt1 = con.prepareStatement(UPDATE_ALL_REPORT_FROM_THISCOMMENT_STMT);

			pstmt1.setString(1, reportcommentVO.getStatus());
			pstmt1.setString(2, reportcommentVO.getDesc());
			pstmt1.setInt(3, reportcommentVO.getCommentno());
			pstmt1.executeUpdate();
			
			//搜尋是這筆檢舉是否通過
			pstmt2 = con.prepareStatement(SELECT_REPORT_OR_NOTREPORT_STMT);	
			pstmt2.setInt(1, reportcommentVO.getCommentno());
			rs = pstmt2.executeQuery();
			
			//再判斷是否要更新評論的狀態
			rs.next();
			if(rs.getString("action").equals("report")) {
				CommentDAO dao = new CommentDAO();
				CommentVO commentVO = new CommentVO();
				commentVO.setCommentno(reportcommentVO.getCommentno());
				dao.updateCommentStatusOff(commentVO,con);
			}else {
				CommentDAO dao = new CommentDAO();
				CommentVO commentVO = new CommentVO();
				commentVO.setCommentno(reportcommentVO.getCommentno());
				dao.updateCommentStatusOn(commentVO,con);
			}
			con.commit();
			con.setAutoCommit(true);


			// Handle any driver errors
		} catch (SQLException se) {
			se.printStackTrace();
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("------------------------------------Transaction is being ");
					System.err.println("rolled back-由-reportcomment");
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
	
	@Override
	public void delete(Integer reportno) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setInt(1, reportno);

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
	public ReportCommentVO findByPrimaryKey(Integer reportno) {
		
		ReportCommentVO reportcommentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, reportno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportcommentVO 也稱為 Domain objects
				reportcommentVO = new ReportCommentVO();
				reportcommentVO.setReportno(rs.getInt("REPORT_NO"));
				reportcommentVO.setCommentno(rs.getInt("COMMENT_NO"));
				reportcommentVO.setContent(rs.getString("CONTENT"));
				reportcommentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				reportcommentVO.setMemberno(rs.getInt("MEMBER_NO"));
				reportcommentVO.setExecutedate(rs.getTimestamp("EXECUTE_DT"));
				reportcommentVO.setStatus(rs.getString("STATUS"));
				reportcommentVO.setDesc(rs.getString("DESC"));
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
		return reportcommentVO;
	}
	
	@Override
	public List<ReportCommentVO> getAll() {
		List<ReportCommentVO> list = new ArrayList<ReportCommentVO>();
		ReportCommentVO reportcommentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportcommentVO 也稱為 Domain objects
				reportcommentVO = new ReportCommentVO();
				reportcommentVO.setReportno(rs.getInt("REPORT_NO"));
				reportcommentVO.setCommentno(rs.getInt("COMMENT_NO"));
				reportcommentVO.setContent(rs.getString("CONTENT"));
				reportcommentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				reportcommentVO.setMemberno(rs.getInt("MEMBER_NO"));
				reportcommentVO.setExecutedate(rs.getTimestamp("EXECUTE_DT"));
				reportcommentVO.setStatus(rs.getString("STATUS"));
				reportcommentVO.setDesc(rs.getString("DESC"));
				list.add(reportcommentVO); // Store the row in the list
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
	public List<ReportCommentVO> getAllOrderByReportno() {
		List<ReportCommentVO> list = new ArrayList<ReportCommentVO>();
		ReportCommentVO reportcommentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_OrderByReport_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportcommentVO 也稱為 Domain objects
				reportcommentVO = new ReportCommentVO();
				reportcommentVO.setReportno(rs.getInt("REPORT_NO"));
				reportcommentVO.setCommentno(rs.getInt("COMMENT_NO"));
				reportcommentVO.setContent(rs.getString("CONTENT"));
				reportcommentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				reportcommentVO.setMemberno(rs.getInt("MEMBER_NO"));
				reportcommentVO.setExecutedate(rs.getTimestamp("EXECUTE_DT"));
				reportcommentVO.setStatus(rs.getString("STATUS"));
				reportcommentVO.setDesc(rs.getString("DESC"));
				list.add(reportcommentVO); // Store the row in the list
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
}
