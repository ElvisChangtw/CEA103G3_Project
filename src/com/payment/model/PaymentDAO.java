package com.payment.model;

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

import com.articleCollection.model.ArticleCollectionVO;

public class PaymentDAO implements PaymentDAO_interface{
	
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
			"INSERT INTO payment (member_no, card_no, card_name, exp_mon, exp_year, csc) VALUES (?, ?, ?, ?, ?, ?)";
	private static final String DELETE = 
			"DELETE FROM payment where pay_no =?";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM payment where member_no = ? ";


	@Override
	public String insert(PaymentVO paymentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			String cols[]= {"PAY_NO"};
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			
			pstmt.setInt(1, paymentVO.getMember_no());
			pstmt.setString(2, paymentVO.getCard_no());
			pstmt.setString(3, paymentVO.getCard_name());
			pstmt.setString(4, paymentVO.getExp_mon());
			pstmt.setString(5, paymentVO.getExp_year());
			pstmt.setString(6, paymentVO.getCsc());
			pstmt.executeUpdate();
			
			String next_payno=null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_payno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_payno +"(剛新增成功的payment)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			return next_payno;
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
	public boolean delete(Integer pay_no) { //是否要把member_no也設為PK?因為這樣刪除就可用payno and memberno來找到
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, pay_no);


			int count = pstmt.executeUpdate();
			if(count > 0) {
				result = true;
			} 
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
		return result;
		
	}


	@Override
	public List<PaymentVO> getOneAll(Integer mb_no) {
		PaymentVO paymentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PaymentVO> list = new ArrayList<PaymentVO>();
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, mb_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				paymentVO = new PaymentVO();
				paymentVO.setPay_no(rs.getInt("pay_no"));
				paymentVO.setCard_no(rs.getString("card_no"));
				paymentVO.setCard_name(rs.getString("card_name"));
				paymentVO.setExp_mon(rs.getString("exp_mon"));
				paymentVO.setExp_year(rs.getString("exp_year"));
				paymentVO.setCsc(rs.getString("csc"));
				list.add(paymentVO);
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
