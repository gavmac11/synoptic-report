<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd" version="2.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 13, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> me</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:template match="element()">
        <xsl:apply-templates select="element()"/>
    </xsl:template>
    <xsl:template match="/">
        <valuelist>
            <xsl:perform-sort>
                <xsl:sort select="@name"/>
                <xsl:apply-templates select="element()"/>
            </xsl:perform-sort>
        </valuelist>
    </xsl:template>
    <xsl:template match="xs:simpleType[ends-with(@name,'.values')]">
        <values>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:apply-templates select="element()"/>
        </values>
    </xsl:template>
    <xsl:template match="xs:union[ends-with(../@name,'.values')]">
        <xsl:variable name="simpleType" select="//xs:simpleType"/>
        <xsl:for-each select="tokenize(@memberTypes,' ')">
            <xsl:variable name="value"
                select="$simpleType[@name eq substring-after(current(),'ecc:')]//xs:enumeration/@value"/>
            <!-- "@value = 'unreported','inapplicable','equivocal','specify'"-->
            <xsl:for-each select="$value">
                <value>
                    <xsl:value-of select="current()"/>
                </value>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:restriction[ends-with(../@name,'.values')]">
        <xsl:for-each select="xs:enumeration">
            <value>
                <xsl:value-of select="@value"/>
            </value>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
