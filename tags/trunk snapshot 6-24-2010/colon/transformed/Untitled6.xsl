<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns:ecc="http://cap#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:template match="ecc:section|ecc:item">
        <xsl:element name="{replace(@name,' ','_')}">
            <xsl:apply-templates select="attribute::"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
