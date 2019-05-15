/*******************************************************************************
 * Copyright (C) 2010 Ping Identity Corporation All rights reserved.
 * 
 * This software is licensed under the Open Software License v2.1 (OSL v2.1).
 * 
 * A copy of this license has been provided with the distribution of this
 * software. Additionally, a copy of this license is available at:
 * http://opensource.org/licenses/osl-2.1.php
 *  
 ******************************************************************************/

//Common javascript routines

function copyToClipboard(text) 
{
        if (window.clipboardData) window.clipboardData.setData("Text", text);
        else if (window.netscape) {
	  	try { 
			// ask user for permission
			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
		} catch (e) {
			// user refused permission
			//alert("UniversalXPConnect priviliges denied. If using Mozilla Firefox, access 'about:config' through the address bar and set 'signed.applets.codebase_principal_support' to 'true'."); 
		}
                var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
             	if (clip) {
	                var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
                	if (!trans) return;
                	trans.addDataFlavor('text/unicode');
                	var str = new Object();
                	var len = new Object();
                	var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
                	str.data=text;
                	trans.setTransferData("text/unicode",str,text.length*2);
                	var clipid=Components.interfaces.nsIClipboard;
                	if (!clipid) return;
                	clip.setData(trans,null,clipid.kGlobalClipboard);
                }
        }
        return;
}


function createSSOUrl(url) 
{
	if(document.getElementById('TargetResource') != null) {
		if(document.getElementById('TargetResource').value != "") {
			url += "&TargetResource=";
			url += document.getElementById('TargetResource').value;
		}
	}
	if(document.getElementById('IdPAdapterId') != null) {
		if(document.getElementById('IdPAdapterId').value != "") {
			url += "&IdpAdapterId=";
			url += document.getElementById('IdPAdapterId').value;
		}
	}
    
	return url;
}	