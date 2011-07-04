<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xd" version="2.0" xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/rng:grammar">
        <!-- This matches the toplevel rng:grammar element, and creates the xs:schema wrapper -->
        <xs:schema elementFormDefault="qualified" xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
            xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema">
            <xs:redefine schemaLocation="../generic/values.xsd">
                <!-- The first thing we need to do is capture all the valuesets that are being extended -->
                <!-- We model this as a series of redefinitions in xml schema -->
                <!-- Each redefinition puts the extending elements into the .extension element -->
                <!-- The variable "redefined" finds all the elements that are undergoing extension (redefinition) by looking for all those that have a definition already in the generic values file, but get mentioned again in the site-specific values file -->
                <xsl:variable name="redefined"
                    select="rng:define[@name = doc('../generic/values.xsd')//xs:simpleType/@name]"/>
                <!-- The variable "non-redefined" finds the complement of "redefined". We need to know this, because we need to "collapse" the .extension of each of the non-redefined valuesets down to the base.valueset. Rather than a sequence of elements (like "redefined") this variable stores a sequence of names.  -->
                <!-- This strategy seems clumsy, but is necessary because xml schema does not natively support extending valueset enumerations; it only supports restricting them. -->
                <!-- (In Relax NG, by contrast, extending enumerated valuesets is not a problem.)  -->
                <xsl:variable name="non-redefined" select="for $x in $redefined return concat($x/@name,'.extension')"/>
                <xsl:apply-templates mode="redefined" select="$redefined"/>
                <xsl:variable name="extensible"
                    select="doc('../generic/values.xsd')//xs:simpleType/@name[ends-with(.,'.extension')]"/>
                <xsl:for-each select="$extensible[not(. = $non-redefined)]">
                    <xs:simpleType>
                        <xsl:attribute name="name">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xs:restriction>
                            <xsl:attribute name="base">
                                <xsl:value-of select="."/>
                            </xsl:attribute>
                            <xs:enumeration value="specify"/>
                            <xs:enumeration value="inapplicable"/>
                            <xs:enumeration value="unreported"/>
                        </xs:restriction>
                    </xs:simpleType>
                </xsl:for-each>
            </xs:redefine>
            <xsl:apply-templates mode="new"
                select="rng:define[not(@name = doc('../generic/values.xsd')//xs:simpleType/@name)]"/>
        </xs:schema>
    </xsl:template>
    <xsl:template match="rng:define" mode="redefined">
        <xs:simpleType>
            <xsl:attribute name="name">
                <xsl:value-of select="concat(@name,'.extension')"/>
            </xsl:attribute>
            <xs:restriction>
                <xsl:attribute name="base">
                    <xsl:value-of select="concat(@name,'.extension')"/>
                </xsl:attribute>
                <xsl:for-each select=".//rng:value">
                    <xs:enumeration>
                        <xsl:attribute name="value">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xs:enumeration>
                </xsl:for-each>
                <xs:enumeration value="specify"/>
                <xs:enumeration value="inapplicable"/>
                <xs:enumeration value="unreported"/>
            </xs:restriction>
        </xs:simpleType>
    </xsl:template>
    <xsl:template match="rng:define" mode="new">
        <xs:simpleType>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xs:restriction>
                <xsl:attribute name="base">
                    <xsl:value-of select="'xs:token'"/>
                </xsl:attribute>
                <xsl:for-each select=".//rng:value">
                    <xs:enumeration>
                        <xsl:attribute name="value">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xs:enumeration>
                </xsl:for-each>
                <xs:enumeration value="specify"/>
                <xs:enumeration value="inapplicable"/>
                <xs:enumeration value="unreported"/>
            </xs:restriction>
        </xs:simpleType>
    </xsl:template>
</xsl:stylesheet>
