package com.order.model;

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

import com.ord_food.model.Ord_foodDAO;
import com.ord_food.model.Ord_foodVO;
import com.ord_ticket_type.model.Ord_ticket_typeDAO;
import com.ord_ticket_type.model.Ord_ticket_typeVO;
import com.showtime.model.ShowtimeDAO;

public class OrderDAO implements OrderDAO_interface {

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

	private static final String INSERT_STMT = "insert into `order` (member_no, showtime_no, crt_dt, order_status, "
			+ "order_type, payment_type, total_price, seat_name) values(?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from `order` order by order_no desc";
	private static final String GET_ONE_STMT = "select * from `order` where order_no = ?";
	private static final String DELETE = "delete from `order` where order_no = ?";
	private static final String UPDATE = "update `order` set member_no = ?, showtime_no = ?, crt_dt = ?,"
			+ " order_status = ?, order_type = ?, payment_type = ?, total_price = ?, seat_name = ? where order_no = ?";
	private static final String GET_ALL_BY_MEMNO_STMT = "select * from `order` where member_no=?";
	private static final String DELETE_BY_MEM_STMT = "update `order` set order_status = ? where order_no = ?";
	
	
	@Override
	public void insert(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, orderVO.getMember_no());
			pstmt.setInt(2, orderVO.getShowtime_no());
			pstmt.setTimestamp(3, orderVO.getCrt_dt());
			pstmt.setString(4, orderVO.getOrder_status());
			pstmt.setString(5, orderVO.getOrder_type());
			pstmt.setString(6, orderVO.getPayment_type());
			pstmt.setInt(7, orderVO.getTotal_price());
			pstmt.setString(8, orderVO.getSeat_name());

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
	public void update(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, orderVO.getMember_no());
			pstmt.setInt(2, orderVO.getShowtime_no());
			pstmt.setTimestamp(3, orderVO.getCrt_dt());
			pstmt.setString(4, orderVO.getOrder_status());
			pstmt.setString(5, orderVO.getOrder_type());
			pstmt.setString(6, orderVO.getPayment_type());
			pstmt.setInt(7, orderVO.getTotal_price());
			pstmt.setString(8, orderVO.getSeat_name());
			pstmt.setInt(9, orderVO.getOrder_no());
			
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
	public void delete(Integer order_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, order_no);

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
	public OrderVO findByPrimaryKey(Integer order_no) {
		
		OrderVO orderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, order_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setMember_no(rs.getInt("member_no"));
				orderVO.setShowtime_no(rs.getInt("showtime_no"));
				orderVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				orderVO.setOrder_status(rs.getString("order_status"));
				orderVO.setOrder_type(rs.getString("order_type"));
				orderVO.setPayment_type(rs.getString("payment_type"));
				orderVO.setTotal_price(rs.getInt("total_price"));
				orderVO.setSeat_name(rs.getString("seat_name"));
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
		
		return orderVO;
	}

	@Override
	public List<OrderVO> getAll() {
		List<OrderVO> list = new ArrayList<OrderVO>();
		OrderVO orderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				orderVO = new OrderVO();
				
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setMember_no(rs.getInt("member_no"));
				orderVO.setShowtime_no(rs.getInt("showtime_no"));
				orderVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				orderVO.setOrder_status(rs.getString("order_status"));
				orderVO.setOrder_type(rs.getString("order_type"));
				orderVO.setPayment_type(rs.getString("payment_type"));
				orderVO.setTotal_price(rs.getInt("total_price"));
				orderVO.setSeat_name(rs.getString("seat_name"));
				list.add(orderVO);
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
	public void insert2(OrderVO orderVO, List<Ord_foodVO> ordFood_list, List<Ord_ticket_typeVO> ordTicket_list,
			String seat_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			String cols[] = {"order_no"};
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			
			pstmt.setInt(1, orderVO.getMember_no());
			pstmt.setInt(2, orderVO.getShowtime_no());
			pstmt.setTimestamp(3, orderVO.getCrt_dt());
			pstmt.setString(4, orderVO.getOrder_status());
			pstmt.setString(5, orderVO.getOrder_type());
			pstmt.setString(6, orderVO.getPayment_type());
			pstmt.setInt(7, orderVO.getTotal_price());
			pstmt.setString(8, orderVO.getSeat_name());

			pstmt.executeUpdate();
			
			//掘取對應的自增主鍵值
			String next_order_no = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				next_order_no = rs.getString(1);
				orderVO.setOrder_no(new Integer(next_order_no));
				System.out.println("自增主鍵值= " + next_order_no +"(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			//新增訂單餐點明細
			Ord_foodDAO ord_foodDAO = new Ord_foodDAO();
			System.out.println("ordFood_list.size()="+ ordFood_list.size());
			for(Ord_foodVO ord_foodVO : ordFood_list) {		
				ord_foodVO.setOrder_no(new Integer(next_order_no));
				ord_foodDAO.insert2(ord_foodVO, con);
			}
			
			//新增訂票種明細
			Ord_ticket_typeDAO  ord_ticket_typeDAO = new Ord_ticket_typeDAO();
			System.out.println("ordTicket_list.size()="+ ordTicket_list.size());
			for(Ord_ticket_typeVO ord_ticket_typeVO : ordTicket_list) {
				ord_ticket_typeVO.setOrder_no(new Integer(next_order_no));
				ord_ticket_typeDAO.insert2(ord_ticket_typeVO, con);
			}
			
			//修改場次座位狀態
			ShowtimeDAO showtimeDAO = new ShowtimeDAO();
			showtimeDAO.update2(seat_no, orderVO.getShowtime_no(), con);
			
			//設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("新增訂單編號" + next_order_no + "時,共有訂單餐點" + 
					ordFood_list.size()	+ "筆，訂單票種" + ordTicket_list.size()
					+ "筆同時被新增");
			
		} 
//		catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		}  
		catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-order");
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
	public List<OrderVO> getAllByMemno(Integer memberno) {
		List<OrderVO> list = new ArrayList<OrderVO>();
		OrderVO orderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MEMNO_STMT);
			pstmt.setInt(1, memberno);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				orderVO = new OrderVO();
				
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setMember_no(rs.getInt("member_no"));
				orderVO.setShowtime_no(rs.getInt("showtime_no"));
				orderVO.setCrt_dt(rs.getTimestamp("crt_dt"));
				orderVO.setOrder_status(rs.getString("order_status"));
				orderVO.setOrder_type(rs.getString("order_type"));
				orderVO.setPayment_type(rs.getString("payment_type"));
				orderVO.setTotal_price(rs.getInt("total_price"));
				orderVO.setSeat_name(rs.getString("seat_name"));
				list.add(orderVO);
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
	public void deleteByMem(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_BY_MEM_STMT);
			pstmt.setString(1, orderVO.getOrder_status());
			pstmt.setInt(2, orderVO.getOrder_no());
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
		

}