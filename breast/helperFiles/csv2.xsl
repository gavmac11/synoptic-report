<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY  sites         "//e:tumor//e:site/e:response/@value">
<!ENTITY  tumorSizes    "//e:tumor//e:size/e:response">
<!ENTITY  T-stage       "//e:stage/pT/e:response/@value">
<!ENTITY  N-stage       "//e:stage/e:pN/e:response/@value">
<!ENTITY  posNodes      "//e:nodes//e:result[@of eq 'positive']/e:response/@value">
<!ENTITY  examNodes     "//e:nodes//e:result[@of eq 'total']/e:response/@value">
<!ENTITY  mets          "//e:distant//e:result/e:response/@value">
<!ENTITY  metsEval      "//e:distant//e:result[e:response/@value eq 'positive']/@for">
<!ENTITY  SSF1          "//e:studies/e:estrogenReceptor/e:result/e:response/@value">
<!ENTITY  SSF2          "//e:studies/e:progesteroneReceptor/e:result/e:response/@value">
<!ENTITY  SSF3          "//e:nodes/e:status[@of = ('low axillary','mid axillary')]/e:result[@for eq 'positive']/e:response/@value">
<!ENTITY  SSF4          "//e:nodes/e:status[contains(@technique,'immunohistochemistry')/e:result">
<!ENTITY  SSF7          "//e:tumor/e:focus[1]/e:grade/e:result[@for = ('glands','nuclei','mitoses')]/e:response/@value">

]>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns="http://www.cancerstaging.org/csv2#"
    xmlns:e="http://purl.org/pathology/ecc/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--  -->
    <xsl:output indent="yes" method="xml"/>
    <!--  -->
    <xsl:variable name="unreported">
        <xsl:value-of select="('unreported','inapplicable')"/>
    </xsl:variable>
    <!--  -->
    <xsl:function as="xs:decimal" name="e:to-mm">
        <xsl:param name="value"/>
        <xsl:param name="unit"/>
        <xsl:param name="relation"/>
        <xsl:variable name="correction">
            <xsl:value-of
                select="if ($relation eq 'less than') then -1.0 else if ($relation eq 'greater than') then 1.0 else 0.0"
            />
        </xsl:variable>
        <xsl:value-of
            select="if ($value castable as xs:decimal) then if ($unit eq 'mm') then ($value + $correction) else if ($unit eq 'cm') then    ($value*10.0 + $correction) else if ($unit eq 'in') then ($value*25.4 + $correction) else (0) else (0)"
        />
    </xsl:function>
    <!--  -->
    <xsl:function name="e:string-end">
        <xsl:param name="str"/>
        <xsl:param name="len"/>
        <xsl:value-of select="substring($str,string-length($str) - $len + 1)"/>
    </xsl:function>
    <!--  -->
    <xsl:template match="/">
        <breast xmlns="http://www.cancerstaging.org/csv2#">
            <subsite>
                <xsl:attribute name="code">
                    <xsl:call-template name="site"/>
                </xsl:attribute>
            </subsite>
            <tumorSize>
                <xsl:attribute name="code">
                    <xsl:call-template name="tumorSize"/>
                </xsl:attribute>
            </tumorSize>
            <extension>
                <xsl:attribute name="code">
                    <xsl:call-template name="extension"/>
                </xsl:attribute>
            </extension>
            <tumorSizeExtentEval>
                <xsl:attribute name="code">
                    <xsl:call-template name="tumorSizeExtentEval"/>
                </xsl:attribute>
            </tumorSizeExtentEval>
            <lymphNodes>
                <xsl:attribute name="code">
                    <xsl:call-template name="lymphNodes"/>
                </xsl:attribute>
            </lymphNodes>
            <lymphNodesEval>
                <xsl:attribute name="code">
                    <xsl:call-template name="lymphNodesEval"/>
                </xsl:attribute>
            </lymphNodesEval>
            <regLNPos>
                <xsl:attribute name="code">
                    <xsl:call-template name="regLNPos"/>
                </xsl:attribute>
            </regLNPos>
            <regLNExam>
                <xsl:attribute name="code">
                    <xsl:call-template name="regLNExam"/>
                </xsl:attribute>
            </regLNExam>
            <metsAtDx>
                <xsl:attribute name="code">
                    <xsl:call-template name="metsAtDx"/>
                </xsl:attribute>
            </metsAtDx>
            <metsEval>
                <xsl:attribute name="code">
                    <xsl:call-template name="metsEval"/>
                </xsl:attribute>
            </metsEval>
            <SSF1>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF1"/>
                </xsl:attribute>
            </SSF1>
            <SSF2>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF2"/>
                </xsl:attribute>
            </SSF2>
            <SSF3>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF3"/>
                </xsl:attribute>
            </SSF3>
            <SSF4>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF4"/>
                </xsl:attribute>
            </SSF4>
            <SSF5>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF5"/>
                </xsl:attribute>
            </SSF5>
            <SSF6>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF6"/>
                </xsl:attribute>
            </SSF6>
            <SSF7>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF7"/>
                </xsl:attribute>
            </SSF7>
            <SSF8>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF8"/>
                </xsl:attribute>
            </SSF8>
            <SSF9>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF9"/>
                </xsl:attribute>
            </SSF9>
            <SSF10>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF10"/>
                </xsl:attribute>
            </SSF10>
            <SSF11>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF11"/>
                </xsl:attribute>
            </SSF11>
            <!--<SSF12>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF12"/>
                </xsl:attribute>
            </SSF12>
            <SSF13>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF13"/>
                </xsl:attribute>
            </SSF13>
            <SSF14>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF14"/>
                </xsl:attribute>
            </SSF14>
            <SSF15>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF15"/>
                </xsl:attribute>
            </SSF15>
            <SSF16>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF16"/>
                </xsl:attribute>
            </SSF16>
            <SSF17>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF17"/>
                </xsl:attribute>
            </SSF17>
            <SSF18>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF18"/>
                </xsl:attribute>
            </SSF18>
            <SSF19>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF19"/>
                </xsl:attribute>
            </SSF19>
            <SSF20>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF20"/>
                </xsl:attribute>
            </SSF20>
            <SSF21>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF21"/>
                </xsl:attribute>
            </SSF21>
            <SSF22>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF22"/>
                </xsl:attribute>
            </SSF22>
            <SSF23>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF23"/>
                </xsl:attribute>
            </SSF23>
            <SSF24>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF24"/>
                </xsl:attribute>
            </SSF24>
            <SSF25>
                <xsl:attribute name="code">
                    <xsl:call-template name="SSF25"/>
                </xsl:attribute>
            </SSF25>-->
        </breast>
    </xsl:template>
    <!--  -->
    <xsl:template name="site">
        <xsl:variable name="site">
            <xsl:value-of select="distinct-values(&sites;)"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="count($site) eq 1">
                <xsl:choose>
                    <xsl:when test="$site eq 'nipple'">
                        <xsl:text>C50.0</xsl:text>
                    </xsl:when>
                    <xsl:when test="$site eq 'central'">
                        <xsl:text>C50.1</xsl:text>
                    </xsl:when>
                    <xsl:when test="$site eq 'upper inner quadrant'">
                        <xsl:text>C50.2</xsl:text>
                    </xsl:when>
                    <xsl:when test="$site eq 'lower inner quadrant'">
                        <xsl:text>C50.3</xsl:text>
                    </xsl:when>
                    <xsl:when test="$site eq 'upper outer quadrant'">
                        <xsl:text>C50.4</xsl:text>
                    </xsl:when>
                    <xsl:when test="$site eq 'lower outer quadrant'">
                        <xsl:text>C50.5</xsl:text>
                    </xsl:when>
                    <xsl:when test="$site eq 'axillary tail'">
                        <xsl:text>C50.6</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>C50.9</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>C50.8</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  -->
    <xsl:template name="tumorSize">
        <xsl:variable name="tumorSize">
            <xsl:for-each select="&tumorSizes;">
                <xsl:sequence select="e:to-mm(@value,@unit,@relation)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="result" select="concat('000',min((xs:integer(max(tokenize($tumorSize,' '))),989)))"/>
        <xsl:value-of select="substring($result,string-length($result)-2)"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="extension">
        <xsl:variable name="T" select="&T-stage;"/>
        <xsl:choose>
            <xsl:when test="$T eq 'is'">
                <xsl:text>000</xsl:text>
            </xsl:when>
            <xsl:when test="$T eq 'is (Paget)'">
                <xsl:text>070</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($T,'1')">
                <xsl:text>170</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($T,'2')">
                <xsl:text>180</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($T,'3')">
                <xsl:text>190</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($T,'4')">
                <xsl:text>380</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>999</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  -->
    <xsl:template name="tumorSizeExtentEval">
        <xsl:text>3</xsl:text>
    </xsl:template>
    <!--  -->
    <xsl:template name="lymphNodes">
        <xsl:variable name="N">
            <xsl:value-of select="&N-stage;"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$N eq '0'">
                <xsl:text>000</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '0(i+)'">
                <xsl:text>050</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($N,'0')">
                <xsl:text>000</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '1mi'">
                <xsl:text>130</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '1'">
                <xsl:text>260</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '1a'">
                <xsl:text>260</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '1b'">
                <xsl:text>710</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '1c'">
                <xsl:text>710</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($N,'1')">
                <xsl:text>260</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '2'">
                <xsl:text>300</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '2a'">
                <xsl:text>300</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '2b'">
                <xsl:text>740</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '2c'">
                <xsl:text>300</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '3'">
                <xsl:text>790</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '3a'">
                <xsl:text>750</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '3b'">
                <xsl:text>760</xsl:text>
            </xsl:when>
            <xsl:when test="$N eq '3c'">
                <xsl:text>800</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>999</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- -->
    <xsl:template name="lymphNodesEval">
        <xsl:text>2</xsl:text>
    </xsl:template>
    <!-- -->
    <xsl:template name="regLNPos">
        <xsl:variable name="pnodes">
            <xsl:value-of select="sum(&posNodes;)"/>
        </xsl:variable>
        <xsl:value-of
            select="if ($pnodes castable as xs:integer) then e:string-end(concat('0',min(($pnodes,90))),2) else '97'"/>
    </xsl:template>
    <!-- -->
    <xsl:template name="regLNExam">
        <xsl:variable name="enodes">
            <xsl:value-of select="sum(&examNodes;)"/>
        </xsl:variable>
        <xsl:value-of
            select="if ($enodes castable as xs:integer) then e:string-end(concat('0',min(($enodes,90))),2) else '98'"/>
    </xsl:template>
    <!-- -->
    <xsl:template name="metsAtDx">
        <xsl:variable name="mets">
            <xsl:value-of select="&mets;"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$mets eq 'positive'">
                <xsl:text>60</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>00</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- -->
    <xsl:template name="metsEval">
        <xsl:variable name="metsEval">
            <xsl:value-of select="&metsEval;"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="'this specimen' = $metsEval">
                <xsl:text>3</xsl:text>
            </xsl:when>
            <xsl:when test="'outside report' = $metsEval">
                <xsl:text>3</xsl:text>
            </xsl:when>
            <xsl:when test="'prior accession' = $metsEval">
                <xsl:text>3</xsl:text>
            </xsl:when>
            <xsl:when test="'clinical history' = $metsEval">
                <xsl:text>0</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>99</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF1">
        <xsl:variable name="ssf">
            <xsl:value-of select="&SSF1;"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$ssf eq 'pending'">
                <xsl:text>080</xsl:text>
            </xsl:when>
            <xsl:when test="$ssf castable as xs:decimal">
                <xsl:value-of select="if (xs:decimal($ssf) ge 1) then '010' else '020'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>99</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF2">
        <xsl:variable name="ssf">
            <xsl:value-of select="&SSF2;"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$ssf eq 'pending'">
                <xsl:text>080</xsl:text>
            </xsl:when>
            <xsl:when test="$ssf castable as xs:decimal">
                <xsl:value-of select="if (xs:decimal($ssf) ge 1) then '010' else '020'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>99</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF3">
        <xsl:variable name="ssf">
            <xsl:value-of select="sum(&SSF3;)"/>
        </xsl:variable>
        <xsl:value-of
            select="if (&SSF3; castable as xs:integer) then e:string-end(concat('000',min(($ssf,90))),3) else '099'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF4">
       <!-- <xsl:variable name="ssf">
            <xsl:value-of select="&SSF4;[e:response[@value castable as xs:integer]]"/>
        </xsl:variable>
        <xsl:value-of select="if ($ssf[@type eq 'isolated tumor cells'][@value gt 0]) then '002' else '000'"/>-->
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF5">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF6">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF7">
        <xsl:variable name="ssf">
            <xsl:value-of select="xs:integer(sum(&SSF7;))"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="xs:integer($ssf) eq 3">
                <xsl:text>030</xsl:text>
            </xsl:when>
            <xsl:when test="xs:integer($ssf) eq 4">
                <xsl:text>040</xsl:text>
            </xsl:when>
            <xsl:when test="xs:integer($ssf) eq 5">
                <xsl:text>050</xsl:text>
            </xsl:when>
            <xsl:when test="xs:integer($ssf) eq 6">
                <xsl:text>060</xsl:text>
            </xsl:when>
            <xsl:when test="xs:integer($ssf) eq 7">
                <xsl:text>070</xsl:text>
            </xsl:when>
            <xsl:when test="xs:integer($ssf) eq 8">
                <xsl:text>080</xsl:text>
            </xsl:when>
            <xsl:when test="xs:integer($ssf) eq 9">
                <xsl:text>090</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF8">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF9">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'999'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF10">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'997'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF11">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF12">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF13">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF14">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF15">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF16">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF17">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF18">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF19">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF20">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF21">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'988'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF22">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'999'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF23">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'999'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF24">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'000'"/>
    </xsl:template>
    <!--  -->
    <xsl:template name="SSF25">
        <xsl:variable name="ssf">
            <xsl:value-of select="'xyz'"/>
        </xsl:variable>
        <xsl:value-of select="'988'"/>
    </xsl:template>
    <!--  -->
</xsl:stylesheet>
