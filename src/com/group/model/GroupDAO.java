package com.group.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.group_member.model.*;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Group;

public class GroupDAO implements GroupDAO_interface {

	// 
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
//	private static final String GET_ALL_STMT = "SELECT * FROM `group` where group_status <> 3 order by group_no";
	private static final String GET_ALL_STMT = " SELECT  S0.*  FROM `group` S0 " + 
			" LEFT JOIN SHOWTIME S1 ON S0.SHOWTIME_NO = S1.SHOWTIME_NO " + 
			" where S0.group_status = 0  AND DATE(S1.SHOWTIME_TIME) >= DATE_ADD(DATE(NOW()), INTERVAL 1 DAY) " +
			" AND S0.REQUIRED_CNT > S0.MEMBER_CNT AND DEADLINE_DT > NOW() "
			+ " order by S0.group_no "; 
	//
	private static final String GET_MYGROUP_STMT = 
			"SELECT  S0.*  FROM `group` S0 " + 
			"LEFT JOIN SHOWTIME S1 ON S0.SHOWTIME_NO = S1.SHOWTIME_NO " + 
			"LEFT JOIN GROUP_MEMBER S2 ON S0.GROUP_NO = S2.GROUP_NO " + 
			"where S0.group_status = ?  AND DATE(S1.SHOWTIME_TIME) >= DATE_ADD(DATE(NOW()), INTERVAL 1 DAY) " + 
			"and s2.member_no = ? AND S2.STATUS = 1 "
			+ "order by S0.group_no ";
	private static final String GET_ONE_STMT = "SELECT * FROM `group` where group_no = ?";
	private static final String GET_Members_ByGroupno_STMT = "SELECT * FROM group_member where group_no = ? order by member_no";
	private static final String DELETE_MEMBERS = "DELETE FROM `group_member` where group_no = ?";
	private static final String DELETE_GROUP = "DELETE FROM `group` where group_no = ?";
	private static final String UPDATE = "UPDATE `group` set showtime_no = ?, member_no = ?, group_title = ?, required_cnt = ?, group_status=?, `desc` = ?, deadline_dt = ?, modify_dt = default where group_no = ?";
	
	//update時順便踢掉除團長外所有團員
	private static final String UPDATE_GROUP_AND_DELETE_MEMS_EXCEPT_HOST = "UPDATE `GROUP` S0 " + 
			"LEFT JOIN `GROUP_MEMBER` S1 " + 
			"ON S0.GROUP_NO = S1.GROUP_NO AND S0.MEMBER_NO <> S1.MEMBER_NO " + 
			"SET S1.STATUS = 0 , S0.MEMBER_CNT = 1 " + 
			"WHERE S0.GROUP_NO = ?";
	private static final String GET_ALL_BY_GROUP_STMT = "SELECT * FROM `group` where member_no=?";	
	private static final String GET_STAT_EQUALS_1 = "SELECT * FROM `group` where GROUP_STATUS= 1;";	
	
	private static final String OVER_DUE_STMT = "UPDATE `GROUP` SET GROUP_STATUS = 3 where GROUP_NO = ?";
	private static final String GOGO_STMT =
			  "UPDATE `GROUP` S0  "
			+ "LEFT JOIN SHOWTIME S1 ON S0.SHOWTIME_NO = S1.SHOWTIME_NO " 
			+ " SET S0.GROUP_STATUS = 1  "
			+ ", S0.DEADLINE_DT = DATE_ADD(S1.SHOWTIME_TIME, INTERVAL -1 HOUR) " 
			+ "where GROUP_NO = ?; ";
	private static final String GET_ONE_STATUS_STMT = "SELECT GROUP_STATUS FROM `GROUP` where GROUP_NO = ?";
	private static final String UPDATE_STAT_FROM_1_TO_2 = "UPDATE `GROUP` SET GROUP_STATUS = 2 WHERE GROUP_NO = ? AND GROUP_STATUS = 1";
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
		PreparedStatement pstmt = null, pstmt2 = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			//更新揪團資訊
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
			
			
			//踢掉所有團員(其實是更新group_member表該筆status狀態為1)
			pstmt2 = con.prepareStatement(UPDATE_GROUP_AND_DELETE_MEMS_EXCEPT_HOST);
			pstmt2.setInt(1, groupVO.getGroup_no());
			pstmt2.executeUpdate();
			
			
			
			
			con.commit();
			con.setAutoCommit(true);
			
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
	public void delete(Integer group_no) {
		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null;

		try {
			con = ds.getConnection();
			// 交易開始
			con.setAutoCommit(false);
			// 先刪除成員
			pstmt = con.prepareStatement(DELETE_MEMBERS);
			pstmt.setInt(1, group_no);
			pstmt.executeUpdate();

			// 再刪除揪團
			pstmt2 = con.prepareStatement(DELETE_GROUP);
			pstmt2.setInt(1, group_no);
			pstmt2.executeUpdate();

			// 
			con.commit();
			con.setAutoCommit(true);
			//交易結束
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
				//
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
				// 
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
	
	//出團中的，到時候給timer取出來，狀態改成正常出團用
	@Override
	public List<GroupVO> getStatusEquals1() {
		List<GroupVO> list = new ArrayList<GroupVO>();
		GroupVO groupVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STAT_EQUALS_1);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 
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
					+ " AND S0.REQUIRED_CNT > S0.MEMBER_CNT "
					+ "order by group_no";
			
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("finalSQL(by DAO) = "+finalSQL);
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
				// messageVO 
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
	//截止時間內團長未出團, 失敗結束
	@Override
	public void failure(Integer group_no) {
		System.out.println("有進截止揪團DAO");
		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null;

		try {
			con = ds.getConnection();
			// 交易開始
			con.setAutoCommit(false);

			// 再更改揪團狀態為3(條件失敗結束)
			pstmt2 = con.prepareStatement(OVER_DUE_STMT);
			pstmt2.setInt(1, group_no);
			pstmt2.executeUpdate();
			
			// 
			con.commit();
			con.setAutoCommit(true);
			//交易結束
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
	
	
	//團長按了出團, 更改揪團狀態
		@Override
		public void gogogo(Integer group_no) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				// 交易開始
				con.setAutoCommit(false);
				// 再更改揪團狀態為3(條件失敗結束)
				pstmt = con.prepareStatement(GOGO_STMT);
				pstmt.setInt(1, group_no);
				pstmt.executeUpdate();
				
				// 
				con.commit();
				con.setAutoCommit(true);
				//交易結束
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
		public String getGroupStatus(Integer group_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String str = null;
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STATUS_STMT);
				pstmt.setInt(1, group_no);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					str = rs.getString("GROUP_STATUS");
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
			return str;
		}
		
		
		@Override
		public List<GroupVO> getMyGroups(int member_no, int group_status) {
			List<GroupVO> list = new ArrayList<GroupVO>();
			GroupVO groupVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_MYGROUP_STMT);
				pstmt.setInt(1,  group_status);
				pstmt.setInt(2, member_no);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// 
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
		public void updateStatusFrom_1_to_2(Integer group_no, Connection con) {
//			Connection con = null;
			PreparedStatement pstmt = null;

			try {
//				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_STAT_FROM_1_TO_2);
				pstmt.setInt(1, group_no);
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
//				if (con != null) {
//					try {
//						con.close();
//					} catch (Exception e) {
//						e.printStackTrace(System.err);
//					}
//				}
			}
		}

}