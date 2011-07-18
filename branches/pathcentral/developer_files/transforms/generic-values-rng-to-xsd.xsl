<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd" version="2.0"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0" xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 30, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> John F. Madden. MD, PhD</xd:p>
            <xd:p>This transform takes as input the generic values.rng file, and outputs a generic values.xsd
                file.</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="inextensible-1"
        select="('extension.valueset','base.valueset','lengthUnit.valueset','weightUnit.valueset','relation.valueset')"/>
    <xsl:variable name="inextensible-2" select="('qualitative.valueset','laterality.valueset','focality.valueset')"/>
    <xsl:output indent="yes" method="xml"/>
    <xsl:variable name="inextensible" select="$inextensible-1, $inextensible-2"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="comment()">
        <!--This template preserves comments.-->
        <xsl:comment>
            <xsl:value-of select="."/>
        </xsl:comment>
    </xsl:template>
    <xsl:template match="a:documentation">
        <!--This template preserves a:documentation elements as comments.-->
        <xsl:comment>
            <xsl:value-of select="."/>
        </xsl:comment>
    </xsl:template>
    <xsl:template match="/rng:grammar">
        <!--This template creates the top-level schema element.-->
        <xs:schema elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
            <xsl:apply-templates/>
        </xs:schema>
    </xsl:template>
    <xsl:template match="rng:define">
        <!--This template creates the simpleType definition envelope and (if the element is extensible) it
            also creates the .extensible simpleType envelope with which it is paired. -->
        <xs:simpleType>
            <xsl:attribute name="name">
                <xsl:value-of select="./@name"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xs:simpleType>
        <xsl:if test="not(@name = $inextensible)">
            <xsl:comment select="'--------------------------------'"/>
            <xs:simpleType>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat(./@name,'.extension')"/>
                </xsl:attribute>
                <xs:restriction base="xs:token"/>
            </xs:simpleType>
        </xsl:if>
    </xsl:template>
    <xsl:template match="rng:choice">
        <!-- This template creates the contents of the simpleType. It checks whether the element is
            extensible first. If it is, then it models it as a union of a restriction on xs:token
            and its companion .extension type. If it is inextensible, then it is modeled just as a restriction on xs:token. -->
        <xsl:choose>
            <xsl:when test="..[@name = $inextensible-1]">
                <xs:restriction base="xs:token">
                    <xsl:apply-templates/>
                </xs:restriction>
            </xsl:when>
            <xsl:when test="..[@name = $inextensible-2]">
                <xs:union memberTypes="base.valueset">
                    <xs:simpleType>
                        <xs:restriction base="xs:token">
                            <xsl:apply-templates/>
                        </xs:restriction>
                    </xs:simpleType>
                </xs:union>
            </xsl:when>
            <xsl:otherwise>
                <xs:union>
                    <xsl:attribute name="memberTypes">
                        <xsl:value-of select="concat(../@name,'.extension')"/>
                    </xsl:attribute>
                    <xs:simpleType>
                        <xs:restriction base="xs:token">
                            <xsl:apply-templates/>
                        </xs:restriction>
                    </xs:simpleType>
                </xs:union>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="rng:value">
        <!-- This changes each rng:value to an xsd:enumeration/@value -->
        <xs:enumeration>
            <xsl:attribute name="value">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </xs:enumeration>
    </xsl:template>
    <xsl:template match="rng:ref">
        <!-- This deals with types that are defined by reference in the rng. -->
        <xs:union>
            <xsl:attribute name="memberTypes">
                <xsl:value-of select="concat(./@name,' ',../@name,'.extension')"/>
            </xsl:attribute>
        </xs:union>
    </xsl:template>
    <xsl:template match="rng:notAllowed|rng:empty">
        <!-- This deals with types that are notAllowed or empty in the rng. -->
        <xs:union>
            <xsl:attribute name="memberTypes">
                <xsl:value-of select="concat(../@name,'.extension')"/>
            </xsl:attribute>
        </xs:union>
    </xsl:template>
</xsl:stylesheet>
