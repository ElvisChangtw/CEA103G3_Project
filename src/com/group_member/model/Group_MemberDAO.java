package com.group_member.model;

import java.util.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.group.model.GroupService;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Group_Member;
public class Group_MemberDAO implements Group_MemberDAO_interface {

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
	private static final String CHECK_INSERT_OR_UPDATE = "select EXISTS(select * from group_member where group_no = ? and member_no = ?) CNT";
	private static final String INSERT_STMT = " INSERT INTO group_member (group_no,member_no) VALUES (?, ?) ";
	private static final String REJOIN_UPDATE_STMT = "update group_member set status = 1 where group_no = ? and member_no = ?  ";
	
	private static final String GET_ALL_STMT = 
		"SELECT * FROM group_member and status = '1' order by group_no, crt_dt";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM group_member where group_no = ? and member_no = ? AND STATUS = 1";
	private static final String DELETE = 
		"DELETE FROM group_member where group_no = ? and member_no = ?";
	private static final String UPDATE_COUNT_STMT = 
			"UPDATE `GROUP` SET MEMBER_CNT = ? WHERE GROUP_NO = ?";
	private static final String UPDATE = 
		"UPDATE group_member set pay_status = ?, status=? where group_no = ? and member_no = ?";
	private static final String GET_GROUP_BY_MEMBER_STMT = 
			"SELECT * FROM group_member where member_no = ? order by group_no, crt_dt";
	private static final String KICKOUT__STMT = "UPDATE `group_member` set STATUS = 0 where PAY_STATUS = 0 and GROUP_NO = ?";
	private static final String GET_COUNT = "SELECT COUNT(*) CNT from GROUP_MEMBER WHERE GROUP_NO = ? AND STATUS = 1; ";
	private static final String GET_MEMBERS_BY_GROUP_STMT = 
			"SELECT * FROM group_member where group_no = ?";
	private static final String GET_UNPAIDMEMBERS_BY_GROUP_STMT="SELECT * FROM group_member where group_no = ? AND STATUS = 0";
	@Override
	public void insert(Group_MemberVO group_memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null, pstmt4 = null, pstmt5 = null;
		ResultSet rs = null, rs2 = null;
		Integer cnt = null;
		try {
			con = ds.getConnection();
			// 交易開始
			con.setAutoCommit(false);
			//確定是新增還是修改
			pstmt4 = con.prepareStatement(CHECK_INSERT_OR_UPDATE);
			pstmt4.setInt(1, group_memberVO.getGroup_no());
			pstmt4.setInt(2, group_memberVO.getMember_no());
			rs = pstmt4.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("CNT");
				if(cnt == 0) {
					pstmt = con.prepareStatement(INSERT_STMT);
					pstmt.setInt(1, group_memberVO.getGroup_no());
					pstmt.setInt(2, group_memberVO.getMember_no());
				}
				else {
					pstmt = con.prepareStatement(REJOIN_UPDATE_STMT);
					pstmt.setInt(1, group_memberVO.getGroup_no());
					pstmt.setInt(2, group_memberVO.getMember_no());
				}
			}
			pstmt.executeUpdate();
			//取得揪團人數
			pstmt2 = con.prepareStatement(GET_COUNT);
			pstmt2.setInt(1, group_memberVO.getGroup_no());
			rs2 = pstmt2.executeQuery();
			
			while (rs2.next()) {
				cnt = rs2.getInt("CNT");
				System.out.println("新增後, 揪團人數: "+ cnt);
			}

			//更新揪團人數
			pstmt3 = con.prepareStatement(UPDATE_COUNT_STMT);
			pstmt3.setInt(1,  cnt);
			pstmt3.setInt(2, group_memberVO.getGroup_no());
			pstmt3.executeUpdate();
			
			con.commit();
			con.setAutoCommit(true);
			//交易結束
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if ( rs != null) {
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
	public void update(Group_MemberVO group_memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, group_memberVO.getPay_status());
			pstmt.setString(2, group_memberVO.getStatus());
			pstmt.setInt(3, group_memberVO.getGroup_no());
			pstmt.setInt(4, group_memberVO.getMember_no());
			
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
	public void delete(Integer group_no, Integer member_no) {

		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			// 交易開始
			con.setAutoCommit(false);
			//先刪除揪團成員
			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, group_no);
			pstmt.setInt(2, member_no);
			pstmt.executeUpdate();
			
			//取得揪團人數
			pstmt2 = con.prepareStatement(GET_COUNT);
			pstmt2.setInt(1, group_no);
			rs = pstmt2.executeQuery();
			Integer cnt = null;
			while (rs.next()) {
				cnt = rs.getInt("CNT");
				System.out.println("刪除後, 揪團人數: "+ cnt);
			}

			//更新揪團人數
			pstmt3 = con.prepareStatement(UPDATE_COUNT_STMT);
			pstmt3.setInt(1,  cnt);
			pstmt3.setInt(2, group_no);
			pstmt3.executeUpdate();
			
			con.commit();
			con.setAutoCommit(true);
			//交易結束
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
			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt3 != null) {
				try {
					pstmt3.close();
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
	public Group_MemberVO findByPrimaryKey(Integer group_no, Integer member_no) {
		Group_MemberVO group_memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, group_no);
			pstmt.setInt(2, member_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				group_memberVO.setStatus(rs.getString("status"));
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
		return group_memberVO;
	}

	@Override
	public List<Group_MemberVO> getAll() {
		List<Group_MemberVO> list = new ArrayList<Group_MemberVO>();
		Group_MemberVO group_memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				group_memberVO.setStatus(rs.getString("status"));
				list.add(group_memberVO); // Store the row in the list
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
	public List<Group_MemberVO> findGroupByMember_no(Integer member_no) {
		List<Group_MemberVO> list = new ArrayList<Group_MemberVO>();
		Group_MemberVO group_memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_GROUP_BY_MEMBER_STMT);
			pstmt.setInt(1, member_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				group_memberVO.setStatus(rs.getString("status"));
				list.add(group_memberVO); // Store the row in the list
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
	public List<Group_MemberVO> getAll(Map<String, String[]> map) {
		List<Group_MemberVO> list = new ArrayList<Group_MemberVO>();
		Group_MemberVO group_memberVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from group_member "
		          + jdbcUtil_CompositeQuery_Group_Member.get_WhereCondition(map)
		          + "order by group_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				group_memberVO.setStatus(rs.getString("status"));
				list.add(group_memberVO); // Store the row in the List
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
	
	
	//踢掉沒付款的團員
	@Override
	public void kickUnpaidMemberOut(Integer group_no) {
		GroupService groupSvc = new GroupService();
		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null, pstmt4 = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			
			//開始交易
			con.setAutoCommit(false);
			//先刪除員工
			pstmt = con.prepareStatement(KICKOUT__STMT);
			pstmt.setInt(1, group_no);
			pstmt.executeUpdate();

			//取得揪團人數
			pstmt2 = con.prepareStatement(GET_COUNT);
			pstmt2.setInt(1, group_no);
			rs = pstmt2.executeQuery();
			Integer cnt = null;
			while (rs.next()) {
				cnt = rs.getInt("CNT");
			}

			//更新揪團人數
			pstmt3 = con.prepareStatement(UPDATE_COUNT_STMT);
			pstmt3.setInt(1,  cnt);
			pstmt3.setInt(2, group_no);
			pstmt3.executeUpdate();
			
			
			//
			groupSvc.updateStatusFrom_1_to_2(group_no, con);
			
			con.commit();
			con.setAutoCommit(true);
			//交易結束
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
			if (rs != null) {
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
			if (pstmt3 != null) {
				try {
					pstmt3.close();
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
	public int getGroupCount(Integer group_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer cnt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COUNT);
			pstmt.setInt(1, group_no);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("CNT");
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
		return cnt;
	}
	
	@Override
	public List<Group_MemberVO> findMembersByGroup_no(Integer group_no) {
		List<Group_MemberVO> list = new ArrayList<Group_MemberVO>();
		Group_MemberVO group_memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEMBERS_BY_GROUP_STMT);
			pstmt.setInt(1, group_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				group_memberVO.setStatus(rs.getString("status"));
				list.add(group_memberVO); // Store the row in the list
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
	public List<Group_MemberVO> findUnpaidMembersByGroup_no(Integer group_no) {
		List<Group_MemberVO> list = new ArrayList<Group_MemberVO>();
		Group_MemberVO group_memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_UNPAIDMEMBERS_BY_GROUP_STMT);
			pstmt.setInt(1, group_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(rs.getInt("group_no"));
				group_memberVO.setMember_no(rs.getInt("member_no"));
				group_memberVO.setPay_status(rs.getString("pay_status"));
				group_memberVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				group_memberVO.setStatus(rs.getString("status"));
				list.add(group_memberVO); // Store the row in the list
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