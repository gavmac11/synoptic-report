<?xml version="1.0" encoding="UTF-8"?>
<xs:transform version="2.0" xmlns:ecc="http://cap#" xmlns:str="http://john.madden.name/string#"
    xmlns:xs="http://www.w3.org/1999/XSL/Transform">
    <xs:include href="file:///Applications/oXygen11.1/frameworks/xslt/extensions/xt.xsl"/>
    <xs:template match="*|node()">
        <xs:copy>
            <xs:for-each select="@*">
                <xs:apply-templates select="."/>
            </xs:for-each>
            <xs:apply-templates select="*|node()"/>
        </xs:copy>
    </xs:template>
    <xs:template match="ecc:item">
        <xs:element name="{str:lower-camel(@name)}">
            <xs:attribute name="xml:id">
                <xs:value-of select="generate-id()"></xs:value-of>
            </xs:attribute>
            <xs:for-each select="@*">
                <xs:apply-templates select="."/>
            </xs:for-each>
            <xs:attribute name="kind">item</xs:attribute>
            <xs:apply-templates select="*|node()"/>
        </xs:element>
    </xs:template>
    <xs:template match="ecc:section">
        <xs:element name="{str:lower-camel(@name)}">
            <xs:attribute name="xml:id">
                <xs:value-of select="generate-id()"></xs:value-of>
            </xs:attribute>
            <xs:for-each select="@*">
                <xs:apply-templates select="."/>
            </xs:for-each>
            <xs:attribute name="kind">section</xs:attribute>
            <xs:apply-templates select="*|node()"/>
        </xs:element>
    </xs:template>
    <xs:template match="@name"/>
    <xs:template match="@*">
        <xs:copy/>
    </xs:template>
    <xs:template match="ecc:response/@value">
        <xs:attribute name="value">
            <xs:value-of select="concat('ecc:',str:lower-camel(.))"/>
        </xs:attribute>
    </xs:template>
</xs:transform>
