package com.rays.pro4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.PaymentRecordBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Model.PaymentRecordModel;
import com.rays.pro4.Model.StudentModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.DataValidator;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

//TODO: Auto-generated Javadoc
/**
* PaymentRecordCtl functionality Controller. Performs operation for add, update,
* delete and get Payment
* 
*  @author Prabhakar Mandloi
*/
@WebServlet(name = "PaymentRecordCtl", urlPatterns = { "/ctl/PaymentRecordCtl" })
public class PaymentRecordCtl extends BaseCtl{

	private static Logger log = Logger.getLogger(PaymentRecordCtl.class);

	/* (non-Javadoc)
	 * @see in.co.rays.ors.controller.BaseCtl#validate(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {
		log.debug("PaymentRecordCtl Method validate Started");
	
		boolean pass = true;
		
		if (DataValidator.isNull(request.getParameter("transactionId"))) {
			request.setAttribute("transactionId", PropertyReader.getValue("error.require", "Transaction id"));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("amount")) && !DataValidator.isDouble(request.getParameter("amount"))) {
			request.setAttribute("amount", PropertyReader.getValue("error.require", "Amount"));
			pass = false;
			
		} 
		
		if (DataValidator.isNull(request.getParameter("transactionDate"))) {
			request.setAttribute("transactionDate", PropertyReader.getValue("error.require", "Transaction Date"));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("status"))) {
			request.setAttribute("status", PropertyReader.getValue("error.require", "status"));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("paymentMethod"))) {
			request.setAttribute("paymentMethod", PropertyReader.getValue("error.require", "Payment Method"));
			pass = false;
		}

		log.debug("PaymentRecordCtl Method validate Ended");
		
		System.out.println("pass"+pass);
		return pass;
	}

	/* (non-Javadoc)
	 * @see in.co.rays.ors.controller.BaseCtl#populateBean(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		log.debug("PaymentRecordCtl Method populatebean Started");

		PaymentRecordBean bean = new PaymentRecordBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setTransactionId(DataUtility.getString(request.getParameter("transactionId")));
		bean.setAmount(DataUtility.getDouble(request.getParameter("amount")));
		bean.setTransactionDate(DataUtility.getDate(request.getParameter("transactionDate")));
		bean.setStatus(DataUtility.getString(request.getParameter("status")));
		bean.setPaymentMethod(DataUtility.getString(request.getParameter("paymentMethod")));
		
	//	System.out.println(">>>>>>>>>>>>>" +request.getParameter("studentId"));

		populateDTO(bean, request);
		System.out.println("Population done");
		log.debug("PaymentRecordCtl Method populatebean Ended");

		return bean;
	}

	/**
	 * Contains Display logics.
	 *
	 * @param request the request
	 * @param response the response
	 * @throws ServletException the servlet exception
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("PaymentRecordCtl Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		PaymentRecordModel model = new PaymentRecordModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		if (id > 0 || op != null) {
			PaymentRecordBean bean;
			try {
				bean = model.findByPK(id);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				e.printStackTrace();
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		ServletUtility.forward(getView(), request, response);
		log.debug("PaymentRecordCtl Method doGet Ended");
	}

	/**
	 * Contains Submit logics.
	 *
	 * @param request the request
	 * @param response the response
	 * @throws ServletException the servlet exception
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.debug("PaymentRecordCtl Method doPost Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		long id = DataUtility.getLong(request.getParameter("id"));
		PaymentRecordBean bean = (PaymentRecordBean) populateBean(request);
		
		// get model
		PaymentRecordModel model = new PaymentRecordModel();

		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			try {
				if (id > 0) {
					model.update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Payment is Successfully Updated ", request);

				} else {
					long pk = model.add(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Payment is Successfully Added ", request);
				}
				
			} catch (ApplicationException e) {
				log.error(e);
				e.printStackTrace();
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				ServletUtility.setBean(bean, request);
				ServletUtility.setErrorMessage("Roll no already exists", request);
			}

		} else if (OP_RESET.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.PAYMENT_RECORD_CTL, request, response);
			return;
		} else if (OP_CANCEL.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.PAYMENT_RECORD_LIST_CTL, request, response);
			return;
		}
		ServletUtility.setBean(bean, request);
		ServletUtility.forward(getView(), request, response);

		log.debug("PaymentRecordCtl Method doPost Ended");
	}

	/* (non-Javadoc)
	 * @see in.co.rays.ors.controller.BaseCtl#getView()
	 */
	@Override
	protected String getView() {
		return ORSView.PAYMENT_RECORD_VIEW;
	}

	
}
