package com.ord_ticket_type.model;

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

public class Ord_ticket_typeDAO implements Ord_ticket_typeDAO_interface {

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

	private static final String INSERT_STMT = "insert into ord_ticket_type (ticket_type_no, order_no, "
			+ "ticket_count, price) values(?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from ord_ticket_type order by order_no, ticket_type_no";
	private static final String GET_ONE_STMT = "select * from ord_ticket_type where ticket_type_no = ? and order_no = ?";
	private static final String DELETE = "delete from ord_ticket_type where ticket_type_no = ? and order_no = ?";
	private static final String UPDATE = "update ord_ticket_type set ticket_count = ?, price = ? "
			+ "where ticket_type_no = ? and order_no = ?";
	private static final String GET_ALL_TICKET_STMT = "select * from ord_ticket_type where order_no=?";
	
	@Override
	public void insert(Ord_ticket_typeVO ord_ticket_typeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, ord_ticket_typeVO.getTicket_type_no());
			pstmt.setInt(2, ord_ticket_typeVO.getOrder_no());
			pstmt.setInt(3, ord_ticket_typeVO.getTicket_count());
			pstmt.setInt(4, ord_ticket_typeVO.getPrice());

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
	public void update(Ord_ticket_typeVO ord_ticket_typeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, ord_ticket_typeVO.getTicket_count());
			pstmt.setInt(2, ord_ticket_typeVO.getPrice());
			pstmt.setInt(3, ord_ticket_typeVO.getTicket_type_no());
			pstmt.setInt(4, ord_ticket_typeVO.getOrder_no());
			
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
	public void delete(Integer ticket_type_no, Integer order_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ticket_type_no);
			pstmt.setInt(2, order_no);

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
	public Ord_ticket_typeVO findByPrimaryKey(Integer ticket_type_no, Integer order_no) {
		
		Ord_ticket_typeVO ord_ticket_typeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, ticket_type_no);
			pstmt.setInt(2, order_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ord_ticket_typeVO = new Ord_ticket_typeVO();
				
				ord_ticket_typeVO.setTicket_type_no(rs.getInt("ticket_type_no"));
				ord_ticket_typeVO.setOrder_no(rs.getInt("order_no"));
				ord_ticket_typeVO.setTicket_count(rs.getInt("ticket_count"));
				ord_ticket_typeVO.setPrice(rs.getInt("price"));
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
		
		return ord_ticket_typeVO;
	}

	@Override
	public List<Ord_ticket_typeVO> getAll() {
		List<Ord_ticket_typeVO> list = new ArrayList<Ord_ticket_typeVO>();
		Ord_ticket_typeVO ord_ticket_typeVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ord_ticket_typeVO = new Ord_ticket_typeVO();
				
				ord_ticket_typeVO.setTicket_type_no(rs.getInt("ticket_type_no"));
				ord_ticket_typeVO.setOrder_no(rs.getInt("order_no"));
				ord_ticket_typeVO.setTicket_count(rs.getInt("ticket_count"));
				ord_ticket_typeVO.setPrice(rs.getInt("price"));
				list.add(ord_ticket_typeVO);
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
	public void insert2(Ord_ticket_typeVO ord_ticket_typeVO, Connection con) {
		
		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, ord_ticket_typeVO.getTicket_type_no());
			pstmt.setInt(2, ord_ticket_typeVO.getOrder_no());
			pstmt.setInt(3, ord_ticket_typeVO.getTicket_count());
			pstmt.setInt(4, ord_ticket_typeVO.getPrice());

			pstmt.executeUpdate();
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-ord_tikcket");
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
	public List<Ord_ticket_typeVO> getAllTicketByOrderno(Integer order_no) {
		List<Ord_ticket_typeVO> list = new ArrayList<Ord_ticket_typeVO>();
		Ord_ticket_typeVO ord_ticket_typeVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_TICKET_STMT);
			pstmt.setInt(1, order_no);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ord_ticket_typeVO = new Ord_ticket_typeVO();
				
				ord_ticket_typeVO.setTicket_type_no(rs.getInt("ticket_type_no"));
				ord_ticket_typeVO.setOrder_no(rs.getInt("order_no"));
				ord_ticket_typeVO.setTicket_count(rs.getInt("ticket_count"));
				ord_ticket_typeVO.setPrice(rs.getInt("price"));
				list.add(ord_ticket_typeVO);
				System.out.println("1");
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