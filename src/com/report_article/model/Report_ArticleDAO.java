package com.report_article.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Report_ArticleDAO implements Report_ArticleDAO_interface{
	
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
			"INSERT INTO report_article (article_no,content,crt_dt,member_no,execute_dt,`status`,`desc`) VALUES (?, ?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT report_no,article_no,content,crt_dt,member_no,execute_dt,`status`,`desc` FROM report_article order by report_no";
		private static final String GET_ONE_STMT = 
			"SELECT report_no,article_no,content,crt_dt,member_no,execute_dt,`status`,`desc` FROM report_article where report_no = ?";
		private static final String DELETE = 
			"DELETE FROM report_article where report_no = ?";
		private static final String UPDATE = 
			"UPDATE report_article set article_no=?,content=?,crt_dt=?,member_no=?,execute_dt=?,`status`=?,`desc`=? where report_no = ?";

	
	public void insert(Report_ArticleVO report_articleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, report_articleVO.getArticleno());
			pstmt.setString(2, report_articleVO.getContent());
			pstmt.setTimestamp(3, report_articleVO.getCrtdt());
			pstmt.setInt(4, report_articleVO.getMemberno());
			pstmt.setTimestamp(5, report_articleVO.getExecutedt());			
			pstmt.setInt(6, report_articleVO.getStatus());
			pstmt.setString(7, report_articleVO.getDesc());

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
	public void update(Report_ArticleVO report_articleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, report_articleVO.getArticleno());
			pstmt.setString(2, report_articleVO.getContent());
			pstmt.setTimestamp(3, report_articleVO.getCrtdt());
			pstmt.setInt(4, report_articleVO.getMemberno());
			pstmt.setTimestamp(5, report_articleVO.getExecutedt());			
			pstmt.setInt(6, report_articleVO.getStatus());
			pstmt.setString(7, report_articleVO.getDesc());
			pstmt.setInt(8, report_articleVO.getReportno());

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
			pstmt = con.prepareStatement(DELETE);

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
	public Report_ArticleVO findByPrimaryKey(Integer reportno) {
		Report_ArticleVO report_articleVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, reportno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// replyVO 也稱為 Domain objects
				report_articleVO = new Report_ArticleVO();
				report_articleVO.setReportno(rs.getInt("report_no"));
				report_articleVO.setArticleno(rs.getInt("article_no"));
				report_articleVO.setContent(rs.getString("content"));
				report_articleVO.setCrtdt(rs.getTimestamp("crt_dt"));
				report_articleVO.setMemberno(rs.getInt("member_no"));
				report_articleVO.setExecutedt(rs.getTimestamp("execute_dt"));
				report_articleVO.setStatus(rs.getInt("status"));
				report_articleVO.setDesc(rs.getString("desc"));

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
		return report_articleVO;
	}


	public List<Report_ArticleVO> getAll() {
		List<Report_ArticleVO> list = new ArrayList<Report_ArticleVO>();
		Report_ArticleVO report_articleVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects

				report_articleVO = new Report_ArticleVO();
				report_articleVO.setReportno(rs.getInt("report_no"));
				report_articleVO.setArticleno(rs.getInt("article_no"));
				report_articleVO.setContent(rs.getString("content"));
				report_articleVO.setCrtdt(rs.getTimestamp("crt_dt"));
				report_articleVO.setMemberno(rs.getInt("member_no"));
				report_articleVO.setExecutedt(rs.getTimestamp("execute_dt"));
				report_articleVO.setStatus(rs.getInt("status"));
				report_articleVO.setDesc(rs.getString("desc"));
				list.add(report_articleVO); // Store the row in the list
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


