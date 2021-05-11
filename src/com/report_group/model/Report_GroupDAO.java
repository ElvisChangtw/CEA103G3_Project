package com.report_group.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.group_member.model.Group_MemberVO;

public class Report_GroupDAO implements Report_GroupDAO_interface {

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
		"insert into report_group (group_no, content, member_no, execute_dt) values (?, ?, ?,'1900-01-01 00:00:00')";
	private static final String GET_ALL_STMT = 
		"select * from report_group order by report_no";
	private static final String GET_ONE_STMT = 
		"select * from report_group where report_no = ?";
	private static final String DELETE = 
		"delete from report_group where report_no = ?";
	private static final String UPDATE = 
		"update report_group set `status`=?, `desc` = ? where report_no = ?";

	// (新增)從狀態找檢舉
		private static final String GET_Reports_ByGroupno_STMT = "SELECT * FROM report_group where status = ? order by report_no";

	
	
	@Override
	public void insert(Report_GroupVO report_groupVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, report_groupVO.getGroup_no());
			pstmt.setString(2, report_groupVO.getContent());
			pstmt.setInt(3, report_groupVO.getMember_no());
			// Handle any SQL errors
			
			pstmt.executeUpdate();
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
	public void update(Report_GroupVO report_groupVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, report_groupVO.getStatus());
			pstmt.setString(2, report_groupVO.getDesc());
			
			pstmt.setInt(3, report_groupVO.getReport_no());
			
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
	public void delete(Integer report_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, report_no);

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
	public Report_GroupVO findByPrimaryKey(Integer reort_no) {

		Report_GroupVO report_groupVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, reort_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				report_groupVO = new Report_GroupVO();
				report_groupVO.setReport_no(rs.getInt("report_no"));
				report_groupVO.setGroup_no(rs.getInt("group_no"));
				report_groupVO.setContent(rs.getString("content"));
				report_groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				report_groupVO.setMember_no(rs.getInt("member_no"));
				report_groupVO.setExecute_dt(rs.getTimestamp("execute_dt"));
				report_groupVO.setStatus(rs.getString("status"));
				report_groupVO.setDesc(rs.getString("desc"));
				
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
		return report_groupVO;
	}

	@Override
	public List<Report_GroupVO> getAll() {
		List<Report_GroupVO> list = new ArrayList<Report_GroupVO>();
		Report_GroupVO report_groupVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				report_groupVO = new Report_GroupVO();
				report_groupVO.setReport_no(rs.getInt("report_no"));
				report_groupVO.setGroup_no(rs.getInt("group_no"));
				report_groupVO.setContent(rs.getString("content"));
				report_groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				report_groupVO.setMember_no(rs.getInt("member_no"));
				report_groupVO.setExecute_dt(rs.getTimestamp("execute_dt"));
				report_groupVO.setStatus(rs.getString("status"));
				report_groupVO.setDesc(rs.getString("desc"));
				list.add(report_groupVO); // Store the row in the list
				
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
	public Set<Report_GroupVO> getReportsByStatus(String status) {
		Set<Report_GroupVO> set = new LinkedHashSet<Report_GroupVO>();
		Report_GroupVO report_groupVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Reports_ByGroupno_STMT);
			pstmt.setString(1, status);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				report_groupVO = new Report_GroupVO();
				report_groupVO.setReport_no(rs.getInt("report_no"));
				report_groupVO.setGroup_no(rs.getInt("group_no"));
				report_groupVO.setMember_no(rs.getInt("member_no"));
				report_groupVO.setStatus(rs.getString("status"));
				report_groupVO.setContent(rs.getString("content"));
				report_groupVO.setDesc(rs.getString("desc"));
				report_groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				report_groupVO.setExecute_dt(rs.getTimestamp("execute_dt"));
				set.add(report_groupVO); // Store the row in the vector
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
}