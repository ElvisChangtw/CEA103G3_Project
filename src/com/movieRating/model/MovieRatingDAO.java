package com.movieRating.model;

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

import com.movieExpect.model.MovieExpectVO;

public class MovieRatingDAO implements MovieRatingDAO_interface{
	
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
			"INSERT INTO rating (movie_no, member_no, rating, crt_dt, modify_dt) VALUES (?, ?, ?, default, default)";
	private static final String UPDATE = 
			"UPDATE rating set rating = ?, modify_dt = default where movie_no = ? and member_no = ? ";
	private static final String DELETE = 
			"DELETE FROM rating where movie_no = ? and member_no = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM rating order by movie_no";
	private static final String GET_ALL_RATING_BY_MEM = 
			"SELECT * FROM rating where member_no=?";

	@Override
	public void insert(MovieRatingVO movieRatingVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, movieRatingVO.getMovie_no());
			pstmt.setInt(2, movieRatingVO.getMember_no());
			pstmt.setFloat(3, movieRatingVO.getRating());
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
	public void update(MovieRatingVO movieRatingVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setFloat(1, movieRatingVO.getRating());
			pstmt.setInt(2, movieRatingVO.getMovie_no());
			pstmt.setInt(3, movieRatingVO.getMember_no());

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
	public void delete(Integer movie_no, Integer member_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, movie_no);
			pstmt.setInt(2, member_no);

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
	public List<MovieRatingVO> getAll() {
		List<MovieRatingVO> list = new ArrayList<MovieRatingVO>();
		MovieRatingVO movieRatingVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				movieRatingVO = new MovieRatingVO();
				movieRatingVO.setMovie_no(rs.getInt("movie_no"));
				movieRatingVO.setMember_no(rs.getInt("member_no"));
				movieRatingVO.setRating(rs.getFloat("rating"));
				movieRatingVO.setCrt_dt(rs.getDate("crt_dt"));
				movieRatingVO.setModify_dt(rs.getDate("modify_dt"));
				list.add(movieRatingVO);
			}
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
	
	public List<MovieRatingVO> getAllRating(Integer member_no) {
		List<MovieRatingVO> list = new ArrayList<MovieRatingVO>();
		MovieRatingVO movieRatingVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_RATING_BY_MEM);
			pstmt.setInt(1, member_no);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				movieRatingVO = new MovieRatingVO();
				movieRatingVO.setMovie_no(rs.getInt("movie_no"));
				movieRatingVO.setMember_no(rs.getInt("member_no"));
				movieRatingVO.setRating(rs.getFloat("rating"));
				list.add(movieRatingVO);
			}
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
