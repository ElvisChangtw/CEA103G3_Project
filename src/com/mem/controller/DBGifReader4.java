package com.mem.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.movie.model.MovieService;
import com.movie.model.MovieVO;

public class DBGifReader4 extends HttpServlet {

	Connection con;

	public static final String SQL = "SELECT MB_PIC FROM `MEMBER` WHERE MEMBER_NO = ?";

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("image/gif,image/png,image/jpeg");
		ServletOutputStream out = res.getOutputStream();
		try {

			PreparedStatement pstmt = con.prepareStatement(SQL);

			Integer member_no = new Integer(req.getParameter("member_no"));

			pstmt.setInt(1, member_no);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("MB_PIC"));

				if (in.available() != 0) {
					byte[] buf = new byte[4 * 1024]; // 4K buffer
					int len;
					while ((len = in.read(buf)) != -1) {
						out.write(buf, 0, len);
					}
					in.close();
				} else {
					InputStream input = getServletContext().getResourceAsStream("/images/NoData/NoPicture.jpg");
					byte[] b = new byte[input.available()];
					input.read(b);
					out.write(b);
					in.close();
				}
			} else {

//				res.sendError(HttpServletResponse.SC_NOT_FOUND);
				InputStream in = getServletContext().getResourceAsStream("/images/NoData/none2.jpg");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
//			System.out.println(e);
			InputStream in = getServletContext().getResourceAsStream("/images/NoData/null.jpg");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103G3");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
}