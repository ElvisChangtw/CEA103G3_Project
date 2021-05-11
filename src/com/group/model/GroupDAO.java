package com.group.model;

import java.util.*;
import java.sql.*;
import java.sql.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.group_member.model.*;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Group;
import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Group_Member;

public class GroupDAO implements GroupDAO_interface {

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

	private static final String INSERT_STMT = "INSERT INTO `group` (showtime_no,member_no,group_title,required_cnt,member_cnt, group_status, `desc`, deadline_dt) VALUES (?, ?, ?, ?, 0, 0, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM `group` where group_status <> 3 order by group_no";
	private static final String GET_ONE_STMT = "SELECT * FROM `group` where group_no = ?";
	// (新增)從揪團編號找成員
	private static final String GET_Members_ByGroupno_STMT = "SELECT * FROM group_member where group_no = ? order by member_no";

	private static final String DELETE_MEMBERS = "DELETE FROM `group_member` where group_no = ?";

	private static final String DELETE_GROUP = "DELETE FROM `group` where group_no = ?";

	private static final String UPDATE = "UPDATE `group` set showtime_no = ?, member_no = ?, group_title = ?, required_cnt = ?, group_status=?, `desc` = ?, deadline_dt = ?, modify_dt = default where group_no = ?";
	
	private static final String GET_ALL_BY_GROUP_STMT = "SELECT * FROM `group` where member_no=?";
	
	@Override
	public int insert(GroupVO groupVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer aiKey = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, groupVO.getShowtime_no());
			pstmt.setInt(2, groupVO.getMember_no());
			pstmt.setString(3, groupVO.getGroup_title());
			pstmt.setInt(4, groupVO.getRequired_cnt());
			pstmt.setString(5, groupVO.getDesc());
			pstmt.setTimestamp(6, groupVO.getDeadline_dt());
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			
			
			if (rs.next()) {
				aiKey = rs.getInt(1);
			}
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
			if(rs != null) {
				try {
					rs.close();
				}
				catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return aiKey;
	}

	@Override
	public void update(GroupVO groupVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, groupVO.getShowtime_no());
			pstmt.setInt(2, groupVO.getMember_no());
			pstmt.setString(3, groupVO.getGroup_title());
			pstmt.setInt(4, groupVO.getRequired_cnt());
			
			pstmt.setString(5, groupVO.getGroup_status());
			pstmt.setString(6, groupVO.getDesc());
			pstmt.setTimestamp(7, groupVO.getDeadline_dt());
			pstmt.setInt(8, groupVO.getGroup_no());

			pstmt.executeUpdate();

			
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void delete(Integer group_no) {
		int updateCount_Members = 0;
		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null;

		try {

			con = ds.getConnection();
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			// 先刪除成員
			pstmt = con.prepareStatement(DELETE_MEMBERS);
			pstmt.setInt(1, group_no);
			updateCount_Members = pstmt.executeUpdate();

			// 再刪除揪團
			pstmt2 = con.prepareStatement(DELETE_GROUP);
			pstmt2.setInt(1, group_no);
			pstmt2.executeUpdate();

			
			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除揪團編號" + group_no + "時,共有會員" + updateCount_Members + "人同時被刪除");
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt2 != null) {
				try {
					pstmt2.close();
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
	public GroupVO findByPrimaryKey(Integer group_no) {

		GroupVO groupVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, group_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				groupVO = new GroupVO();
				groupVO.setGroup_no(rs.getInt("group_no"));
				groupVO.setShowtime_no(rs.getInt("showtime_no"));
				groupVO.setMember_no(rs.getInt("member_no"));
				groupVO.setGroup_title(rs.getString("group_title"));
				groupVO.setRequired_cnt(rs.getInt("required_cnt"));
				groupVO.setMember_cnt(rs.getInt("member_cnt"));
				groupVO.setGroup_status(rs.getString("group_status"));
				groupVO.setDesc(rs.getString("desc"));
				groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				groupVO.setModify_dt(rs.getTimestamp("modify_dt"));
				groupVO.setDeadline_dt(rs.getTimestamp("deadline_dt"));

			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return groupVO;
	}

	@Override
	public List<GroupVO> getAll() {
		List<GroupVO> list = new ArrayList<GroupVO>();
		GroupVO groupVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				groupVO = new GroupVO();
				groupVO.setGroup_no(rs.getInt("group_no"));
				groupVO.setShowtime_no(rs.getInt("showtime_no"));
				groupVO.setMember_no(rs.getInt("member_no"));
				groupVO.setGroup_title(rs.getString("group_title"));
				groupVO.setRequired_cnt(rs.getInt("required_cnt"));
				groupVO.setMember_cnt(rs.getInt("member_cnt"));
				groupVO.setGroup_status(rs.getString("group_status"));
				groupVO.setDesc(rs.getString("desc"));
				groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				groupVO.setModify_dt(rs.getTimestamp("modify_dt"));
				groupVO.setDeadline_dt(rs.getTimestamp("deadline_dt"));
				list.add(groupVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public Set<Group_MemberVO> getMembersByGroupno(Integer group_no) {
		Set<Group_MemberVO> set = new LinkedHashSet<Group_MemberVO>();
		Group_MemberVO group_memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Members_ByGroupno_STMT);
			pstmt.setInt(1, group_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setStatus(rs.getString("status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				set.add(group_memberVO); // Store the row in the vector
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
	
	
	
	@Override
	public List<GroupVO> getAll(Map<String, String[]> map) {
		List<GroupVO> list = new ArrayList<GroupVO>();
		GroupVO groupVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = 
					"select S0.GROUP_NO, S0.SHOWTIME_NO,S0.MEMBER_NO, S3.MB_NAME, "
					+ "S1.SHOWTIME_TIME, S1.MOVIE_NO, S2.MOVIE_NAME, "
					+ " S0.GROUP_TITLE, S0.REQUIRED_CNT, S0.MEMBER_CNT, S0.GROUP_STATUS, "
					+ "S0.`DESC`, S0.CRT_DT, S0.MODIFY_DT, S0.DEADLINE_DT "
					+ "from `group` S0 "
					+ "LEFT JOIN SHOWTIME S1 ON S0.SHOWTIME_NO = S1.SHOWTIME_NO "
					+ "LEFT JOIN MOVIE S2 ON S1.MOVIE_NO = S2.MOVIE_NO "
					+ "LEFT JOIN `MEMBER` S3 ON S0.MEMBER_NO = S3.MEMBER_NO "
					+ jdbcUtil_CompositeQuery_Group.get_WhereCondition(map)
					+ " order by group_no";
			
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				groupVO = new GroupVO();
				groupVO.setGroup_no(rs.getInt("group_no"));
				groupVO.setShowtime_no(rs.getInt("showtime_no"));
				groupVO.setMember_no(rs.getInt("member_no"));
				groupVO.setGroup_title(rs.getString("group_title"));
				groupVO.setRequired_cnt(rs.getInt("required_cnt"));
				groupVO.setMember_cnt(rs.getInt("member_cnt"));
				groupVO.setGroup_status(rs.getString("group_status"));
				groupVO.setDesc(rs.getString("desc"));
				groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				groupVO.setModify_dt(rs.getTimestamp("modify_dt"));
				groupVO.setDeadline_dt(rs.getTimestamp("deadline_dt"));
				list.add(groupVO); // Store the row in the list
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
	public List<GroupVO> getAllByMemno(Integer memberno) {
		List<GroupVO> list = new ArrayList<GroupVO>();
		GroupVO groupVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_GROUP_STMT);
			pstmt.setInt(1, memberno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				groupVO = new GroupVO();
				groupVO.setGroup_no(rs.getInt("group_no"));
				groupVO.setShowtime_no(rs.getInt("showtime_no"));
				groupVO.setMember_no(rs.getInt("member_no"));
				groupVO.setGroup_title(rs.getString("group_title"));
				groupVO.setRequired_cnt(rs.getInt("required_cnt"));
				groupVO.setMember_cnt(rs.getInt("member_cnt"));
				groupVO.setGroup_status(rs.getString("group_status"));
				groupVO.setDesc(rs.getString("desc"));
				groupVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				groupVO.setModify_dt(rs.getTimestamp("modify_dt"));
				groupVO.setDeadline_dt(rs.getTimestamp("deadline_dt"));
				list.add(groupVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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