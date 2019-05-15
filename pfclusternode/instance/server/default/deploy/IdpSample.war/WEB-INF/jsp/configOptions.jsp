<%--
*******************************************************************************
* Copyright (C) 2010 Ping Identity Corporation All rights reserved.
*
* This software is licensed under the Open Software License v2.1 (OSL v2.1).
*
* A copy of this license has been provided with the distribution of this
* software. Additionally, a copy of this license is available at:
* http://opensource.org/licenses/osl-2.1.php
*
******************************************************************************
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.File" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.InputStream" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "com.pingidentity.sample.idp.manage.ConfigManager" %>
<%@ page import = "com.pingidentity.sample.idp.manage.SampleAppConfig" %>
<%@ page import = "com.pingidentity.sample.idp.manage.SampleConstants" %>
<%@ page import = "com.pingidentity.sample.util.URLUtil" %>

<%
	String showAdvanced = request.getParameter("showAdvanced");

	if (showAdvanced == null) 
	{
		showAdvanced = "false";	
	}

	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");

	ConfigManager configManager = ConfigManager.getInstance();
	Properties idpConfigProperties = null;
	if (configManager != null)
	{
		SampleAppConfig sampleAppConfig = configManager.getConfig();
		if (sampleAppConfig != null)
		{
			idpConfigProperties = sampleAppConfig.getIdpConfig();
		}
	}
	
	// Get all of the fields from the config file for display
	String hostPF = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_HOST);
	String attributeNamesList = idpConfigProperties.getProperty(SampleConstants.SAMPLE_ATTRS_NAMES_LIST);
	String useSSL = idpConfigProperties.getProperty(SampleConstants.SAMPLE_USE_SSL);
	String httpPort = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_HTTP_PORT);
	String httpsPort = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_HTTPS_PORT);
	String pfContextPath = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_CONTEXT_PATH);
	String wsUname = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_WS_UNAME);
	String wsPwd = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_WS_PWD);

	// On an upload the contentType will switch to multipart/form-data,
	// so call the ConfigManager to upload the OpenToken config file specified
	// by the user.
	String contentType = request.getContentType();
	String uploadMessage = null;
	if (contentType != null && contentType.contains("multipart/form-data"))
	{
		uploadMessage = ConfigManager.uploadContents(request);
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
	<head>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<LINK media="screen" href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
	<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<title>IdP Integration Configuration</title>
	<script type="text/javascript" src="scripts/common.js"></script>
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
			<a href="<%= URLUtil.getIdentityProviderHomeUrl(request) %>">Identity Provider Home</a> 
			</td>
		</tr>
		</table> 
	</div>

	<div id="content">
   		<form name="config" method="POST" action="<%= URLUtil.getConfigOptionsFormPostUrl(request, showAdvanced)%>">
		<table class="cell" style="margin-left: auto; margin-right: auto;">
			<tr>
				<td colspan="2" style="text-align: center;">
					<h1>IdP Sample Application Configuration <br/> (<%= ConfigManager.getIdpConfigFileName() %>)</h1>
					<hr class="cell"/>
				</td>
			</tr>

			<%	
				if (request.getParameter(SampleConstants.SAMPLE_PF_HOST) != null) {			
			%>
			<tr>
				<td colspan="2" class="error"  style="text-align: center;">			
					Configuration successfully saved.
					<hr class="cell"/>					
				</td>
			</tr>			
			<%
				} else {
					String errorMessage = request.getParameter(SampleConstants.ATTRIB_NAME_ERROR);
					if (errorMessage != null) {
			%>
			<tr>
				<td colspan="2" class="error"  style="text-align: center;">			
					<%= errorMessage %>
					<hr class="cell"/>					
				</td>
			</tr>			
			<%
					}
				}
			%>				

  			<tr>
  				<td align="left">PF Host Name: </td>
  				<td align="left">
  					<input type="text" name="<%= SampleConstants.SAMPLE_PF_HOST %>" id="<%= SampleConstants.SAMPLE_PF_HOST %>" value="<%= hostPF %>">
  				</td>
  			</tr>
			<tr>
				<td></td>
				<td>
					<% if ("true".equalsIgnoreCase(showAdvanced)) { %>
						<a href="<%= URLUtil.getHideAdvancedUrl(request, SampleConstants.PARAM_CMD_CONFIG_OPTIONS) %>">Hide advanced options</a>
					<% } else {%>
						<a href="<%= URLUtil.getShowAdvancedUrl(request, SampleConstants.PARAM_CMD_CONFIG_OPTIONS) %>">Show advanced options</a>
					<% } %>
				</td>
			</tr>			
				   
            <% 	if ("true".equalsIgnoreCase(showAdvanced)) { %>  				   
  				   <tr>
  					   <td align="left">Use SSL:  </td>
  					   <td align="left">
  							<% if ("true".equalsIgnoreCase(useSSL)) { %>
  					   			<input type="checkbox" checked name="<%= SampleConstants.SAMPLE_USE_SSL %>" id="<%= SampleConstants.SAMPLE_USE_SSL %>" value="checked" >

  					   		<% } else { %>
  					   			<input type="checkbox" name="<%= SampleConstants.SAMPLE_USE_SSL %>" id="<%= SampleConstants.SAMPLE_USE_SSL %>" value="checked" >

  					   		<% } %>
						</td>
  				   </tr>

  				   <tr>
  					   <td align="left">PF HTTP Port: </td>
  					   <td align="left">  					   	
  					   	<input type="text" name="<%= SampleConstants.SAMPLE_PF_HTTP_PORT %>" id="<%= SampleConstants.SAMPLE_PF_HTTP_PORT %>" value="<%= httpPort %>">
  					   </td>
  				   </tr>				   				   				     				   
  				   <tr>
  					   <td align="left">PF HTTPS Port: </td>
  					   <td align="left">  					   	
  					   	<input type="text" name="<%= SampleConstants.SAMPLE_PF_HTTPS_PORT %>" id="<%= SampleConstants.SAMPLE_PF_HTTPS_PORT %>" value="<%= httpsPort %>">
  					   </td>
  				   </tr>				   				   				     				     				   
  				   <tr>
  					   <td align="left">PF Context Path: </td>
  					   <td align="left">  					   	
  					   	<input type="text" name="<%= SampleConstants.SAMPLE_PF_CONTEXT_PATH %>" id="<%= SampleConstants.SAMPLE_PF_CONTEXT_PATH %>" value="<%= pfContextPath %>">
  					   </td>
  				   </tr>				   				   				     				     				   
  				   <tr>
  					   <td align="left">PF Web Service Username: </td>
  					   <td align="left">  					   	
  					   	<input type="text" name="<%= SampleConstants.SAMPLE_PF_WS_UNAME %>" id="<%= SampleConstants.SAMPLE_PF_WS_UNAME %>" value="<%= wsUname %>">
  					   </td>
  				   </tr>				   				   				     				     				     				   
  				   <tr>
  					   <td align="left">PF Web Service Password: </td>
  					   <td align="left">  					   	
  					   	<input type="password" name="<%= SampleConstants.SAMPLE_PF_WS_PWD %>" id="<%= SampleConstants.SAMPLE_PF_WS_PWD %>" value="<%= wsPwd %>">
  					   </td>
  				   </tr>				   				   				     				   
  				   <tr>
  					   <td align="left">Attribute Names List: </td>
  					   <td align="left">  					   	
  					   	<input type="text" name="<%= SampleConstants.SAMPLE_ATTRS_NAMES_LIST %>" id="<%= SampleConstants.SAMPLE_ATTRS_NAMES_LIST %>" value="<%= attributeNamesList %>">
  					   </td>
  				   </tr>				   				   				   				   				   				   
  				   
				<%	} %>
  				   <tr>
					 <td></td>
  					   <td>
  						<input type="submit" value="Save">
  					   </td>
				   </tr>
				</table>	     								   
  				</form>

				<FORM ENCTYPE='multipart/form-data' method='POST' action=''>            					   
					<table class="cell" style="margin-left: auto; margin-right: auto;">
						<tr>
							<td colspan="6" style="text-align: center;">
							<h1>IdP OpenToken Configuration <br/> (<%= ConfigManager.getOpenTokenConfigFileName() %>)</h1>
							<hr class="cell"/>
							</td>
						</tr>
						<%
							if (uploadMessage != null) {
						%>
						<tr>
							<td colspan="2" class="error"  style="text-align: center;">			
								<%= uploadMessage %>
								<hr class="cell"/>					
							</td>
						</tr>		
						<%
							}
						%>
						<tr>
							<td>OpenToken Adapter Config File:</td>
							<td><INPUT TYPE='file' NAME='mptest'></td>
						</tr>
						<tr>
							<td></td>
							<td><INPUT TYPE='submit' VALUE='Upload'></td>
						</tr>
					</table>
				</FORM>
		</div>
	</div>
  </body>
</html>
