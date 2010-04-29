<?xml version="1.0" encoding="UTF-8"?>
<xs:transform version="2.0" xmlns:ecc="http://cap#" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
	<xs:template match="*|node()">
		<xs:copy>
			<xs:for-each select="@*">
				<xs:apply-templates select="."/>
			</xs:for-each>
			<xs:apply-templates select="*|node()"/>
		</xs:copy>
	</xs:template>
	<xs:template match="*[@kind]">
		<xs:element name="{@kind}">
			<xs:for-each select="@*">
				<xs:apply-templates select="."/>
			</xs:for-each>
			<xs:attribute name="name">
				<xs:value-of select="name(.)"/>
			</xs:attribute>
			<xs:apply-templates select="*|node()"/>
		</xs:element>
	</xs:template>
	<xs:template match="@*[name(.) eq 'kind']"/>
	<xs:template match="@*">
		<xs:copy/>
	</xs:template>
</xs:transform>
