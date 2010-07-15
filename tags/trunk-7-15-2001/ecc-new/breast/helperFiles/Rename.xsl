<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns:ns1="http://temp#"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"/>
    <!--                                                     -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <!--                                                     -->
    <xsl:template match="@name[parent::xs:group[starts-with(@name,'item')]]" mode="#default">
        <xsl:variable name="old-name">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:variable name="new-name">
            <xsl:value-of select="translate(..//xs:enumeration[1]/@value,' ','-')"/>
        </xsl:variable>
        <xsl:attribute name="name">
            <xsl:value-of select="$new-name"/>
        </xsl:attribute>
        <xsl:attribute name="oldName">
            <xsl:value-of select="$old-name"/>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
