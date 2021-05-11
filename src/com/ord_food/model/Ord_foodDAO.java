package com.ord_food.model;

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

public class Ord_foodDAO implements Ord_foodDAO_interface {

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

	private static final String INSERT_STMT = "insert into ord_food (order_no, food_no, food_count, price) "
			+ "values(?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from ord_food order by order_no, food_no";
	private static final String GET_ONE_STMT = "select * from ord_food where order_no = ? and food_no = ?";
	private static final String DELETE = "delete from ord_food where order_no = ? and food_no = ?";
	private static final String UPDATE = "update ord_food set food_count = ?, price = ? "
			+ "where order_no = ? and food_no = ?";
	private static final String GET_ALL_FOOD_STMT = "select * from ord_food where order_no=?";

	@Override
	public void insert(Ord_foodVO ord_foodVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, ord_foodVO.getOrder_no());
			pstmt.setInt(2, ord_foodVO.getFood_no());
			pstmt.setInt(3, ord_foodVO.getFood_count());
			pstmt.setInt(4, ord_foodVO.getPrice());

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
	public void update(Ord_foodVO ord_foodVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, ord_foodVO.getFood_count());
			pstmt.setInt(2, ord_foodVO.getPrice());
			pstmt.setInt(3, ord_foodVO.getOrder_no());
			pstmt.setInt(4, ord_foodVO.getFood_no());
			
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
	public void delete(Integer order_no, Integer food_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, order_no);
			pstmt.setInt(2, food_no);

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
	public Ord_foodVO findByPrimaryKey(Integer order_no, Integer food_no) {
		
		Ord_foodVO ord_foodVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, order_no);
			pstmt.setInt(2, food_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ord_foodVO = new Ord_foodVO();
				ord_foodVO.setOrder_no(rs.getInt("order_no"));
				ord_foodVO.setFood_no(rs.getInt("food_no"));
				ord_foodVO.setFood_count(rs.getInt("food_count"));
				ord_foodVO.setPrice(rs.getInt("price"));
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
		
		return ord_foodVO;
	}

	@Override
	public List<Ord_foodVO> getAll() {
		List<Ord_foodVO> list = new ArrayList<Ord_foodVO>();
		Ord_foodVO ord_foodVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ord_foodVO = new Ord_foodVO();
				ord_foodVO.setOrder_no(rs.getInt("order_no"));
				ord_foodVO.setFood_no(rs.getInt("food_no"));
				ord_foodVO.setFood_count(rs.getInt("food_count"));
				ord_foodVO.setPrice(rs.getInt("price"));
				list.add(ord_foodVO);
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
	public void insert2(Ord_foodVO ord_foodVO, Connection con) {

		PreparedStatement pstmt = null;

		try {

			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, ord_foodVO.getOrder_no());
			pstmt.setInt(2, ord_foodVO.getFood_no());
			pstmt.setInt(3, ord_foodVO.getFood_count());
			pstmt.setInt(4, ord_foodVO.getPrice());

			pstmt.executeUpdate();
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-Ord_food");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
	public List<Ord_foodVO> getAllFoodByOrderno(Integer order_no) {
		List<Ord_foodVO> list = new ArrayList<Ord_foodVO>();
		Ord_foodVO ord_foodVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_FOOD_STMT);
			pstmt.setInt(1, order_no);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ord_foodVO = new Ord_foodVO();
				ord_foodVO.setOrder_no(rs.getInt("order_no"));
				ord_foodVO.setFood_no(rs.getInt("food_no"));
				ord_foodVO.setFood_count(rs.getInt("food_count"));
				ord_foodVO.setPrice(rs.getInt("price"));
				list.add(ord_foodVO);
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