<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//xs:group/@ref">
        <xsl:variable name="tag" select="."/>
        <xsl:choose>
            <xsl:when test="exists(//xs:group[@oldName eq $tag])">
                <xsl:attribute name="ref">
                    <xsl:value-of select="//xs:group[@oldName eq $tag]/@name"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:copy>
                   <xsl:apply-templates select="."></xsl:apply-templates>
               </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
