package com.expectation.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import com.comment.model.CommentVO;
import com.movie.model.*;
import com.rating.model.RatingVO;

public class ExpectationDAO implements ExpectationDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "insert into EXPECTATION (MEMBER_NO,MOVIE_NO,EXPECTATION) values (?, ?, ?)";
	private static final String UPDATE_STMT = "update EXPECTATION set EXPECTATION=?, MODIFY_DT=default where MEMBER_NO=? and MOVIE_NO=?";
	private static final String DELETE_STMT = "delete from EXPECTATION where MEMBER_NO=? and MOVIE_NO=?";
	private static final String GET_ONE_STMT = "select * from EXPECTATION where MEMBER_NO = ? and MOVIE_NO = ?";
//	private static final String GET_ONE_BY_MEMBER_STMT = 
//			"select * from EXPECTATION where MEMBER_NO = ?";	
	private static final String GET_ONE_BY_MOVIENO_STMT = "select * from EXPECTATION where MOVIE_NO = ?";
//	private static final String GET_ALL_BY_MEMBER_STMT = 
//			"select * from EXPECTATION order by MEMBER_NO";	
	private static final String GET_ALL_BY_MOVIENO_STMT = "select * from EXPECTATION order by MOVIE_NO";
	
	private static final String SELECT_INSERT_OR_UPDATE_STMT = 
			"select IF(EXISTS(select * from EXPECTATION where MEMBER_NO = ? and MOVIE_NO = ?),'update','insert' )as `action`";
	private static final String GET_AVGEXPECTATION_BY_MOVIENO_STMT = 
			"select format(avg(EXPECTATION),2) as 'avg(EXPECTATION)' from EXPECTATION where MOVIE_NO = ?";
	private static final String GET_COUNTEXPECTATION_BY_MOVIENO_STMT = 
			"select count(EXPECTATION) from EXPECTATION where MOVIE_NO = ?";
	
	


	@Override
	public void insert(ExpectationVO expectationVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, expectationVO.getMemberno());
			pstmt.setInt(2, expectationVO.getMovieno());
			pstmt.setDouble(3, expectationVO.getExpectation());

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
	public void update(ExpectationVO expectationVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setDouble(1, expectationVO.getExpectation());
			pstmt.setInt(2, expectationVO.getMemberno());
			pstmt.setInt(3, expectationVO.getMovieno());

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
	public void delete(Integer memberno,Integer movieno) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setInt(1, memberno);
			pstmt.setInt(2, movieno);

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
	public ExpectationVO findByPrimaryKey(Integer memberno , Integer movieno) {
		
		ExpectationVO expectationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, memberno);
			pstmt.setInt(2, movieno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// expectationVo 也稱為 Domain objects
				expectationVO = new ExpectationVO();
				expectationVO.setMemberno(rs.getInt("MEMBER_NO"));
				expectationVO.setMovieno(rs.getInt("MOVIE_NO"));
				expectationVO.setExpectation(rs.getDouble("EXPECTATION"));
				expectationVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				expectationVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
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
		return expectationVO;
	}

	@Override
	public List<ExpectationVO> findByMovieNo(Integer movieno) {
		List<ExpectationVO> list = new ArrayList<ExpectationVO>();
		ExpectationVO expectationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_MOVIENO_STMT);

			pstmt.setInt(1, movieno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// commentVo 也稱為 Domain objects
				expectationVO = new ExpectationVO();
				expectationVO.setMemberno(rs.getInt("MEMBER_NO"));
				expectationVO.setMovieno(rs.getInt("MOVIE_NO"));
				expectationVO.setExpectation(rs.getDouble("EXPECTATION"));
				expectationVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				expectationVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				list.add(expectationVO);
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
	public List<ExpectationVO> getAllByMovieNo() {
		List<ExpectationVO> list = new ArrayList<ExpectationVO>();
		ExpectationVO expectationVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MOVIENO_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// expectationVO 也稱為 Domain objects
				expectationVO = new ExpectationVO();
				expectationVO.setMemberno(rs.getInt("MEMBER_NO"));
				expectationVO.setMovieno(rs.getInt("MOVIE_NO"));
				expectationVO.setExpectation(rs.getDouble("EXPECTATION"));
				expectationVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				expectationVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				list.add(expectationVO); // Store the row in the list
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
	public void insertOrUpdateExpectationAndUpdateMovieExpectation(ExpectationVO expectationVO) {

		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;	
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();			
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			
			//先搜尋是否有這筆評分
			pstmt1 = con.prepareStatement(SELECT_INSERT_OR_UPDATE_STMT);	
			pstmt1.setInt(1, expectationVO.getMemberno());
			pstmt1.setInt(2, expectationVO.getMovieno());

			rs = pstmt1.executeQuery();
			
			//再判斷是要新增還是更新
			rs.next();
			if(rs.getString("action").equals("insert")) {
				pstmt2 = con.prepareStatement(INSERT_STMT);			
				pstmt2.setInt(1, expectationVO.getMemberno());
				pstmt2.setInt(2, expectationVO.getMovieno());
				pstmt2.setDouble(3, expectationVO.getExpectation());
				pstmt2.executeUpdate();	
			}else {
				pstmt2 = con.prepareStatement(UPDATE_STMT);	
				pstmt2.setDouble(1, expectationVO.getExpectation());
				pstmt2.setInt(2, expectationVO.getMemberno());
				pstmt2.setInt(3, expectationVO.getMovieno());
				pstmt2.executeUpdate();	
			}
				
			
			pstmt3 = con.prepareStatement(GET_AVGEXPECTATION_BY_MOVIENO_STMT);
			pstmt3.setInt(1, expectationVO.getMovieno());
	
			rs = pstmt3.executeQuery();
	
			// 再同時更新電影表格的評分
			rs.next();
				MovieDAO dao = new MovieDAO();
				MovieVO movieVO = new MovieVO();
				movieVO.setMovieno(expectationVO.getMovieno());
				movieVO.setExpectation(rs.getDouble("avg(EXPECTATION)"));	
				dao.updateMovieExpectation(movieVO,con);
	
			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			
			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("------------------------------------Transaction is being ");
					System.err.println("rolled back-由-expectation");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt3 != null) {
				try {
					pstmt3.close();
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
			if (pstmt1 != null) {
				try {
					pstmt1.close();
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
	
	public ExpectationVO getThisMovieToatalExpectation(Integer movieno) {
		
		ExpectationVO expectationVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COUNTEXPECTATION_BY_MOVIENO_STMT);

			pstmt.setInt(1, movieno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// expectationVo 也稱為 Domain objects
				expectationVO = new ExpectationVO();
				expectationVO.setExpectation(rs.getDouble("count(EXPECTATION)"));
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
		return expectationVO;
	}
}
