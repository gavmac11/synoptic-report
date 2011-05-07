<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns:my="http://john.madden.name/xpath#"
    xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:string" name="my:upper-camel">
        <xsl:param name="input"/>
        <xsl:value-of select="string-join(for $a in tokenize($input,' ') return my:camelize($a),'')"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function name="my:camelize">
        <!-- Internal utility function to break up overly long line in my:upper-camel -->
        <xsl:param name="input"/>
        <xsl:value-of select="concat(upper-case(substring($input,1,1)),substring($input,2))"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:string" name="my:lower-camel">
        <xsl:param name="input"/>
        <xsl:variable name="a" select="my:upper-camel($input)"/>
        <xsl:value-of select="concat(lower-case(substring($a,1,1)),substring($a,2))"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:string" name="my:space-to-hyphen">
        <xsl:param name="input"/>
        <xsl:value-of select="translate(lower-case($input),' ','-')"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:string" name="my:space-to-underscore">
        <xsl:param name="input"/>
        <xsl:value-of select="translate(lower-case($input),' ','_')"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:decimal" name="my:decimal">
        <xsl:param name="input"/>
        <xsl:value-of select="if ($input castable as xs:decimal) then xs:decimal($input) else 0.0"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:boolean" name="my:isPositive">
        <xsl:param name="input"/>
        <xsl:value-of select="if ($input castable as xs:string) then ($input eq 'positive') else false()"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:string" name="my:string">
        <xsl:param name="input"/>
        <xsl:choose>
            <xsl:when test="count($input) le 1">
                <xsl:value-of select="if ($input castable as xs:string) then xs:string($input) else ''"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="for $x in $input return my:string($x)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="*|node()">
        <result value="{my:camelize('these are the times')}"/>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</xsl:stylesheet>
