<%--
*******************************************************************************
* Copyright (C) 2006 Ping Identity Corporation All rights reserved.
*
* This software is licensed under the Open Software License v2.1 (OSL v2.1).
*
* A copy of this license has been provided with the distribution of this
* software. Additionally, a copy of this license is available at:
* http://opensource.org/licenses/osl-2.1.php
*
******************************************************************************
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<html>
	<head>
		<META http-equiv=Content-Type content="text/html; charset=utf-8">
		<LINK media=screen href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
		<link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
		<title>SP Sample Application Configuration Error Page</title>
	</head>
	
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
				</td>
			</tr>
			</table> 
		</div>
		<div id="content">
			<table style="float: right;" class="cell">
				<tr>
					<td colspan="2" style="text-align: center;">
						There was a configuration error.  Please check the logs.
					</td>
				</tr>
	        </table>
	     </div>
	</div>
	</body>
</html>