
package com.employee.model;

import java.util.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.authority.model.AuthorityVO;
import com.employee.model.*;
import com.employee.model.EmployeeVO;

public class EmployeeDAO implements EmployeeDAO_interface {

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

	private static final String INSERT_STMT = "INSERT INTO employee (empname,emppwd,gender,tel,email,title,hiredate,quitdate,status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT empno,empname,emppwd,gender,tel,email,title,hiredate,quitdate,status FROM employee order by empno";
	private static final String GET_ONE_STMT = "SELECT empno,empname,emppwd,gender,tel,email,title,hiredate,quitdate,status FROM employee where empno = ?";
	private static final String DELETE = "DELETE FROM employee where empno = ?";
	private static final String UPDATE = "UPDATE employee set empname=?, emppwd=?, gender=?, tel=?, email=?, title=?, hiredate=?, quitdate=?, status=? where empno = ?";
	private static final String LOGIN_CHECK = "SELECT * FROM employee where email = ? and emppwd = ?";
	private static final String UPDATERANDOMPWD = "UPDATE employee set emppwd = ? where email = ?";
	private static final String GET_Auths_ByEmpno_STMT = "Select function_no, auth_status FROM authority where empno = ?";

	public void insert(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT, Statement.RETURN_GENERATED_KEYS);
			
			
			pstmt.setString(1, employeeVO.getEmpname());
			pstmt.setString(2, employeeVO.getEmppwd());
			pstmt.setString(3, employeeVO.getGender());
			pstmt.setString(4, employeeVO.getTel());
			pstmt.setString(5, employeeVO.getEmail());
			pstmt.setString(6, employeeVO.getTitle());
			pstmt.setDate(7, employeeVO.getHiredate());
			pstmt.setDate(8, employeeVO.getQuitdate());
			pstmt.setString(9, employeeVO.getStatus());

			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			rs.next();
			Integer empno = rs.getInt(1);
			

			employeeVO.setEmpno(empno);
			employeeVO.getEmpno();
			int i = employeeVO.getEmpno();
			System.out.println(i);


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
		}
	}

	public void update(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, employeeVO.getEmpname());
			pstmt.setString(2, employeeVO.getEmppwd());
			pstmt.setString(3, employeeVO.getGender());
			pstmt.setString(4, employeeVO.getTel());
			pstmt.setString(5, employeeVO.getEmail());
			pstmt.setString(6, employeeVO.getTitle());
			pstmt.setDate(7, employeeVO.getHiredate());
			pstmt.setDate(8, employeeVO.getQuitdate());
			pstmt.setString(9, employeeVO.getStatus());
			pstmt.setInt(10, employeeVO.getEmpno());

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

	public void delete(Integer empno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, empno);

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

	public EmployeeVO findByPrimaryKey(Integer empno) {

		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, empno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmpno(rs.getInt("empno"));
				employeeVO.setEmpname(rs.getString("empname"));
				employeeVO.setEmppwd(rs.getString("emppwd"));
				employeeVO.setGender(rs.getString("gender"));
				employeeVO.setTel(rs.getString("tel"));
				employeeVO.setEmail(rs.getString("email"));
				employeeVO.setTitle(rs.getString("title"));
				employeeVO.setHiredate(rs.getDate("hiredate"));
				employeeVO.setQuitdate(rs.getDate("quitdate"));
				employeeVO.setStatus(rs.getString("status"));
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
		return employeeVO;
	}

	public List<EmployeeVO> getAll() {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// employeeVO 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmpno(rs.getInt("empno"));
				employeeVO.setEmpname(rs.getString("empname"));
				employeeVO.setEmppwd(rs.getString("emppwd"));
				employeeVO.setGender(rs.getString("gender"));
				employeeVO.setTel(rs.getString("tel"));
				employeeVO.setEmail(rs.getString("email"));
				employeeVO.setTitle(rs.getString("title"));
				employeeVO.setHiredate(rs.getDate("hiredate"));
				employeeVO.setQuitdate(rs.getDate("quitdate"));
				employeeVO.setStatus(rs.getString("status"));
				list.add(employeeVO); // Store the row in the list
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
	public EmployeeVO login_check(String email, String emppwd) {
		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LOGIN_CHECK);

			pstmt.setString(1, email);
			pstmt.setString(2, emppwd);

			rs = pstmt.executeQuery();
				
			while (rs.next()) {
				employeeVO = new EmployeeVO();
				employeeVO.setEmpno(rs.getInt("empno"));
				employeeVO.setEmpname(rs.getString("empname"));
				employeeVO.setEmppwd(rs.getString("emppwd"));
				employeeVO.setGender(rs.getString("gender"));
				employeeVO.setTel(rs.getString("tel"));
				employeeVO.setEmail(rs.getString("email"));
				employeeVO.setTitle(rs.getString("title"));
				employeeVO.setHiredate(rs.getDate("hiredate"));
				employeeVO.setQuitdate(rs.getDate("quitdate"));
				employeeVO.setStatus(rs.getString("status"));
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
		return employeeVO;
	}

	@Override
	public void updateRandomPws(String email, String randomPwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(UPDATERANDOMPWD);
			
			pstmt.setString(1, randomPwd);
			pstmt.setString(2, email);

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
	public Set<AuthorityVO> getAuthsByEmpno(Integer empno) {
		Set<AuthorityVO> set = new LinkedHashSet<AuthorityVO>();
		AuthorityVO authorityVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Auths_ByEmpno_STMT);
			pstmt.setInt(1, empno);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				authorityVO = new AuthorityVO();
				authorityVO.setFunction_no(rs.getInt("function_no"));
				authorityVO.setAuth_status(rs.getString("auth_status"));
				set.add(authorityVO); // Store the row in the vector
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
}
