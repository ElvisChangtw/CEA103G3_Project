package com.ticket_type.model;

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

public class Ticket_typeDAO implements Ticket_typeDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;

	static {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "insert into ticket_type (ticket_type, ticket_price, ticket_desc) values(?, ?, ?)";
	private static final String GET_ALL_STMT = "select * from ticket_type order by ticket_type_no desc";
	private static final String GET_ONE_STMT = "select * from ticket_type where ticket_type_no = ?";
	private static final String DELETE = "delete from ticket_type where ticket_type_no = ?";
	private static final String UPDATE = "update ticket_type set ticket_type = ? , ticket_price = ?, ticket_desc = ? "
			+ "where ticket_type_no = ?";

	@Override
	public void insert(Ticket_typeVO ticket_typeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, ticket_typeVO.getTicket_type());
			pstmt.setInt(2, ticket_typeVO.getTicket_price());
			pstmt.setString(3, ticket_typeVO.getTicket_desc());

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
	public void update(Ticket_typeVO ticket_typeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, ticket_typeVO.getTicket_type());
			pstmt.setInt(2, ticket_typeVO.getTicket_price());
			pstmt.setString(3, ticket_typeVO.getTicket_desc());
			pstmt.setInt(4, ticket_typeVO.getTicket_type_no());
			
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
	public void delete(Integer ticket_type_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ticket_type_no);

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
	public Ticket_typeVO findByPrimaryKey(Integer ticket_type_no) {
		
		Ticket_typeVO ticket_typeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, ticket_type_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ticket_typeVO = new Ticket_typeVO();
				
				ticket_typeVO.setTicket_type_no(rs.getInt("ticket_type_no"));
				ticket_typeVO.setTicket_type(rs.getString("ticket_type"));
				ticket_typeVO.setTicket_price(rs.getInt("ticket_price"));
				ticket_typeVO.setTicket_desc(rs.getString("ticket_desc"));
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
		
		return ticket_typeVO;
	}

	@Override
	public List<Ticket_typeVO> getAll() {
		List<Ticket_typeVO> list = new ArrayList<Ticket_typeVO>();
		Ticket_typeVO ticket_typeVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				// theaterVO 也稱為 Domain objects
				ticket_typeVO = new Ticket_typeVO();
				
				ticket_typeVO.setTicket_type_no(rs.getInt("ticket_type_no"));
				ticket_typeVO.setTicket_type(rs.getString("ticket_type"));
				ticket_typeVO.setTicket_price(rs.getInt("ticket_price"));
				ticket_typeVO.setTicket_desc(rs.getString("ticket_desc"));
				list.add(ticket_typeVO);
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