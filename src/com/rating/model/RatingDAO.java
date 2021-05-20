package com.rating.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import com.movie.model.*;

public class RatingDAO implements RatingDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "insert into RATING (MEMBER_NO,MOVIE_NO,RATING) values (?, ?, ?)";
	private static final String UPDATE_STMT = "update RATING set RATING=?, MODIFY_DT=default where MEMBER_NO=? and MOVIE_NO=?";
	private static final String DELETE_STMT = "delete from RATING where MEMBER_NO=? and MOVIE_NO=?";
	private static final String GET_ONE_STMT = "select * from RATING where MEMBER_NO = ? and MOVIE_NO = ?";
//	private static final String GET_ONE_BY_MEMBER_STMT = 
//			"select * from RATING where MEMBER_NO = ?";	
	private static final String GET_ONE_BY_MOVIENO_STMT = "select * from RATING where MOVIE_NO = ?";
//	private static final String GET_ALL_BY_MEMBER_STMT = 
//			"select * from RATING order by MEMBER_NO";	
	private static final String GET_ALL_BY_MOVIENO_STMT = "select * from RATING order by MOVIE_NO";
	
	private static final String SELECT_INSERT_OR_UPDATE_STMT = 
			"select IF(EXISTS(select * from RATING where MEMBER_NO = ? and MOVIE_NO = ?),'update','insert' )as `action`";
	private static final String GET_AVGRATING_BY_MOVIENO_STMT = 
			"select format(avg(RATING),1) as 'avg(RATING)' from RATING where MOVIE_NO = ?";
	private static final String GET_COUNTRATING_BY_MOVIENO_STMT = 
			"select count(RATING) from RATING where MOVIE_NO = ?";
	
	


	@Override
	public void insert(RatingVO ratingVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, ratingVO.getMemberno());
			pstmt.setInt(2, ratingVO.getMovieno());
			pstmt.setDouble(3, ratingVO.getRating());

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
	public void update(RatingVO ratingVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setDouble(1, ratingVO.getRating());
			pstmt.setInt(2, ratingVO.getMemberno());
			pstmt.setInt(3, ratingVO.getMovieno());

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
	public RatingVO findByPrimaryKey(Integer memberno , Integer movieno) {
		
		RatingVO ratingVO = null;
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
				// commentVo 也稱為 Domain objects
				ratingVO = new RatingVO();
				ratingVO.setMemberno(rs.getInt("MEMBER_NO"));
				ratingVO.setMovieno(rs.getInt("MOVIE_NO"));
				ratingVO.setRating(rs.getDouble("RATING"));
				ratingVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				ratingVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
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
		return ratingVO;
	}

	@Override
	public List<RatingVO> findByMovieNo(Integer movieno) {
		List<RatingVO> list = new ArrayList<RatingVO>();
		RatingVO ratingVO = null;
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
				ratingVO = new RatingVO();
				ratingVO.setMemberno(rs.getInt("MEMBER_NO"));
				ratingVO.setMovieno(rs.getInt("MOVIE_NO"));
				ratingVO.setRating(rs.getDouble("RATING"));
				ratingVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				ratingVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				list.add(ratingVO);
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
	public List<RatingVO> getAllByMovieNo() {
		List<RatingVO> list = new ArrayList<RatingVO>();
		RatingVO ratingVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MOVIENO_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ratingVO 也稱為 Domain objects
				ratingVO = new RatingVO();
				ratingVO.setMemberno(rs.getInt("MEMBER_NO"));
				ratingVO.setMovieno(rs.getInt("MOVIE_NO"));
				ratingVO.setRating(rs.getDouble("RATING"));
				ratingVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				ratingVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				list.add(ratingVO); // Store the row in the list
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
	public void insertOrUpdateRatingtAndUpdateMovieRating(RatingVO ratingVO) {

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
			pstmt1.setInt(1, ratingVO.getMemberno());
			pstmt1.setInt(2, ratingVO.getMovieno());

			rs = pstmt1.executeQuery();
			
			//再判斷是要新增還是更新
			rs.next();
			if(rs.getString("action").equals("insert")) {
				pstmt2 = con.prepareStatement(INSERT_STMT);			
				pstmt2.setInt(1, ratingVO.getMemberno());
				pstmt2.setInt(2, ratingVO.getMovieno());
				pstmt2.setDouble(3, ratingVO.getRating());
				pstmt2.executeUpdate();	
			}else {
				pstmt2 = con.prepareStatement(UPDATE_STMT);	
				pstmt2.setDouble(1, ratingVO.getRating());
				pstmt2.setInt(2, ratingVO.getMemberno());
				pstmt2.setInt(3, ratingVO.getMovieno());
				pstmt2.executeUpdate();	
			}
				
			
			pstmt3 = con.prepareStatement(GET_AVGRATING_BY_MOVIENO_STMT);
			pstmt3.setInt(1, ratingVO.getMovieno());
	
			rs = pstmt3.executeQuery();
			
			// 再同時更新電影表格的評分
			rs.next();
				MovieDAO dao = new MovieDAO();
				MovieVO movieVO = new MovieVO();
				movieVO.setMovieno(ratingVO.getMovieno());
				movieVO.setRating(rs.getDouble("avg(RATING)"));	
				dao.updateMovieRating(movieVO,con);
	
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
					System.err.println("rolled back-由-rating");
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
	
	
	public RatingVO getThisMovieToatalRating(Integer movieno) {
		
		RatingVO ratingVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COUNTRATING_BY_MOVIENO_STMT);

			pstmt.setInt(1, movieno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// commentVo 也稱為 Domain objects
				ratingVO = new RatingVO();
				ratingVO.setRating(rs.getDouble("count(RATING)"));
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
		return ratingVO;
	}

}
