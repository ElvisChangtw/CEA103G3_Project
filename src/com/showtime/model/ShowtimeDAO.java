package com.showtime.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import com.showtime.model.ShowtimeVO;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Showtime;
import util.HibernateUtil;

public class ShowtimeDAO implements ShowtimeDAO_interface {

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

	private static final String INSERT_STMT = "insert into showtime (movie_no, theater_no, seat_no, showtime_time)"
			+ "values(?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from showtime order by showtime_time";
	private static final String GET_ONE_STMT = "select * from showtime where showtime_no = ?";
	private static final String DELETE = "delete from showtime where showtime_no = ?";
	private static final String UPDATE = "update showtime set movie_no = ?, theater_no = ?, seat_no = ?,"
			+ " showtime_time = ? where showtime_no = ?";
	private static final String UPDATE_SEATNO = "update showtime set seat_no = ? where showtime_no = ?";

	private static final String GET_ALL_BY_MOVIE_STMT = "select showtime_no, movie_no, theater_no, showtime_time from showtime where movie_no = ? order by showtime_time; ";
	
	@Override
	public void insert(ShowtimeVO showtimeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, showtimeVO.getMovie_no());
			pstmt.setInt(2, showtimeVO.getTheater_no());
			pstmt.setString(3, showtimeVO.getSeat_no());
			pstmt.setTimestamp(4, showtimeVO.getShowtime_time());

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
	public void insert_showtimes(List<ShowtimeVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			for(ShowtimeVO showtimeVO : list) {
				pstmt.setInt(1, showtimeVO.getMovie_no());
				pstmt.setInt(2, showtimeVO.getTheater_no());
				pstmt.setString(3, showtimeVO.getSeat_no());
				pstmt.setTimestamp(4, showtimeVO.getShowtime_time());
				pstmt.executeUpdate();
			}
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
	public void update(ShowtimeVO showtimeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, showtimeVO.getMovie_no());
			pstmt.setInt(2, showtimeVO.getTheater_no());
			pstmt.setString(3, showtimeVO.getSeat_no());
			pstmt.setTimestamp(4, showtimeVO.getShowtime_time());
			pstmt.setInt(5, showtimeVO.getShowtime_no());
			
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
	public void delete(Integer showtime_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, showtime_no);

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
	public ShowtimeVO findByPrimaryKey(Integer showtime_no) {
		
		ShowtimeVO showtimeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, showtime_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				showtimeVO = new ShowtimeVO();
				showtimeVO.setShowtime_no(rs.getInt("showtime_no"));
				showtimeVO.setMovie_no(rs.getInt("movie_no"));
				showtimeVO.setTheater_no(rs.getInt("theater_no"));
				showtimeVO.setSeat_no(rs.getString("seat_no"));
				showtimeVO.setShowtime_time(rs.getTimestamp("showtime_time"));
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
		
		return showtimeVO;
	}

	@Override
	public List<ShowtimeVO> getAll() {
		List<ShowtimeVO> list = new ArrayList<ShowtimeVO>();
		ShowtimeVO showtimeVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				showtimeVO = new ShowtimeVO();
				
				showtimeVO.setShowtime_no(rs.getInt("showtime_no"));
				showtimeVO.setMovie_no(rs.getInt("movie_no"));
				showtimeVO.setTheater_no(rs.getInt("theater_no"));
				showtimeVO.setSeat_no(rs.getString("seat_no"));
				showtimeVO.setShowtime_time(rs.getTimestamp("showtime_time"));
				list.add(showtimeVO);
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
	public List<ShowtimeVO> getAll(Map<String, String[]> map) {
		List<ShowtimeVO> list = new ArrayList<ShowtimeVO>();
		ShowtimeVO showtimeVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from showtime "
		          + jdbcUtil_CompositeQuery_Showtime.get_WhereCondition(map)
		          + "order by showtime_no";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				showtimeVO = new ShowtimeVO();
				
				showtimeVO.setShowtime_no(rs.getInt("showtime_no"));
				showtimeVO.setMovie_no(rs.getInt("movie_no"));
				showtimeVO.setTheater_no(rs.getInt("theater_no"));
				showtimeVO.setSeat_no(rs.getString("seat_no"));
				showtimeVO.setShowtime_time(rs.getTimestamp("showtime_time"));
				list.add(showtimeVO);
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
	
	@Override
	public void update2(String seat_no, Integer showtime_no, java.sql.Connection con) {
		PreparedStatement pstmt = null;
		
		try {
			pstmt = con.prepareStatement(UPDATE_SEATNO);
			pstmt.setString(1, seat_no);
			pstmt.setInt(2, showtime_no);
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-showtime");
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
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
	}
	

	@Override
	public List<ShowtimeVO> getAllByMovie_no(Integer movie_no) {
		List<ShowtimeVO> list = new ArrayList<ShowtimeVO>();
		ShowtimeVO showtimeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MOVIE_STMT);
			pstmt.setInt(1, movie_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// messageVO 也稱為 Domain objects
				showtimeVO = new ShowtimeVO();
				showtimeVO.setShowtime_no(rs.getInt("SHOWTIME_NO"));
				showtimeVO.setMovie_no(rs.getInt("MOVIE_NO"));
				showtimeVO.setTheater_no(rs.getInt("THEATER_NO"));
				showtimeVO.setShowtime_time(rs.getTimestamp("SHOWTIME_TIME"));
				list.add(showtimeVO); // Store the row in the list
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
	public List<Object[]> getAllByDate() {
		List<Object[]> list = null;
		System.out.println("1");
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		System.out.println("2");
		try {
			session.beginTransaction();
			System.out.println("3");
			@SuppressWarnings("unchecked")
			NativeQuery<Object[]> query2 = session.createNativeQuery("select distinct s.movie_no, m.movie_name, m.off_dt from showtime s join movie m where m.movie_no = s.movie_no and s.showtime_time >= now() order by movie_no");
			list = query2.getResultList();
			System.out.println("4");
			for(int i = 0; i < list.size(); i++) {
				for(int j = 0; j < list.get(i).length; j++) {
					System.out.println(list.get(i)[j]);
				}
			}
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
		
	}
	
	@Override
	public List<Object[]> getByHibernate(String sql) {
		List<Object[]> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			@SuppressWarnings("unchecked")
			NativeQuery<Object[]> query2 = session.createNativeQuery(sql);
			list = query2.getResultList();
			System.out.println(list.size());
			
//			for(int i = 0; i < list.size(); i++) {
//				System.out.println(list.get(0));
//				System.out.println(list.get(i));
//			}
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
		
	}

}