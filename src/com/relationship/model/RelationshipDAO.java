package com.relationship.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RelationshipDAO implements RelationshipDAO_interface {

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
		"INSERT INTO relationship (member_no,friend_no) VALUES (?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM relationship order by member_no, friend_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM relationship where member_no = ? and friend_no = ?";
	private static final String DELETE = 
		"DELETE FROM relationship where member_no = ? and friend_no = ?";
	private static final String UPDATE = 
		"UPDATE relationship set isblock=? where member_no = ? and friend_no = ?";
	private static final String GET_ALL_FRIENDNO = 
			"SELECT * FROM relationship where member_no = ? and status = 1";	
	
	private static final String UPDATE_STATUS_TO_ONE = 
			"UPDATE relationship set `status`=1 "
			+ "where (member_no = ? and friend_no = ?) or "
			+ "(friend_no = ? and member_no = ?)";
	private static final String GET_ONE_STMT_BY_MEMNO = 
			"SELECT * FROM relationship where member_no = ?";
		
	
	@Override
	public void insert(RelationshipVO relationshipVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, relationshipVO.getMember_no());
			pstmt.setInt(2, relationshipVO.getFriend_no());
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
	public void update(RelationshipVO relationshipVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, relationshipVO.getIsblock());
			pstmt.setInt(2, relationshipVO.getMember_no());
			pstmt.setInt(3, relationshipVO.getFriend_no());
			
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
	public void update_status(Integer member_no, Integer friend_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, member_no);
			pstmt.setInt(2, friend_no);

			pstmt.executeUpdate();
			pstmt2 = con.prepareStatement(UPDATE_STATUS_TO_ONE);
			pstmt2.setInt(1, member_no);
			pstmt2.setInt(2, friend_no);
			pstmt2.setInt(3, member_no);
			pstmt2.setInt(4, friend_no);
			pstmt2.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
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
	public void delete(Integer member_no, Integer friend_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, member_no);
			pstmt.setInt(2, friend_no);
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
	public RelationshipVO findByPrimaryKey(Integer member_no, Integer friend_no) {

		RelationshipVO relationshipVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1, member_no);
			pstmt.setInt(2, friend_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(rs.getInt("member_no"));
				relationshipVO.setFriend_no(rs.getInt("friend_no"));
				relationshipVO.setStatus(rs.getString("status"));
				relationshipVO.setIsblock(rs.getString("isblock"));
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
		return relationshipVO;
	}

	@Override
	public List<RelationshipVO> getAll() {
		List<RelationshipVO> list = new ArrayList<RelationshipVO>();
		RelationshipVO relationshipVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			
			rs = pstmt.executeQuery();
			

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(rs.getInt("member_no"));
				relationshipVO.setFriend_no(rs.getInt("friend_no"));
				relationshipVO.setStatus(rs.getString("status"));
				relationshipVO.setIsblock(rs.getString("isblock"));
				list.add(relationshipVO); // Store the row in the list
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
	public List<RelationshipVO> getAllFriendno(Integer member_no) {
		List<RelationshipVO> list = new ArrayList<RelationshipVO>();
		RelationshipVO relationshipVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_FRIENDNO);
			//設定member_no = ?
			pstmt.setInt(1, member_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(rs.getInt("member_no"));
				relationshipVO.setFriend_no(rs.getInt("friend_no"));
//				relationshipVO.setStatus(rs.getString("status"));
//				relationshipVO.setIsblock(rs.getString("isblock"));
				list.add(relationshipVO); // Store the row in the list
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
	public void addOneWay(RelationshipVO relationshipVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, relationshipVO.getMember_no());
			pstmt.setInt(2, relationshipVO.getFriend_no());
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
	public List<RelationshipVO> findByPrimaryKeyByMemno(Integer member_no){
		List<RelationshipVO> list = new ArrayList<RelationshipVO>();
		RelationshipVO relationshipVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_BY_MEMNO);
			pstmt.setInt(1, member_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(rs.getInt("member_no"));
				relationshipVO.setFriend_no(rs.getInt("friend_no"));
				relationshipVO.setStatus(rs.getString("status"));
				relationshipVO.setIsblock(rs.getString("isblock"));
				list.add(relationshipVO);
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