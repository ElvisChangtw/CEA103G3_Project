package com.mem.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.relationship.model.RelationshipVO;
import java.util.*;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Member;


public class MemDAO implements MemDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO member (mb_name, mb_email, mb_pwd, mb_bd, mb_pic, mb_phone, mb_city, mb_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM member order by member_no";
	private static final String GET_ONE_STMT = "SELECT * FROM member where member_no = ?";
	private static final String DELETE = "DELETE FROM member where member_no = ?";
	private static final String FRONT_UPDATE = "UPDATE member set mb_name=?, mb_bd=?, mb_phone=?, mb_city=?, mb_address=? where member_no = ?";
	private static final String BACK_UPDATE = "UPDATE member set mb_name=?, mb_email=?, mb_pwd=?, mb_bd=?, mb_pic=?, mb_phone=?, mb_city=?, mb_address=?, status=?, crt_dt=?, mb_point=?, mb_level=?   where member_no = ?";
	private static final String GET_ONE_PIC = "SELECT mb_pic FROM member WHERE member_no=?";
	private static final String UPDATEPIC = "UPDATE MEMBER SET MB_PIC = ? WHERE member_no = ?";
	private static final String UPDATEPWD = "UPDATE MEMBER SET MB_PWD = ? WHERE member_no = ?";
	private static final String LOGIN_CHECK = "SELECT * FROM member where mb_email = ? and mb_pwd = ?";
	private static final String ACOUNTACTIVATE = "SELECT * FROM member where mb_email = ? and status ='0'";
	private static final String EMAIL_CHECK = "SELECT * FROM member where mb_email = ?";
	private static final String GET_Relationships_ByMemberno_STMT = 
			"SELECT * FROM RELATIONSHIP where MEMBER_NO = ? order by MEMBER_NO and FRIEND_NO";
	private static final String GET_PASSWORD = "SELECT * FROM member where mb_email = ?";
	private static final String UPDATERANDOMPWD = "UPDATE MEMBER SET mb_pwd = ? WHERE mb_email = ?";

	public void insert(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, memVO.getMb_name());
			pstmt.setString(2, memVO.getMb_email());
			pstmt.setString(3, memVO.getMb_pwd());
			pstmt.setDate(4, memVO.getMb_bd());
			pstmt.setBytes(5, memVO.getMb_pic());
			pstmt.setString(6, memVO.getMb_phone());
			pstmt.setString(7, memVO.getMb_city());
			pstmt.setString(8, memVO.getMb_address());

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
	public void front_update(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FRONT_UPDATE);

			pstmt.setString(1, memVO.getMb_name());
			pstmt.setDate(2, memVO.getMb_bd());
			pstmt.setString(3, memVO.getMb_phone());
			pstmt.setString(4, memVO.getMb_city());
			pstmt.setString(5, memVO.getMb_address());
			pstmt.setInt(6, memVO.getMember_no());

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

	public void back_update(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(BACK_UPDATE);

			pstmt.setString(1, memVO.getMb_name());
			pstmt.setString(2, memVO.getMb_email());
			pstmt.setString(3, memVO.getMb_pwd());
			pstmt.setDate(4, memVO.getMb_bd());
			pstmt.setBytes(5, memVO.getMb_pic());
			pstmt.setString(6, memVO.getMb_phone());
			pstmt.setString(7, memVO.getMb_city());
			pstmt.setString(8, memVO.getMb_address());
			pstmt.setString(9, memVO.getStatus());
			pstmt.setDate(10, memVO.getCrt_dt());
			pstmt.setInt(11, memVO.getMb_point());
			pstmt.setString(12, memVO.getMb_level());
			pstmt.setInt(13, memVO.getMember_no());

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
	public void delete(Integer member_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, member_no);

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
	public MemVO findByPrimaryKey(Integer member_no) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, member_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				memVO = new MemVO();
				memVO.setMember_no(rs.getInt("member_no"));
				memVO.setMb_name(rs.getString("mb_name"));
				memVO.setMb_email(rs.getString("mb_email"));
				memVO.setMb_pwd(rs.getString("mb_pwd"));
				memVO.setMb_bd(rs.getDate("mb_bd"));
				memVO.setMb_pic(rs.getBytes("mb_pic"));
				memVO.setMb_phone(rs.getString("mb_phone"));
				memVO.setMb_city(rs.getString("mb_city"));
				memVO.setMb_address(rs.getString("mb_address"));
				memVO.setStatus(rs.getString("status"));
				memVO.setMb_point(rs.getInt("mb_point"));
				memVO.setMb_level(rs.getString("mb_level"));
				memVO.setCrt_dt(rs.getDate("crt_dt"));

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
		return memVO;
	}

	@Override
	public List<MemVO> getAll() {
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMember_no(rs.getInt("member_no"));
				memVO.setMb_name(rs.getString("mb_name"));
				memVO.setMb_email(rs.getString("mb_email"));
				memVO.setMb_pwd(rs.getString("mb_pwd"));
				memVO.setMb_bd(rs.getDate("mb_bd"));
				memVO.setMb_pic(rs.getBytes("mb_pic"));
				memVO.setMb_phone(rs.getString("mb_phone"));
				memVO.setMb_city(rs.getString("mb_city"));
				memVO.setMb_address(rs.getString("mb_address"));
				memVO.setStatus(rs.getString("status"));
				memVO.setMb_point(rs.getInt("mb_point"));
				memVO.setMb_level(rs.getString("mb_level"));
				memVO.setCrt_dt(rs.getDate("crt_dt"));
				list.add(memVO); // Store the row in the list
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

	public MemVO getOnePic(Integer member_no) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_PIC);

			pstmt.setInt(1, member_no);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				memVO = new MemVO();
				memVO.setMb_pic(rs.getBytes("mb_pic"));
			}

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
		return memVO;
	}

	public void updatePic(MemVO membervo) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(UPDATEPIC);

			pstmt.setBytes(1, membervo.getMb_pic());
			pstmt.setInt(2, membervo.getMember_no());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	public void updatePwd(MemVO membervo) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(UPDATEPWD);

			pstmt.setString(1, membervo.getMb_pwd());
			pstmt.setInt(2, membervo.getMember_no());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public MemVO login_check(String mb_email, String mb_pwd) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LOGIN_CHECK);

			pstmt.setString(1, mb_email);
			pstmt.setString(2, mb_pwd);

			rs = pstmt.executeQuery();
			
				
			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMember_no(rs.getInt("member_no"));
				memVO.setMb_name(rs.getString("mb_name"));
				memVO.setMb_email(rs.getString("mb_email"));
				memVO.setMb_pwd(rs.getString("mb_pwd"));
				memVO.setMb_bd(rs.getDate("mb_bd"));
				memVO.setMb_pic(rs.getBytes("mb_pic"));
				memVO.setMb_phone(rs.getString("mb_phone"));
				memVO.setMb_city(rs.getString("mb_city"));
				memVO.setMb_address(rs.getString("mb_address"));
				memVO.setStatus(rs.getString("status"));
				memVO.setMb_point(rs.getInt("mb_point"));
				memVO.setMb_level(rs.getString("mb_level"));
				memVO.setCrt_dt(rs.getDate("crt_dt"));
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
		return memVO;
	}

	@SuppressWarnings("resource")
	@Override
	public MemVO account_activate(String mb_email) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ACOUNTACTIVATE);

			pstmt.setString(1, mb_email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				pstmt = con.prepareStatement("UPDATE member SET status='1' WHERE mb_email = ?");

				pstmt.setString(1, mb_email);
				pstmt.executeUpdate();
			}
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
		return memVO;
	}

	@Override
	public MemVO email_check(String mb_email) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(EMAIL_CHECK);

			pstmt.setString(1, mb_email);

			rs = pstmt.executeQuery();
			
				
			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMember_no(rs.getInt("member_no"));
				memVO.setMb_name(rs.getString("mb_name"));
				memVO.setMb_email(rs.getString("mb_email"));
				memVO.setMb_pwd(rs.getString("mb_pwd"));
				memVO.setMb_bd(rs.getDate("mb_bd"));
				memVO.setMb_pic(rs.getBytes("mb_pic"));
				memVO.setMb_phone(rs.getString("mb_phone"));
				memVO.setMb_city(rs.getString("mb_city"));
				memVO.setMb_address(rs.getString("mb_address"));
				memVO.setStatus(rs.getString("status"));
				memVO.setMb_point(rs.getInt("mb_point"));
				memVO.setMb_level(rs.getString("mb_level"));
				memVO.setCrt_dt(rs.getDate("crt_dt"));
				
				String checkemail = memVO.getMb_email();
				if (checkemail.contentEquals(mb_email)) {
					throw new RegisterException();
				}
			}
			

			// Handle any driver errors
		} catch (RegisterException le) {
			throw new RuntimeException("帳號創建失敗." + le.getMessage());
			// Clean up JDBC resources
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
		return memVO;
	}
	
	@Override
	public Set<RelationshipVO> getRelationshipsByMemberno(Integer member_no) {
		Set<RelationshipVO> set = new LinkedHashSet<RelationshipVO>();
		RelationshipVO relationshipVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Relationships_ByMemberno_STMT);
			pstmt.setInt(1, member_no);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(rs.getInt("member_no"));
				relationshipVO.setFriend_no(rs.getInt("friend_no"));
				relationshipVO.setStatus(rs.getString("status"));
				relationshipVO.setIsblock(rs.getString("isblock"));
				set.add(relationshipVO);// Store the row in the vector
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
		return set;
	}
	
	@Override
	public MemVO getPassword(String mb_email) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_PASSWORD);

			pstmt.setString(1, mb_email);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				memVO = new MemVO();
				memVO.setMember_no(rs.getInt("member_no"));
				memVO.setMb_name(rs.getString("mb_name"));
				memVO.setMb_email(rs.getString("mb_email"));
				memVO.setMb_pwd(rs.getString("mb_pwd"));
				memVO.setMb_bd(rs.getDate("mb_bd"));
				memVO.setMb_pic(rs.getBytes("mb_pic"));
				memVO.setMb_phone(rs.getString("mb_phone"));
				memVO.setMb_city(rs.getString("mb_city"));
				memVO.setMb_address(rs.getString("mb_address"));
				memVO.setStatus(rs.getString("status"));
				memVO.setMb_point(rs.getInt("mb_point"));
				memVO.setMb_level(rs.getString("mb_level"));
				memVO.setCrt_dt(rs.getDate("crt_dt"));

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
		return memVO;
	}

	@Override
	public void updateRandomPws(String mb_email, String mb_pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(UPDATERANDOMPWD);
			
			pstmt.setString(1, mb_pwd);
			pstmt.setString(2, mb_email);

			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public List<MemVO> getAll(Map<String, String[]> map) {
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {			
			con = ds.getConnection();
			String finalSQL = "select * from `member` "
					+ jdbcUtil_CompositeQuery_Member.get_WhereCondition(map)
					+ "order by member_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMember_no(rs.getInt("member_no"));
				memVO.setMb_name(rs.getString("mb_name"));
				memVO.setMb_email(rs.getString("mb_email"));
				memVO.setMb_pwd(rs.getString("mb_pwd"));
				memVO.setMb_bd(rs.getDate("mb_bd"));
				memVO.setMb_pic(rs.getBytes("mb_pic"));
				memVO.setMb_phone(rs.getString("mb_phone"));
				memVO.setMb_city(rs.getString("mb_city"));
				memVO.setMb_address(rs.getString("mb_address"));
				memVO.setStatus(rs.getString("status"));
				memVO.setMb_point(rs.getInt("mb_point"));
				memVO.setMb_level(rs.getString("mb_level"));
				memVO.setCrt_dt(rs.getDate("crt_dt"));
				
				list.add(memVO); // Store the row in the List
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

	