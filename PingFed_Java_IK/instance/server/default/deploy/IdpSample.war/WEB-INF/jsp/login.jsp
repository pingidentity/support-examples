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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.pingidentity.sample.idp.manage.SampleConstants" %>
<%@ page import = "com.pingidentity.sample.util.DisplayUtil" %>

<%
	String resumePath = request.getParameter(SampleConstants.OTK_RESUME_PATH);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<LINK media="screen" href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
	<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<title>IdP Integration Login</title>
</head>

<body class="idp">
	<div id="container">
	<div id="left_header" style="background-image: url(<%=request.getContextPath()%>/images/idp_head_01.gif)">
	</div>
	<div id="right_header" style="background-image: url(<%=request.getContextPath()%>/images/idp_head_02.gif)">	
		<table id="menu">
		<tr height="100">
			<td></td>
		</tr>
		 <tr>
		 	<td>
			<a href="<%=request.getContextPath()%>/?cmd=configOptions">Options</a> | 
			<a href="<%=request.getContextPath()%>/">Identity Provider Home</a> 
			</td>
		</tr>
		</table> 
	</div>

<%	String errorMessage = request.getParameter("error");
	if (errorMessage != null) {
%>
		<div id="errorCenter"><%= errorMessage %></div>
<%
	}
%>      
	<div id="content">
		<form method="post" action="<%=request.getContextPath()%>/MainPage?cmd=login">
			<% if (resumePath != null) { %>
				<input type="hidden" name="<%= SampleConstants.OTK_RESUME_PATH %>" value="<%= resumePath %>">
			<% } %>

			<table class="cell" style="margin-left: auto; margin-right: auto;">
				<tr>
					<td colspan=2 style="text-align: center;">
						<h1>Local Login</h1>
						<hr class="cell"/>
					</td>
				</tr>
				<tr>
					<td>Username:</td>
					<td><%= DisplayUtil.writeHtmlUserList("userName") %></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="password" id="password" name="password"/></td>
				</tr>
    			<tr>        
					<td></td>
					<td><input type="Submit" value="Login"/></td>
				</tr>
			</table>    
		</form>
	</div>
</BODY>
</html>
<script language="javascript">
	document.getElementById('password').focus();
</script>