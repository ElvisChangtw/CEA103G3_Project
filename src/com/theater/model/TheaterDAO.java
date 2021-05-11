package com.theater.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.theater.model.TheaterVO;

public class TheaterDAO implements TheaterDAO_interface {

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

	private static final String INSERT_STMT = "insert into theater (theater_name, theater_type, seat_no, seat_name)"
			+ "values(?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from theater order by theater_no";
	private static final String GET_ONE_STMT = "select * from theater where theater_no = ?";
	private static final String DELETE = "delete from theater where theater_no = ?";
	private static final String UPDATE = "update theater set theater_name = ?, theater_type = ?, seat_no = ?,"
			+ " seat_name = ? where theater_no = ?";
//	private static final String GET_ONE_SEAT_NO = "select seat_no from theater where theater_no = ?";

	@Override
	public void insert(TheaterVO theaterVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, theaterVO.getTheater_name());
			pstmt.setString(2, theaterVO.getTheater_type());
			pstmt.setString(3, theaterVO.getSeat_no());
			pstmt.setString(4, theaterVO.getSeat_name());

			pstmt.executeUpdate();
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

	@Override
	public void update(TheaterVO theaterVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, theaterVO.getTheater_name());
			pstmt.setString(2, theaterVO.getTheater_type());
			pstmt.setString(3, theaterVO.getSeat_no());
			pstmt.setString(4, theaterVO.getSeat_name());
			pstmt.setInt(5, theaterVO.getTheater_no());
			
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
	public void delete(Integer theater_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, theater_no);

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
	public TheaterVO findByPrimaryKey(Integer theater_no) {
		
		TheaterVO theaterVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, theater_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				theaterVO = new TheaterVO();
				theaterVO.setTheater_no(rs.getInt("theater_no"));
				theaterVO.setTheater_name(rs.getString("theater_name"));
				theaterVO.setTheater_type(rs.getString("theater_type"));
				theaterVO.setSeat_no(rs.getString("seat_no"));
				theaterVO.setSeat_name(rs.getString("seat_name"));
			}
			
			
		}catch (SQLException se) {
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
		
		return theaterVO;
	}

	@Override
	public List<TheaterVO> getAll() {
		List<TheaterVO> list = new ArrayList<TheaterVO>();
		TheaterVO theaterVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				theaterVO = new TheaterVO();
				theaterVO.setTheater_no(rs.getInt("theater_no"));
				theaterVO.setTheater_name(rs.getString("theater_name"));
				theaterVO.setTheater_type(rs.getString("theater_type"));
				theaterVO.setSeat_no(rs.getString("seat_no"));
				theaterVO.setSeat_name(rs.getString("seat_name"));
				list.add(theaterVO);
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

//	@Override
//	public TheaterVO findSeat_no(Integer theater_no) {
//		TheaterVO theaterVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ONE_SEAT_NO);
//			
//			pstmt.setInt(1, theater_no);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				// theaterVO 也稱為 Domain objects
//				theaterVO = new TheaterVO();
//
//				theaterVO.setSeat_no(rs.getString("seat_no"));
//			}
//			
//			
//		}catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		
//		return theaterVO;
//	}

}