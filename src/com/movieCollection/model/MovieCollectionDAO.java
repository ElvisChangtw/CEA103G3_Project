package com.movieCollection.model;

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



public class MovieCollectionDAO implements MovieCollectionDAO_interface{

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
			"INSERT INTO moviecollection (movie_no, member_no) VALUES (?, ?)";
	private static final String DELETE = 
			"DELETE FROM moviecollection where movie_no = ? and member_no = ? ";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM moviecollection where member_no = ? ";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM moviecollection order by movie_no";
	
	public void insert(MovieCollectionVO movieCollectionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, movieCollectionVO.getMovie_no());
			pstmt.setInt(2, movieCollectionVO.getMember_no());
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
	public List<MovieCollectionVO> findByPrimaryKey(Integer member_no) {
		MovieCollectionVO movieCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MovieCollectionVO> list = new ArrayList<MovieCollectionVO>();
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, member_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				movieCollectionVO = new MovieCollectionVO();
				movieCollectionVO.setMovie_no(rs.getInt("movie_no"));
				movieCollectionVO.setMember_no(rs.getInt("member_no"));
				movieCollectionVO.setCrt_dt(rs.getDate("crt_dt"));
				list.add(movieCollectionVO);
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
	public List<MovieCollectionVO> getAll() {
		List<MovieCollectionVO> list = new ArrayList<MovieCollectionVO>();
		MovieCollectionVO movieCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				movieCollectionVO = new MovieCollectionVO();
				movieCollectionVO.setMovie_no(rs.getInt("movie_no"));
				movieCollectionVO.setMember_no(rs.getInt("member_no"));
				movieCollectionVO.setCrt_dt(rs.getDate("crt_dt"));
				list.add(movieCollectionVO);
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
