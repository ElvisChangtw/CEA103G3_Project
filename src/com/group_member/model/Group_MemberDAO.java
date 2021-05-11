package com.group_member.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.group_member.model.*;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Group_Member;

public class Group_MemberDAO implements Group_MemberDAO_interface {

	// �@�����ε{����,�w��@�Ӹ�Ʈw ,�@�Τ@��DataSource�Y�i
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
		"INSERT INTO group_member (group_no,member_no) VALUES (?, ?)";
	private static final String ADD_COUNT_STMT = 
			"UPDATE `GROUP` SET MEMBER_CNT = MEMBER_CNT + 1 WHERE GROUP_NO = ? AND MEMBER_CNT < REQUIRED_CNT";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM group_member order by group_no, crt_dt";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM group_member where group_no = ? and member_no = ? ";
	private static final String DELETE = 
		"DELETE FROM group_member where group_no = ? and member_no = ?";
	private static final String SUBTRACT_COUNT_STMT = 
			"UPDATE `GROUP` SET MEMBER_CNT = MEMBER_CNT - 1 WHERE GROUP_NO = ?";
	
	
	private static final String UPDATE = 
		"UPDATE group_member set pay_status = ?, status=? where group_no = ? and member_no = ?";
	
	private static final String GET_MEMBER_BY_GROUP_STMT = 
			"SELECT * FROM group_member where group_no = ? order by group_no, crt_dt";
	private static final String GET_GROUP_BY_MEMBER_STMT = 
			"SELECT * FROM group_member where member_no = ? order by group_no, crt_dt";

	
	
	

	@Override
	public void insert(Group_MemberVO group_memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		try {
			con = ds.getConnection();
			
			//�s�W���Φ���
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, group_memberVO.getGroup_no());
			pstmt.setInt(2, group_memberVO.getMember_no());
			pstmt.executeUpdate();

			//���ΤH��+1

			pstmt2 = con.prepareStatement(ADD_COUNT_STMT);
			pstmt2.setInt(1, group_memberVO.getGroup_no());
			pstmt2.executeUpdate();
			
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
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			
			//���R�����u
			
			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, group_no);
			pstmt.setInt(2, member_no);
			pstmt.executeUpdate();
			
			//�]�w���ΤH��-1
			pstmt = con.prepareStatement(SUBTRACT_COUNT_STMT);
			pstmt.setInt(1, group_no);
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
				// messageVO �]�٬� Domain objects
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
				// messageVO �]�٬� Domain objects
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
				// messageVO �]�٬� Domain objects
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
			System.out.println("����finalSQL(by DAO) = "+finalSQL);
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
}