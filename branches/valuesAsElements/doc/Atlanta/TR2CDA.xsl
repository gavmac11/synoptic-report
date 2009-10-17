<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:data="Data lookup"
	xmlns:my="http://schemas.microsoft.com/office/infopath/2003/myXSD/2003-04-21T17:37:34"
	xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:variable name="Sections"
		select="my:ClinicalHistory|my:Gross|my:CPT|my:Intraoperative|my:Microscopic|my:Immunohistochemistry|my:EM|my:Diagnosis|my:Comments|*[starts-with(local-name(), 'Specimen')]"/>
	<xsl:template match="/">
		<xsl:variable name="R" select="/my:PathologyReport"/>
		<xsl:variable name="H" select="/my:PathologyReport/my:Header"/>
		<ClinicalDocument>
			<id>
				<xsl:attribute name="extension"
					>SurgicalPathologyReport</xsl:attribute>
				<xsl:attribute name="root">123.456.789</xsl:attribute>
			</id>
			<code>
				<xsl:attribute name="code">22034-3</xsl:attribute>
				<xsl:attribute name="codeSystem"
					>2.16.840.1.113883.6.1</xsl:attribute>
				<xsl:attribute name="displayName">Pathology report
					total</xsl:attribute>
				<xsl:attribute name="codeSystemName">LOINC</xsl:attribute>
			</code>
			<title>Surgical Pathology Report</title>
			<xsl:variable name="ETime"
				select="translate($H/my:EffectiveTime,'-:T','')"/>
			<effectiveTime>
				<xsl:attribute name="value">
					<xsl:value-of select="$ETime"/>
				</xsl:attribute>
			</effectiveTime>
			<author>
				<time>
					<xsl:attribute name="value">
						<xsl:value-of select="$ETime"/>
					</xsl:attribute>
				</time>
				<assignedAuthor>
					<id>
						<xsl:attribute name="extension">
							<xsl:value-of select="$H/my:PathologistIDExtension"
							/>
						</xsl:attribute>
						<xsl:attribute name="root">
							<xsl:value-of select="$H/my:PathologistIDRoot"/>
						</xsl:attribute>
					</id>
					<assignedAuthorChoice>
						<Person>
							<name>
								<given>
									<xsl:value-of
										select="$H/my:PathologistGivenName"/>
								</given>
								<family>
									<xsl:value-of
										select="$H/my:PathologistFamilyName"/>
								</family>
								<suffix>
									<xsl:value-of
										select="$H/my:PathologistSuffix"/>
								</suffix>
							</name>
						</Person>
					</assignedAuthorChoice>
				</assignedAuthor>
			</author>
			<custodian>
				<assignedCustodian>
					<representedOrganization>
						<id>
							<xsl:attribute name="extension">
								<xsl:value-of select="$H/my:RepOrgExtension"/>
							</xsl:attribute>
							<xsl:attribute name="root">
								<xsl:value-of select="$H/my:PathologistIDRoot"/>
							</xsl:attribute>
						</id>
						<name>Duke University Medical Center</name>
					</representedOrganization>
				</assignedCustodian>
			</custodian>
			<recordTarget>
				<patientRole>
					<id>
						<xsl:attribute name="extension">
							<xsl:value-of select="$H/my:PatientIDExtension"/>
						</xsl:attribute>
						<xsl:attribute name="root">
							<xsl:value-of select="$H/my:PatientIDRoot"/>
						</xsl:attribute>
					</id>
					<patientPatient>
						<name>
							<given>
								<xsl:value-of select="$H/my:GivenName"/>
							</given>
							<family>
								<xsl:value-of select="$H/my:FamilyName"/>
							</family>
						</name>
						<administrativeGenderCode>
							<xsl:attribute name="code">
								<xsl:choose>
									<xsl:when test="$H/my:PatientSex='Male'"
										>248153007</xsl:when>
									<xsl:when test="$H/my:PatientSex='Female'"
										>248152002</xsl:when>
									<xsl:otherwise>394743007</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:attribute name="codeSystem"
								>2.16.840.1.113883.6.96</xsl:attribute>
						</administrativeGenderCode>
						<birthTime>
							<xsl:attribute name="value">
								<xsl:value-of
									select="translate($H/my:DOB,'-:T','')"/>
							</xsl:attribute>
						</birthTime>
					</patientPatient>
				</patientRole>
			</recordTarget>
			<component>
				<bodyChoice>
					<StructuredBody>
						<xsl:apply-templates/>
					</StructuredBody>
				</bodyChoice>
			</component>
		</ClinicalDocument>
	</xsl:template>
	<xsl:template match="/my:PathologyReport/my:ClinicalHistory">
		<component>
			<section>
				<title>Clinical history</title>
				<text>
					<list>
						<xsl:for-each select="./my:Item">
							<item>
								<content>
									<xsl:value-of select="."/>
								</content>
							</item>
						</xsl:for-each>
					</list>
				</text>
				<entry>
					<entryChoice>
						<Observation>
							<code>
								<xsl:value-of
									select="document('')//data:Item[@Name=local-name(current())]/@SCTID"
								/>
							</code>
						</Observation>
					</entryChoice>
				</entry>
			</section>
		</component>
	</xsl:template>
	<xsl:template
		match="/my:PathologyReport/*[name()!='my:Header' and name()!='my:ClinicalHistory' and name()!='my:Diagnosis']">
		<component>
			<section>
				<title>
					<xsl:value-of
						select="document('')//data:Item[@Name=local-name(current())]/@Caption"
					/>
				</title>
				<xsl:for-each
					select="./*[starts-with(local-name(),'Specimen.')]">
					<component>
						<section>
							<title>
								<xsl:value-of
									select="concat('Specimen ', position())"/>
							</title>
							<text>
								<xsl:value-of
									select="./*[starts-with(local-name(),'Text.')]"
								/>
							</text>
						</section>
					</component>
				</xsl:for-each>
				<entry>
					<entryChoice>
						<Observation>
							<code>
								<xsl:attribute name="code">
									<xsl:value-of
										select="document('')//data:Item[@Name=local-name(current())]/@SCTID"
									/>
								</xsl:attribute>
								<xsl:attribute name="codeSystem"
									>2.16.840.1.113883.6.96</xsl:attribute>
							</code>
						</Observation>
					</entryChoice>
				</entry>
			</section>
		</component>
	</xsl:template>
	<xsl:template match="/my:PathologyReport/my:Diagnosis">
		<component>
			<section>
				<title>Diagnosis</title>
				<component>
					<section>
						<title>Cancer diagnosis</title>
						<text>
							<xsl:apply-templates mode="Narrative"/>
						</text>
						<xsl:for-each select="./my:Checklist/*">
							<entry>
								<xsl:apply-templates mode="Entry" select="."/>
							</entry>
						</xsl:for-each>
					</section>
				</component>
			</section>
		</component>
	</xsl:template>
	<xsl:template mode="Narrative" match="my:Checklist//*">
		<content>
			<content>
				<xsl:value-of
					select="document('')//data:Item[@Name=local-name(current())]/@Caption"
				/>
			</content>
			<content>
				<xsl:apply-templates mode="Narrative"/>
			</content>
		</content>
	</xsl:template>
	<xsl:template mode="Entry" match="my:Diagnosis/my:Checklist//*">
		<xsl:variable name="Type"
			select="document('')//data:Item[@Name=local-name(current())]/@Type"/>
		<xsl:choose>
			<xsl:when test="$Type='container'">
				<xsl:apply-templates mode="Container" select="."/>
			</xsl:when>
			<xsl:when test="$Type='select'">
				<xsl:apply-templates mode="Select" select="."/>
			</xsl:when>
			<xsl:when test="$Type='select1'">
				<xsl:apply-templates mode="Select1" select="."/>
			</xsl:when>
			<xsl:when test="$Type='input'">
				<xsl:apply-templates mode="Input" select="."/>
			</xsl:when>
			<xsl:when test="$Type='value'">
				<xsl:apply-templates mode="Value" select="."/>
			</xsl:when>
			<xsl:otherwise>
				<entryChoice>
					<Observation>
						<code>
							<xsl:attribute name="nullFlavor">
								<xsl:text>NI</xsl:text>
							</xsl:attribute>
						</code>
					</Observation>
				</entryChoice>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template mode="Container" match="my:Checklist//*">
		<entryChoice>
			<Observation>
				<xsl:variable name="Code"
					select="document('')//data:Item[@Name=local-name(current())]"/>
				<code>
					<xsl:attribute name="code">
						<xsl:variable name="SCTID" select="$Code/@SCTID"/>
						<xsl:choose>
							<xsl:when test="$SCTID">
								<xsl:value-of select="$SCTID"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="codeSystem"
						>2.16.840.1.113883.6.96</xsl:attribute>
					<originalText>
						<xsl:value-of select="$Code/@Caption"/>
					</originalText>
				</code>
				<xsl:for-each select="./*">
					<xsl:if test="current()">
						<entryRelationship>
							<xsl:apply-templates mode="Entry" select="."/>
						</entryRelationship>
					</xsl:if>
				</xsl:for-each>
			</Observation>
		</entryChoice>
	</xsl:template>
	<xsl:template mode="Select" match="my:Checklist//*">
		<entryChoice>
			<xsl:variable name="Code"
				select="document('')//data:Item[@Name=local-name(current())]"/>
			<Observation>
				<code>
					<xsl:attribute name="code">
						<xsl:variable name="SCTID" select="$Code/@SCTID"/>
						<xsl:choose>
							<xsl:when test="$SCTID">
								<xsl:value-of select="$SCTID"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="codeSystem"
						>2.16.840.1.113883.6.96</xsl:attribute>
					<originalText>
						<xsl:value-of select="$Code/@Caption"/>
					</originalText>
				</code>
				<xsl:for-each select="./*[.='true']">
					<xsl:if test="current()">
						<entryRelationship>
							<entryChoice>
								<Observation>
									<code>
										<xsl:attribute name="code">
										<xsl:value-of select="$Code/@SCTID"/>
										</xsl:attribute>
										<xsl:attribute name="codeSystem"
										>2.16.840.1.113883.6.96</xsl:attribute>
									</code>
									<value>
										<xsl:variable name="Value"
										select="document('')//data:Item[@Name=local-name(current())]"/>
										<xsl:attribute name="xsi:type">
										<xsl:text>CD</xsl:text>
										</xsl:attribute>
										<xsl:attribute name="code">
										<xsl:variable name="SCTID"
										select="$Value/@SCTID"/>
										<xsl:choose>
										<xsl:when test="$SCTID">
										<xsl:value-of select="$SCTID"/>
										</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
										</xsl:choose>
										</xsl:attribute>
										<xsl:attribute name="codeSystem"
										>2.16.840.1.113883.6.96</xsl:attribute>
										<originalText>
										<xsl:value-of select="$Value/@Caption"/>
										</originalText>
									</value>
								</Observation>
							</entryChoice>
						</entryRelationship>
					</xsl:if>
				</xsl:for-each>
			</Observation>
		</entryChoice>
	</xsl:template>
	<xsl:template mode="Select1" match="my:Checklist//*">
		<entryChoice>
			<xsl:variable name="Code"
				select="document('')//data:Item[@Name=local-name(current())]"/>
			<xsl:variable name="Value" select="$Code/*[@Caption=current()]"/>
			<Observation>
				<xsl:if
					test="$Value/@Modifier='negative' or $Value/@Modifier='indeterminate'">
					<xsl:attribute name="negationInd">
						<xsl:value-of select="true()"/>
					</xsl:attribute>
				</xsl:if>
				<code>
					<xsl:attribute name="code">
						<xsl:variable name="SCTID" select="$Code/@SCTID"/>
						<xsl:choose>
							<xsl:when test="$SCTID">
								<xsl:value-of select="$SCTID"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="codeSystem"
						>2.16.840.1.113883.6.96</xsl:attribute>
					<originalText>
						<xsl:value-of select="$Code/@Caption"/>
					</originalText>
				</code>
				<value>
					<xsl:attribute name="xsi:type">
						<xsl:text>CD</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="code">
						<xsl:variable name="SCTID" select="$Value/@SCTID"/>
						<xsl:choose>
							<xsl:when test="$SCTID">
								<xsl:value-of select="$SCTID"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="codeSystem"
						>2.16.840.1.113883.6.96</xsl:attribute>
					<originalText>
						<xsl:value-of select="$Value/@Caption"/>
					</originalText>
				</value>
			</Observation>
		</entryChoice>
	</xsl:template>
	<xsl:template mode="Value" match="my:Checklist//*">
		<xsl:variable name="Code"
			select="document('')//data:Item[@Name=local-name(current())]"/>
		<code>
			<xsl:attribute name="code">
				<xsl:variable name="SCTID" select="$Code/@SCTID"/>
				<xsl:choose>
					<xsl:when test="$SCTID">
						<xsl:value-of select="$SCTID"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="codeSystem"
				>2.16.840.1.113883.6.96</xsl:attribute>
			<originalText>
				<xsl:value-of select="$Code/@Caption"/>
			</originalText>
		</code>
	</xsl:template>
	<xsl:template mode="Input" match="my:Checklist//*">
		<entryChoice>
			<xsl:variable name="Code"
				select="document('')//data:Item[@Name=local-name(current())]"/>
			<Observation>
				<code>
					<xsl:attribute name="code">
						<xsl:variable name="SCTID" select="$Code/@SCTID"/>
						<xsl:choose>
							<xsl:when test="$SCTID">
								<xsl:value-of select="$SCTID"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="codeSystem"
						>2.16.840.1.113883.6.96</xsl:attribute>
					<originalText>
						<xsl:value-of select="$Code/@Caption"/>
					</originalText>
				</code>
				<value>
					<xsl:variable name="Value1"
						select="document('')//data:Item[@Name=local-name(current())]/data:Item[@Caption=current()]"/>
					<xsl:choose>
						<xsl:when test="$Value1">
							<xsl:attribute name="xsi:type">
								<xsl:text>CD</xsl:text>
							</xsl:attribute>
							<xsl:attribute name="code">
								<xsl:variable name="SCTID"
									select="$Value1/@SCTID"/>
								<xsl:choose>
									<xsl:when test="$SCTID">
										<xsl:value-of select="$SCTID"/>
									</xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:attribute name="codeSystem"
								>2.16.840.1.113883.6.96</xsl:attribute>
							<originalText>
								<xsl:value-of select="$Value1/@Caption"/>
							</originalText>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="xsi:type">
								<xsl:text>TS</xsl:text>
							</xsl:attribute>
							<xsl:attribute name="value">
								<xsl:value-of select="current()"/>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				</value>
			</Observation>
		</entryChoice>
	</xsl:template>
	<xsl:template mode="Entry" match="my:Codes"/>
	<xsl:template match="my:PathologyReport/my:Header/my:*"/>
	<!--LOOKUP TABLE FOR SCTID CODES ETCETERA-->
	<data:Item Caption="Clinical History" Name="ClinicalHistory"
		SCTID="250171008"
		SCTName="clinical history and observation findings (finding)"
		Type="container"/>
	<data:Item Caption="Gross description" Name="Gross" SCTID="168459006"
		SCTName="gross pathology NOS (finding)" Type="container">
		<data:Item Caption="Specimen " Name="Specimen.GD" Type="container"
			SCTID="363661006"/>
	</data:Item>
	<data:Item Caption="CPT Items" Name="CPT" SCTID="363661006" Type="container"/>
	<data:Item Caption="Intraoperative consultation" Name="Intraoperative"
		SCTID="363661006" Type="container">
		<data:Item Caption="Specimen " Name="Specimen.IO" Type="container"
			SCTID="363661006"/>
	</data:Item>
	<data:Item Caption="Microscopic description" Name="Microscopic"
		SCTID="395538009" SCTName="microscopic specimen observation (finding)"
		Type="container">
		<data:Item Caption="Specimen " Name="Specimen.MD" Type="container"
			SCTID="363661006"/>
	</data:Item>
	<data:Item Caption="Immunohistochemical findings"
		Name="Immunohistochemistry" SCTID="363661006" Type="container">
		<data:Item Caption="Specimen " Name="Specimen.IH" Type="container"
			SCTID="363661006"/>
	</data:Item>
	<data:Item Caption="Molecular diagnostic findings" Name="Molecular"
		SCTID="363661006" Type="container">
		<data:Item Caption="Specimen " Name="Specimen.MO" Type="container"
			SCTID="363661006"/>
	</data:Item>
	<data:Item Caption="Electron microscopic findings" Name="EM"
		SCTID="363661006" Type="container">
		<data:Item Caption="Specimen " Name="Specimen.EM" Type="container"
			SCTID="363661006"/>
	</data:Item>
	<data:Item Caption="Diagnosis" Name="Diagnosis" SCTID="363661006"
		Type="container">
		<data:Item Caption="Specimen " Name="Specimen.DX" Type="container"
			SCTID="363661006"/>
		<data:Item Caption="Diagnosis header" Name="DiagnosisHeader"
			Type="input" SCTID="363661006">
			<data:Item Caption="CARCINOMA OF LUNG" Type="value"
				SCTID="363661006"/>
		</data:Item>
		<data:Item Caption="Tumor location" Name="TumorLocationGroup"
			SCTID="399687005" SCTName="primary tumor site (observable)"
			Type="select">
			<data:Item Caption="Right upper lobe" Name="RightUpperLobe"
				SCTID="42400003" SCTName="structure of right upper lobe of lung"
				Type="value"/>
			<data:Item Caption="Right middle lobe" Name="RightMiddleLobe"
				SCTID="72481006"
				SCTName="structure of right middle lobe of lung" Type="value"/>
			<data:Item Caption="Right lower lobe" Name="RightLowerLobe"
				SCTID="266005" SCTName="structure of right lower lobe of lung"
				Type="value"/>
			<data:Item Caption="Left upper lobe" Name="LeftUpperLobe"
				SCTID="44714003" SCTName="structure of left upper lobe of lung"
				Type="value"/>
			<data:Item Caption="Lingula" Name="Lingula" SCTID="50837003"
				SCTName="structure of lingula of left lung" Type="value"/>
			<data:Item Caption="Left lower lobe" Name="LeftLowerLobe"
				SCTID="41224006" SCTName="structure of left lower lobe of lung"
				Type="value"/>
		</data:Item>
		<data:Item Caption="Specimen type" Name="SpecimenType" SCTID="371439000"
			SCTName="specimen type (observable)" Type="select1">
			<data:Item Caption="Pneumonectomy" SCTID="122607002"
				SCTName="specimen from lung obtained by pneumonectormy"
				Type="value"/>
			<data:Item Caption="Lobectomy" SCTID="122606006"
				SCTName="specimen from lung obtained by lobectomy" Type="value"/>
			<data:Item Caption="Wedge resection" SCTID="363661006"/>
		</data:Item>
		<data:Item Caption="Histologic type" Name="HistologicType"
			SCTID="37144104" Type="select1">
			<data:Item Caption="Squamous cell carcinoma" SCTID="2889901"
				Type="value"/>
			<data:Item Caption="Small cell carcinoma" SCTID="7436400"
				Type="value"/>
			<data:Item Caption="Combined small cell carcinoma" SCTID="2132604"
				Type="value"/>
			<data:Item Caption="Adenocarcinoma" SCTID="3591707" Type="value"/>
			<data:Item Caption="Bronchiolo-alveolar cell carcinoma"
				SCTID="11267702" Type="value"/>
			<data:Item Caption="Large cell carcinoma" SCTID="2268700"
				Type="value"/>
			<data:Item Caption="Large cell neuroendocrine carcinoma"
				SCTID="12862802" Type="value"/>
			<data:Item Caption="Basaloid carcinoma" SCTID="584304" Type="value"/>
			<data:Item Caption="Adenosquamous carcinoma" SCTID="5936705"
				Type="value"/>
			<data:Item Caption="Carcinoid tumor" SCTID="8162200" Type="value"/>
			<data:Item Caption="Mucoepidermoid carcinoma" SCTID="407900"
				Type="value"/>
			<data:Item Caption="Carcinoma, NOS" SCTID="6845308" Type="value"/>
		</data:Item>
		<data:Item Caption="Histologic subtype" Name="HistologicTypeAdd"
			SCTID="371441004" Type="input"/>
		<data:Item Caption="Histologic grade" Name="Grade" SCTID="37146907"
			Type="select1">
			<data:Item Caption="Grade 1" SCTID="5410205" Type="value"/>
			<data:Item Caption="Grade 2" SCTID="166304" Type="value"/>
			<data:Item Caption="Grade 3" SCTID="6102606" Type="value"/>
			<data:Item Caption="Grade 4" SCTID="25824503" Type="value"/>
			<data:Item Caption="Grade not determined" SCTID="6081508"
				Type="value"/>
		</data:Item>
		<data:Item Caption="Extent of invasion" Name="Invasion" SCTID="37148705"
			Type="container">
			<data:Item Caption="Greatest tumor diameter (cm)" Name="Diameter"
				SCTID="371479009" SCTName="tumor size, largest dimension"
				Type="input"/>
			<data:Item Caption="Mainstem bronchus involvement"
				Name="MainstemBronchusInvolvement" SCTID="363661006"
				Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38497905" Type="value"/>
				<data:Item Caption="Positive" SCTID="38497905" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38497905" Type="value"/>
			</data:Item>
			<data:Item Caption="Visceral pleura invasion"
				Name="VisceralPleuraInvasion" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38496601" Type="value"/>
				<data:Item Caption="Positive" SCTID="38496601" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38496601" Type="value"/>
			</data:Item>
			<data:Item Caption="Chest wall (muscle) invasion"
				Name="ChestWallInvasion" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38496601" Type="value"/>
				<data:Item Caption="Positive" SCTID="38496309" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38496601" Type="value"/>
			</data:Item>
			<data:Item Caption="Mediastinal invasion" Name="MediastinalInvasion"
				SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38496601" Type="value"/>
				<data:Item Caption="Positive" SCTID="38496800" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38496601" Type="value"/>
			</data:Item>
			<data:Item Caption="Multiple tumor nodules"
				Name="MultipleTumorNodules" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38496601" Type="value"/>
				<data:Item Caption="Positive" SCTID="38497905" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38496601" Type="value"/>
			</data:Item>
			<data:Item Caption="Panlobar atelectasis or obstructive pneumonitis"
				Name="PanlobarAtelectasis" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38496601" Type="value"/>
				<data:Item Caption="Positive" SCTID="38498008" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38496601" Type="value"/>
			</data:Item>
			<data:Item
				Caption="Atelectasis or obstructive pneumonitis of entire lung"
				Name="PanLungAtelectasis" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="369882007" Type="value"/>
				<data:Item Caption="Positive" SCTID="369882007" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="369882007" Type="value"/>
			</data:Item>
			<data:Item Caption="Tumor less than 2 cm from carina"
				Name="MainstemCloseCarina" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="369883002" Type="value"/>
				<data:Item Caption="Positive" SCTID="369883002" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="369883002" Type="value"/>
			</data:Item>
			<data:Item Caption="Malignant pleural effusion"
				Name="MalignantEffusion" SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="369886005" Type="value"/>
				<data:Item Caption="Positive" SCTID="369886005" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="369886005" Type="value"/>
			</data:Item>
		</data:Item>
		<data:Item Caption="Margin status" Name="Margin" SCTID="39663101"
			Type="container">
			<data:Item Caption="Bronchial margin" Name="BronchialMargin"
				SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38495508" Type="value"/>
				<data:Item Caption="Positive" SCTID="38495508" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38495508" Type="value"/>
			</data:Item>
			<data:Item Caption="Vascular margin" Name="VascularMargin"
				SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38495609" Type="value"/>
				<data:Item Caption="Positive" SCTID="38495609" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38495609" Type="value"/>
			</data:Item>
			<data:Item Caption="Parenchymal margin" Name="ParenchymalMargin"
				SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38495700" Type="value"/>
				<data:Item Caption="Positive" SCTID="38495700" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38495700" Type="value"/>
			</data:Item>
			<data:Item Caption="Pleural margin" Name="PleuralMargin"
				SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" Modifier="negative"
					SCTID="38495805" Type="value"/>
				<data:Item Caption="Positive" SCTID="38495805" Type="value"/>
				<data:Item Caption="Indeterminate" Modifier="indeterminate"
					SCTID="38495805" Type="value"/>
			</data:Item>
			<data:Item Caption="Closest margin" Name="ClosestMargin"
				Type="input"/>
			<data:Item Caption="Distance from closest margin (cm)"
				Name="MarginDistance" Type="input"/>
		</data:Item>
		<data:Item Caption="Other tumor-related findings">
			<data:Item Caption="Venous (large vessel) invasion"
				Name="VenousInvasion" SCTID="37149302" Type="select1">
				<data:Item Caption="Negative" SCTID="4022308" Type="value"/>
				<data:Item Caption="Positive" SCTID="36973207" Type="value"/>
				<data:Item Caption="Indeterminate" SCTID="651002" Type="value"/>
			</data:Item>
			<data:Item Caption="Lymphatic (small vessel) invasion"
				Name="LymphaticInvasion" SCTID="39571509" Type="select1">
				<data:Item Caption="Negative" SCTID="4464903" Type="value"/>
				<data:Item Caption="Positive" SCTID="7413905" Type="value"/>
				<data:Item Caption="Indeterminate" SCTID="3341901" Type="value"
				/>
			</data:Item>
		</data:Item>
		<data:Item Caption="Regional lymph nodes" Name="RegionalLymphNodes"
			SCTID="37149408" Type="container">
			<data:Item Caption="Regional lymph node status" Name="RLNStatus"
				SCTID="363661006" Type="select1">
				<data:Item Caption="Negative" SCTID="2191709" Type="value"/>
				<data:Item Caption="Positive" SCTID="39937409" Type="value"/>
				<data:Item Caption="Indeterminate" SCTID="5445205" Type="value"
				/>
			</data:Item>
			<data:Item Caption="Location of involved lymph nodes"
				Name="LNLocation" SCTID="397440000" Type="select">
				<data:Item
					Caption="Ipsilateral pulmonary (level 10-14) lymph nodes"
					Name="IpsiPulmonaryLN" SCTID="384749008"
					SCTName="pN1: Metastasis in..." Type="value"/>
				<data:Item
					Caption="Ipsilateral mediastinal (level 1-9) lymph nodes"
					Name="IpsiMediastinalLN" SCTID="384750008"
					SCTName="pN2: Metastasis in..." Type="value"/>
				<data:Item Caption="Contralateral level 1-14 lymph nodes"
					Name="ContraLN" SCTID="384751007"
					SCTName="pN3: Metastasis in..." Type="value"/>
				<data:Item Caption="Scalene or supraclavicular lymph nodes"
					Name="ScalClavLN" SCTID="384751007"
					SCTName="pN3: Metastasis in..." Type="value"/>
			</data:Item>
			<data:Item Caption="Number of lymph nodes examined"
				Name="NodesExamined" SCTID="37230906" Type="input"/>
			<data:Item Caption="Number of lymph nodes involved"
				Name="PositiveNodes" SCTID="37230803" Type="input"/>
		</data:Item>
		<data:Item Caption="NontumorRelated" Type="input"/>
		<data:Item Caption="Note" Name="Note" Type="container" SCTID="363661006"
		/>
	</data:Item>
	<data:Item Caption="Comments" Name="Comments" Type="container"
		SCTID="363661006">
		<data:Item Caption="Comment" Name="Comment" Type="value"
			SCTID="363661006"/>
	</data:Item>
</xsl:stylesheet>
