//package com.showtime.model;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.naming.NamingException;
//import javax.sql.DataSource;
//
//import com.showtime.model.ShowtimeVO;
//
//public class ShowtimeDAOJDBC implements ShowtimeDAO_interface {
//
////	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
////	private static DataSource ds = null;
////
////	static {
////		try {
////			Context ctx = new InitialContext();
////			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Movie");
////		} catch (NamingException e) {
////			e.printStackTrace();
////		}
////	}
//	String driver = "com.mysql.cj.jdbc.Driver";
//	String url = "jdbc:mysql://localhost:3306/Movie?serverTimezone=Asia/Taipei";
//	String userid = "David";
//	String passwd = "123456";
//	
//
//	private static final String INSERT_STMT = "insert into showtime (movie_no, theater_no, seat_no, showtime_time)"
//			+ "values(?, ?, ?, ?)";
//	private static final String GET_ALL_STMT = "select * from showtime order by showtime_no";
//	private static final String GET_ONE_STMT = "select * from showtime where showtime_no = ?";
//	private static final String DELETE = "delete from showtime where showtime_no = ?";
//	private static final String UPDATE = "update showtime set movie_no = ?, theater_no = ?, seat_no = ?,"
//			+ " showtime_time = ? where showtime_no = ?";
//
//	@Override
//	public void insert(ShowtimeVO showtimeVO) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
////			con = ds.getConnection();
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(INSERT_STMT);
//
//			pstmt.setInt(1, showtimeVO.getMovie_no());
//			pstmt.setInt(2, showtimeVO.getTheater_no());
//			pstmt.setString(3, showtimeVO.getSeat_no());
//			pstmt.setTimestamp(4, showtimeVO.getShowtime_time());
//
//			pstmt.executeUpdate();
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		}finally {
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
//	}
//
//	@Override
//	public void update(ShowtimeVO showtimeVO) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(UPDATE);
//
//			pstmt.setInt(1, showtimeVO.getMovie_no());
//			pstmt.setInt(2, showtimeVO.getTheater_no());
//			pstmt.setString(3, showtimeVO.getSeat_no());
//			pstmt.setTimestamp(4, showtimeVO.getShowtime_time());
//			pstmt.setInt(5, showtimeVO.getShowtime_no());
//			
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		}catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		} finally {
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
//	}
//
//	@Override
//	public void delete(Integer showtime_no) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setInt(1, showtime_no);
//
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		}catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		} finally {
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
//	}
//
//	@Override
//	public ShowtimeVO findByPrimaryKey(Integer showtime_no) {
//		
//		ShowtimeVO showtimeVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(GET_ONE_STMT);
//			
//			pstmt.setInt(1, showtime_no);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				// theaterVO 也稱為 Domain objects
//				showtimeVO = new ShowtimeVO();
//				showtimeVO.setShowtime_no(rs.getInt("showtime_no"));
//				showtimeVO.setMovie_no(rs.getInt("movie_no"));
//				showtimeVO.setTheater_no(rs.getInt("theater_no"));
//				showtimeVO.setSeat_no(rs.getString("seat_no"));
//				showtimeVO.setShowtime_time(rs.getTimestamp("showtime_time"));
//			}
//			
//			
//		}catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
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
//		return showtimeVO;
//	}
//
//	@Override
//	public List<ShowtimeVO> getAll() {
//		List<ShowtimeVO> list = new ArrayList<ShowtimeVO>();
//		ShowtimeVO showtimeVO = null;
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(GET_ALL_STMT);
//			rs = pstmt.executeQuery();
//
//			while(rs.next()) {
//				// theaterVO 也稱為 Domain objects
//				showtimeVO = new ShowtimeVO();
//				
//				showtimeVO.setShowtime_no(rs.getInt("showtime_no"));
//				showtimeVO.setMovie_no(rs.getInt("movie_no"));
//				showtimeVO.setTheater_no(rs.getInt("theater_no"));
//				showtimeVO.setSeat_no(rs.getString("seat_no"));
//				showtimeVO.setShowtime_time(rs.getTimestamp("showtime_time"));
//				list.add(showtimeVO);
//			}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
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
//		return list;
//	}
//	
//	public static void main(String[] args) {
//		
//		ShowtimeDAOJDBC dao = new ShowtimeDAOJDBC();
//		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		
//		ShowtimeVO showtimeVO = dao.findByPrimaryKey(1);
//		System.out.print(showtimeVO.getShowtime_no() + ",");
//		System.out.print(showtimeVO.getMovie_no() + ",");
//		System.out.print(showtimeVO.getTheater_no() + ",");
//		System.out.print(df.format(showtimeVO.getShowtime_time()) + ",");
//		System.out.print(showtimeVO.getSeat_no() + ",");
//		System.out.println("");
//		
//		List<ShowtimeVO> list = dao.getAll();
//		for(ShowtimeVO showtimeVO1 : list) {
//		System.out.print(showtimeVO1.getShowtime_no() + ",");
//		System.out.print(showtimeVO1.getMovie_no() + ",");
//		System.out.print(showtimeVO1.getTheater_no() + ",");
//		System.out.print(df.format(showtimeVO1.getShowtime_time()) + ",");
//		System.out.print(showtimeVO1.getSeat_no() + ",");
//		System.out.println();
//		System.out.println("---------------------");
//		}
//		
////		ShowtimeVO showtimeVO3 = new ShowtimeVO();
//////	showtimeVO3.setShowtime_no();
////		showtimeVO3.setMovie_no(1);
////		showtimeVO3.setTheater_no(1);
////		showtimeVO3.setShowtime_time(java.sql.Timestamp.valueOf("2021-04-24 14:00:00"));
////		showtimeVO3.setSeat_no("0000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000");
////		dao.insert(showtimeVO3);
//		
////		ShowtimeVO showtimeVO3 = new ShowtimeVO();
////		showtimeVO3.setMovie_no(2);
////		showtimeVO3.setTheater_no(3);
////		showtimeVO3.setShowtime_time(java.sql.Timestamp.valueOf("2021-04-23 14:00:00"));
////		showtimeVO3.setSeat_no("0000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000");
////		showtimeVO3.setShowtime_no(11);
////		dao.update(showtimeVO3);
//		
////		dao.delete(11);
//		
//		
//	}
//	
//	
//	
//	
//	
//
//}