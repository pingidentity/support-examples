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
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import = "com.pingidentity.sample.util.DisplayUtil" %>
<%@ page import = "com.pingidentity.sample.sp.manage.SampleConstants" %>

<%
	String resumePath = request.getParameter(SampleConstants.OTK_RESUME_PATH);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>

<HEAD>
	<TITLE>SP Integration Account Linking</TITLE>
	<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<LINK media="screen" href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
	<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<script type="text/javascript" src="scripts/common.js"></script>
</HEAD>

<BODY>
<div id="container">
	<div id="left_header" style="background-image: url(<%=request.getContextPath()%>/images/sp_head_01.gif)">
	</div>
	<div id="right_header" style="background-image: url(<%=request.getContextPath()%>/images/sp_head_02.gif)">	
		<table id="menu">
		<tr height="100">
			<td></td>
		</tr>
		 <tr>
		 	<td>
		 	<!-- Menu goes here -->
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
		<form name="loginForm" method="post" action="<%=request.getContextPath()%>/MainPage?cmd=postloginaccountlink">
		<% if (resumePath != null) { %>
			<input type="hidden" name="<%= SampleConstants.OTK_RESUME_PATH %>" value="<%= resumePath %>">
		<% } %>
		
		<table class="cell" style="margin-left: auto; margin-right: auto;">
			<tr>
				<td colspan=2 style="text-align: center;">
					<h1>Account Link Login</h1>
					<hr class="cell"/>
				</td>
			</tr>
        	<tr>
            	<td align="right">Username:</td>
            	<td>
					<%= DisplayUtil.writeHtmlUserList("userName") %>
            	</td>
        	</tr>
        	<tr>                
            	<td align="right">Password:</td>
            	<td><input type="password" name="password" style="width:150px;"/></td>
        	</tr>
        	<tr>                
            	<td></td><td><input type="Submit" value="Login"/></td>
        	</tr>
      	</table>    

		<input type="hidden" name="action" value="login"/>

	</form>

	</div>
</div>
<SCRIPT language="JavaScript">
        document.loginForm.password.focus();
</SCRIPT>


</BODY></HTML>

