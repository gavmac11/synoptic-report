<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd" version="2.0"
    xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 10, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> John Madden</xd:p>
            <xd:p><xd:b>This transforms a values.rng file to an approximation of a values.xsd file.</xd:b></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <begin>
            <xsl:apply-templates/>
        </begin>
    </xsl:template>
    <xsl:template match="rng:define">
        <xs:simpleType>
            <xsl:attribute name="name">
                <xsl:value-of select="./@name"/>
            </xsl:attribute>
            <xs:restriction>
                <xsl:attribute name="base">
                    <xsl:value-of select="./@name"/>
                </xsl:attribute>
                <xsl:for-each select="./rng:choice/rng:value">
                    <xs:enumeration>
                        <xsl:attribute name="value">
                        <xsl:value-of select="."/></xsl:attribute>
                    </xs:enumeration>
                </xsl:for-each>
                <xs:enumeration value="specify"/>
            </xs:restriction>
        </xs:simpleType>
    </xsl:template>
</xsl:stylesheet>
