package com.report_comment.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import com.comment.model.CommentVO;

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
			"insert into REPORT_COMMENT (COMMENT_NO,CONTENT,MEMBER_NO,EXECUTE_DT,DESC) values (?, ?, ?, null, ?)";
	private static final String UPDATE_STMT = 
			"update REPORT_COMMENT set EXECUTE_DT=default, STATUS=?, DESC=? where REPORT_NO = ?";
	private static final String DELETE_STMT = 
			"delete from REPORT_COMMENT where REPORT_NO = ?";
	private static final String GET_ONE_STMT = 
			"select * from REPORT_COMMENT where REPORT_NO = ?";	
	private static final String GET_ALL_STMT = 
			"select * from REPORT_COMMENT order by REPORT_NO";
	
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
			pstmt.setString(4, reportcommentVO.getDesc());

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
}
