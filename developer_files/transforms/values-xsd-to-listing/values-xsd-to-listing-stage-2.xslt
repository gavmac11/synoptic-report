<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd" version="2.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="element()">
        <xsl:copy>
            <xsl:apply-templates select="@*,node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    <xsl:template match="values[contains(@name,'sitespecific')]"> </xsl:template>
    <xsl:template match="values">
        <xsl:copy>
            <xsl:attribute name="name" select="@name"/>
            <xsl:perform-sort>
                <xsl:sort select=". eq 'unreported'"/>
                <xsl:sort select=". eq 'inapplicable'"/>
                <xsl:sort select=". eq 'innapplicable'"/>
                <xsl:sort select=". eq 'pending'"/>
                <xsl:sort select=". eq 'equivocal'"/>
                <xsl:sort select=". eq 'indeterminate'"/>
                <xsl:sort select=". eq 'specify'"/>
                <xsl:apply-templates select="value"/>
            </xsl:perform-sort>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
