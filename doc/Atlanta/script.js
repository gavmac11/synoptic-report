/*
 * This file contains functions for data validation and form-level events.
 * Because the functions are referenced in the form definition (.xsf) file, 
 * it is recommended that you do not modify the name of the function,
 * or the name and number of arguments.
 *
*/

// The following line is created by Microsoft InfoPath to define the prefixes
// for all the known namespaces in the main XML data file.
// Any modification to the form files made outside of InfoPath
// will not be automatically updated.
//<namespacesDefinition>
XDocument.DOM.setProperty("SelectionNamespaces", 'xmlns:my="http://schemas.microsoft.com/office/infopath/2003/myXSD/2003-04-21T17:37:34"');
//</namespacesDefinition>

var fDebug = true;
var strSolution2CDA = "TR2CDA.xsl"
// var strUrl="http://localhost/ReceiveReferral/BTSHttpReceive.dll";
var strUrl="http://localhost/ReceiveTumorReport/BTSHttpReceive.dll";


//=======
// The following function handler is created by Microsoft InfoPath.
// Do not modify the name of the function, or the name and number of arguments.
//=======
function CTRL17_5::OnClick(eventObj)
{

}

//=======
// The following function handler is created by Microsoft InfoPath.
// Do not modify the name of the function, or the name and number of arguments.
//=======
function CTRL19_5::OnClick(eventObj)
{var oPopup = window.createPopup();
function richDropDown()
{
    oPopup.document.body.innerHTML = oContextHTML.innerHTML; 
    oPopup.show(0, 28, 305, 100, dropdowno);
}
function richToolTip()
{
    var lefter = event.offsetY+0;
    var topper = event.offsetX+15;
    oPopup.document.body.innerHTML = oToolTip.innerHTML; 
    oPopup.show(topper, lefter, 170, 120, ttip);
}
function richDialog()
{
    oPopup.document.body.innerHTML = oDialog.innerHTML; 
    oPopup.show(100, 50, 400, 300);
}
function richContext()
{
    var lefter2 = event.offsetY+0;
    var topper2 = event.offsetX+15;
    oPopup.document.body.innerHTML = oContext2.innerHTML; 
    oPopup.show(topper2, lefter2, 210, 88, contextobox);
}


}

//=======
// The following function handler is created by Microsoft InfoPath.
// Do not modify the name of the function, or the name and number of arguments.
//=======
function XDocument::OnLoad(eventObj)
{
	// Write your code here
}

//=======
// The following function handler is created by Microsoft InfoPath.
// Do not modify the name of the function, or the name and number of arguments.
// This function is associated with the following field or group (XPath): /my:myFields/my:RegionalLymphNodesSection/my:NodesExamined
// Note: Information in this comment is not updated after the function handler is created.
//=======
function msoxd_my_NodesExamined::OnAfterChange(eventObj)
{
// Write code here to restore the global state.

	if (eventObj.IsUndoRedo)
		{
			// An undo or redo operation has occurred and the DOM is read-only.
			return;
		}

// A field change has occurred and the DOM is writable. Write code here to respond to the changes.

}

//=======
// The following function handler is created by Microsoft Office InfoPath.
// Do not modify the name of the function, or the name and number of arguments.
//=======
function SubmitCDA::OnClick(eventObj)
{

	if (fDebug) debugger;
	
	var newDOM = generateValidCDA();
	
	// Create the objXMLHttp object for transporting of the HTTP message.
    try
    {
        var objXMLHttp = new ActiveXObject("MSXML2.XMLHTTP.5.0");
    }
    catch(ex)
    {
        XDocument.UI.Alert("Could not create MSXML2.XMLHTTP.5.0 object.\r\n" + ex.number + " - " + ex.description);
        eventObj.ReturnStatus = false;
        return;
    }

    // Send the HTTP POST request.
    try
    {
        strRequestXml = newDOM.xml

        objXMLHttp.open("POST", strUrl, false);
        objXMLHttp.setRequestHeader("Content-Type", "text/xml; charset=utf-8");
        objXMLHttp.send(strRequestXml);
    }
    catch(ex)
    {
        XDocument.UI.Alert("Could not post document to " + strUrl + "\r\n" + ex.number + " - " + ex.description);
        eventObj.ReturnStatus = false;
        return;
    }

/************ 
	// post xml document to strUrl
	objXmlHttp.open("POST", strUrl, false)
	try
	{
		// fix xsi types
		// newDOM.setProperty("SelectionNamespaces",'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"');
		// objXmlHttp.send(newDOM.documentElement.xml)
		objXmlHttp.send(newDOM)
	}
	catch(ex)
	{
		XDocument.UI.Alert("Could not post to" + strUrl+"-"+objXmlHttp.Status+"-");
		return false;
	}
********/

	// check server HTTP response
	if ((objXMLHttp.Status != 200) && (objXMLHttp.Status != 202))
	{
        XDocument.UI.Alert("Could not post document to " + strUrl + "\r\n" + ex.number + " - " + ex.description);
		// XDocument.UI.Alert("Could not post to" + strUrl+" - "+objXMLHttp.Status+" -" );
        eventObj.ReturnStatus = false;
		return;
	}
	else
		XDocument.UI.Alert("Post Success");

	// debug: XDocument.UI.Alert("200 OK returned:\r\n\r\n" + objXmlHttp.responseText)
    eventObj.ReturnStatus = true;
	return;
}

function generateValidCDA()
{
	if (fDebug) debugger;;
    var xmlDOM, xsltDOM, strCDADOM;
    var newDOM = new ActiveXObject("Msxml2.DOMDocument.5.0");

    try 
    {
        xmlDOM = XDocument.DOM;
        xsltDOM = new ActiveXObject("MSXML2.DOMDocument.5.0");
        xsltDOM.validateOnParse = false;
        xsltDOM.async = false;
        xsltDOM.resolveExternals = false;
        xsltDOM.load(strSolution2CDA); 
        strCDADOM = xmlDOM.transformNode(xsltDOM);   

        newDOM.validateOnParse = false;
        newDOM.loadXML(strCDADOM);
	}
    catch(err) 
    {
        XDocument.UI.Alert(err.description);
    }
 
	return newDOM;
}
