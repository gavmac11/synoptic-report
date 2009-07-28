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
				<div align="right">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 708px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 365px"></col>
							<col style="WIDTH: 67px"></col>
							<col style="WIDTH: 276px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr style="MIN-HEIGHT: 25px">
								<td rowSpan="4" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-BOTTOM-STYLE: none">
									<div align="left">
										<font face="Book Antiqua" size="2">
											<img style="WIDTH: 282px; HEIGHT: 75px" height="366" src="812BAF19.jpg" width="1384"/>
										</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none">
									<div align="right">
										<font face="Book Antiqua" size="2">Patient:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:FamilyName" xd:CtrlId="CTRL4" xd:xctname="PlainText" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 143px; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Book Antiqua; WHITE-SPACE: nowrap; HEIGHT: 20px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:FamilyName"/>
											</span>
											<font face="Book Antiqua">,</font><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:GivenName" xd:CtrlId="CTRL3" xd:xctname="PlainText" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 114px; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Book Antiqua; WHITE-SPACE: nowrap; HEIGHT: 20px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:GivenName"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 26px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none">
									<div align="right">
										<font face="Book Antiqua" size="2">MRN:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:PatientIDExtension" xd:CtrlId="CTRL5" xd:xctname="PlainText" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 100%; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Book Antiqua; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:PatientIDExtension"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 26px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none">
									<div align="right">
										<font face="Book Antiqua" size="2">DOB:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2"><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:DOB" xd:CtrlId="CTRL13" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;date&quot;,&quot;dateFormat:Short Date;&quot;" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 100%; BORDER-BOTTOM: #c0c0c0 1pt solid; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
												<xsl:attribute name="xd:num">
													<xsl:value-of select="my:Header/my:DOB"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(my:Header/my:DOB,&quot;date&quot;,&quot;dateFormat:Short Date;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="my:Header/my:DOB"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 27px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-LEFT-STYLE: none">
									<div align="right">
										<font face="Book Antiqua" size="2">Sex:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:PatientSex" xd:CtrlId="CTRL1" xd:xctname="PlainText" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 100%; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Book Antiqua; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:PatientSex"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div align="right">
					<font face="Book Antiqua"></font> </div>
				<div align="right">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 704px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 342px"></col>
							<col style="WIDTH: 362px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr>
								<td>
									<div align="justify">
										<font face="3 of 9 Barcode" size="7">
											<font face="Book Antiqua" size="5">Accession # </font><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:DocIDRoot" xd:CtrlId="CTRL12" xd:xctname="PlainText" style="FONT-SIZE: large; WIDTH: 136px; FONT-FAMILY: Book Antiqua; WHITE-SPACE: nowrap; HEIGHT: 32px; BACKGROUND-COLOR: #e2dcc5; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:DocIDRoot"/>
											</span>
										</font>
									</div>
								</td>
								<td>
									<div align="right"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:DocIDRoot" xd:CtrlId="CTRL11" xd:xctname="PlainText" style="FONT-SIZE: x-large; WIDTH: 225px; FONT-FAMILY: 3 of 9 Barcode; WHITE-SPACE: nowrap; HEIGHT: 28px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Header/my:DocIDRoot"/>
										</span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div> </div>
				<div align="center">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 155px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 42px"></col>
							<col style="WIDTH: 113px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Book Antiqua">Date:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="7"><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:Date" xd:CtrlId="CTRL8" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;date&quot;,&quot;dateFormat:Short Date;&quot;" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; FONT-SIZE: x-small; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 100%; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Book Antiqua; WHITE-SPACE: nowrap; HEIGHT: 20px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
												<xsl:attribute name="xd:num">
													<xsl:value-of select="my:Header/my:Date"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(my:Header/my:Date,&quot;date&quot;,&quot;dateFormat:Short Date;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="my:Header/my:Date"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
										</font>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div> </div>
				<div align="center">
					<font face="Bookman Old Style" size="5">
						<strong>Surgical Pathology Report</strong>
					</font>
				</div>
				<div align="center">
					<font face="Bookman Old Style"></font> </div>
				<div align="left">
					<strong>
						<font face="Bookman Old Style">Clinical History</font>
					</strong>
				</div>
				<div align="left">     <span class="xdRepeating" title="" style="BORDER-RIGHT: #408ce8 1pt solid; BORDER-TOP: #408ce8 1pt solid; MARGIN-BOTTOM: 1px; BORDER-LEFT: #408ce8 1pt solid; WIDTH: 708px; BORDER-BOTTOM: #408ce8 1pt solid; FONT-FAMILY: Bookman Old Style; HEIGHT: 20px" xd:xctname="BulletedList">
						<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: disc">
							<xsl:for-each select="my:ClinicalHistory/my:Item">
								<li><span class="xdListItem" hideFocus="1" tabIndex="-1" xd:disableEditing="yes" xd:binding="." xd:CtrlId="CTRL14" xd:xctname="ListItem_Plain" style="WIDTH: 100%; WHITE-SPACE: normal; WORD-WRAP: break-word">
										<xsl:value-of select="."/>
									</span>
								</li>
							</xsl:for-each>
						</ol>
					</span>
				</div>
				<div align="left"> </div>
				<font face="Bookman Old Style"></font>
				<div>
					<font face="Bookman Old Style">
						<strong>Gross Examination</strong>
					</font>
				</div>
				<div align="center">
					<table class="xdRepeatingTable msoUcTable" title="" style="TABLE-LAYOUT: fixed; WIDTH: 707px; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word; BORDER-BOTTOM-STYLE: none" border="1" xd:CtrlId="CTRL15">
						<colgroup>
							<col style="WIDTH: 82px"></col>
							<col style="WIDTH: 625px"></col>
						</colgroup><tbody xd:xctname="RepeatingTable">
							<xsl:for-each select="my:Gross/my:Specimen.GD">
								<tr>
									<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
										<div align="center">
											<font face="Bookman Old Style">Specimen</font><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="@my:Caption" xd:CtrlId="CTRL16" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" style="WIDTH: 36px; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 20px; WORD-WRAP: normal">
												<xsl:attribute name="xd:num">
													<xsl:value-of select="@my:Caption"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(@my:Caption,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="@my:Caption"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
										</div>
									</td>
									<td><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Text.GD" xd:CtrlId="CTRL17" xd:xctname="RichText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: normal; HEIGHT: 50px; BACKGROUND-COLOR: transparent">
											<xsl:copy-of select="my:Text.GD/node()"/>
										</span>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>
				<div>
					<font face="Bookman Old Style"></font> </div>
				<div>
					<font face="Bookman Old Style">
						<strong>Microscopic Examination</strong>
					</font>
				</div>
				<div align="center">
					<table class="xdRepeatingTable msoUcTable" title="" style="TABLE-LAYOUT: fixed; WIDTH: 707px; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word; BORDER-BOTTOM-STYLE: none" border="1" xd:CtrlId="CTRL18">
						<colgroup>
							<col style="WIDTH: 79px"></col>
							<col style="WIDTH: 628px"></col>
						</colgroup><tbody xd:xctname="RepeatingTable">
							<xsl:for-each select="my:Microscopic/my:Specimen.MD">
								<tr>
									<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
										<div align="center">
											<font face="Bookman Old Style">Specimen</font><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" contentEditable="true" tabIndex="0" xd:binding="@my:Caption" xd:CtrlId="CTRL19" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" style="WIDTH: 28px; FONT-FAMILY: Bookman Old Style; HEIGHT: 20px">
												<xsl:attribute name="xd:num">
													<xsl:value-of select="@my:Caption"/>
												</xsl:attribute>
												<xsl:choose>
													<xsl:when test="function-available('xdFormatting:formatString')">
														<xsl:value-of select="xdFormatting:formatString(@my:Caption,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="@my:Caption"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
										</div>
									</td>
									<td><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Text.MD" xd:CtrlId="CTRL20" xd:xctname="RichText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: normal; HEIGHT: 50px; BACKGROUND-COLOR: transparent">
											<xsl:copy-of select="my:Text.MD/node()"/>
										</span>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>
				<div>
					<font face="Bookman Old Style"></font> </div>
				<div>
					<font face="Bookman Old Style">
						<strong>Diagnosis</strong>
					</font>
				</div>
				<div align="center"><xsl:apply-templates select="my:Diagnosis/my:Checklist" mode="_1"/>
				</div>
				<div> </div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="my:Checklist" mode="_1">
		<div class="xdSection xdRepeating" title="" style="BORDER-RIGHT: #408ce8 1pt solid; BORDER-TOP: #408ce8 1pt solid; MARGIN-BOTTOM: 6px; BORDER-LEFT: #408ce8 1pt solid; WIDTH: 706px; BORDER-BOTTOM: #408ce8 1pt solid; HEIGHT: 928px" align="left" xd:CtrlId="CTRL21" xd:xctname="Section" tabIndex="-1">
			<div align="center"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:DiagnosisHeader" xd:CtrlId="CTRL22" xd:xctname="PlainText" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 172px; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 20px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
					<xsl:value-of select="my:DiagnosisHeader"/>
				</span>
				<font face="Bookman Old Style">, </font><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:SpecimenType" xd:CtrlId="CTRL31" xd:xctname="PlainText" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 147px; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 22px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
					<xsl:value-of select="my:SpecimenType"/>
				</span>
				<font face="Bookman Old Style">, </font><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="local-name(/descendant-or-self::node()/*[local-name() = &quot;TumorLocationGroup&quot;]/*[text() = &quot;true&quot;])" xd:CtrlId="CTRL66" xd:xctname="ExpressionBox" style="BORDER-RIGHT: #c0c0c0 1pt solid; BORDER-TOP: #c0c0c0 1pt solid; FONT-WEIGHT: bold; BORDER-LEFT: #c0c0c0 1pt solid; WIDTH: 350px; BORDER-BOTTOM: #c0c0c0 1pt solid; FONT-FAMILY: Bookman Old Style; HEIGHT: 22px; BACKGROUND-COLOR: transparent">
					<xsl:value-of select="local-name(/descendant-or-self::node()/*[local-name() = &quot;TumorLocationGroup&quot;]/*[text() = &quot;true&quot;])"/>
				</span>
			</div>
			<div>
				<font face="Bookman Old Style"></font> </div>
			<div>
				<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 697px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
					<colgroup>
						<col style="WIDTH: 278px"></col>
						<col style="WIDTH: 419px"></col>
					</colgroup>
					<tbody vAlign="top">
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Histologic type</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:HistologicType" xd:CtrlId="CTRL32" xd:xctname="PlainText" style="WIDTH: 185px; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 22px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:HistologicType"/>
										</span><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:HistologicTypeAdd" xd:CtrlId="CTRL33" xd:xctname="PlainText" style="WIDTH: 225px; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 22px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:HistologicTypeAdd"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong/>
									</font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Histologic grade</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Grade" xd:CtrlId="CTRL34" xd:xctname="PlainText" style="WIDTH: 179px; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 22px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Grade"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Extent of invasion</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Diameter</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Invasion/my:Diameter" xd:CtrlId="CTRL36" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:auto;negativeOrder:1;&quot;" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:attribute name="xd:num">
												<xsl:value-of select="my:Invasion/my:Diameter"/>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="function-available('xdFormatting:formatString')">
													<xsl:value-of select="xdFormatting:formatString(my:Invasion/my:Diameter,&quot;number&quot;,&quot;numDigits:auto;negativeOrder:1;&quot;)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="my:Invasion/my:Diameter"/>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Visceral pleura</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Invasion/my:VisceralPleuraInvasion" xd:CtrlId="CTRL38" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Invasion/my:VisceralPleuraInvasion"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Mainstem bronchus</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:CtrlId="CTRL68" xd:xctname="ExpressionBox" style="WIDTH: 100%">
											<xsl:value-of select="my:Invasion/my:MainstemBronchusInvolvement"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Chest wall</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Invasion/my:ChestWallInvasion" xd:CtrlId="CTRL39" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Invasion/my:ChestWallInvasion"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Mediastinal structures</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Invasion/my:MediastinalInvasion" xd:CtrlId="CTRL40" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Invasion/my:MediastinalInvasion"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Obstructive pneumonitis/</font>
								</div>
								<div align="right">
									<font face="Bookman Old Style">atelectasis</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:CtrlId="CTRL67" xd:xctname="ExpressionBox" style="WIDTH: 100%">
											<xsl:value-of select="my:Invasion/my:PanlobarAtelectasis"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Malignant pleural effusion</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Invasion/my:MalignantEffusion" xd:CtrlId="CTRL45" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Invasion/my:MalignantEffusion"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Multiple nodules</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Invasion/my:MultipleTumorNodules" xd:CtrlId="CTRL41" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Invasion/my:MultipleTumorNodules"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Margin status</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Bronchial</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Margin/my:BronchialMargin" xd:CtrlId="CTRL47" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Margin/my:BronchialMargin"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Vascular</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Margin/my:VascularMargin" xd:CtrlId="CTRL48" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Margin/my:VascularMargin"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Parenchymal</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Margin/my:ParenchymalMargin" xd:CtrlId="CTRL49" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Margin/my:ParenchymalMargin"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 21px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Pleural</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Margin/my:PleuralMargin" xd:CtrlId="CTRL50" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Margin/my:PleuralMargin"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Closest</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Margin/my:ClosestMargin" xd:CtrlId="CTRL51" xd:xctname="PlainText" style="WIDTH: 161px; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 22px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:Margin/my:ClosestMargin"/>
										</span>, <span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Margin/my:MarginDistance" xd:CtrlId="CTRL52" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" style="WIDTH: 74px; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; HEIGHT: 22px; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:attribute name="xd:num">
												<xsl:value-of select="my:Margin/my:MarginDistance"/>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="function-available('xdFormatting:formatString')">
													<xsl:value-of select="xdFormatting:formatString(my:Margin/my:MarginDistance,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="my:Margin/my:MarginDistance"/>
												</xsl:otherwise>
											</xsl:choose>
										</span> cm</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Other tumor-related findings</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Venous invasion</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:VenousInvasion" xd:CtrlId="CTRL53" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:VenousInvasion"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Lymphatic invasion</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:LymphaticInvasion" xd:CtrlId="CTRL54" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:LymphaticInvasion"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Regional lymph node status</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:RegionalLymphNodes/my:RLNStatus" xd:CtrlId="CTRL56" xd:xctname="PlainText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:value-of select="my:RegionalLymphNodes/my:RLNStatus"/>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Positive nodes</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:RegionalLymphNodes/my:PositiveNodes" xd:CtrlId="CTRL58" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:attribute name="xd:num">
												<xsl:value-of select="my:RegionalLymphNodes/my:PositiveNodes"/>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="function-available('xdFormatting:formatString')">
													<xsl:value-of select="xdFormatting:formatString(my:RegionalLymphNodes/my:PositiveNodes,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="my:RegionalLymphNodes/my:PositiveNodes"/>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">Total number of nodes examined</font>
								</div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"><span class="xdTextBox xdBehavior_Formatting" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:RegionalLymphNodes/my:NodesExamined" xd:CtrlId="CTRL57" xd:xctname="PlainText" xd:boundProp="xd:num" xd:datafmt="&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: nowrap; BACKGROUND-COLOR: transparent; WORD-WRAP: normal">
											<xsl:attribute name="xd:num">
												<xsl:value-of select="my:RegionalLymphNodes/my:NodesExamined"/>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="function-available('xdFormatting:formatString')">
													<xsl:value-of select="xdFormatting:formatString(my:RegionalLymphNodes/my:NodesExamined,&quot;number&quot;,&quot;numDigits:0;negativeOrder:1;&quot;)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="my:RegionalLymphNodes/my:NodesExamined"/>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 41px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Non-tumor-related findings</strong>
									</font>
								</div>
							</td>
							<td>
								<div>
									<span class="xdRepeating" title="" style="MARGIN-BOTTOM: 1px; WIDTH: 100%; BACKGROUND-COLOR: transparent" xd:xctname="PlainList">
										<ol style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; LIST-STYLE-TYPE: none">
											<xsl:for-each select="my:NontumorFindings">
												<li><span class="xdListItem" hideFocus="1" tabIndex="-1" xd:disableEditing="yes" xd:binding="." xd:CtrlId="CTRL69" xd:xctname="ListItem_Plain" style="WIDTH: 100%; WHITE-SPACE: normal">
														<xsl:value-of select="."/>
													</span>
												</li>
											</xsl:for-each>
										</ol>
									</span>
								</div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 22px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style"></font> </div>
							</td>
							<td>
								<div>
									<font face="Bookman Old Style"></font> </div>
							</td>
						</tr>
						<tr style="MIN-HEIGHT: 22px">
							<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
								<div align="right">
									<font face="Bookman Old Style">
										<strong>Note</strong>
									</font>
								</div>
							</td>
							<td>
								<div><span class="xdRichTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Note" xd:CtrlId="CTRL65" xd:xctname="RichText" style="WIDTH: 100%; FONT-FAMILY: Bookman Old Style; WHITE-SPACE: normal; HEIGHT: 50px; BACKGROUND-COLOR: transparent">
										<xsl:copy-of select="my:Note/node()"/>
									</span>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
