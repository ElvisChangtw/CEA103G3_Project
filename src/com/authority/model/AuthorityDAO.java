package com.authority.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class AuthorityDAO implements AuthorityDAO_interface{

//請更改連線池~	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "insert into Authority (EMPNO,FUNCTION_NO,AUTH_STATUS) values (?, ?, ?)";
	private static final String UPDATE_STMT = "update Authority set AUTH_STATUS=? where EMPNO=? and FUNCTION_NO=?";
	private static final String DELETE_STMT = "delete from Authority where EMPNO=? and FUNCTION_NO=?";
	private static final String GET_ONE_BY_EMPNO_STMT = "select * from Authority where EMPNO = ?";
	private static final String GET_ONE_BY_EMPNO_FUCTION_STMT = "select * from Authority where EMPNO = ? and FUNCTION_NO=?";
	private static final String GET_ALL_BY_EMPNO_STMT = "select * from Authority order by EMPNO";
	
	@Override
	public void insert(AuthorityVO authorityVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, authorityVO.getEmpno());
			pstmt.setInt(2, authorityVO.getFunction_no());
			pstmt.setString(3, authorityVO.getAuth_status());

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
	public void update(AuthorityVO authorityVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, authorityVO.getAuth_status());
			pstmt.setInt(2, authorityVO.getEmpno());
			pstmt.setInt(3, authorityVO.getFunction_no());

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
	public void delete(Integer empno, Integer function_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setInt(1, empno);
			pstmt.setInt(2, function_no);

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
	public AuthorityVO findByEmpNo_FunctionNo(Integer empno, Integer function_no) {
		
		AuthorityVO authorityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_EMPNO_FUCTION_STMT);

			pstmt.setInt(1, empno);
			pstmt.setInt(2, function_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// authorityVo 也稱為 Domain objects
				authorityVO = new AuthorityVO();
				authorityVO.setEmpno(rs.getInt("EMPNO"));
				authorityVO.setFunction_no(rs.getInt("FUNCTION_NO"));
				authorityVO.setAuth_status(rs.getString("AUTH_STATUS"));
				
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
		return authorityVO;
	}
	
	
	@Override
	public List<AuthorityVO> findByEmpNo(Integer empno) {
		
		List<AuthorityVO> list = new ArrayList<AuthorityVO>();
		AuthorityVO authorityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_EMPNO_STMT);

			pstmt.setInt(1, empno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// authorityVo 也稱為 Domain objects
				authorityVO = new AuthorityVO();
				authorityVO.setEmpno(rs.getInt("EMPNO"));
				authorityVO.setFunction_no(rs.getInt("FUNCTION_NO"));
				authorityVO.setAuth_status(rs.getString("AUTH_STATUS"));
				list.add(authorityVO);
				
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
	public List<AuthorityVO> getAllByEmpNo() {
		
		List<AuthorityVO> list = new ArrayList<AuthorityVO>();
		AuthorityVO authorityVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_EMPNO_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// authorityVO 也稱為 Domain objects
				authorityVO = new AuthorityVO();
				authorityVO.setEmpno(rs.getInt("EMPNO"));
				authorityVO.setFunction_no(rs.getInt("FUNCTION_NO"));
				authorityVO.setAuth_status(rs.getString("AUTH_STATUS"));
				list.add(authorityVO); // Store the row in the list
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
