package com.food.model;

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

import com.expectation.model.ExpectationVO;
import com.movie.model.MovieDAO;
import com.movie.model.MovieVO;

public class FoodDAO implements FoodDAO_interface {

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

	private static final String INSERT_STMT = "insert into food (food_name, food_type, food_price, food_pic, food_status) "
			+ "values(?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from food order by food_no desc";
	private static final String GET_ONE_STMT = "select * from food where food_no = ?";
	private static final String DELETE = "delete from food where food_no = ?";
	private static final String UPDATE = "update food set food_name = ?, food_type = ?, food_price = ?, food_pic = ?  , food_status = ? "
			+ "where food_no = ?";
	
	
	private static final String SELECT_ON_OR_OFF_STMT = 
			"select IF(EXISTS(select * from FOOD where FOOD_NO = ? and FOOD_STATUS = 1 ),'ON','OFF' )as `action`";
	private static final String UPDATE_FOOD_STATUS_ON_STMT = 
			"update food set food_status = 1 where food_no = ?";
	private static final String UPDATE_FOOD_STATUS_OFF_STMT = 
			"update food set food_status = 0 where food_no = ?";
	
	@Override
	public void onOrDownFoodStatus(Integer food_no) {

		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;	
		ResultSet rs = null;

		try {

			con = ds.getConnection();			

			pstmt1 = con.prepareStatement(SELECT_ON_OR_OFF_STMT);	
			pstmt1.setInt(1, food_no);

			rs = pstmt1.executeQuery();
			
			//再判斷是要上架還是下架
			rs.next();
			if(rs.getString("action").equals("ON")) {
				pstmt2 = con.prepareStatement(UPDATE_FOOD_STATUS_OFF_STMT);			
				pstmt2.setInt(1, food_no);
				pstmt2.executeUpdate();	
			}else {
				pstmt2 = con.prepareStatement(UPDATE_FOOD_STATUS_ON_STMT);	
				pstmt2.setInt(1, food_no);
				pstmt2.executeUpdate();	
			}
			// Handle any SQL errors
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
	
	

	@Override
	public void insert(FoodVO foodVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, foodVO.getFood_name());
			pstmt.setString(2, foodVO.getFood_type());
			pstmt.setInt(3, foodVO.getFood_price());
			pstmt.setBytes(4, foodVO.getFood_pic());
			pstmt.setString(5, foodVO.getFood_status());

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
	public void update(FoodVO foodVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, foodVO.getFood_name());
			pstmt.setString(2, foodVO.getFood_type());
			pstmt.setInt(3, foodVO.getFood_price());
			pstmt.setBytes(4, foodVO.getFood_pic());
			pstmt.setString(5, foodVO.getFood_status());
			pstmt.setInt(6, foodVO.getFood_no());
			
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
	public void delete(Integer food_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, food_no);

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
	public FoodVO findByPrimaryKey(Integer food_no) {
		
		FoodVO foodVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, food_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				foodVO = new FoodVO();
				foodVO.setFood_no(rs.getInt("food_no"));
				foodVO.setFood_name(rs.getString("food_name"));
				foodVO.setFood_type(rs.getString("food_type"));
				foodVO.setFood_price(rs.getInt("food_price"));
				foodVO.setFood_pic(rs.getBytes("food_pic"));
				foodVO.setFood_status(rs.getString("food_status"));
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
		
		return foodVO;
	}

	@Override
	public List<FoodVO> getAll() {
		List<FoodVO> list = new ArrayList<FoodVO>();
		FoodVO foodVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				foodVO = new FoodVO();
				
				foodVO.setFood_no(rs.getInt("food_no"));
				foodVO.setFood_name(rs.getString("food_name"));
				foodVO.setFood_type(rs.getString("food_type"));
				foodVO.setFood_price(rs.getInt("food_price"));
				foodVO.setFood_pic(rs.getBytes("food_pic"));
				foodVO.setFood_status(rs.getString("food_status"));
				list.add(foodVO);
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