<!--
*******************************************************************************
* Copyright (C) 2010 Ping Identity Corporation All rights reserved.
*
* This software is licensed under the Open Software License v2.1 (OSL v2.1).
*
*
******************************************************************************
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import = "java.lang.StringBuilder" %>
<%@ page import = "com.pingidentity.sample.sp.manage.ConfigManager" %>

<%
	/* 
		Redirect requests to SpSample/ to SpSample/Mainpage while preserving any query params.
	*/
	String baseUrl = request.getContextPath() + "/MainPage";
	String queryParams = request.getQueryString();
	StringBuilder mainpageUrl = new StringBuilder();
	mainpageUrl.append((queryParams != null) ? baseUrl + "?" + queryParams : baseUrl);
	
	response.sendRedirect(mainpageUrl.toString());
%>