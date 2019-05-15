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
<%@ page import = "com.pingidentity.sample.util.DisplayUtil" %>
<%@ page import = "com.pingidentity.sample.util.URLUtil" %>
<%@ page import = "com.pingidentity.sample.idp.manage.ConfigManager" %>
<%@ page import = "com.pingidentity.sample.idp.manage.SampleAppConfig" %>
<%@ page import = "com.pingidentity.sample.idp.manage.SampleConstants" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "org.apache.commons.collections.MultiMap" %>
<%@ page import = "org.apache.commons.collections.map.MultiValueMap" %>
<%@ page import = "com.pingidentity.sample.token.SampleAppOpenTokenHelper" %>
<%@ page import = "com.pingidentity.opentoken.TokenException" %>
<%@ page import = "com.pingidentity.opentoken.TokenExpiredException" %>

<%
	String showAdvanced = request.getParameter("showAdvanced");
	if (showAdvanced == null) 
	{
		showAdvanced = "false";	
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
	
	String idpStartSLO = URLUtil.getIdpSLOUrl();
	String sloErrorMsg = "Error+during+idp-initiated+SLO";
	String ssoErrorMsg = "Error+during+idp-initiated+SSO";
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html>
	<head>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<LINK media=screen href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
	<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<title>IdP Integration Main</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/common.js"></script>
	<script language="javascript">
		function createSSOLink() 
		{
			var url = createSSOUrl(document.getElementById('PartnerSpId').value);
			
			if ("true" == "<%=showAdvanced%>")
			{
				if (document.getElementById('InErrorResource').checked)
				{
					url += "&InErrorResource=" + "<%= URLUtil.getIdpErrorPageUrl() %>" + "<%= ssoErrorMsg %>";
				}
			}

			document.getElementById('ssolink').value = url;
			document.getElementById('ssolink').select();
			copyToClipboard(document.getElementById('ssolink').value);
		}	
		function createSLOLink() 
		{
			var url = "<%= idpStartSLO %>";
			
			if ("true" == "<%=showAdvanced%>")
			{
				if (document.getElementById('InErrorResource').checked)
				{
					url = "<%= URLUtil.addIdpInErrorResource(idpStartSLO, sloErrorMsg) %>";
				}
			}
			
			document.getElementById('slolink').value = url;
			document.getElementById('slolink').select();
			copyToClipboard(document.getElementById('slolink').value);
		}				
	</script>
	
	</head>
<BODY>
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
			<a href="<%= URLUtil.getConfigOptionsUrl(request) %>">Options</a>  | 
			<%      if (userInfo != null) { %>
				
				<a href="<%= URLUtil.getLocalLogoutUrl(request) %>">Local Logout</a>
				
			<%	} else{ %>
				
			<a href="<%= URLUtil.getLocalLoginUrl(request) %>">Login Locally</a>
			
			<%
				}
			%>
			</td>
		</tr>
		</table> 
	</div>
	<div id="content">
			<table style="float: left;" class="cell">
				<tr>
					<td colspan=2 style="text-align: center;">
						<h1>User Attributes</h1>
						<hr class="cell"/>
					</td>
				</tr>
				<%      if (userInfo != null) { %>
					<%= DisplayUtil.writeHtmlUserAttributes(userInfo) %>
				<%	} else { %>
					<tr><td class="error">Not logged in locally to IdP</td></tr>
				<%	} %>	
			</table>
			
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
			                <% } else {%>
			                	<a href="<%= URLUtil.getShowAdvancedUrl(request, null) %>" style="color:#0000FF">Show advanced options</a>
			                <% } %>
			                </td>
		                </tr>
		            
						<%-- Generate the html for either the connections dropdown list which is built with a
						     web service call to PingFederate or display an error message. --%>
						<%= DisplayUtil.writeHtmlConnectionListOrErrorMsg(request, response, SampleConstants.PARTNER_SP_ID) %>
			            
						<% if ("true".equalsIgnoreCase(showAdvanced)) { %>
			            	<tr>
			                	<td>Target URL: </td>
			                	<td>
			                    	<input type="text" id="TargetResource" name="TargetResource"/>
			                	</td>
			            	</tr>

							<%-- Generate the html for either the adapters dropdown list which is built with a
							     web service call to PingFederate or display an error message. --%>
							<%= DisplayUtil.writeHtmlAdapterInstanceListOrErrorMsg(request, response) %>
							
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
			                <td></td>
			                <td>
			                    <input type="submit" name="cmd" value="<%= SampleConstants.SSO_BUTTON %>"/>
			                </td>
			            </tr>
			         
			            <%  if (userInfo != null) { %>
						<tr>
							<td>Start SLO URL:</td>
							<td><input id="slolink" READONLY="true" type="text">&nbsp;<a href="javascript:createSLOLink();" style="font-size:10px;">show</a></td>
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


