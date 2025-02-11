package com.rays.pro4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.PositionBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Model.PositionModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.DataValidator;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

//TODO: Auto-generated Javadoc
/**
 * Position functionality Controller. Performs operation for add, update, delete
 * and get Position
 * 
 * @author Prabhakar Mandloi
 */
@WebServlet(name = "PositionCtl", urlPatterns = { "/ctl/PositionCtl" })
public class PositionCtl extends BaseCtl {

	/** The log. */
	private static Logger log = Logger.getLogger(PositionCtl.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see in.co.rays.ors.controller.BaseCtl#validate(javax.servlet.http.
	 * HttpServletRequest)
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {
		System.out.println("validate started ... std ctl");
		log.debug("PositionCtl Method validate Started");
		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("designation"))) {
			request.setAttribute("designation", PropertyReader.getValue("error.require", "designation"));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("openingDate"))) {
			request.setAttribute("openingDate", PropertyReader.getValue("error.require", "Opening Date"));
			pass = false;
		} else if (!DataValidator.isDate(request.getParameter("openingDate"))) {
			request.setAttribute("openingDate", "Invalid Date formate");
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("requiredExperience"))) {
			request.setAttribute("requiredExperience", PropertyReader.getValue("error.require", "Required Experience"));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("condition"))) {
			request.setAttribute("condition", PropertyReader.getValue("error.require", "Condition"));
			pass = false;
		}
		System.out.println("validate over ,.... Position ctl");
		log.debug("PositionCtl Method validate Ended");
		return pass;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see in.co.rays.ors.controller.BaseCtl#populateBean(javax.servlet.http.
	 * HttpServletRequest)
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		log.debug("PositionCtl Method populatebean Started");

		PositionBean bean = new PositionBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setDesignation(DataUtility.getString(request.getParameter("designation")));
		bean.setOpeningDate(DataUtility.getDate(request.getParameter("openingDate")));
		bean.setRequiredExperience(DataUtility.getString(request.getParameter("requiredExperience")));
		bean.setCondition(DataUtility.getString(request.getParameter("condition")));
		populateDTO(bean, request);
		log.debug("PositionCtl Method populatebean Ended");
		return bean;
	}

	/**
	 * Contains Display logics.
	 *
	 * @param request  the request
	 * @param response the response
	 * @throws ServletException the servlet exception
	 * @throws IOException      Signals that an I/O exception has occurred.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.debug("PositionCtl Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		long id = DataUtility.getLong(request.getParameter("id"));

		// get model

		PositionModel model = new PositionModel();
		if (id > 0 || op != null) {
			PositionBean bean;
			try {
				bean = model.findByPK(id);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		ServletUtility.forward(getView(), request, response);
		log.debug("PositionCtl Method doGett Ended");
	}

	/**
	 * Contains Submit logics.
	 *
	 * @param request  the request
	 * @param response the response
	 * @throws ServletException the servlet exception
	 * @throws IOException      Signals that an I/O exception has occurred.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.debug("PositionCtl Method doPost Started");

		String op = DataUtility.getString(request.getParameter("operation"));

		long id = DataUtility.getLong(request.getParameter("id"));

		PositionModel model = new PositionModel();

		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			PositionBean bean = (PositionBean) populateBean(request);
			try {
				if (id > 0) {
					model.Update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage(" Data is successfully Updated", request);
				} else {
					long pk = model.add(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage(" Data is successfully Added", request);
				}
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;

			} 
		} else if (OP_RESET.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.POSITION_CTL, request, response);
			return;
		} else if (OP_CANCEL.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.POSITION_LIST_CTL, request, response);
			return;
		}
		ServletUtility.forward(getView(), request, response);

		log.debug("PositionCtl Method doPost Ended");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see in.co.rays.ors.controller.BaseCtl#getView()
	 */
	@Override
	protected String getView() {
		return ORSView.POSITION_VIEW;
	}

}
