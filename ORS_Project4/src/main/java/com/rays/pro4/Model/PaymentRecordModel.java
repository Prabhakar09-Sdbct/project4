package com.rays.pro4.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.rays.pro4.Bean.PaymentRecordBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DatabaseException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Util.JDBCDataSource;

/**
 * JDBC Implementation of PaymentRecordModel Model.
 * 
 * @author Prabhakar Mandloi
 *
 */
public class PaymentRecordModel {

	private static Logger log = Logger.getLogger(PaymentRecordModel.class);

	public Integer nextPK() throws DatabaseException {
		log.debug("Model nextPK Started");
		Connection conn = null;
		int pk = 0;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ID) FROM st_payment");

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				pk = rs.getInt(1);

			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new DatabaseException("Exception : Exception in getting PK");

		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Modal nextPK End");
		return pk + 1;
	}

	public long add(PaymentRecordBean bean) throws ApplicationException, DuplicateRecordException {

		log.debug("Modal add Started");
		Connection conn = null;
		int pk = 0;

//		PaymentRecordBean duplicateRole=findByName(bean.getName());
//		
//		if(duplicateRole !=null){
//			throw new DuplicateRecordException("Role already exists");
//			
//		}
		try {
			conn = JDBCDataSource.getConnection();
			pk = nextPK();

			System.out.println(pk + "in ModelJDBC");
			conn.setAutoCommit(false);
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO st_payment VALUES(?,?,?,?,?,?,?,?,?,?)");

			pstmt.setInt(1, pk);
			pstmt.setString(2, bean.getTransactionId());
			pstmt.setDouble(3, bean.getAmount());
			pstmt.setDate(4, new java.sql.Date(bean.getTransactionDate().getTime()));
			pstmt.setString(5, bean.getStatus());
			pstmt.setString(6, bean.getPaymentMethod());
			
			pstmt.setString(7, bean.getCreatedBy());
			pstmt.setString(8, bean.getModifiedBy());
			pstmt.setTimestamp(9, bean.getCreatedDatetime());
			pstmt.setTimestamp(10, bean.getModifiedDatetime());
			pstmt.executeUpdate();
			conn.commit();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			// log.error("Database Exception...",e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				// throw new ApplicationException("Exception : add rollback
				// exception"+ex.getMessage());
			}
			// throw new ApplicationException("Exception :Exception in add Role");
		} finally {
			JDBCDataSource.closeConnection(conn);

		}
		log.debug("Modal add End");
		return pk;
	}

	public void delete(long id) throws ApplicationException {

		log.debug("Modal delete Started");
		Connection conn = null;

		try {
			conn = JDBCDataSource.getConnection();
			conn.setAutoCommit(false);
			PreparedStatement pstmt = conn.prepareStatement("Delete FROM st_payment WHERE ID=?");
			pstmt.setLong(1, id);
			pstmt.executeUpdate();
			conn.commit();
			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception...", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				// throw new ApplicationException("Exception : Delete rollback
				// exception"+ex.getMessage());
			}
			// throw new ApplicationException("Exception : Exception in delete Role");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}

		log.debug("Modal delete Started");
	}

	public PaymentRecordBean findByPK(long pk) throws ApplicationException {
		log.debug("Modal findByPK Started");

		StringBuffer sql = new StringBuffer("SELECT*FROM st_payment WHERE ID=?");
		PaymentRecordBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, pk);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				bean = new PaymentRecordBean();
				bean.setId(rs.getLong(1));
				bean.setTransactionId(rs.getString(2));
				bean.setAmount(rs.getDouble(3));
				bean.setTransactionDate(rs.getDate(4));
				bean.setStatus(rs.getString(5));
				bean.setPaymentMethod(rs.getString(6));

				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));

			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting User by pk");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Modal findByPK End");
		return bean;
	}

	public void update(PaymentRecordBean bean) throws ApplicationException, DuplicateRecordException {
		log.debug("Model update Started");
		Connection conn = null;

		/*
		 * PaymentRecordBean duplicataRole = findByName(bean.getName()); // Check if
		 * updated Role already exist if (duplicataRole != null && duplicataRole.getId()
		 * != bean.getId()) { throw new DuplicateRecordException("Role already exists");
		 * }
		 */
		try {
			conn = JDBCDataSource.getConnection();

			conn.setAutoCommit(false);
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE st_payment SET transaction_id=?,amount=?,transaction_date=?,status=?,payment_method=?,CREATED_BY=?,MODIFIED_BY=?,CREATED_DATETIME=?,MODIFIED_DATETIME=? WHERE ID=?");
			pstmt.setString(1, bean.getTransactionId());
			pstmt.setDouble(2, bean.getAmount());
			pstmt.setDate(3, new java.sql.Date(bean.getTransactionDate().getTime()));
			pstmt.setString(4, bean.getStatus());
			pstmt.setString(5, bean.getPaymentMethod());
			
			pstmt.setString(6, bean.getCreatedBy());
			pstmt.setString(7, bean.getModifiedBy());
			pstmt.setTimestamp(8, bean.getCreatedDatetime());
			pstmt.setTimestamp(9, bean.getModifiedDatetime());
			pstmt.setLong(10, bean.getId());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : Delete rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception in updating Role ");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model update End");
	}

	public List search(PaymentRecordBean bean) throws ApplicationException {
		return search(bean);
	}

	public List search(PaymentRecordBean bean, int pageNo, int pageSize) throws ApplicationException {
		log.debug("Model search Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM st_payment WHERE 1=1");

		if (bean != null) {
			if (bean.getId() > 0) {
				sql.append(" AND id= " + bean.getId());
			}
			if (bean.getTransactionId() != null && bean.getTransactionId().length() > 0) {
				sql.append(" AND transaction_id like '" + bean.getTransactionId() + "%'");
			}
			if (bean.getAmount() > 0) {
				sql.append(" AND amount like '" + bean.getAmount() + "%'");
			}

		}

		if (pageSize > 0) {
			pageNo = (pageNo - 1) * pageSize;
			sql.append(" Limit " + pageNo + "," + pageSize);

		}
		System.out.println(" sql "+sql.toString());
		ArrayList list = new ArrayList();
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			System.out.println("conn"+conn);
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());

			ResultSet rs = pstmt.executeQuery();
			
			System.out.println(" rs size"+rs);
			while (rs.next()) {
				bean = new PaymentRecordBean();
				bean.setId(rs.getLong(1));
				bean.setTransactionId(rs.getString(2));
				bean.setAmount(rs.getDouble(3));
				bean.setTransactionDate(rs.getDate(4));
				bean.setStatus(rs.getString(5));
				bean.setPaymentMethod(rs.getString(6));

				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			// log.error("DatabaseException.....", e);
			// throw new ApplicationException("Exception : Exception in search Role");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model search End");
		System.out.println("list >>>>>>>>>>"+list.size());
		return list;
	}

	public List list() throws ApplicationException {
		return search(null,0, 0);
	}

	

}
