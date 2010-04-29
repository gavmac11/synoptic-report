<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform exclude-result-prefixes="xs" version="2.0" xmlns:ecc="http://cap#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="*|node()">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ecc:item">
        <xsl:text>
        </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ecc:response">
        <xsl:text>   </xsl:text>
        <xsl:value-of select="@value"/>
        <xsl:text>
        </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
</xsl:transform>
