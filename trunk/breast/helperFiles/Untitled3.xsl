<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--  -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!--  -->
    <xsl:template match="xs:group[starts-with(@name,'item_')]">
        <xsl:variable name="oldName">
            <xsl:value-of select="@name"/>
        </xsl:variable>
        <xsl:variable name="newName">
            <xsl:value-of select="translate(.//xs:attribute[@name eq 'name'][1]//xs:enumeration[1]/@value,' ','-')"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="name">
                <xsl:value-of select="$newName"/>
            </xsl:attribute>
            <xsl:attribute name="oldName">
                <xsl:value-of select="$oldName"/>
            </xsl:attribute>
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="xs:group[starts-with(@name,'section_')]">
        <xsl:variable name="oldName">
            <xsl:value-of select="@name"/>
        </xsl:variable>
        <xsl:variable name="newName">
            <xsl:value-of select="translate(.//xs:attribute[@name eq 'name'][1]//xs:enumeration[1]/@value,' ','-')"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="name">
                <xsl:value-of select="$newName"/>
            </xsl:attribute>
            <xsl:attribute name="oldName">
                <xsl:value-of select="$oldName"/>
            </xsl:attribute>
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="xs:group[starts-with(@name,'response_')]">
        <xsl:variable name="oldName">
            <xsl:value-of select="@name"/>
        </xsl:variable>
        <xsl:variable name="newName">
            <xsl:value-of select="translate(.//xs:attribute[@name eq 'value'][1]//xs:enumeration[1]/@value,' ','-')"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="name">
                <xsl:value-of select="$newName"/>
            </xsl:attribute>
            <xsl:attribute name="oldName">
                <xsl:value-of select="$oldName"/>
            </xsl:attribute>
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
