<xsl:function as="xs:decimal" name="f:to-mm">
    <xsl:param name="value"/>
    <xsl:param name="unit"/>
    <xsl:param name="relation"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:variable name="lessThan" select="'less than'"/>
    <xsl:variable name="greaterThan" select="'greaterThan'"/>
    <xsl:variable name="mm" select="'mm'"/>
    <xsl:variable name="cm" select="'cm'"/>
    <xsl:variable name="in" select="'in'"/>
    <xsl:variable name="correction">
        <xsl:choose>
            <xsl:when test="$relation eq $lessThan">-1.0</xsl:when>
            <xsl:when test="$relation eq $greaterThan">1.0</xsl:when>
            <xsl:otherwise>0.0</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:value-of>
        <xsl:choose>
            <xsl:when test="not($value castable as xs:decimal)">
                <xsl:sequence select="0.0"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$unit eq $mm">
                        <xsl:sequence select="$value + $correction"/>
                    </xsl:when>
                    <xsl:when test="$unit eq $cm">
                        <xsl:sequence select="$value*10.0 + $correction"/>
                    </xsl:when>
                    <xsl:when test="$unit eq $in">
                        <xsl:sequence select="$value*25.4 + $correction"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="0.0"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:value-of>
</xsl:function>
