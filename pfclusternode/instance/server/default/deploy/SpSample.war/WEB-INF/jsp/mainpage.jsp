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
<%@ page import = "com.pingidentity.sample.util.URLUtil" %>
<%@ page import = "com.pingidentity.sample.sp.manage.ConfigManager" %>
<%@ page import = "com.pingidentity.sample.sp.manage.SampleAppConfig" %>
<%@ page import = "com.pingidentity.sample.sp.manage.SampleConstants" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "org.apache.commons.collections.MultiMap" %>
<%@ page import = "org.apache.commons.collections.map.MultiValueMap" %>
<%@ page import = "javax.servlet.http.HttpUtils,java.util.Enumeration" %>
<%@ page import = "com.pingidentity.sample.token.SampleAppOpenTokenHelper" %>
<%@ page import = "com.pingidentity.opentoken.TokenException" %>
<%@ page import = "com.pingidentity.opentoken.TokenExpiredException" %>

<%
	String showAdvanced = request.getParameter("showAdvanced");
	
	if (showAdvanced == null) 
	{
		showAdvanced = "false";	
	}
	
	ConfigManager configManager = ConfigManager.getInstance();
	Properties spConfigProperties = null;
	if (configManager != null)
	{
		SampleAppConfig sampleAppConfig = configManager.getConfig();
		if (sampleAppConfig != null)
		{
			spConfigProperties = sampleAppConfig.getSpConfig();
		}
	}
	
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");
	
	MultiMap userInfo = null;
	
	// First, check to see if the userInfo is in the local session.
	if (session != null)
	{
		userInfo = (MultiMap)session.getAttribute(SampleConstants.USER_INFO);
	}
	
	if (userInfo == null)
	{
		try
		{
			// Get user attributes from the OpenToken if the user has it
			SampleAppOpenTokenHelper sampleAppOpenTokenHelper = new SampleAppOpenTokenHelper();
			userInfo = sampleAppOpenTokenHelper.parseOpenToken(request, response);			
		}
		catch (TokenExpiredException tokenExpiredEx)
		{
			userInfo = null;
		}
		catch (TokenException tokenEx)
		{
			userInfo = null;
		}
	}
	
	String spStartSLO = URLUtil.getSpSLOUrl();
	String sloErrorMsg = "Error+during+sp-initiated+SLO";
	String ssoErrorMsg = "Error+during+sp-initiated+SSO";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<HTML>
<HEAD>
	<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<LINK media=screen href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
	<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<title>SP Integration Main</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/common.js"></script>
	<script language="javascript">
		function createSSOLink() 
		{
			var url = createSSOUrl(document.getElementById('PartnerIdpId').value);

			if ("true" == "<%=showAdvanced%>")
			{
				if (document.getElementById('InErrorResource').checked)
				{
					url += "&InErrorResource=" + "<%= URLUtil.getSpErrorPageUrl() %>" + "<%= ssoErrorMsg %>";
				}
			}
			document.getElementById('ssolink').value = url;
			document.getElementById('ssolink').select();
			copyToClipboard(document.getElementById('ssolink').value);
		}		
		function createSLOLink() 
		{	
			var url = "<%= spStartSLO %>";

			if ("true" == "<%=showAdvanced%>")
			{
				if (document.getElementById('InErrorResource').checked)
				{
					url = "<%= URLUtil.addSpInErrorResource(spStartSLO, sloErrorMsg) %>";
				}
			}
			document.getElementById('slolink').value = url;
			document.getElementById('slolink').select();
			copyToClipboard(document.getElementById('slolink').value);
		}
	</script>
</HEAD>

<body class="sp">

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
			<a href="<%= URLUtil.getConfigOptionsUrl(request) %>">Options</a> 
			<%      if(userInfo != null) { %>				
			| 
			<a href="<%= URLUtil.getLocalLogoutUrl(request) %>">Local Logout</a>
<%-- 
			Commenting out the link to launch defederation (terminate account linking) since it 
			is not configured by default in the data.zip packaged with the Sample Applications.  
			With account linking not configured by default clicking on this link always leads to
			an error from PingFederate that is cryptic to most users.
			|
			<a href="<%= URLUtil.getSpDefederateUrl() %>">Unlink Account</a>
--%>
			<%	} %>
			</td>
		</tr>
		</table> 
	</div>
	<div id="content">

		<%      if (userInfo != null) { %>

					<table style="float: left;" class="cell">
						<tr>
							<td colspan=2 style="text-align: center;">
								<h1>User Attributes</h1>
								<hr class="cell"/>
							</td>
						</tr>
						<%= DisplayUtil.writeHtmlUserAttributes(userInfo) %>
					</table>

		<% } else { %>
					<table style="float: left;" class="cell" id="doot">
						<tr>
							<td colspan=2 style="text-align: center;">
								<h1>User Attributes</h1>
								<hr class="cell"/>
							</td>
						</tr>
						<tr><td class="error">No user attributes since you're not logged in.  Use Single Sign-On to login to the Service Provider application.</td></tr>
					</table>
		<% } %>
	<form name="mainForm" action="<%= URLUtil.getActionWithParams(request) %>" method="POST" >
		<table style="float: right;" class="cell">
			<tr>
				<td colspan=2 style="text-align: center;">
					<h1>SSO Processing</h1>
					<hr class="cell"/>
				</td>
			</tr>
			<tr>
				<td></td>
                <td style="text-align:right">
                	<% if ("true".equalsIgnoreCase(showAdvanced)) { %>
	                	<a href="<%= URLUtil.getHideAdvancedUrl(request, null) %>" style="color:#0000FF">Hide advanced options</a>
	                <% } else { %>
	                	<a href="<%= URLUtil.getShowAdvancedUrl(request, null) %>" style="color:#0000FF">Show advanced options</a>
	                <% } %>
                </td>
            </tr>

			<%-- Generate the html for either the connections dropdown list which is built with a
			     web service call to PingFederate or display an error message. --%>
			<%= DisplayUtil.writeHtmlConnectionListOrErrorMsg(request, response) %>
			
			<% if ("true".equalsIgnoreCase(showAdvanced)) { %>
			
			<%-- Generate the html for either the adapters dropdown list which is built with a
				 web service call to PingFederate or display an error message. --%>
			<%= DisplayUtil.writeHtmlAdapterInstanceListOrErrorMsg(request, response) %>           
                    
			<tr>
				<td>Is Passive: </td>
				<td>
					<input type="checkbox" id="IsPassive" name="IsPassive" value="true"/>
                </td>
            </tr>
			<tr>
                <td>Force Authn: </td>
				<td>
					<input type="checkbox" id="ForceAuthn" name="ForceAuthn" value="true"/>
				</td>
			</tr>
            <!-- InErrorResource -->
            <tr>
            	<td>Use InErrorResource: </td>
            	<td>
            	    <input type="checkbox" id="InErrorResource" name="InErrorResource" value="true"/>
            	</td>
            </tr>
			<%	} %>

            <tr>
                <td width="40%">Start SSO URL:</td>
				<td>
                	<input id="ssolink" READONLY="true" type="text">&nbsp;<a href="javascript:createSSOLink();" style="font-size:10px;">show</a>						                	
                </td>
            </tr>            
            <tr>
                <td> </td>
                <td>
                    <input type="submit" name="cmd" value="<%= SampleConstants.SSO_BUTTON %>"/>
                </td>
            </tr>
	           
			<% if (userInfo != null) { %>
			<tr>
				<td>Start SLO URL:</td>
				<td>
					<input id="slolink" READONLY="true" type="text">&nbsp;<a href="javascript:createSLOLink();" style="font-size:10px;">show</a>
				<td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" name="cmd" value="<%= SampleConstants.SLO_BUTTON %>"/>
				</td>
			</tr>
            <%	} %>
        </table>
	</form>
	</div>
	
</BODY>
</HTML>

