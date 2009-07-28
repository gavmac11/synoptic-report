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
				<div align="center">
					<strong>
						<a href="http://www.naaccr.org/">
							<font size="5">Tumor Registry Coding Form</font>
						</a>
					</strong>
				</div>
				<div align="center">
					<strong>
						<font size="5">
							<em>Carcinoma of Lung</em>
						</font>
					</strong>
				</div>
				<div> </div>
				<div align="center">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 455px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 117px"></col>
							<col style="WIDTH: 338px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr style="MIN-HEIGHT: 19px">
								<td colSpan="2" style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-RIGHT-STYLE: none; BORDER-BOTTOM-STYLE: none">
									<div align="center">
										<font face="Verdana" size="3">
											<strong>PATIENT</strong>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2">Given Name:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-TOP-STYLE: none; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:GivenName" xd:xctname="PlainText" xd:CtrlId="CTRL3" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:GivenName"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2">Family Name:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Header/my:FamilyName" xd:xctname="PlainText" xd:CtrlId="CTRL4" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Header/my:FamilyName"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2">DOB:</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2">
											<div class="xdDTPicker" title="" style="WIDTH: 100%" noWrap="1" xd:xctname="DTPicker" xd:CtrlId="CTRL5"><span class="xdDTText xdBehavior_FormattingNoBUI" hideFocus="1" contentEditable="true" tabIndex="0" xd:binding="my:Header/my:DOB" xd:xctname="DTPicker_DTText" xd:datafmt="&quot;date&quot;,&quot;dateFormat:Short Date;&quot;" xd:boundProp="xd:num" xd:innerCtrl="_DTText">
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
												<button class="xdDTButton" xd:xctname="DTPicker_DTButton" xd:innerCtrl="_DTButton" tabIndex="-1">
													<img src="res://infopath.exe/calendar.gif" Linked="true"/>
												</button>
											</div>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2">Surgery</font>
									</div>
								</td>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div>
										<font face="Verdana" size="2">
											<div class="xdDTPicker" title="" style="WIDTH: 100%" noWrap="1" xd:xctname="DTPicker" xd:CtrlId="CTRL6"><span class="xdDTText xdBehavior_FormattingNoBUI" hideFocus="1" contentEditable="true" tabIndex="0" xd:binding="my:Header/my:Date" xd:xctname="DTPicker_DTText" xd:datafmt="&quot;date&quot;,&quot;dateFormat:Short Date;&quot;" xd:boundProp="xd:num" xd:innerCtrl="_DTText">
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
												<button class="xdDTButton" xd:xctname="DTPicker_DTButton" xd:innerCtrl="_DTButton" tabIndex="-1">
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
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 388px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 84px"></col>
							<col style="WIDTH: 92px"></col>
							<col style="WIDTH: 212px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr style="MIN-HEIGHT: 19px">
								<td colSpan="3" style="BORDER-RIGHT: #ff00ff 6pt solid; BORDER-TOP: #ff00ff 6pt solid; BORDER-LEFT: #ff00ff 6pt solid; BORDER-BOTTOM-STYLE: none">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcsstagetable.html">
											<font face="Verdana" size="4">
												<strong>Predicted stage classification</strong>
											</font>
										</a>
									</div>
								</td>
							</tr>
							<tr>
								<td style="BORDER-LEFT: #ff00ff 6pt solid; BORDER-TOP-STYLE: none; BORDER-BOTTOM: #ff00ff 6pt solid">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(concat(substring(&quot;pT4&quot;, 1 div ((//my:MalignantEffusion = &quot;Positive&quot; or //my:MultipleTumorNodules = &quot;Positive&quot;) or //my:MediastinalInvasion = &quot;Positive&quot;)), substring(&quot;pT3&quot;, 1 div ((//my:ChestWallInvasion = &quot;Positive&quot; or //my:PanlobarAtelectasis = &quot;PositiveLung&quot;) or //my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;)), substring(&quot;pT2&quot;, 1 div (((//my:PanlobarAtelectasis = &quot;Positive&quot; or //my:MainstemBronchusInvolvement = &quot;Positive&quot;) or //my:VisceralPleuraInvasion = &quot;Positive&quot;) or //my:Diameter &gt; 3)), &quot;pT1&quot;), 1, 3)" xd:xctname="ExpressionBox" xd:CtrlId="CTRL578" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; FONT-SIZE: medium; BORDER-LEFT: #000000 1pt solid; WIDTH: 73px; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Verdana; HEIGHT: 26px; BACKGROUND-COLOR: #d3e5fa">
												<xsl:value-of select="substring(concat(substring(&quot;pT4&quot;, 1 div ((//my:MalignantEffusion = &quot;Positive&quot; or //my:MultipleTumorNodules = &quot;Positive&quot;) or //my:MediastinalInvasion = &quot;Positive&quot;)), substring(&quot;pT3&quot;, 1 div ((//my:ChestWallInvasion = &quot;Positive&quot; or //my:PanlobarAtelectasis = &quot;PositiveLung&quot;) or //my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;)), substring(&quot;pT2&quot;, 1 div (((//my:PanlobarAtelectasis = &quot;Positive&quot; or //my:MainstemBronchusInvolvement = &quot;Positive&quot;) or //my:VisceralPleuraInvasion = &quot;Positive&quot;) or //my:Diameter &gt; 3)), &quot;pT1&quot;), 1, 3)"/>
											</span>
										</div>
									</font>
								</td>
								<td style="BORDER-TOP-STYLE: none; BORDER-BOTTOM: #ff00ff 6pt solid">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI  " title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(concat(substring(&quot;pN3&quot;, 1 div (//my:ScalClavLN = &quot;Positive&quot;)), substring(&quot;pN3&quot;, 1 div (//my:ContraLN = &quot;Positive&quot;)), substring(&quot;pN2&quot;, 1 div (//my:IpsiMediastinalLN = &quot;Positive&quot;)), substring(&quot;pN1&quot;, 1 div (//my:IpsiPulmonaryLN = &quot;Positive&quot;)), substring(&quot;pN?&quot;, 1 div (//my:RLNStatus = &quot;Positive&quot;)), &quot;pN0&quot;), 1, 3)" xd:xctname="ExpressionBox" xd:CtrlId="CTRL572" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; FONT-SIZE: medium; BORDER-LEFT: #000000 1pt solid; WIDTH: 70px; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Verdana; HEIGHT: 26px; BACKGROUND-COLOR: #d3e5fa">
												<xsl:value-of select="substring(concat(substring(&quot;pN3&quot;, 1 div (//my:ScalClavLN = &quot;Positive&quot;)), substring(&quot;pN3&quot;, 1 div (//my:ContraLN = &quot;Positive&quot;)), substring(&quot;pN2&quot;, 1 div (//my:IpsiMediastinalLN = &quot;Positive&quot;)), substring(&quot;pN1&quot;, 1 div (//my:IpsiPulmonaryLN = &quot;Positive&quot;)), substring(&quot;pN?&quot;, 1 div (//my:RLNStatus = &quot;Positive&quot;)), &quot;pN0&quot;), 1, 3)"/>
											</span>
										</div>
									</font>
								</td>
								<td style="BORDER-RIGHT: #ff00ff 6pt solid; BORDER-TOP-STYLE: none; BORDER-BOTTOM: #ff00ff 6pt solid">
									<div align="center"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:pM" xd:xctname="PlainText" xd:CtrlId="CTRL10" style="BORDER-RIGHT: #000000 1pt solid; BORDER-TOP: #000000 1pt solid; FONT-WEIGHT: bold; FONT-SIZE: medium; BORDER-LEFT: #000000 1pt solid; WIDTH: 202px; BORDER-BOTTOM: #000000 1pt solid; FONT-FAMILY: Verdana; WHITE-SPACE: nowrap; HEIGHT: 26px; BACKGROUND-COLOR: #d3e5fa; WORD-WRAP: normal">
											<xsl:value-of select="my:pM"/>
										</span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div align="center"> </div>
				<div align="center">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 407px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 271px"></col>
							<col style="WIDTH: 136px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr>
								<td rowSpan="2" style="PADDING-RIGHT: 1px; BORDER-TOP: #333399 6pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #333399 6pt solid; BORDER-RIGHT-STYLE: none; BACKGROUND-COLOR: #ffd991">
									<div align="center">
										<font face="Verdana" size="2">
											<em>Presurgical systemic treatment or radiation?</em>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; BORDER-TOP: #333399 6pt solid; BORDER-BOTTOM: #333399 6pt; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991">
									<div align="center">
										<font face="Verdana" size="2"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:PresurgicalRx)}" tabIndex="0" xd:binding="my:PresurgicalRx" xd:xctname="OptionButton" xd:CtrlId="CTRL37" xd:boundProp="xd:value" xd:onValue="0">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:PresurgicalRx"/>
												</xsl:attribute>
												<xsl:if test="my:PresurgicalRx=&quot;0&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>No/<br/>Unknown</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 24px">
								<td style="BORDER-RIGHT: #333399 6pt solid; BORDER-TOP: #333399 6pt; BORDER-BOTTOM: #333399 6pt solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #ffd991">
									<div align="center">
										<font face="Verdana" size="2"><input class="xdBehavior_Boolean" title="" type="radio" value="on" name="{generate-id(my:PresurgicalRx)}" tabIndex="0" xd:binding="my:PresurgicalRx" xd:xctname="OptionButton" xd:CtrlId="CTRL38" xd:boundProp="xd:value" xd:onValue="1">
												<xsl:attribute name="xd:value">
													<xsl:value-of select="my:PresurgicalRx"/>
												</xsl:attribute>
												<xsl:if test="my:PresurgicalRx=&quot;1&quot;">
													<xsl:attribute name="CHECKED">CHECKED</xsl:attribute>
												</xsl:if>
											</input>Yes</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #333399 6pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #d3e5fa">
									<div align="center">
										<font face="Verdana">
											<strong>
												<a href="http://web.facs.org/cstage/lung/Lungschema.htm">
													<font size="4">Collaborative Staging </font>
												</a>
												<br/>
												<font size="4">Data Item</font>
											</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #333399 6pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #d3e5fa">
									<div align="center">
										<font face="Verdana" size="4">
											<strong>Candidate value</strong>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcstumorsizetable.html">
											<font face="Verdana" size="2">
												<strong>CS Tumor Size</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(round(xdMath:Nz(my:Diagnosis/my:Checklist/my:Invasion/my:Diameter) * 10), 1 div xdMath:Nz(my:Diagnosis/my:Checklist/my:Invasion/my:Diameter))" xd:xctname="ExpressionBox" xd:CtrlId="CTRL33" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:if test="function-available('xdXDocument:GetDOM')">
													<xsl:value-of select="substring(round(xdMath:Nz(my:Diagnosis/my:Checklist/my:Invasion/my:Diameter) * 10), 1 div xdMath:Nz(my:Diagnosis/my:Checklist/my:Invasion/my:Diameter))"/>
												</xsl:if>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcsextensiontable.html">
											<font face="Verdana" size="2">
												<strong>CS Extension</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(concat(substring(&quot;61 or 70-77 or 80&quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MediastinalInvasion = &quot;Positive&quot;)), substring(&quot;72               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MalignantEffusion = &quot;Positive&quot;)), substring(&quot;65               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MultipleTumorNodules = &quot;Positive&quot;)), substring(&quot;56 or 59 or 60   &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:ChestWallInvasion = &quot;Positive&quot;)), substring(&quot;55               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis = &quot;PositiveLung&quot;)), substring(&quot;53               &quot;, 1 div ((my:Diagnosis/my:Checklist/my:Invasion/my:VisceralPleuraInvasion = &quot;Positive&quot;) and (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;))), substring(&quot;52               &quot;, 1 div ((my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis = &quot;Positive&quot;) and (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;))), substring(&quot;50               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;)), substring(&quot;45               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:VisceralPleuraInvasion = &quot;Positive&quot;)), substring(&quot;40               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis = &quot;Positive&quot;)), substring(&quot;21               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;Positive&quot;)), substring(&quot;20               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:Diameter &gt; 3)), &quot;11&quot;), 1, 17)" xd:xctname="ExpressionBox" xd:CtrlId="CTRL34" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:value-of select="substring(concat(substring(&quot;61 or 70-77 or 80&quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MediastinalInvasion = &quot;Positive&quot;)), substring(&quot;72               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MalignantEffusion = &quot;Positive&quot;)), substring(&quot;65               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MultipleTumorNodules = &quot;Positive&quot;)), substring(&quot;56 or 59 or 60   &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:ChestWallInvasion = &quot;Positive&quot;)), substring(&quot;55               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis = &quot;PositiveLung&quot;)), substring(&quot;53               &quot;, 1 div ((my:Diagnosis/my:Checklist/my:Invasion/my:VisceralPleuraInvasion = &quot;Positive&quot;) and (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;))), substring(&quot;52               &quot;, 1 div ((my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis = &quot;Positive&quot;) and (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;))), substring(&quot;50               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;PositiveClose&quot;)), substring(&quot;45               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:VisceralPleuraInvasion = &quot;Positive&quot;)), substring(&quot;40               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis = &quot;Positive&quot;)), substring(&quot;21               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement = &quot;Positive&quot;)), substring(&quot;20               &quot;, 1 div (my:Diagnosis/my:Checklist/my:Invasion/my:Diameter &gt; 3)), &quot;11&quot;), 1, 17)"/>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcstsextevaltable.html">
											<font face="Verdana" size="2">
												<strong>CS TS/Ext-Eval</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="3 + xdMath:Nz(my:PresurgicalRx) * 3" xd:xctname="ExpressionBox" xd:CtrlId="CTRL39" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:if test="function-available('xdXDocument:GetDOM')">
													<xsl:value-of select="3 + xdMath:Nz(my:PresurgicalRx) * 3"/>
												</xsl:if>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 27px">
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcslymphnodetable.html">
											<font face="Verdana" size="2">
												<strong>CS Lymph Nodes</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(concat(substring(&quot;60&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:ScalClavLN = &quot;Positive&quot;)), substring(&quot;60&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:ContraLN = &quot;Positive&quot;)), substring(&quot;20&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:IpsiMediastinalLN = &quot;Positive&quot;)), substring(&quot;10&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:IpsiPulmonaryLN = &quot;Positive&quot;)), substring(&quot;50&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:RLNStatus = &quot;Positive&quot;)), substring(&quot;00&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined != 0)), &quot;99&quot;), 1, 2)" xd:xctname="ExpressionBox" xd:CtrlId="CTRL40" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:value-of select="substring(concat(substring(&quot;60&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:ScalClavLN = &quot;Positive&quot;)), substring(&quot;60&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:ContraLN = &quot;Positive&quot;)), substring(&quot;20&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:IpsiMediastinalLN = &quot;Positive&quot;)), substring(&quot;10&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:LNLocation/my:IpsiPulmonaryLN = &quot;Positive&quot;)), substring(&quot;50&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:RLNStatus = &quot;Positive&quot;)), substring(&quot;00&quot;, 1 div (my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined != 0)), &quot;99&quot;), 1, 2)"/>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcsregnodesevaltable.html">
											<font face="Verdana" size="2">
												<strong>CS Reg Nodes Eval</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined &gt; 0) * (3 + xdMath:Nz(my:PresurgicalRx) * 3)" xd:xctname="ExpressionBox" xd:CtrlId="CTRL41" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:if test="function-available('xdXDocument:GetDOM')">
													<xsl:value-of select="(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined &gt; 0) * (3 + xdMath:Nz(my:PresurgicalRx) * 3)"/>
												</xsl:if>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 27px">
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungreglnpostable.html">
											<font face="Verdana" size="2">
												<strong>Reg LN Pos</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:PositiveNodes, 1 div xdMath:Nz(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:PositiveNodes))" xd:xctname="ExpressionBox" xd:CtrlId="CTRL35" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:if test="function-available('xdXDocument:GetDOM')">
													<xsl:value-of select="substring(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:PositiveNodes, 1 div xdMath:Nz(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:PositiveNodes))"/>
												</xsl:if>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungreglnexamtable.html">
											<font face="Verdana" size="2">
												<strong>Reg LN Exam</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="substring(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined, 1 div xdMath:Nz(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined))" xd:xctname="ExpressionBox" xd:CtrlId="CTRL36" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:if test="function-available('xdXDocument:GetDOM')">
													<xsl:value-of select="substring(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined, 1 div xdMath:Nz(my:Diagnosis/my:Checklist/my:RegionalLymphNodes/my:NodesExamined))"/>
												</xsl:if>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcsmetsatdxtable.html">
											<font face="Verdana" size="2">
												<strong>CS Mets at DX</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="&quot;99&quot;" xd:xctname="ExpressionBox" xd:CtrlId="CTRL42" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:value-of select="&quot;99&quot;"/>
											</span>
										</div>
									</font>
								</td>
							</tr>
							<tr>
								<td style="BORDER-RIGHT: #000000 1pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #333399 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #333399 6pt solid; BACKGROUND-COLOR: #ccffff">
									<div align="center">
										<a href="http://web.facs.org/cstage/lung/Lungcsmetsevaltable.html">
											<font face="Verdana" size="2">
												<strong>CS Mets Eval</strong>
											</font>
										</a>
									</div>
								</td>
								<td style="BORDER-RIGHT: #333399 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #000000 1pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #000000 1pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #333399 6pt solid; BACKGROUND-COLOR: #ccffff">
									<font face="Verdana" size="2">
										<div align="center"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="&quot;9&quot;" xd:xctname="ExpressionBox" xd:CtrlId="CTRL43" style="FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: 60pt; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #ffffff">
												<xsl:value-of select="&quot;9&quot;"/>
											</span>
										</div>
									</font>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div> </div>
				<div align="center">
					<table class="xdLayout" style="BORDER-RIGHT: medium none; TABLE-LAYOUT: fixed; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 441px; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; WORD-WRAP: break-word" borderColor="buttontext" border="1">
						<colgroup>
							<col style="WIDTH: 208px"></col>
							<col style="WIDTH: 233px"></col>
						</colgroup>
						<tbody vAlign="top">
							<tr>
								<td style="PADDING-RIGHT: 1px; BORDER-TOP: #3366ff 6pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Site</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; BORDER-TOP: #3366ff 6pt solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="local-name(/descendant-or-self::node()/*[local-name() = &quot;TumorLocationGroup&quot;]/*[text() = &quot;true&quot;])" xd:xctname="ExpressionBox" xd:CtrlId="CTRL8" style="WIDTH: 321px; HEIGHT: 20px; BACKGROUND-COLOR: #ffffff">
											<xsl:value-of select="local-name(/descendant-or-self::node()/*[local-name() = &quot;TumorLocationGroup&quot;]/*[text() = &quot;true&quot;])"/>
										</span>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 25px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Tumor type</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left"><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="/descendant-or-self::node()/*[local-name() = &quot;HistologicType&quot;]" xd:xctname="ExpressionBox" xd:CtrlId="CTRL9" style="WIDTH: 322px; HEIGHT: 20px; BACKGROUND-COLOR: #ffffff">
											<xsl:value-of select="/descendant-or-self::node()/*[local-name() = &quot;HistologicType&quot;]"/>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Size</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div><span class="xdExpressionBox xdDataBindingUI" title="" tabIndex="-1" xd:disableEditing="yes" xd:xctname="ExpressionBox" xd:CtrlId="CTRL11" style="WIDTH: 322px; HEIGHT: 20px; BACKGROUND-COLOR: #ffffff">
											<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:Diameter"/>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Grade</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Grade" xd:xctname="PlainText" xd:CtrlId="CTRL12" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Grade"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 19px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Visceral pleura</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:VisceralPleuraInvasion" xd:xctname="PlainText" xd:CtrlId="CTRL13" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:VisceralPleuraInvasion"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 27px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Chest wall</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:ChestWallInvasion" xd:xctname="PlainText" xd:CtrlId="CTRL21" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:ChestWallInvasion"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Mediastinum</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:MediastinalInvasion" xd:xctname="PlainText" xd:CtrlId="CTRL14" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:MediastinalInvasion"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr style="MIN-HEIGHT: 36px">
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Mainstem bronchus ≥2 cm from carina</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement" xd:xctname="PlainText" xd:CtrlId="CTRL15" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:MainstemBronchusInvolvement"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Mainstem bronchus &lt;2 cm from carina</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:MainstemCloseCarina" xd:xctname="PlainText" xd:CtrlId="CTRL16" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:MainstemCloseCarina"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Multiple tumor nodules</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:MultipleTumorNodules" xd:xctname="PlainText" xd:CtrlId="CTRL17" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:MultipleTumorNodules"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Panlobar atelectasis</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis" xd:xctname="PlainText" xd:CtrlId="CTRL18" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:PanlobarAtelectasis"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Pan-lung atelectasis</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:PanLungAtelectasis" xd:xctname="PlainText" xd:CtrlId="CTRL19" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:PanLungAtelectasis"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; BORDER-LEFT: #3366ff 6pt solid; PADDING-TOP: 1px; BORDER-BOTTOM: #3366ff 6pt solid; BACKGROUND-COLOR: #d3e5fa">
									<div align="right">
										<font size="2">
											<strong>Malignant effusion</strong>
										</font>
									</div>
								</td>
								<td style="BORDER-RIGHT: #3366ff 6pt solid; PADDING-RIGHT: 1px; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; VERTICAL-ALIGN: middle; PADDING-TOP: 1px; BORDER-BOTTOM: #3366ff 6pt solid">
									<div align="left">
										<font size="2"><span class="xdTextBox" hideFocus="1" title="" tabIndex="-1" xd:disableEditing="yes" xd:binding="my:Diagnosis/my:Checklist/my:Invasion/my:MalignantEffusion" xd:xctname="PlainText" xd:CtrlId="CTRL20" style="WIDTH: 100%; WHITE-SPACE: nowrap; WORD-WRAP: normal">
												<xsl:value-of select="my:Diagnosis/my:Checklist/my:Invasion/my:MalignantEffusion"/>
											</span>
										</font>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div> </div>
				<div> </div>
				<div> </div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
