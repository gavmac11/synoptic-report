<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:my="http://schemas.microsoft.com/office/infopath/2003/myXSD/2003-04-21T17:37:34" xmlns:xd="http://schemas.microsoft.com/office/infopath/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:xdExtension="http://schemas.microsoft.com/office/infopath/2003/xslt/extension" xmlns:xdXDocument="http://schemas.microsoft.com/office/infopath/2003/xslt/xDocument" xmlns:xdSolution="http://schemas.microsoft.com/office/infopath/2003/xslt/solution" xmlns:xdFormatting="http://schemas.microsoft.com/office/infopath/2003/xslt/formatting" xmlns:xdImage="http://schemas.microsoft.com/office/infopath/2003/xslt/xImage" xmlns:xdUtil="http://schemas.microsoft.com/office/infopath/2003/xslt/Util" xmlns:xdMath="http://schemas.microsoft.com/office/infopath/2003/xslt/Math" xmlns:xdDate="http://schemas.microsoft.com/office/infopath/2003/xslt/Date" xmlns:sig="http://www.w3.org/2000/09/xmldsig#" xmlns:xdSignatureProperties="http://schemas.microsoft.com/office/infopath/2003/SignatureProperties">
	<xsl:output method="html" indent="no"/>
	<xsl:template match="my:PathologyReport">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html"></meta>
				<style controlStyle="controlStyle">@media screen 			{ 			BODY{margin-left:21px;background-position:21px 0px;} 			} 		BODY{color:windowtext;background-color:window;layout-grid:none;} 		.xdListItem {display:inline-block;width:100%;vertical-align:text-top;} 		.xdListBox,.xdComboBox{margin:1px;} 		.xdInlinePicture{margin:1px; BEHAVIOR: url(#default#urn::xdPicture) } 		.xdLinkedPicture{margin:1px; BEHAVIOR: url(#default#urn::xdPicture) url(#default#urn::controls/Binder) } 		.xdSection{border:1pt solid #FFFFFF;margin:6px 0px 6px 0px;padding:1px 1px 1px 5px;} 		.xdRepeatingSection{border:1pt solid #FFFFFF;margin:6px 0px 6px 0px;padding:1px 1px 1px 5px;} 		.xdBehavior_Formatting {BEHAVIOR: url(#default#urn::controls/Binder) url(#default#Formatting);} 	 .xdBehavior_FormattingNoBUI{BEHAVIOR: url(#default#CalPopup) url(#default#urn::controls/Binder) url(#default#Formatting);} 	.xdExpressionBox{margin: 1px;padding:1px;word-wrap: break-word;text-overflow: ellipsis;overflow-x:hidden;}.xdBehavior_GhostedText,.xdBehavior_GhostedTextNoBUI{BEHAVIOR: url(#default#urn::controls/Binder) url(#default#TextField) url(#default#GhostedText);}	.xdBehavior_GTFormatting{BEHAVIOR: url(#default#urn::controls/Binder) url(#default#Formatting) url(#default#GhostedText);}	.xdBehavior_GTFormattingNoBUI{BEHAVIOR: url(#default#CalPopup) url(#default#urn::controls/Binder) url(#default#Formatting) url(#default#GhostedText);}	.xdBehavior_Boolean{BEHAVIOR: url(#default#urn::controls/Binder) url(#default#BooleanHelper);}	.xdBehavior_Select{BEHAVIOR: url(#default#urn::controls/Binder) url(#default#SelectHelper);}	.xdRepeatingTable{BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word;}.xdScrollableRegion{BEHAVIOR: url(#default#ScrollableRegion);} 		.xdMaster{BEHAVIOR: url(#default#MasterHelper);} 		.xdActiveX{margin:1px; BEHAVIOR: url(#default#ActiveX);} 		.xdFileAttachment{display:inline-block;margin:1px;BEHAVIOR:url(#default#urn::xdFileAttachment);} 		.xdPageBreak{display: none;}BODY{margin-right:21px;} 		.xdTextBoxRTL{display:inline-block;white-space:nowrap;text-overflow:ellipsis;;padding:1px;margin:1px;border: 1pt solid #dcdcdc;color:windowtext;background-color:window;overflow:hidden;text-align:right;} 		.xdRichTextBoxRTL{display:inline-block;;padding:1px;margin:1px;border: 1pt solid #dcdcdc;color:windowtext;background-color:window;overflow-x:hidden;word-wrap:break-word;text-overflow:ellipsis;text-align:right;font-weight:normal;font-style:normal;text-decoration:none;vertical-align:baseline;} 		.xdDTTextRTL{height:100%;width:100%;margin-left:22px;overflow:hidden;padding:0px;white-space:nowrap;} 		.xdDTButtonRTL{margin-right:-21px;height:18px;width:20px;behavior: url(#default#DTPicker);}.xdTextBox{display:inline-block;white-space:nowrap;text-overflow:ellipsis;;padding:1px;margin:1px;border: 1pt solid #dcdcdc;color:windowtext;background-color:window;overflow:hidden;text-align:left;} 		.xdRichTextBox{display:inline-block;;padding:1px;margin:1px;border: 1pt solid #dcdcdc;color:windowtext;background-color:window;overflow-x:hidden;word-wrap:break-word;text-overflow:ellipsis;text-align:left;font-weight:normal;font-style:normal;text-decoration:none;vertical-align:baseline;} 		.xdDTPicker{;display:inline;margin:1px;margin-bottom: 2px;border: 1pt solid #dcdcdc;color:windowtext;background-color:window;overflow:hidden;} 		.xdDTText{height:100%;width:100%;margin-right:22px;overflow:hidden;padding:0px;white-space:nowrap;} 		.xdDTButton{margin-left:-21px;height:18px;width:20px;behavior: url(#default#DTPicker);} 		.xdRepeatingTable TD {VERTICAL-ALIGN: top;}</style>
				<style tableEditor="TableStyleRulesID">TABLE.xdLayout TD {
	BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none
}
TABLE.msoUcTable TD {
	BORDER-RIGHT: 1pt solid; BORDER-TOP: 1pt solid; BORDER-LEFT: 1pt solid; BORDER-BOTTOM: 1pt solid
}
TABLE {
	BEHAVIOR: url (#default#urn::tables/NDTable)
}
</style>
				<style languageStyle="languageStyle">BODY {
	FONT-SIZE: 10pt; FONT-FAMILY: Verdana
}
TABLE {
	FONT-SIZE: 10pt; FONT-FAMILY: Verdana
}
SELECT {
	FONT-SIZE: 10pt; FONT-FAMILY: Verdana
}
.optionalPlaceholder {
	PADDING-LEFT: 20px; FONT-WEIGHT: normal; FONT-SIZE: xx-small; BEHAVIOR: url(#default#xOptional); COLOR: #333333; FONT-STYLE: normal; FONT-FAMILY: Verdana; TEXT-DECORATION: none
}
.langFont {
	FONT-FAMILY: Verdana
}
</style>
				<style themeStyle="urn:office.microsoft.com:themeBrightBlue">BODY {
	COLOR: black; BACKGROUND-COLOR: white
}
TABLE {
	BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse
}
TD {
	BORDER-LEFT-COLOR: #408ce8; BORDER-BOTTOM-COLOR: #408ce8; BORDER-TOP-COLOR: #408ce8; BORDER-RIGHT-COLOR: #408ce8
}
TH {
	BORDER-LEFT-COLOR: #408ce8; BORDER-BOTTOM-COLOR: #408ce8; COLOR: black; BORDER-TOP-COLOR: #408ce8; BACKGROUND-COLOR: #d3e5fa; BORDER-RIGHT-COLOR: #408ce8
}
.xdTableHeader {
	COLOR: black; BACKGROUND-COLOR: #f5f3eb
}
P {
	MARGIN-TOP: 0px
}
H1 {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; COLOR: #134fc7
}
H2 {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; COLOR: #134fc7
}
H3 {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; COLOR: #134fc7
}
H4 {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; COLOR: #134fc7
}
H5 {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; COLOR: #408ce8
}
H6 {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; COLOR: #f5f3eb
}
.primaryVeryDark {
	COLOR: #f5f3eb; BACKGROUND-COLOR: #134fc7
}
.primaryDark {
	COLOR: white; BACKGROUND-COLOR: #408ce8
}
.primaryMedium {
	COLOR: black; BACKGROUND-COLOR: #d3e5fa
}
.primaryLight {
	COLOR: black; BACKGROUND-COLOR: #f5f3eb
}
.accentDark {
	COLOR: white; BACKGROUND-COLOR: #ff8716
}
.accentLight {
	COLOR: black; BACKGROUND-COLOR: #ffd991
}
</style>
			</head>
			<body style="BACKGROUND-COLOR: #f5f3eb">
				<div> </div>
				<div> </div>
				<div align="center">
					<table class="xdFormLayout xdLayout" style="TABLE-LAYOUT: fixed; WIDTH: 700px; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word; BORDER-BOTTOM-STYLE: none" border="1">
						<colgroup>
							<col style="WIDTH: 100px"></col>
							<col style="WIDTH: 500px"></col>
							<col style="WIDTH: 100px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt; BACKGROUND-COLOR: #134fc7">
									<div align="center">
										<a href="http://www.cap.org/apps/cap.portal">
											<img style="WIDTH: 96px; HEIGHT: 98px" src="mso4E16A.png"/>
										</a>
										<a href="http://www.snomed.org/">
											<img style="WIDTH: 96px; HEIGHT: 37px" height="37" src="mso74DC0.png" width="96"/>
										</a>
										<a href="http://www.cap.org/index.html" xd:disableEditing="yes">
											<font color="#000099"></font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #000000 1pt; PADDING-RIGHT: 3px; BORDER-TOP: #000000 1pt; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt; PADDING-TOP: 3px; BORDER-BOTTOM: #000000 1pt; BACKGROUND-COLOR: #134fc7">
									<div style="FONT-WEIGHT: normal" align="center">
										<a href="http://www.dukehealth.org/" xd:disableEditing="yes">
											<img style="WIDTH: 210px; HEIGHT: 54px" height="366" src="8678B9F7.jpg" width="1384"/>
										</a>
									</div>
									<div style="FONT-WEIGHT: normal" align="center"> </div>
									<h2 style="FONT-WEIGHT: normal" align="center">
										<a title="Based on the &quot;Breast&quot; cancer diagnostic protocol&quot; of the College of American Pathologists." href="http://www.cap.org/cancerprotocols/breast03_p.html" tabIndex="0">
											<font face="Century Schoolbook" color="#d3e5fa">
												<strong>Lung cancer </strong>
											</font>
										</a>
									</h2>
									<h2 style="FONT-WEIGHT: normal" align="center">
										<font face="Century Schoolbook" color="#d3e5fa">
											<strong>diagnostic report template</strong>
										</font>
									</h2>
								</td>
								<td style="BORDER-RIGHT: #000000 1pt; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt; BACKGROUND-COLOR: #134fc7">
									<div align="center">
										<a href="http://www.hl7.org/">
											<font size="1">
												<em>
													<img style="WIDTH: 96px; HEIGHT: 82px" height="82" src="mso4C83D.png" width="96"/>
												</em>
											</font>
										</a>
									</div>
									<div align="center">
										<font size="1">
											<em/>
										</font> </div>
									<div align="center">
										<a href="http://office.microsoft.com/home/default.aspx">
											<font size="1">
												<em>
													<img style="WIDTH: 1in; HEIGHT: 37px" height="60" src="msoAE69B.png" width="152"/>
												</em>
											</font>
										</a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div align="center"><xsl:apply-templates select="my:Header" mode="_67"/>
				</div>
				<div align="center">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 700px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 700px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr>
								<td style="BORDER-RIGHT: #000000 3pt double; PADDING-RIGHT: 3px; BORDER-TOP: #000000 3pt double; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 3pt double; PADDING-TOP: 3px; BORDER-BOTTOM: #000000 3pt double; BACKGROUND-COLOR: #d3e5fa">
									<div align="justify">
										<em>
											<font size="1">This template conforms to the final draft version of the College of American Pathologists "</font>
										</em>
										<a href="http://www.cap.org/cancerprotocols/protocols_index.html" xd:disableEditing="yes">
											<em>
												<font color="#3366ff" size="1">Diagnostic Protocols for Cancer Diagnosis</font>
											</em>
										</a>
										<em>
											<font size="1">". The document generated using this template will contain all required informational elements with xml markup as defined in the </font>
											<a href="http://www.example.com/" xd:disableEditing="yes">
												<font color="#3366ff" size="1">online resource guide </font>
											</a>
											<font size="1">for this InfoPath solution. Reports generated from the result document can be further customized using an approved stylesheet (.xsl).</font>
										</em>
									</div>
									<div align="justify">
										<em>
											<font size="1"></font>
										</em> </div>
									<div align="justify">
										<font size="1">
											<em>Summary help is available in the task pane on the right side of the screen (</em>not yet implemented<em>). Links to supplementary online resources are available for many items by clicking the </em>
											<font face="Wingdings" color="#0000ff" size="4">Ü</font> icons. </font>
									</div>
									<div align="left">
										<font size="1">
											<em/>
										</font> </div>
									<div align="justify">
										<font size="1">
											<em>Output of this form can be enclosed within an HL7 CDA shell by selecting "HL7-CDA" in the Views menus (</em>not yet implemented<em>).</em>
										</font>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div align="left"> </div>
				<div align="center"><xsl:apply-templates select="my:ClinicalHistory" mode="_43"/>
				</div>
				<div align="center"><xsl:apply-templates select="my:Gross" mode="_44"/>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:CPT">
							<xsl:apply-templates select="my:CPT" mode="_58"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="CPT_313" tabIndex="0" align="left" style="WIDTH: 700px">Click here to insert CPT codes...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:Intraoperative">
							<xsl:apply-templates select="my:Intraoperative" mode="_46"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="Intraoperative_341" tabIndex="0" align="left" style="WIDTH: 700px">Click here to intraoperative consultation results...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div align="center"><xsl:apply-templates select="my:Microscopic" mode="_52"/>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:Images">
							<xsl:apply-templates select="my:Images" mode="_62"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="Images_322" tabIndex="0" align="left" style="WIDTH: 700px">Click here to insert images...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:Immunohistochemistry">
							<xsl:apply-templates select="my:Immunohistochemistry" mode="_54"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="Immunohistochemistry_295" tabIndex="0" align="left" style="WIDTH: 700px">Click here to insert immunohistochemical findings...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:Molecular">
							<xsl:apply-templates select="my:Molecular" mode="_59"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="Molecular_317" tabIndex="0" align="left" style="WIDTH: 708px">Click here to insert molecular diagnostic findings...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:EM">
							<xsl:apply-templates select="my:EM" mode="_61"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="EM_318" tabIndex="0" align="left" style="WIDTH: 700px">Click here to insert electron microscopic  findings...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div align="center"><xsl:apply-templates select="my:Diagnosis" mode="_40"/>
				</div>
				<div align="center"><xsl:choose>
						<xsl:when test="my:Comments">
							<xsl:apply-templates select="my:Comments" mode="_57"/>
						</xsl:when>
						<xsl:otherwise>
							<div class="optionalPlaceholder" xd:xmlToEdit="Comments_319" tabIndex="0" align="left" style="WIDTH: 700px">Click here to insert comments...</div>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div> </div>
				<div align="center"><input class="langFont" title="" style="WIDTH: 253px; HEIGHT: 43px" type="button" value="Submit as CDA Document" xd:xctname="Button" xd:CtrlId="SubmitCDA" tabIndex="0"/>
				</div>
				<div> </div>
				<div> </div>
				<div> </div>
				<div> </div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="my:Header" mode="_67">
		<div class="xdSection xdRepeating" title="" style="BORDER-RIGHT: #0000ff 1pt ridge; BORDER-TOP: #0000ff 1pt ridge; MARGIN-BOTTOM: 6px; BORDER-LEFT: #0000ff 1pt ridge; WIDTH: 699px; BORDER-BOTTOM: #0000ff 1pt ridge; HEIGHT: 491px; BACKGROUND-COLOR: #ffd991" align="left" xd:xctname="Section" xd:CtrlId="CTRL607">
			<div align="center">
				<strong>
					<font size="4">Demographics</font>
				</strong>
			</div>
			<div> </div>
			<div align="center">Effective time: <span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:xctname="PlainText" xd:CtrlId="CTRL608" xd:boundProp="xd:num" xd:datafmt="&quot;datetime&quot;,&quot;dateFormat:Short Date;&quot;" xd:binding="my:EffectiveTime" xd:disableEditing="yes" style="WIDTH: 216px; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
					<xsl:attribute name="xd:num">
						<xsl:value-of select="my:EffectiveTime"/>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="function-available('xdFormatting:formatString')">
							<xsl:value-of select="xdFormatting:formatString(my:EffectiveTime,&quot;datetime&quot;,&quot;dateFormat:Short Date;&quot;)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="my:EffectiveTime"/>
						</xsl:otherwise>
					</xsl:choose>
				</span>  </div>
			<div/>
			<div align="center">
				<strong>
					<font size="3">Patient:</font>
				</strong>
			</div>
			<div align="center">
				<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 367px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
					<colgroup>
						<col style="WIDTH: 142px"></col>
						<col style="WIDTH: 225px"></col>
					</colgroup>
					<tbody vAlign="top">
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">First Name</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL609" xd:binding="my:GivenName" style="WIDTH: 100%">
											<xsl:value-of select="my:GivenName"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">Last Name</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL610" xd:binding="my:FamilyName" style="WIDTH: 100%">
											<xsl:value-of select="my:FamilyName"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">Gender</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><select class="xdComboBox xdBehavior_Select" title="" size="1" xd:xctname="DropDown" xd:CtrlId="CTRL611" xd:boundProp="value" xd:binding="my:PatientSex" style="WIDTH: 100%">
											<xsl:attribute name="value">
												<xsl:value-of select="my:PatientSex"/>
											</xsl:attribute>
											<option>
												<xsl:if test="my:PatientSex=&quot;&quot;">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>Select...</option>
											<option value="M">
												<xsl:if test="my:PatientSex=&quot;M&quot;">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>Male</option>
											<option value="F">
												<xsl:if test="my:PatientSex=&quot;F&quot;">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>Female</option>
										</select>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Verdana" size="2">Patient ID</font>
								</div>
							</td>
							<td style="BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL612" xd:binding="my:PatientIDExtension" style="WIDTH: 100%">
											<xsl:value-of select="my:PatientIDExtension"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="BORDER-TOP-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Verdana" size="2">ID Root</font>
								</div>
							</td>
							<td style="BORDER-TOP-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL613" xd:binding="my:PatientIDRoot" style="WIDTH: 100%">
											<xsl:value-of select="my:PatientIDRoot"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="BORDER-TOP-STYLE: none">
								<div>
									<font face="Verdana" size="2">Date Of Birth</font>
								</div>
							</td>
							<td style="BORDER-TOP-STYLE: none">
								<div>
									<font face="Verdana" size="2">
										<div class="xdDTPicker" title="" style="WIDTH: 100%" noWrap="1" xd:xctname="DTPicker" xd:CtrlId="CTRL614"><span class="xdDTText xdBehavior_FormattingNoBUI" hideFocus="1" contentEditable="true" xd:xctname="DTPicker_DTText" xd:boundProp="xd:num" xd:datafmt="&quot;date&quot;,&quot;dateFormat:Short Date;&quot;" xd:binding="my:DOB" xd:innerCtrl="_DTText">
												<xsl:attribute name="xd:num">
													<xsl:value-of select="my:DOB"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(my:DOB,&quot;date&quot;,&quot;dateFormat:Short Date;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="my:DOB"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
											<button class="xdDTButton" xd:xctname="DTPicker_DTButton" xd:innerCtrl="_DTButton">
												<img src="res://infopath.exe/calendar.gif" Linked="true"/>
											</button>
										</div>
									</font>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div> </div>
			<div align="center">
				<strong>
					<font size="3">Pathologist:</font>
				</strong>
			</div>
			<div align="center">
				<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 440px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
					<colgroup>
						<col style="WIDTH: 223px"></col>
						<col style="WIDTH: 217px"></col>
					</colgroup>
					<tbody vAlign="top">
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">First Name</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL615" xd:binding="my:PathologistGivenName" style="WIDTH: 100%; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
											<xsl:value-of select="my:PathologistGivenName"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">Last Name</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL616" xd:binding="my:PathologistFamilyName" style="WIDTH: 100%; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
											<xsl:value-of select="my:PathologistFamilyName"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">Suffix</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL617" xd:binding="my:PathologistSuffix" style="WIDTH: 100%; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
											<xsl:value-of select="my:PathologistSuffix"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">Pathologist ID</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL622" xd:binding="my:PathologistIDExtension" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
											<xsl:value-of select="my:PathologistIDExtension"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">ID Root</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL619" xd:binding="my:PathologistIDRoot" style="WIDTH: 100%; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
											<xsl:value-of select="my:PathologistIDRoot"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<font face="Verdana" size="2">Represented Organization ID</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" xd:xctname="PlainText" xd:CtrlId="CTRL620" xd:binding="my:RepOrgExtension" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
											<xsl:value-of select="my:RepOrgExtension"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div> </div>
			<div align="center">Document ID: <span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:xctname="PlainText" xd:CtrlId="CTRL621" xd:binding="my:DocIDRoot" xd:disableEditing="yes" style="WIDTH: 357px; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
					<xsl:value-of select="my:DocIDRoot"/>
				</span>
			</div>
			<div> </div>
		</div>
	</xsl:template>
	<xsl:template match="my:ClinicalHistory" mode="_43">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL392" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>Clinical history</strong>
				</font>
			</div>
			<div align="left">
				<span class="xdRepeating" title="" style="MARGIN: 0px; WIDTH: 7.121in; HEIGHT: 16px; BACKGROUND-COLOR: #ffffff" xd:xctname="PlainList">
					<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: none">
						<xsl:for-each select="my:Item">
							<li><span class="xdListItem" hideFocus="1" tabIndex="0" xd:xctname="ListItem_Plain" xd:CtrlId="CTRL425" xd:binding="." style="WIDTH: 100%">
									<xsl:value-of select="."/>
								</span>
							</li>
						</xsl:for-each>
					</ol>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Gross" mode="_44">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL427" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>Gross description</strong>
				</font>
			</div>
			<div><xsl:apply-templates select="my:Specimen.GD" mode="_50"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Specimen.GD" mode="_50">
		<div class="xdRepeatingSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 6.544in; PADDING-TOP: 0px; HEIGHT: 49px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL428" tabIndex="-1">
			<div><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL538" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #d3e5fa">
					<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
				</span>
			</div>
			<div align="center"><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="RichText" xd:CtrlId="CTRL591" xd:binding="my:Text.GD" style="WIDTH: 687px; HEIGHT: 23px">
					<xsl:copy-of select="my:Text.GD/node()"/>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:CPT" mode="_58">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL464" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>CPT Codes</strong>
					<a href="https://webstore.ama-assn.org/search/CptLookup.jhtml">
						<font face="Wingdings" color="#0000ff" size="4">Ü</font>
					</a>
				</font>
			</div>
			<div align="left">
				<span class="xdRepeating" title="" style="MARGIN-BOTTOM: 1px; WIDTH: 689px; HEIGHT: 16px; BACKGROUND-COLOR: #ffffff" xd:xctname="NumberedList">
					<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: decimal">
						<xsl:for-each select="my:Codes">
							<li><span class="xdListItem" hideFocus="1" tabIndex="0" xd:xctname="ListItem_Plain" xd:CtrlId="CTRL544" xd:binding="." style="WIDTH: 100%">
									<xsl:value-of select="."/>
								</span>
							</li>
						</xsl:for-each>
					</ol>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Intraoperative" mode="_46">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL436" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>Intraoperative consultation</strong>
				</font>
			</div>
			<div><xsl:apply-templates select="my:Specimen.IO" mode="_51"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Specimen.IO" mode="_51">
		<div class="xdRepeatingSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 6.933in; PADDING-TOP: 0px; HEIGHT: 42px" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL437" tabIndex="-1">
			<div><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL535" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #d3e5fa">
					<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
				</span>
			</div>
			<div align="center"><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="RichText" xd:CtrlId="CTRL438" xd:binding="my:Text.IO" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 7.17in; PADDING-TOP: 0px; HEIGHT: 18px">
					<xsl:copy-of select="my:Text.IO/node()"/>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Microscopic" mode="_52">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL440" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>Microscopic description</strong>
				</font>
			</div>
			<div><xsl:apply-templates select="my:Specimen.MD" mode="_53"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Specimen.MD" mode="_53">
		<div class="xdRepeatingSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 6.87in; PADDING-TOP: 0px; HEIGHT: 42px" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL441" tabIndex="-1">
			<div>
				<font face="Century Schoolbook">
					<strong><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL537" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #d3e5fa">
							<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
						</span>
					</strong>
				</font>
			</div>
			<div align="center"><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="RichText" xd:CtrlId="CTRL442" xd:binding="my:Text.MD" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 7.179in; PADDING-TOP: 0px; HEIGHT: 18px">
					<xsl:copy-of select="my:Text.MD/node()"/>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Images" mode="_62">
		<div class="xdSection xdRepeating" title="" style="BORDER-RIGHT: #ffffff 1pt; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 1pt; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-LEFT: #ffffff 1pt; WIDTH: 700px; BORDER-BOTTOM: #ffffff 1pt; BACKGROUND-COLOR: #d3e5fa" align="left" xd:xctname="Section" xd:CtrlId="CTRL470" tabIndex="-1">
			<div align="left">
				<strong>
					<font face="Century Schoolbook" size="3">Images</font>
				</strong>
			</div>
			<div align="left">
				<table class="xdRepeatingTable msoUcTable" title="Insert your images here. You can add as many images as you want by selecting the tab to the left of the sample photo." style="TABLE-LAYOUT: fixed; WIDTH: 695px; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word; BORDER-BOTTOM-STYLE: none" border="1" xd:CtrlId="CTRL157">
					<colgroup>
						<col style="WIDTH: 3.021in"></col>
						<col style="WIDTH: 405px"></col>
					</colgroup><tbody xd:xctname="repeatingtable">
						<xsl:for-each select="my:Image">
							<tr>
								<td style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #408ce8 1pt; BORDER-BOTTOM: #c0c0c0 1pt solid">
									<font face="Century Schoolbook"><xsl:if test="function-available('xdImage:getImageUrl')">
											<img class="xdInlinePicture" hideFocus="1" style="WIDTH: 3in; HEIGHT: 2in" alt="Click here to insert a picture" tabIndex="0" xd:xctname="InlineImage" xd:CtrlId="CTRL476" xd:boundProp="" xd:binding="my:Photo" tabStop="true" xd:inline="my:Photo" src="{xdImage:getImageUrl(my:Photo)}"/>
										</xsl:if>
									</font>
								</td>
								<td style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #c0c0c0 1pt solid; BORDER-BOTTOM: #c0c0c0 1pt solid">
									<div align="justify"><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="RichText" xd:CtrlId="CTRL477" xd:binding="my:ImageDescription" style="WIDTH: 100%; HEIGHT: 116px">
											<xsl:copy-of select="my:ImageDescription/node()"/>
										</span>
									</div>
									<div align="center">
										<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 402px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
											<colgroup>
												<col style="WIDTH: 117px"></col>
												<col style="WIDTH: 285px"></col>
											</colgroup>
											<tbody vAlign="top">
												<tr style="MIN-HEIGHT: 27px">
													<td style="BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: medium none; PADDING-TOP: 1px; BORDER-BOTTOM: medium none">
														<div>
															<font face="Century Schoolbook" size="2">
																<strong>Type of image:</strong>
															</font>
														</div>
													</td>
													<td style="BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: medium none; PADDING-TOP: 1px; BORDER-BOTTOM: medium none">
														<div>
															<font face="Verdana" size="2"><select class="xdComboBox xdBehavior_Select" title="" size="1" tabIndex="0" xd:xctname="DropDown" xd:CtrlId="CTRL482" xd:boundProp="value" xd:binding="my:TypeOfImage" style="WIDTH: 281px; FONT-FAMILY: Century Schoolbook">
																	<xsl:attribute name="value">
																		<xsl:value-of select="my:TypeOfImage"/>
																	</xsl:attribute>
																	<option>
																		<xsl:if test="my:TypeOfImage=&quot;&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>Select...</option>
																	<option value="Microscopic">
																		<xsl:if test="my:TypeOfImage=&quot;Microscopic&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>Microscopic</option>
																	<option value="Gross">
																		<xsl:if test="my:TypeOfImage=&quot;Gross&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>Gross</option>
																	<option value="Clinical">
																		<xsl:if test="my:TypeOfImage=&quot;Clinical&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>Clinical</option>
																	<option value="Diagram">
																		<xsl:if test="my:TypeOfImage=&quot;Diagram&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>Diagram</option>
																</select>
															</font>
														</div>
													</td>
												</tr>
												<tr style="MIN-HEIGHT: 27px">
													<td style="BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: medium none; PADDING-TOP: 1px; BORDER-BOTTOM: medium none">
														<div>
															<font face="Century Schoolbook" size="2">
																<strong>Magnification:</strong>
															</font>
														</div>
													</td>
													<td style="BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: medium none; PADDING-TOP: 1px; BORDER-BOTTOM: medium none">
														<div>
															<font face="Verdana" size="2"><select class="xdComboBox xdBehavior_Select" title="" size="1" tabIndex="0" xd:xctname="DropDown" xd:CtrlId="CTRL484" xd:boundProp="value" xd:binding="my:Magnification" style="WIDTH: 281px; FONT-FAMILY: Century Schoolbook">
																	<xsl:choose>
																		<xsl:when test="my:TypeOfImage != &quot;Microscopic&quot;">
																			<xsl:attribute name="disabled">true</xsl:attribute>
																		</xsl:when>
																	</xsl:choose>
																	<xsl:attribute name="value">
																		<xsl:value-of select="my:Magnification"/>
																	</xsl:attribute>
																	<option>
																		<xsl:if test="my:Magnification=&quot;&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>Select...</option>
																	<option value="2x">
																		<xsl:if test="my:Magnification=&quot;2x&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>2x</option>
																	<option value="4x">
																		<xsl:if test="my:Magnification=&quot;4x&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>4x</option>
																	<option value="10x">
																		<xsl:if test="my:Magnification=&quot;10x&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>10x</option>
																	<option value="20x">
																		<xsl:if test="my:Magnification=&quot;20x&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>20x</option>
																	<option value="40x">
																		<xsl:if test="my:Magnification=&quot;40x&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>40x</option>
																	<option value="100x">
																		<xsl:if test="my:Magnification=&quot;100x&quot;">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>100x</option>
																</select>
															</font>
														</div>
													</td>
												</tr>
												<tr style="MIN-HEIGHT: 28px">
													<td style="BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: medium none; PADDING-TOP: 1px; BORDER-BOTTOM: medium none">
														<div>
															<font face="Century Schoolbook" size="2">
																<strong>Stain:</strong>
															</font>
														</div>
													</td>
													<td style="BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: medium none; PADDING-TOP: 1px; BORDER-BOTTOM: medium none">
														<div align="justify"><select class="xdComboBox xdBehavior_Select" title="" size="1" tabIndex="0" xd:xctname="DropDown" xd:CtrlId="CTRL486" xd:boundProp="value" xd:binding="my:Stain" style="WIDTH: 281px; FONT-FAMILY: Century Schoolbook">
																<xsl:choose>
																	<xsl:when test="my:TypeOfImage != &quot;Microscopic&quot;">
																		<xsl:attribute name="disabled">true</xsl:attribute>
																	</xsl:when>
																</xsl:choose>
																<xsl:attribute name="value">
																	<xsl:value-of select="my:Stain"/>
																</xsl:attribute>
																<option>
																	<xsl:if test="my:Stain=&quot;&quot;">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>Select...</option>
																<option value="H&amp;E">
																	<xsl:if test="my:Stain=&quot;H&amp;E&quot;">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>H&amp;E</option>
																<option value="Immunostain">
																	<xsl:if test="my:Stain=&quot;Immunostain&quot;">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>Immunostain</option>
																<option value="Other special stain">
																	<xsl:if test="my:Stain=&quot;Other special stain&quot;">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>Other special stain</option>
															</select>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Immunohistochemistry" mode="_54">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL446" tabIndex="-1">
			<div>
				<a href="http://www.ipox.org/newfiles/index.cfm">
					<font face="Century Schoolbook" size="3">
						<strong>Immunohistochemical findings</strong>
					</font>
				</a>
			</div>
			<div><xsl:apply-templates select="my:Specimen.IC" mode="_55"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Specimen.IC" mode="_55">
		<div class="xdRepeatingSection xdRepeating" title="" style="MARGIN-BOTTOM: 6px; WIDTH: 703px; HEIGHT: 56px" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL447" tabIndex="-1">
			<div>
				<font face="Century Schoolbook"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL539" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #99ccff">
						<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
					</span>
				</font>
			</div>
			<div align="center"><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="RichText" xd:CtrlId="CTRL448" xd:binding="my:Text.IC" style="WIDTH: 688px; FONT-FAMILY: Century Schoolbook; HEIGHT: 24px">
					<xsl:copy-of select="my:Text.IC/node()"/>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Molecular" mode="_59">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 708px; HEIGHT: 81px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL468" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>Molecular findings</strong>
				</font>
			</div>
			<div><xsl:apply-templates select="my:Specimen.MO" mode="_63"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Specimen.MO" mode="_63">
		<div class="xdRepeatingSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 6.931in; PADDING-TOP: 0px; HEIGHT: 42px" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL488" tabIndex="-1">
			<div><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL540" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #99ccff">
					<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
				</span>
			</div>
			<div><span class="xdTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL489" xd:binding="my:Text.MO" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 7.222in; PADDING-TOP: 0px; HEIGHT: 18px">
					<xsl:value-of select="my:Text.MO"/>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:EM" mode="_61">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL469" tabIndex="-1">
			<div>
				<strong>
					<font face="Century Schoolbook" size="3">Electron microscopic findings</font>
				</strong>
			</div>
			<div><xsl:apply-templates select="my:Specimen.EM" mode="_65"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Specimen.EM" mode="_65">
		<div class="xdRepeatingSection xdRepeating" title="" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; MARGIN: auto; WIDTH: 700px; PADDING-TOP: 3px" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL491" tabIndex="-1">
			<div><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL541" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #99ccff">
					<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
				</span>
			</div>
			<div><span class="xdTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL492" xd:binding="my:Text.EM" style="WIDTH: 693px; HEIGHT: 20px">
					<xsl:value-of select="my:Text.EM"/>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Diagnosis" mode="_40">
		<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #ffcc99" align="left" xd:xctname="Section" xd:CtrlId="CTRL383" tabIndex="-1">
			<div>
				<font face="Century Schoolbook" size="3">
					<strong>Diagnosis</strong>
				</font>
			</div>
			<div>
				<table class="xdFormLayout xdLayout" style="TABLE-LAYOUT: fixed; WIDTH: 702px; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word; BORDER-BOTTOM-STYLE: none" border="1">
					<colgroup>
						<col style="WIDTH: 205px"></col>
						<col style="WIDTH: 151px"></col>
						<col style="WIDTH: 141px"></col>
						<col style="WIDTH: 205px"></col>
					</colgroup>
					<tbody vAlign="top">
						<tr style="MIN-HEIGHT: 23px">
							<td rowSpan="4" style="PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BORDER-RIGHT-STYLE: none">
								<div align="left"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:xctname="PlainText" xd:CtrlId="CTRL413" xd:binding="my:Checklist/my:DiagnosisHeader" xd:disableEditing="yes" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-WEIGHT: bold; FONT-SIZE: x-small; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; FONT-FAMILY: Century Schoolbook; WHITE-SPACE: nowrap; BACKGROUND-COLOR: #ffcc99; WORD-WRAP: normal">
										<xsl:value-of select="my:Checklist/my:DiagnosisHeader"/>
									</span>
									<font face="Century Schoolbook">,</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div align="left"><input class="xdBehavior_Boolean" title="" type="checkbox" value="on" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL414" xd:boundProp="xd:value" xd:binding="my:Checklist/my:TumorLocationGroup/my:RightUpperLobe" xd:onValue="true" xd:offValue="false" style="FONT-SIZE: x-small; FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:RightUpperLobe"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:TumorLocationGroup/my:RightUpperLobe=&quot;true&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook"> Right upper lobe</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div align="left"><input class="xdBehavior_Boolean" title="" type="checkbox" value="on" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL417" xd:boundProp="xd:value" xd:binding="my:Checklist/my:TumorLocationGroup/my:LeftUpperLobe" xd:onValue="true" xd:offValue="false" style="FONT-SIZE: x-small; FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:LeftUpperLobe"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:TumorLocationGroup/my:LeftUpperLobe=&quot;true&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook"> Left upper lobe</font>
								</div>
							</td>
							<td rowSpan="4" style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BORDER-LEFT-STYLE: none">
								<div align="center">
									<font face="Verdana">
										<font face="Century Schoolbook">, <font size="4">(<select class="xdComboBox xdBehavior_Select" title="" size="1" tabIndex="0" xd:xctname="DropDown" xd:CtrlId="CTRL628" xd:boundProp="value" xd:binding="my:Checklist/my:SpecimenType" style="WIDTH: 131px; FONT-FAMILY: Century Schoolbook">
													<xsl:attribute name="value">
														<xsl:value-of select="my:Checklist/my:SpecimenType"/>
													</xsl:attribute>
													<option>
														<xsl:if test="my:Checklist/my:SpecimenType=&quot;&quot;">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
													</option>
													<option value="Biopsy">
														<xsl:if test="my:Checklist/my:SpecimenType=&quot;Biopsy&quot;">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>Biopsy</option>
													<option value="Lobectomy">
														<xsl:if test="my:Checklist/my:SpecimenType=&quot;Lobectomy&quot;">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>Lobectomy</option>
													<option value="Pneumonectomy">
														<xsl:if test="my:Checklist/my:SpecimenType=&quot;Pneumonectomy&quot;">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>Pneumonectomy</option>
													<option value="Wedge resection">
														<xsl:if test="my:Checklist/my:SpecimenType=&quot;Wedge resection&quot;">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>Wedge resection</option>
												</select>
											</font>
										</font>
										<font face="Century Schoolbook" size="4">)</font>
									</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 23px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div align="left"><input class="xdBehavior_Boolean" title="" type="checkbox" value="on" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL415" xd:boundProp="xd:value" xd:binding="my:Checklist/my:TumorLocationGroup/my:RightMiddleLobe" xd:onValue="true" xd:offValue="false" style="FONT-SIZE: x-small; FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:RightMiddleLobe"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:TumorLocationGroup/my:RightMiddleLobe=&quot;true&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook"> Right middle lobe</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div align="left"><input class="xdBehavior_Boolean" title="" type="checkbox" value="on" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL418" xd:boundProp="xd:value" xd:binding="my:Checklist/my:TumorLocationGroup/my:Lingula" xd:onValue="true" xd:offValue="false" style="FONT-SIZE: x-small; FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:Lingula"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:TumorLocationGroup/my:Lingula=&quot;true&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook"> Lingula</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 23px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div align="left"><input class="xdBehavior_Boolean" title="" type="checkbox" value="on" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL416" xd:boundProp="xd:value" xd:binding="my:Checklist/my:TumorLocationGroup/my:RightLowerLobe" xd:onValue="true" xd:offValue="false" style="FONT-SIZE: x-small; FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:RightLowerLobe"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:TumorLocationGroup/my:RightLowerLobe=&quot;true&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook"> Right lower lobe</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<div align="left"><input class="xdBehavior_Boolean" title="" type="checkbox" value="on" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL419" xd:boundProp="xd:value" xd:binding="my:Checklist/my:TumorLocationGroup/my:LeftLowerLobe" xd:onValue="true" xd:offValue="false" style="FONT-SIZE: x-small; FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:LeftLowerLobe"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:TumorLocationGroup/my:LeftLowerLobe=&quot;true&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook"> Left lower lobe</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 42px">
							<td colSpan="2" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none">
								<div align="left">
									<font face="Century Schoolbook">Other </font><span class="xdTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL420" xd:binding="my:Checklist/my:TumorLocationGroup/my:Other" style="FONT-SIZE: x-small; WIDTH: 245px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px">
										<xsl:value-of select="my:Checklist/my:TumorLocationGroup/my:Other"/>
									</span>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div align="center">
				<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 705px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
					<colgroup>
						<col style="WIDTH: 176px"></col>
						<col style="WIDTH: 57px"></col>
						<col style="WIDTH: 1.24in"></col>
						<col style="WIDTH: 176px"></col>
						<col style="WIDTH: 177px"></col>
					</colgroup>
					<tbody vAlign="top">
						<tr style="MIN-HEIGHT: 27px">
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div>
									<font face="Century Schoolbook">
										<strong>Histologic type:</strong>
										<a href="http://www.vh.org/adult/provider/radiology/LungTumors/PathologicTypes/Text/PathologicTypes.html">
											<font face="Wingdings" color="#0000ff" size="4">Ü</font>
										</a>
									</font>
								</div>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div>
									<font face="Verdana">
										<select class="xdComboBox xdBehavior_Select" title="" style="WIDTH: 242px; FONT-FAMILY: Century Schoolbook" size="1" xd:xctname="DropDown" xd:CtrlId="CTRL494" xd:boundProp="value" xd:binding="my:Checklist/my:HistologicType" value="Specify..." tabIndex="0">
											<xsl:attribute name="value">
												<xsl:value-of select="my:Checklist/my:HistologicType"/>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="function-available('xdXDocument:GetDOM')">
													<option/>
													<xsl:variable name="val" select="my:Checklist/my:HistologicType"/>
													<xsl:if test="not(xdXDocument:GetDOM(&quot;TumorData&quot;)/FormData/Type/Item[@Label=$val] or $val='')">
														<option selected="selected">
															<xsl:attribute name="value">
																<xsl:value-of select="$val"/>
															</xsl:attribute>
															<xsl:value-of select="$val"/>
														</option>
													</xsl:if>
													<xsl:for-each select="xdXDocument:GetDOM(&quot;TumorData&quot;)/FormData/Type/Item">
														<option>
															<xsl:attribute name="value">
																<xsl:value-of select="@Label"/>
															</xsl:attribute>
															<xsl:if test="$val=@Label">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="@Label"/>
														</option>
													</xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<option>
														<xsl:value-of select="my:Checklist/my:HistologicType"/>
													</option>
												</xsl:otherwise>
											</xsl:choose>
										</select><span class="xdTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL498" xd:binding="my:Checklist/my:HistologicTypeAdd" style="WIDTH: 179px; HEIGHT: 20px">
											<xsl:value-of select="my:Checklist/my:HistologicTypeAdd"/>
										</span> </font>
									<font face="Century Schoolbook">(subtype)</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 25px">
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div>
									<font face="Century Schoolbook">
										<strong>Histologic grade:</strong>
										<a href="http://www.chestjournal.org/cgi/content/full/117/4_suppl_1/80S" xd:disableEditing="yes">
											<font face="Wingdings" color="#0000ff" size="4">Ü</font>
										</a>
									</font>
								</div>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div>
									<font face="Verdana">
										<select class="xdComboBox xdBehavior_Select" title="GradeDropDown" style="WIDTH: 241px; FONT-FAMILY: Century Schoolbook" size="1" xd:xctname="DropDown" xd:CtrlId="CTRL497" xd:boundProp="value" xd:binding="my:Checklist/my:Grade" value="1" tabIndex="0">
											<xsl:attribute name="value">
												<xsl:value-of select="my:Checklist/my:Grade"/>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="function-available('xdXDocument:GetDOM')">
													<option/>
													<xsl:variable name="val" select="my:Checklist/my:Grade"/>
													<xsl:if test="not(xdXDocument:GetDOM(&quot;TumorData&quot;)/FormData/Grade/Item[@Label=$val] or $val='')">
														<option selected="selected">
															<xsl:attribute name="value">
																<xsl:value-of select="$val"/>
															</xsl:attribute>
															<xsl:value-of select="$val"/>
														</option>
													</xsl:if>
													<xsl:for-each select="xdXDocument:GetDOM(&quot;TumorData&quot;)/FormData/Grade/Item">
														<option>
															<xsl:attribute name="value">
																<xsl:value-of select="@Label"/>
															</xsl:attribute>
															<xsl:if test="$val=@Label">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="@Label"/>
														</option>
													</xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<option>
														<xsl:value-of select="my:Checklist/my:Grade"/>
													</option>
												</xsl:otherwise>
											</xsl:choose>
										</select>
									</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 17px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook">
										<strong>Extent of invasion</strong>
										<a href="http://www.hc-sc.gc.ca/pphb-dgspsp/publicat/lung-poumon/lcg_b_e.html">
											<font face="Wingdings" color="#0000ff" size="4">Ü</font>
										</a>
										<strong>  <img style="WIDTH: 482px; HEIGHT: 10px" height="10" src="B9E2EA05.gif" width="600"/>
										</strong>
									</font>
									<font face="Century Schoolbook"></font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook" Extra="Extra">Maximum tumor diameter</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook" Extra="Extra"></font> </div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center"><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" contentEditable="true" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL496" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:auto;negativeOrder:1;&quot;" xd:binding="my:Checklist/my:Invasion/my:Diameter" style="WIDTH: 67px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px">
										<xsl:attribute name="xd:num">
											<xsl:value-of select="my:Checklist/my:Invasion/my:Diameter"/>
										</xsl:attribute>
										<xsl:choose>
											<xsl:when test="function-available('xdFormatting:formatString')">
												<xsl:value-of select="xdFormatting:formatString(my:Checklist/my:Invasion/my:Diameter,&quot;number&quot;,&quot;numDigits:auto;negativeOrder:1;&quot;)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="my:Checklist/my:Invasion/my:Diameter"/>
											</xsl:otherwise>
										</xsl:choose>
									</span>
									<font face="Century Schoolbook" Extra="Extra"> cm</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook" Extra="Extra"></font> </div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Mainstem bronchus involvement</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MainstemBronchusInvolvement)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL499" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Negative</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook" Extra="Extra"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MainstemBronchusInvolvement)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL500" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement" xd:onValue="Positive" style="WIDTH: 20px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px">
											<xsl:attribute name="xd:value">
												<xsl:value-of select="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement"/>
											</xsl:attribute>
											<xsl:if test="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement=&quot;Positive&quot;">
												<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
											</xsl:if>
										</input>&gt;2 cm from carina</font>
								</div>
								<font face="Century Schoolbook">
									<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:MainstemBronchusInvolvement)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL560" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement" xd:onValue="PositiveClose">
											<xsl:attribute name="xd:value">
												<xsl:value-of select="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement"/>
											</xsl:attribute>
											<xsl:if test="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement=&quot;PositiveClose&quot;">
												<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
											</xsl:if>
										</input>
										<font face="Century Schoolbook">≤2 cm from carina</font>
									</div>
								</font>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MainstemBronchusInvolvement)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL501" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MainstemBronchusInvolvement=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Visceral pleura invasion</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook">
										<div>
											<strong><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:VisceralPleuraInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL585" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:VisceralPleuraInvasion" xd:onValue="Negative" style="FONT-WEIGHT: normal">
													<xsl:attribute name="xd:value">
														<xsl:value-of select="my:Checklist/my:Invasion/my:VisceralPleuraInvasion"/>
													</xsl:attribute>
													<xsl:if test="my:Checklist/my:Invasion/my:VisceralPleuraInvasion=&quot;Negative&quot;">
														<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
													</xsl:if>
												</input>
											</strong>Negative</div>
									</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook">
										<strong><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:VisceralPleuraInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL586" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:VisceralPleuraInvasion" xd:onValue="Positive" style="FONT-WEIGHT: normal">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:Checklist/my:Invasion/my:VisceralPleuraInvasion"/>
												</xsl:attribute>
												<xsl:if test="my:Checklist/my:Invasion/my:VisceralPleuraInvasion=&quot;Positive&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>
										</strong>Positive</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook">
										<strong><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:VisceralPleuraInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL587" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:VisceralPleuraInvasion" xd:onValue="Indeterminate" style="FONT-WEIGHT: normal">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:Checklist/my:Invasion/my:VisceralPleuraInvasion"/>
												</xsl:attribute>
												<xsl:if test="my:Checklist/my:Invasion/my:VisceralPleuraInvasion=&quot;Indeterminate&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>
										</strong>Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Chest wall, diaphragm, or parietal pleura invasion</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:ChestWallInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL505" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:ChestWallInvasion" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:ChestWallInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:ChestWallInvasion=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Negative</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:ChestWallInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL506" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:ChestWallInvasion" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:ChestWallInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:ChestWallInvasion=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Positive</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:ChestWallInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL507" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:ChestWallInvasion" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:ChestWallInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:ChestWallInvasion=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Mediastinal structures invasion</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MediastinalInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL508" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MediastinalInvasion" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MediastinalInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MediastinalInvasion=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Negative</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MediastinalInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL509" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MediastinalInvasion" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MediastinalInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MediastinalInvasion=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Positive</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MediastinalInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL510" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MediastinalInvasion" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MediastinalInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MediastinalInvasion=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Multiple tumor nodules</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MultipleTumorNodules)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL511" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MultipleTumorNodules" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MultipleTumorNodules"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MultipleTumorNodules=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Negative</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MultipleTumorNodules)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL512" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MultipleTumorNodules" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MultipleTumorNodules"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MultipleTumorNodules=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Positive</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MultipleTumorNodules)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL513" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MultipleTumorNodules" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MultipleTumorNodules"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MultipleTumorNodules=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Panlobar atelectasis or obstructive pneumonitis</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:PanlobarAtelectasis)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL514" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:PanlobarAtelectasis" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:PanlobarAtelectasis"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:PanlobarAtelectasis=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Negative or focal</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook"><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:PanlobarAtelectasis)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL561" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:PanlobarAtelectasis" xd:onValue="Positive">
											<xsl:attribute name="xd:value">
												<xsl:value-of select="my:Checklist/my:Invasion/my:PanlobarAtelectasis"/>
											</xsl:attribute>
											<xsl:if test="my:Checklist/my:Invasion/my:PanlobarAtelectasis=&quot;Positive&quot;">
												<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
											</xsl:if>
										</input>(+) entire lobe</font>
								</div>
								<div align="center">
									<font face="Century Schoolbook"><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:PanlobarAtelectasis)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL562" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:PanlobarAtelectasis" xd:onValue="PositiveLung">
											<xsl:attribute name="xd:value">
												<xsl:value-of select="my:Checklist/my:Invasion/my:PanlobarAtelectasis"/>
											</xsl:attribute>
											<xsl:if test="my:Checklist/my:Invasion/my:PanlobarAtelectasis=&quot;PositiveLung&quot;">
												<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
											</xsl:if>
										</input>(+) entire lung</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:PanlobarAtelectasis)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL516" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:PanlobarAtelectasis" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:PanlobarAtelectasis"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:PanlobarAtelectasis=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<font face="Century Schoolbook" Extra="Extra">Malignant pleural effusion</font>
									</li>
								</ul>
							</td>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<div>
										<div><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Invasion/my:MalignantEffusion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL564" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MalignantEffusion" xd:onValue="Negative">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:Checklist/my:Invasion/my:MalignantEffusion"/>
												</xsl:attribute>
												<xsl:if test="my:Checklist/my:Invasion/my:MalignantEffusion=&quot;Negative&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>
											<font face="Century Schoolbook" Extra="Extra">Negative</font>
										</div>
									</div>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook"><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:MalignantEffusion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL565" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MalignantEffusion" xd:onValue="Positive">
											<xsl:attribute name="xd:value">
												<xsl:value-of select="my:Checklist/my:Invasion/my:MalignantEffusion"/>
											</xsl:attribute>
											<xsl:if test="my:Checklist/my:Invasion/my:MalignantEffusion=&quot;Positive&quot;">
												<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
											</xsl:if>
										</input>
										<font face="Century Schoolbook">Positive</font>
									</font>
								</div>
							</td>
							<td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #8ee68e; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" name="{generate-id(my:Checklist/my:Invasion/my:MalignantEffusion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL566" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Invasion/my:MalignantEffusion" xd:onValue="Indeterminate">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Invasion/my:MalignantEffusion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Invasion/my:MalignantEffusion=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook" Extra="Extra">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td colSpan="5" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffcc; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<div> </div>
								</div>
								<div align="center">
									<div>
										<div>
											<font face="Century Schoolbook">Pathologic extent of invasion (AJCC): <span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL578" xd:binding="substring(concat(substring(&quot;pT4&quot;, 1 div ((//my:MalignantEffusion = &quot;Positive&quot; or //my:MultipleTumorNodules = &quot;Positive&quot;) or //my:MediastinalInvasion = &quot;Positive&quot;)), substring(&quot;pT3&quot;, 1 div ((//my:ChestWallInvasion = &quot;Positive&quot; or //my:PanlobarAtelectasis = &quot;PositiveLung&quot;) or //my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;)), substring(&quot;pT2&quot;, 1 div (((//my:PanlobarAtelectasis = &quot;Positive&quot; or //my:MainstemBronchusInvolvement = &quot;Positive&quot;) or //my:VisceralPleuraInvasion = &quot;Positive&quot;) or //my:Diameter &gt; 3)), &quot;pT1&quot;), 1, 3)" xd:disableEditing="yes" style="FONT-WEIGHT: bold; WIDTH: 44px; HEIGHT: 20px; BACKGROUND-COLOR: #d3e5fa">
													<xsl:value-of select="substring(concat(substring(&quot;pT4&quot;, 1 div ((//my:MalignantEffusion = &quot;Positive&quot; or //my:MultipleTumorNodules = &quot;Positive&quot;) or //my:MediastinalInvasion = &quot;Positive&quot;)), substring(&quot;pT3&quot;, 1 div ((//my:ChestWallInvasion = &quot;Positive&quot; or //my:PanlobarAtelectasis = &quot;PositiveLung&quot;) or //my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;)), substring(&quot;pT2&quot;, 1 div (((//my:PanlobarAtelectasis = &quot;Positive&quot; or //my:MainstemBronchusInvolvement = &quot;Positive&quot;) or //my:VisceralPleuraInvasion = &quot;Positive&quot;) or //my:Diameter &gt; 3)), &quot;pT1&quot;), 1, 3)"/>
												</span>
											</font>
										</div>
									</div>
								</div>
								<div align="center">
									<div>
										<div> </div>
									</div>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 17px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee6e6; BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Century Schoolbook">
										<strong>Margin status<img style="WIDTH: 524px; HEIGHT: 10px" height="10" src="E717AF5B.gif" width="600"/>
										</strong>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffff; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook">Bronchial</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffff; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:BronchialMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL517" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:BronchialMargin" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:BronchialMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:BronchialMargin=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Negative          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:BronchialMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL518" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:BronchialMargin" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:BronchialMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:BronchialMargin=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Positive          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:BronchialMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL519" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:BronchialMargin" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:BronchialMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:BronchialMargin=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee6e6; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook">Vascular</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee6e6; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:VascularMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL520" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:VascularMargin" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:VascularMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:VascularMargin=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Negative          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:VascularMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL521" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:VascularMargin" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:VascularMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:VascularMargin=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Positive          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:VascularMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL522" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:VascularMargin" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:VascularMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:VascularMargin=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffff; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook">Parenchymal</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffff; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:ParenchymalMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL523" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:ParenchymalMargin" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:ParenchymalMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:ParenchymalMargin=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Negative          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:ParenchymalMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL524" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:ParenchymalMargin" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:ParenchymalMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:ParenchymalMargin=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Positive          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:ParenchymalMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL525" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:ParenchymalMargin" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:ParenchymalMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:ParenchymalMargin=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee6e6; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook">Pleural</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #8ee6e6; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:PleuralMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL526" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:PleuralMargin" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:PleuralMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:PleuralMargin=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Negative          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:PleuralMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL527" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:PleuralMargin" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:PleuralMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:PleuralMargin=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Positive          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:Margin/my:PleuralMargin)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL528" xd:boundProp="xd:value" xd:binding="my:Checklist/my:Margin/my:PleuralMargin" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:Margin/my:PleuralMargin"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:Margin/my:PleuralMargin=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffff; BORDER-BOTTOM-STYLE: none">
								<blockquote dir="ltr" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-RIGHT: 0px">
									<div align="left">
										<font face="Century Schoolbook">Closest margin</font>
									</div>
								</blockquote>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ccffff; BORDER-BOTTOM-STYLE: none">
								<div align="center"><span class="xdTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL529" xd:binding="my:Checklist/my:Margin/my:ClosestMargin">
										<xsl:attribute name="style">WIDTH: 208px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px;<xsl:choose>
												<xsl:when test="((my:Checklist/my:Margin/my:BronchialMargin != &quot;Negative&quot; or my:Checklist/my:Margin/my:VascularMargin != &quot;Negative&quot;) or my:Checklist/my:Margin/my:ParenchymalMargin != &quot;Negative&quot;) or my:Checklist/my:Margin/my:PleuralMargin != &quot;Negative&quot;">DISPLAY: none</xsl:when>
											</xsl:choose>
										</xsl:attribute>
										<xsl:value-of select="my:Checklist/my:Margin/my:ClosestMargin"/>
									</span>, <span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" contentEditable="true" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL530" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:auto;negativeOrder:1;&quot;" xd:binding="my:Checklist/my:Margin/my:MarginDistance">
										<xsl:attribute name="style">WIDTH: 50px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px;<xsl:choose>
												<xsl:when test="((my:Checklist/my:Margin/my:BronchialMargin != &quot;Negative&quot; or my:Checklist/my:Margin/my:VascularMargin != &quot;Negative&quot;) or my:Checklist/my:Margin/my:ParenchymalMargin != &quot;Negative&quot;) or my:Checklist/my:Margin/my:PleuralMargin != &quot;Negative&quot;">DISPLAY: none</xsl:when>
											</xsl:choose>
										</xsl:attribute>
										<xsl:attribute name="xd:num">
											<xsl:value-of select="my:Checklist/my:Margin/my:MarginDistance"/>
										</xsl:attribute>
										<xsl:choose>
											<xsl:when test="function-available('xdFormatting:formatString')">
												<xsl:value-of select="xdFormatting:formatString(my:Checklist/my:Margin/my:MarginDistance,&quot;number&quot;,&quot;numDigits:auto;negativeOrder:1;&quot;)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="my:Checklist/my:Margin/my:MarginDistance"/>
											</xsl:otherwise>
										</xsl:choose>
									</span>
									<font face="Century Schoolbook"> cm</font>
									<font face="Century Schoolbook"></font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f0a4a4; BORDER-BOTTOM-STYLE: none">
								<div align="left">
									<font face="Century Schoolbook">
										<strong>Other tumor-related findings<img style="WIDTH: 417px; HEIGHT: 10px" height="10" src="9AA8DD21.gif" width="600"/>
										</strong>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #fadada; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook">Venous (large-vessel) invasion<a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=PubMed&amp;list_uids=7564425&amp;dopt=Abstract">
													<font face="Wingdings" color="#0000ff" size="4">Ü</font>
												</a>
											</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #fadada; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:VenousInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL531" xd:boundProp="xd:value" xd:binding="my:Checklist/my:VenousInvasion" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:VenousInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:VenousInvasion=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Negative          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:VenousInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL532" xd:boundProp="xd:value" xd:binding="my:Checklist/my:VenousInvasion" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:VenousInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:VenousInvasion=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Positive          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:VenousInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL533" xd:boundProp="xd:value" xd:binding="my:Checklist/my:VenousInvasion" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:VenousInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:VenousInvasion=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f0a4a4; BORDER-BOTTOM-STYLE: none">
								<ul style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" type="disc">
									<li>
										<div align="left">
											<font face="Century Schoolbook">Lymphatic (small-vessel) invasion</font>
										</div>
									</li>
								</ul>
							</td>
							<td colSpan="3" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f0a4a4; BORDER-BOTTOM-STYLE: none">
								<div align="center"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:LymphaticInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL458" xd:boundProp="xd:value" xd:binding="my:Checklist/my:LymphaticInvasion" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:LymphaticInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:LymphaticInvasion=&quot;Negative&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Negative          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:LymphaticInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL459" xd:boundProp="xd:value" xd:binding="my:Checklist/my:LymphaticInvasion" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:LymphaticInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:LymphaticInvasion=&quot;Positive&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Positive          </font><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:LymphaticInvasion)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL460" xd:boundProp="xd:value" xd:binding="my:Checklist/my:LymphaticInvasion" xd:onValue="Indeterminate" style="FONT-FAMILY: Century Schoolbook">
										<xsl:attribute name="xd:value">
											<xsl:value-of select="my:Checklist/my:LymphaticInvasion"/>
										</xsl:attribute>
										<xsl:if test="my:Checklist/my:LymphaticInvasion=&quot;Indeterminate&quot;">
											<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
										</xsl:if>
									</input>
									<font face="Century Schoolbook">Indeterminate</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<div align="left">
									<font face="Century Schoolbook">
										<strong>Regional lymph nodes <img style="WIDTH: 479px; HEIGHT: 10px" height="10" src="1F433CD7.gif" width="600"/>
										</strong>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<blockquote dir="ltr" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-RIGHT: 0px">
									<div>
										<div>
											<div><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:RegionalLymphNodes/my:RLNStatus)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL454" xd:boundProp="xd:value" xd:binding="my:Checklist/my:RegionalLymphNodes/my:RLNStatus" xd:onValue="Negative" style="FONT-FAMILY: Century Schoolbook">
													<xsl:attribute name="xd:value">
														<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:RLNStatus"/>
													</xsl:attribute>
													<xsl:if test="my:Checklist/my:RegionalLymphNodes/my:RLNStatus=&quot;Negative&quot;">
														<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
													</xsl:if>
												</input>
												<font face="Century Schoolbook"> Negative for carcinoma, </font><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" contentEditable="true" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL455" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" xd:binding="my:Checklist/my:RegionalLymphNodes/my:NodesExamined">
													<xsl:attribute name="style">WIDTH: 49px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px;<xsl:choose>
															<xsl:when test="my:Checklist/my:RegionalLymphNodes/my:RLNStatus = &quot;Positive&quot;">COLOR: #ffffff</xsl:when>
														</xsl:choose>
													</xsl:attribute>
													<xsl:attribute name="xd:num">
														<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:NodesExamined"/>
													</xsl:attribute>
													<xsl:choose>
														<xsl:when test="function-available('xdFormatting:formatString')">
															<xsl:value-of select="xdFormatting:formatString(my:Checklist/my:RegionalLymphNodes/my:NodesExamined,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:NodesExamined"/>
														</xsl:otherwise>
													</xsl:choose>
												</span>
												<font face="Century Schoolbook"> lymph nodes examined.</font>
											</div>
										</div>
									</div>
								</blockquote>
							</td>
						</tr>
						<tr>
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<blockquote dir="ltr" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-RIGHT: 0px">
									<div>
										<div><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:RegionalLymphNodes/my:RLNStatus)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL453" xd:boundProp="xd:value" xd:binding="my:Checklist/my:RegionalLymphNodes/my:RLNStatus" xd:onValue="Positive" style="FONT-FAMILY: Century Schoolbook">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:RLNStatus"/>
												</xsl:attribute>
												<xsl:if test="my:Checklist/my:RegionalLymphNodes/my:RLNStatus=&quot;Positive&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>
											<font face="Century Schoolbook"> Metastatic carcinoma in </font><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" contentEditable="true" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL456" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" xd:binding="my:Checklist/my:RegionalLymphNodes/my:PositiveNodes" style="WIDTH: 0.5in; FONT-FAMILY: Century Schoolbook">
												<xsl:attribute name="xd:num">
													<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:PositiveNodes"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(my:Checklist/my:RegionalLymphNodes/my:PositiveNodes,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:PositiveNodes"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
											<font face="Century Schoolbook"> of </font><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" contentEditable="true" tabIndex="0" xd:xctname="PlainText" xd:CtrlId="CTRL457" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" xd:binding="my:Checklist/my:RegionalLymphNodes/my:NodesExamined">
												<xsl:attribute name="style">WIDTH: 0.5in; FONT-FAMILY: Century Schoolbook;<xsl:choose>
														<xsl:when test="my:Checklist/my:RegionalLymphNodes/my:RLNStatus = &quot;Negative&quot;">COLOR: #ffffff</xsl:when>
													</xsl:choose>
												</xsl:attribute>
												<xsl:attribute name="xd:num">
													<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:NodesExamined"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(my:Checklist/my:RegionalLymphNodes/my:NodesExamined,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:NodesExamined"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
											<font face="Century Schoolbook"> lymph nodes.</font>
										</div>
										<blockquote dir="ltr" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-RIGHT: 0px">
											<div align="left"><xsl:apply-templates select="my:Checklist/my:RegionalLymphNodes/my:LNLocation" mode="_66"/>
											</div>
											<div align="left">
												<font face="Century Schoolbook"></font> </div>
										</blockquote>
									</div>
								</blockquote>
							</td>
						</tr>
						<tr>
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none">
								<blockquote dir="ltr" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-RIGHT: 0px">
									<div>
										<div><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:RegionalLymphNodes/my:RLNStatus)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL452" xd:boundProp="xd:value" xd:binding="my:Checklist/my:RegionalLymphNodes/my:RLNStatus" xd:onValue="ReportedSeparately" style="FONT-FAMILY: Century Schoolbook">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:RLNStatus"/>
												</xsl:attribute>
												<xsl:if test="my:Checklist/my:RegionalLymphNodes/my:RLNStatus=&quot;ReportedSeparately&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>
											<font face="Century Schoolbook"> Lymph nodes reported separately.</font>
										</div>
									</div>
								</blockquote>
							</td>
						</tr>
						<tr>
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 3px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<blockquote dir="ltr" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-RIGHT: 0px">
									<div>
										<div><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:Checklist/my:RegionalLymphNodes/my:RLNStatus)}" tabIndex="0" xd:xctname="OptionButton" xd:CtrlId="CTRL451" xd:boundProp="xd:value" xd:binding="my:Checklist/my:RegionalLymphNodes/my:RLNStatus" xd:onValue="NotSubmitted" style="FONT-FAMILY: Century Schoolbook">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:Checklist/my:RegionalLymphNodes/my:RLNStatus"/>
												</xsl:attribute>
												<xsl:if test="my:Checklist/my:RegionalLymphNodes/my:RLNStatus=&quot;NotSubmitted&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>
											<font face="Century Schoolbook"> No lymph nodes submitted.</font>
										</div>
									</div>
								</blockquote>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 50px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<div align="center">
									<font face="Century Schoolbook">Pathologic node category (AJCC): </font><span class="xdExpressionBox xdDataBindingUI  " title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL572" xd:binding="substring(concat(substring(&quot;pN3&quot;, 1 div (//my:ScalClavLN = &quot;Positive&quot;)), substring(&quot;pN3&quot;, 1 div (//my:ContraLN = &quot;Positive&quot;)), substring(&quot;pN2&quot;, 1 div (//my:IpsiMediastinalLN = &quot;Positive&quot;)), substring(&quot;pN1&quot;, 1 div (//my:IpsiPulmonaryLN = &quot;Positive&quot;)), substring(&quot;pN?&quot;, 1 div (//my:RLNStatus = &quot;Positive&quot;)), &quot;pN0&quot;), 1, 3)" xd:disableEditing="yes" style="FONT-WEIGHT: bold; WIDTH: 48px; FONT-FAMILY: Century Schoolbook; HEIGHT: 20px; BACKGROUND-COLOR: #d3e5fa">
										<xsl:value-of select="substring(concat(substring(&quot;pN3&quot;, 1 div (//my:ScalClavLN = &quot;Positive&quot;)), substring(&quot;pN3&quot;, 1 div (//my:ContraLN = &quot;Positive&quot;)), substring(&quot;pN2&quot;, 1 div (//my:IpsiMediastinalLN = &quot;Positive&quot;)), substring(&quot;pN1&quot;, 1 div (//my:IpsiPulmonaryLN = &quot;Positive&quot;)), substring(&quot;pN?&quot;, 1 div (//my:RLNStatus = &quot;Positive&quot;)), &quot;pN0&quot;), 1, 3)"/>
									</span>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Century Schoolbook">
										<strong>Non-tumor related findings <img style="WIDTH: 432px; HEIGHT: 10px" height="10" src="6D61D3FD.gif" width="600"/>
										</strong>
									</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 4px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<div align="left">
									<span class="xdRepeating" title="" style="MARGIN-BOTTOM: 1px; WIDTH: 100%; BACKGROUND-COLOR: #ffffff" xd:xctname="BulletedList">
										<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: disc">
											<xsl:for-each select="my:Checklist/my:NontumorFindings">
												<li><span class="xdListItem" hideFocus="1" tabIndex="0" xd:xctname="ListItem_Plain" xd:CtrlId="CTRL590" xd:binding="." style="WIDTH: 100%">
														<xsl:value-of select="."/>
													</span>
												</li>
											</xsl:for-each>
										</ol>
									</span>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 19px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<div>
									<font face="Century Schoolbook">
										<strong>Note</strong>
									</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 20px">
							<td colSpan="5" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991; BORDER-BOTTOM-STYLE: none">
								<div>
									<div><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="0" xd:xctname="RichText" xd:CtrlId="CTRL551" xd:binding="my:Checklist/my:Note" style="WIDTH: 702px; HEIGHT: 50px">
											<xsl:copy-of select="my:Checklist/my:Note/node()"/>
										</span>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div><xsl:apply-templates select="my:Specimen.DX" mode="_56"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:LNLocation" mode="_66">
		<xsl:if test="not((parent::my:RegionalLymphNodes/my:RLNStatus != &quot;Positive&quot;))">
			<div class="xdSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 475px; PADDING-TOP: 0px; HEIGHT: 98px" align="left" xd:xctname="Section" xd:CtrlId="CTRL571" tabIndex="-1">
				<div>
					<font face="Century Schoolbook">Positive lymph node sites include:<a href="http://www.amershamhealth.com/medcyclopaedia/Volume%20V%201/LYMPH%20NODE%20CLASSIFICATION%20CHEST.asp">
							<font face="Wingdings" color="#0000ff" size="4">Ü</font>
						</a>
					</font>
				</div>
				<div> </div>
				<div><input class="xdBehavior_Boolean" title="" type="checkbox" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL573" xd:boundProp="xd:value" xd:binding="my:IpsiPulmonaryLN" xd:onValue="Positive" xd:offValue="Negative">
						<xsl:attribute name="xd:value">
							<xsl:value-of select="my:IpsiPulmonaryLN"/>
						</xsl:attribute>
						<xsl:if test="my:IpsiPulmonaryLN=&quot;Positive&quot;">
							<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
						</xsl:if>
					</input>
					<font face="Century Schoolbook">ipsilateral level 10-14 (hilar, (inter)lobar, and/or (sub)segmental) nodes</font>
				</div>
				<div><input class="xdBehavior_Boolean" title="" type="checkbox" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL581" xd:boundProp="xd:value" xd:binding="my:IpsiMediastinalLN" xd:onValue="Positive" xd:offValue="Negative">
						<xsl:attribute name="xd:value">
							<xsl:value-of select="my:IpsiMediastinalLN"/>
						</xsl:attribute>
						<xsl:if test="my:IpsiMediastinalLN=&quot;Positive&quot;">
							<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
						</xsl:if>
					</input>
					<font face="Century Schoolbook">ipsilateral </font>
					<font face="Century Schoolbook">level 1-9 (mediastinal) nodes</font>
				</div>
				<div><input class="xdBehavior_Boolean" title="" type="checkbox" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL575" xd:boundProp="xd:value" xd:binding="my:ContraLN" xd:onValue="Positive" xd:offValue="Negative">
						<xsl:attribute name="xd:value">
							<xsl:value-of select="my:ContraLN"/>
						</xsl:attribute>
						<xsl:if test="my:ContraLN=&quot;Positive&quot;">
							<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
						</xsl:if>
					</input>
					<font face="Century Schoolbook">contralateral nodes (any level)</font>
				</div>
				<div><input class="xdBehavior_Boolean" title="" type="checkbox" tabIndex="0" xd:xctname="CheckBox" xd:CtrlId="CTRL576" xd:boundProp="xd:value" xd:binding="my:ScalClavLN" xd:onValue="Positive" xd:offValue="Negative">
						<xsl:attribute name="xd:value">
							<xsl:value-of select="my:ScalClavLN"/>
						</xsl:attribute>
						<xsl:if test="my:ScalClavLN=&quot;Positive&quot;">
							<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
						</xsl:if>
					</input>
					<font face="Century Schoolbook">ipsilateral/contralateral scalene or supraclavicular nodes</font>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
	<xsl:template match="my:Specimen.DX" mode="_56">
		<div class="xdRepeatingSection xdRepeating" title="" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 6.493in; PADDING-TOP: 0px; HEIGHT: 62px" align="left" xd:xctname="RepeatingSection" xd:CtrlId="CTRL461" tabIndex="-1">
			<div><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:xctname="ExpressionBox" xd:CtrlId="CTRL542" xd:binding="concat(&quot;Specimen &quot;, position())" xd:disableEditing="yes" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #000000 1pt solid; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Century Schoolbook; BACKGROUND-COLOR: #99ccff">
					<xsl:value-of select="concat(&quot;Specimen &quot;, position())"/>
				</span>
				<span class="xdRepeating" title="" style="MARGIN-BOTTOM: 1px; WIDTH: 698px; HEIGHT: 16px; BACKGROUND-COLOR: #ffffff" xd:xctname="PlainList">
					<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: none">
						<xsl:for-each select="my:Paragraph.DX">
							<li><span class="xdListItem" hideFocus="1" tabIndex="0" xd:xctname="ListItem_Formatted" xd:CtrlId="CTRL543" xd:binding="." style="WIDTH: 100%">
									<xsl:copy-of select="./node()"/>
								</span>
							</li>
						</xsl:for-each>
					</ol>
				</span>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="my:Comments" mode="_57">
		<div class="xdSection xdRepeating" title="Enter your comments (as many as you want) here." style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 700px; BACKGROUND-COLOR: #d3e5fa" align="left" xd:xctname="Section" xd:CtrlId="CTRL462" tabIndex="-1">
			<div>
				<strong>
					<font face="Century Schoolbook" size="3">Comments</font>
				</strong>
			</div>
			<div>
				<span class="xdRepeating" title="" style="MARGIN-BOTTOM: 1px; WIDTH: 701px; HEIGHT: 16px; BACKGROUND-COLOR: #ffffff" xd:xctname="NumberedList">
					<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: decimal">
						<xsl:for-each select="my:Comment">
							<li><span class="xdListItem" hideFocus="1" tabIndex="0" xd:xctname="ListItem_Plain" xd:CtrlId="CTRL493" xd:binding="." style="WIDTH: 100%">
									<xsl:value-of select="."/>
								</span>
							</li>
						</xsl:for-each>
					</ol>
				</span>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
