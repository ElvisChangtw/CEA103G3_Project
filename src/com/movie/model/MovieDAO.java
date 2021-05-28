package com.movie.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import com.comment.model.CommentVO;
import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Movie;


public class MovieDAO implements MovieDAO_interface{
	
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
			"insert into MOVIE (MOVIE_NAME,MOVIE_PIC1,MOVIE_PIC2,DIRECTOR,ACTOR,CATEGORY,LENGTH,STATUS,PREMIERE_DT,OFF_DT,TRAILOR,EMBED,GRADE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_STMT = 
			"update MOVIE set MOVIE_NAME=?, MOVIE_PIC1=?, MOVIE_PIC2=?, DIRECTOR=?, ACTOR=?, CATEGORY=?, LENGTH=?, STATUS=?, PREMIERE_DT=?, OFF_DT=?, TRAILOR=?, EMBED=?, GRADE=? where MOVIE_NO = ?";
	private static final String DELETE_REPORT_COMMENTS = 
			"with a as (select S2.REPORT_NO from MOVIE S0 left join COMMENT S1 on S0.MOVIE_NO = S1.MOVIE_NO left join REPORT_COMMENT S2 on S1.COMMENT_NO = S2.COMMENT_NO where S0.MOVIE_NO = ? and S2.REPORT_NO is not null and S1.COMMENT_NO is not null ) delete from REPORT_COMMENT where REPORT_NO in (select REPORT_NO from a)";
	private static final String DELETE_COMMENTS = 
			"delete from COMMENT where MOVIE_NO = ?";
	private static final String DELETE_MOVIE = 
			"delete from MOVIE where MOVIE_NO = ?";	
	private static final String GET_ONE_STMT = 
			"select * from MOVIE where MOVIE_NO = ?";
	private static final String GET_ALL_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE order by MOVIE_NO desc";
	private static final String GET_Comments_ByMovieno_STMT = 
			"select * from COMMENT where MOVIE_NO = ? order by COMMENT_NO";
	private static final String GET_TOP_TEN_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE order by RATING desc limit 12";
	private static final String GET_TOP_FIVE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE order by RATING desc limit 5";
	private static final String GET_BEST_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE order by RATING desc limit 1";
	private static final String GET_YEAR_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where YEAR(PREMIERE_DT) = ";
	private static final String GET_LATEST_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE order by PREMIERE_DT desc limit 6";
	private static final String GET_INTHEATERS_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where cast(now() as date) between PREMIERE_DT and OFF_DT order by PREMIERE_DT desc";
	private static final String GET_ONE_NEWEST_INTHEATERS_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where cast(now() as date) between PREMIERE_DT and OFF_DT order by PREMIERE_DT desc limit 1";
	private static final String GET_COMINGSOON_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where PREMIERE_DT between now() and date_sub(now(),interval -30 day) order by PREMIERE_DT";	
	private static final String GET_ONE_NEWEST_COMINGSOON_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where PREMIERE_DT between now() and date_sub(now(),interval -30 day) order by PREMIERE_DT desc limit 1";	
	private static final String GET_ALL_TOPRATING_INTHEATERS_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where cast(now() as date) between PREMIERE_DT and OFF_DT order by RATING desc";
	private static final String GET_ALL_TOPEXPECTATION_COMINGSOON_MOVIE_STMT = 
			"select MOVIE_NO, MOVIE_NAME, DIRECTOR, ACTOR, CATEGORY, LENGTH, STATUS, PREMIERE_DT, OFF_DT, TRAILOR, EMBED, GRADE, RATING, EXPECTATION from MOVIE where PREMIERE_DT between now() and date_sub(now(),interval -30 day) order by EXPECTATION desc";		
	
	private static final String UPDATE_MOVIE_RATING_STMT = 
			"update MOVIE set RATING=? where MOVIE_NO = ?";
	private static final String UPDATE_MOVIE_EXPECTATION_STMT = 
			"update MOVIE set EXPECTATION=? where MOVIE_NO = ?";
	
	private static final String SELECT_ALL_MOVIE_NAME = 
			"SELECT MOVIE_NO, MOVIE_NAME FROM `MOVIE`;";
	private static final String INSRET_MOVIE_NAME_INDEX = 
			"INSERT INTO `MOVIE_NAME_INDEX` VALUES  (?, ?);";
	
	private static final String UPDATE_MOVIE_ON = 
			"update MOVIE set `STATUS`= 0 where PREMIERE_DT between date_sub(now(),interval +1 day) and now() and `STATUS` =1;";
	private static final String UPDATE_MOVIE_DOWN = 
			"update MOVIE set `STATUS`= 2 where OFF_DT < cast(now() as date) and `STATUS` = 0;";
	
	
	
	//揪團要取24HR之後有場次的電影列表用
		private static final String GET_ALL_FOR_GROUP = 
			"select S0.*  from MOVIE S0 " + 
			"LEFT JOIN ( " + 
			"select MOVIE_NO, MAX(SHOWTIME_TIME) SHOWTIME_TIME from SHOWTIME GROUP BY MOVIE_NO " + 
			")A  ON S0.MOVIE_NO = A.MOVIE_NO " + 
			"where DATE_ADD(NOW(), interval 1 day ) <  A.SHOWTIME_TIME AND S0.STATUS = 0 " + 
			"order by S0.MOVIE_NO ";
	
	
	@Override
	public void insert(MovieVO movieVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, movieVO.getMoviename());
			pstmt.setBytes(2, movieVO.getMoviepicture1());
			pstmt.setBytes(3, movieVO.getMoviepicture2());
			pstmt.setString(4, movieVO.getDirector());
			pstmt.setString(5, movieVO.getActor());
			pstmt.setString(6, movieVO.getCategory());
			pstmt.setInt(7, movieVO.getLength());
			pstmt.setString(8, movieVO.getStatus());
			pstmt.setDate(9, movieVO.getPremiredate());
			pstmt.setDate(10, movieVO.getOffdate());
			pstmt.setString(11, movieVO.getTrailor());
			pstmt.setString(12, movieVO.getEmbed());
			pstmt.setString(13, movieVO.getGrade());

			pstmt.executeUpdate();

			createMovieIdex();
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public void update(MovieVO movieVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, movieVO.getMoviename());
			pstmt.setBytes(2, movieVO.getMoviepicture1());
			pstmt.setBytes(3, movieVO.getMoviepicture2());
			pstmt.setString(4, movieVO.getDirector());
			pstmt.setString(5, movieVO.getActor());
			pstmt.setString(6, movieVO.getCategory());
			pstmt.setInt(7, movieVO.getLength());
			pstmt.setString(8, movieVO.getStatus());
			pstmt.setDate(9, movieVO.getPremiredate());
			pstmt.setDate(10, movieVO.getOffdate());
			pstmt.setString(11, movieVO.getTrailor());
			pstmt.setString(12, movieVO.getEmbed());
			pstmt.setString(13, movieVO.getGrade());
			pstmt.setInt(14, movieVO.getMovieno());

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
	public void delete(Integer movieno) {
		int updateCount_Comments = 0;
		int updateCount_ReportComments = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();

			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			//先刪除檢舉評論
			pstmt = con.prepareStatement(DELETE_REPORT_COMMENTS);
			pstmt.setInt(1, movieno);
			updateCount_ReportComments = pstmt.executeUpdate();
			// 先刪除評論
			pstmt = con.prepareStatement(DELETE_COMMENTS);
			pstmt.setInt(1, movieno);
			updateCount_Comments = pstmt.executeUpdate();
			// 再刪除電影
			pstmt = con.prepareStatement(DELETE_MOVIE);
			pstmt.setInt(1, movieno);
			pstmt.executeUpdate();

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除電影編號" + movieno + "時,共有評論" + updateCount_Comments
					+ "則同時被刪除,共有檢舉評論 " + updateCount_ReportComments +"則同時被刪除");
			
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public MovieVO findByPrimaryKey(Integer movieno) {
		
		MovieVO movieVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, movieno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVo 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				
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
		return movieVO;
	}
	
	@Override
	public List<MovieVO> getAll() {
		List<MovieVO> list = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				list.add(movieVO); // Store the row in the list
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
	public List<MovieVO> getAll(Map<String, String[]> map) {
		List<MovieVO> list = new ArrayList<MovieVO>();
		MovieVO movieVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			con = ds.getConnection();	
			
//			String finalSQL = "select * from MOVIE "
//		          + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
//		          + "order by MOVIE_NO";
			
			String finalSQL =
					"WITH B AS( "
				   +" select S0.MOVIE_NO,  COUNT(S0.MOVIE_NO) CNT from "
				   +" `movie` S0 LEFT JOIN MOVIE_NAME_INDEX S1 "
				   + " ON S0.MOVIE_NO = S1.MOVIE_NO "
				   + jdbcUtil_CompositeQuery_Movie.get_OnCondition(map)
				   + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
				   +" GROUP BY S0.MOVIE_NO "
				   + ") "			
				   + "select  "
				   + "S0.MOVIE_NO, S0.MOVIE_NAME, S0.DIRECTOR, S0.ACTOR, "
				   + "S0.CATEGORY, S0.LENGTH, S0.STATUS, S0.PREMIERE_DT, "
				   + "S0.OFF_DT, S0.TRAILOR, S0.EMBED, S0.GRADE, "
				   + "S0.RATING, S0.EXPECTATION "
				   + " from movie S0 LEFT JOIN "
				   +" B ON S0.MOVIE_NO = B.MOVIE_NO "
				   + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
				   +" ORDER BY (CASE WHEN B.CNT IS NULL THEN 0 ELSE B.CNT END) DESC, MOVIE_NO DESC"
				   ;
			
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				list.add(movieVO); // Store the row in the List
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
	public Set<CommentVO> getCommentsByMovieno(Integer movieno) {
		Set<CommentVO> set = new LinkedHashSet<CommentVO>();
		CommentVO commentVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Comments_ByMovieno_STMT);
			pstmt.setInt(1, movieno);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				commentVO = new CommentVO();
				commentVO.setCommentno(rs.getInt("COMMENT_NO"));
				commentVO.setMemberno(rs.getInt("MEMBER_NO"));
				commentVO.setMovieno(rs.getInt("MOVIE_NO"));
				commentVO.setContent(rs.getString("CONTENT"));
				commentVO.setCreatdate(rs.getTimestamp("CRT_DT"));
				commentVO.setModifydate(rs.getTimestamp("MODIFY_DT"));
				commentVO.setStatus(rs.getString("STATUS"));
				set.add(commentVO); // Store the row in the vector
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

	public List<MovieVO> getTopTen() {
		List<MovieVO> listTopTen = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_TOP_TEN_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				listTopTen.add(movieVO); // Store the row in the list
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
		return listTopTen;
	}
	
	public List<MovieVO> getTopFive() {
		List<MovieVO> listTopFive = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_TOP_FIVE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				listTopFive.add(movieVO); // Store the row in the list
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
		return listTopFive;
	}
	
	public MovieVO getBestMovie() {
		MovieVO bestMovie = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BEST_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				bestMovie = new MovieVO();
				bestMovie.setMovieno(rs.getInt("MOVIE_NO"));
				bestMovie.setMoviename(rs.getString("MOVIE_NAME"));
//				bestMovie.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				bestMovie.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				bestMovie.setDirector(rs.getString("DIRECTOR"));
				bestMovie.setActor(rs.getString("ACTOR"));
				bestMovie.setCategory(rs.getString("CATEGORY"));
				bestMovie.setLength(rs.getInt("LENGTH"));
				bestMovie.setStatus(rs.getString("STATUS"));
				bestMovie.setPremiredate(rs.getDate("PREMIERE_DT"));
				bestMovie.setOffdate(rs.getDate("OFF_DT"));
				bestMovie.setTrailor(rs.getString("TRAILOR"));
				bestMovie.setEmbed(rs.getString("EMBED"));
				bestMovie.setGrade(rs.getString("GRADE"));
				bestMovie.setRating(rs.getDouble("RATING"));
				bestMovie.setExpectation(rs.getDouble("EXPECTATION"));
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
		return bestMovie;
	}

	@Override
	public List<MovieVO> getYearMovie(String year) {
		List<MovieVO> yearMovie = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_YEAR_MOVIE_STMT +" " + year +  " order by PREMIERE_DT desc");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				yearMovie.add(movieVO); // Store the row in the list
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
		return yearMovie;
	}
	
	public List<MovieVO> getLatestMovie() {
		List<MovieVO> latestMovie = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_LATEST_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				latestMovie.add(movieVO); // Store the row in the list
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
		return latestMovie;
	}
	
	public List<MovieVO> getInTheatersMovie() {
		List<MovieVO> inTheatersMovie = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_INTHEATERS_MOVIE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				inTheatersMovie.add(movieVO); // Store the row in the list
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
		return inTheatersMovie;
	}
	
	public MovieVO getOneNewestInTheatersMovie() {
		MovieVO oneNewestInTheatersMovie = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_NEWEST_INTHEATERS_MOVIE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				oneNewestInTheatersMovie = new MovieVO();
				oneNewestInTheatersMovie.setMovieno(rs.getInt("MOVIE_NO"));
				oneNewestInTheatersMovie.setMoviename(rs.getString("MOVIE_NAME"));
//				oneNewestInTheatersMovie.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				oneNewestInTheatersMovie.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				oneNewestInTheatersMovie.setDirector(rs.getString("DIRECTOR"));
				oneNewestInTheatersMovie.setActor(rs.getString("ACTOR"));
				oneNewestInTheatersMovie.setCategory(rs.getString("CATEGORY"));
				oneNewestInTheatersMovie.setLength(rs.getInt("LENGTH"));
				oneNewestInTheatersMovie.setStatus(rs.getString("STATUS"));
				oneNewestInTheatersMovie.setPremiredate(rs.getDate("PREMIERE_DT"));
				oneNewestInTheatersMovie.setOffdate(rs.getDate("OFF_DT"));
				oneNewestInTheatersMovie.setTrailor(rs.getString("TRAILOR"));
				oneNewestInTheatersMovie.setEmbed(rs.getString("EMBED"));
				oneNewestInTheatersMovie.setGrade(rs.getString("GRADE"));
				oneNewestInTheatersMovie.setRating(rs.getDouble("RATING"));
				oneNewestInTheatersMovie.setExpectation(rs.getDouble("EXPECTATION"));
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
		return oneNewestInTheatersMovie;
	}
	
	public List<MovieVO> getComingSoonMovie() {
		List<MovieVO> comingSoonMovie = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COMINGSOON_MOVIE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				comingSoonMovie.add(movieVO); // Store the row in the list
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
		return comingSoonMovie;
	}
	
	public MovieVO getOneNewestComingSoonMovie() {
		MovieVO oneNewestComingSoonMovie = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_NEWEST_COMINGSOON_MOVIE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				oneNewestComingSoonMovie = new MovieVO();
				oneNewestComingSoonMovie.setMovieno(rs.getInt("MOVIE_NO"));
				oneNewestComingSoonMovie.setMoviename(rs.getString("MOVIE_NAME"));
//				oneNewestComingSoonMovie.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				oneNewestComingSoonMovie.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				oneNewestComingSoonMovie.setDirector(rs.getString("DIRECTOR"));
				oneNewestComingSoonMovie.setActor(rs.getString("ACTOR"));
				oneNewestComingSoonMovie.setCategory(rs.getString("CATEGORY"));
				oneNewestComingSoonMovie.setLength(rs.getInt("LENGTH"));
				oneNewestComingSoonMovie.setStatus(rs.getString("STATUS"));
				oneNewestComingSoonMovie.setPremiredate(rs.getDate("PREMIERE_DT"));
				oneNewestComingSoonMovie.setOffdate(rs.getDate("OFF_DT"));
				oneNewestComingSoonMovie.setTrailor(rs.getString("TRAILOR"));
				oneNewestComingSoonMovie.setEmbed(rs.getString("EMBED"));
				oneNewestComingSoonMovie.setGrade(rs.getString("GRADE"));
				oneNewestComingSoonMovie.setRating(rs.getDouble("RATING"));
				oneNewestComingSoonMovie.setExpectation(rs.getDouble("EXPECTATION"));
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
		return oneNewestComingSoonMovie;
	}
	
	public List<MovieVO> getAllTopRatingInTheatersMovie() {
		List<MovieVO> allTopRatingInTheatersMovie = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_TOPRATING_INTHEATERS_MOVIE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				allTopRatingInTheatersMovie.add(movieVO); // Store the row in the list
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
		return allTopRatingInTheatersMovie;
	}
	
	public List<MovieVO> getAllTopExpectationComingSoonMovie() {
		List<MovieVO> allTopExpectationComingSoonMovie = new ArrayList<MovieVO>();
		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_TOPEXPECTATION_COMINGSOON_MOVIE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// movieVO 也稱為 Domain objects
				movieVO = new MovieVO();
				movieVO.setMovieno(rs.getInt("MOVIE_NO"));
				movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//				movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//				movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
				movieVO.setDirector(rs.getString("DIRECTOR"));
				movieVO.setActor(rs.getString("ACTOR"));
				movieVO.setCategory(rs.getString("CATEGORY"));
				movieVO.setLength(rs.getInt("LENGTH"));
				movieVO.setStatus(rs.getString("STATUS"));
				movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
				movieVO.setOffdate(rs.getDate("OFF_DT"));
				movieVO.setTrailor(rs.getString("TRAILOR"));
				movieVO.setEmbed(rs.getString("EMBED"));
				movieVO.setGrade(rs.getString("GRADE"));
				movieVO.setRating(rs.getDouble("RATING"));
				movieVO.setExpectation(rs.getDouble("EXPECTATION"));
				allTopExpectationComingSoonMovie.add(movieVO); // Store the row in the list
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
		return allTopExpectationComingSoonMovie;
	}
	
	@Override
	public void updateMovieRating(MovieVO movieVO , Connection con) {
		
		PreparedStatement pstmt = null;

		try {
     		pstmt = con.prepareStatement(UPDATE_MOVIE_RATING_STMT );

			pstmt.setDouble(1, movieVO.getRating());	
			pstmt.setInt(2, movieVO.getMovieno());

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
		}
	}
	
	@Override
	public void updateMovieExpectation(MovieVO movieVO , Connection con) {
		
		PreparedStatement pstmt = null;

		try {
     		pstmt = con.prepareStatement(UPDATE_MOVIE_EXPECTATION_STMT );

			pstmt.setDouble(1, movieVO.getExpectation());	
			pstmt.setInt(2, movieVO.getMovieno());

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
		}
	}
	
	@Override
	public void updateMovieStatus() {

		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt1 = con.prepareStatement(UPDATE_MOVIE_ON);
			pstmt2 = con.prepareStatement(UPDATE_MOVIE_DOWN);
			pstmt1.executeUpdate();
			pstmt2.executeUpdate();

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
	
	
	//Elvis新增
		@Override
		public void createMovieIdex() {

			Connection con = null;
			PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null;
			ResultSet rs = null;
			
			Character[] tabueArray = new Character[] { ' ',',','.', ':', ';', '~', '/', '?', '\\', '|','：', '-','?', '「', '」', '，', '。'};
			List<Character> tabuList = Arrays.asList(tabueArray);
			
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(SELECT_ALL_MOVIE_NAME);
				pstmt2 = con.prepareStatement(INSRET_MOVIE_NAME_INDEX);
				pstmt3 = con.prepareStatement("truncate table MOVIE_NAME_INDEX");
				rs = pstmt.executeQuery();
				Integer movie_no = null;
				String movie_name = null;
				Character ch = null;
				
				pstmt3.executeUpdate();
				
				rs = pstmt.executeQuery();
				while (rs.next()) {
					movie_no = rs.getInt("MOVIE_NO");
					movie_name = rs.getString("MOVIE_NAME");
					for (int i = 0 ; i < movie_name.length(); i++) {
						ch = movie_name.charAt(i);
						
						if (tabuList.indexOf(ch) == -1) {
//							System.out.println("charAt(i) =  " + ch);
							pstmt2.setInt(1, movie_no);
							pstmt2.setString(2, String.valueOf(movie_name.charAt(i)));
							pstmt2.addBatch();
						} else {
//							System.out.println("不符資格 =  " + ch);
						}
					}
				}
				pstmt2.executeBatch();
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
		public List<MovieVO> getAllForGroup() {
			List<MovieVO> list = new ArrayList<MovieVO>();
			MovieVO movieVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_FOR_GROUP);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// movieVO 也稱為 Domain objects
					movieVO = new MovieVO();
					movieVO.setMovieno(rs.getInt("MOVIE_NO"));
					movieVO.setMoviename(rs.getString("MOVIE_NAME"));
//					movieVO.setMoviepicture1(rs.getBytes("MOVIE_PIC1"));
//					movieVO.setMoviepicture2(rs.getBytes("MOVIE_PIC2"));
					movieVO.setDirector(rs.getString("DIRECTOR"));
					movieVO.setActor(rs.getString("ACTOR"));
					movieVO.setCategory(rs.getString("CATEGORY"));
					movieVO.setLength(rs.getInt("LENGTH"));
					movieVO.setStatus(rs.getString("STATUS"));
					movieVO.setPremiredate(rs.getDate("PREMIERE_DT"));
					movieVO.setOffdate(rs.getDate("OFF_DT"));
					movieVO.setTrailor(rs.getString("TRAILOR"));
					movieVO.setEmbed(rs.getString("EMBED"));
					movieVO.setGrade(rs.getString("GRADE"));
					movieVO.setRating(rs.getDouble("RATING"));
					movieVO.setExpectation(rs.getDouble("EXPECTATION"));
					list.add(movieVO); // Store the row in the list
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
