<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xd" version="2.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="element()">
        <xsl:copy>
            <xsl:apply-templates select="@*,node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    <xsl:template match="*[ends-with(@name,'.extension')]/xs:restriction">
        <xs:restriction base="xs:token">
            <xs:enumeration value="specify"/>
            <xs:enumeration value="inapplicable"/>
            <xs:enumeration value="unreported"/>
        </xs:restriction>
    </xsl:template>
</xsl:stylesheet>
