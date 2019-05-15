<!--
*******************************************************************************
* Copyright (C) 2010 Ping Identity Corporation All rights reserved.
*
* This software is licensed under the Open Software License v2.1 (OSL v2.1).
*
*
******************************************************************************
-->
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 
		Redirect requests to IdpSample/ to IdpSample/Mainpage while preserving any query params.
	*/
	String baseUrl = request.getContextPath() + "/MainPage";
	String queryParams = request.getQueryString();
	String url = (queryParams != null) ? baseUrl + "?" + queryParams : baseUrl;
	response.sendRedirect(url);
%>