 <%--
 *******************************************************************************
 * Copyright (C) 2010 Ping Identity Corporation All rights reserved.
 * 
 * This software is licensed under the Open Software License v2.1 (OSL v2.1).
 * 
 * A copy of this license has been provided with the distribution of this
 * software. Additionally, a copy of this license is available at:
 * http://www.pingidentity.com/license
 *  
 ******************************************************************************
 --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.pingidentity.sample.util.URLUtil" %>

<html>
	<head>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<LINK media=screen href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
	<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<META content="MSHTML 6.00.2800.1400" name=GENERATOR>	

	<title>Idp Sample App Error Page</title>
	
	</head>
<BODY>
<div id="container">
		<%-- To substitute your own image, change the path of the src attribute in the line below with
		     the path to your graphic file. --%>
	<div id="left_header" style="background-image: url(<%=request.getContextPath()%>/images/idp_head_01.gif)">

	</div>
	<div id="right_header" style="background-image: url(<%=request.getContextPath()%>/images/idp_head_02.gif)">	
		<table id="menu">
		<tr height="100">
			<td></td>
		</tr>
		 <tr>
		 	<td>
			</td>
		</tr>
		</table> 
	</div>
	<div id="content">
			<table>
				<br/> 
				<tr>
					<td colspan="4">
						There was an error in the IdP Sample Application.  Please return with this link:  <h3><a href="/IdpSample/MainPage">IdP Sample Application</a></h3>
					</td>
				</tr>
			</table>
	</div>
</div>
</BODY>
</HTML>