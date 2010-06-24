<?xml version="1.0" encoding="UTF-8"?>
<!--
    
    CAP Schema for Synoptic Reports
    (c) Copyright 2008 College of American Pathologists
    ===========================================================================
    Component name:
    resection@breast.sch
    
    Component type:
    schematron schema for rules-based validation
    
    Version date:
    2008.12.31
    
    Defines:
    
    
    Purpose:
    
    
    
    Dependencies:      
    
    
    ===========================================================================
    This file is part of the "CAP Schema for Synoptic Reports".
    
    The "CAP Schema for Synoptic Reports" is free software: 
    you can redistribute it and/or modify it under the terms of the 
    GNU General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or (at your option) any later version.
    
    The "CAP Schema for Synoptic Reports" is distributed 
    in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
    without even the implied warranty of MERCHANTABILITY or 
    FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
    for more details.
    
    You should have received a copy of the GNU General Public License
    along with the "CAP Schema for Synoptic Reports".  
    If not, see <http://www.gnu.org/licenses/>. 
    ===========================================================================
    
-->
<!-- rules

	1. procedure must match procedure modifier
	2. histologic grade must match component scores
	3. calculated T
	4. technique only allowed for sentinel nodes

-->
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <p>Schema for constraining CAP/PERT compliant XML breast cancer resection documents.</p>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="breast" uri="http://www.cap.org/pert/2009/01/breast/"/>
    <ns prefix="grddl" uri="http://www.w3.org/2003/g/data-view#"/>
    <ns prefix="f" uri="http://purl.org/pathology/ecc/functions/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="report" value="true()"/>
    <let name="positive" value="'positive'"/>
    <let name="negative" value="'negative'"/>
    <let name="indeterminate" value="'indeterminate'"/>
    <let name="lessThan" value="'less than'"/>
    <let name="greaterThan" value="'greater than'"/>
    <let name="mm" value="'mm'"/>
    <let name="cm" value="'cm'"/>
    <let name="in" value="'in'"/>
    <let name="total" value="'total'"/>
    <let name="rtpcrPositive" value="'RT-PCR positive'"/>
    <let name="rtpcrNegative" value="'RT-PCR negative'"/>
    <let name="necroinflammatory" value="'necroinflammatory'"/>
    <let name="isolatedTumorCells" value="'isolated tumor cells'"/>
    <let name="micrometastasis" value="'micrometastasis'"/>
    <let name="totalMastectomy" value="'total mastectomy'"/>
    <let name="partialMastectomy" value="'partial mastectomy'"/>
    <let name="totalBreast" value="'total breast'"/>
    <let name="supraclavicular" value="'supraclavicular'"/>
    <let name="infraclavicular" value="'infraclavicular'"/>
    <let name="highAxillary" value="'high axillary'"/>
    <let name="internalMammary" value="'internal mammary'"/>
    <let name="lowAxillary" value="'low axillary'"/>
    <let name="midAxillary" value="'mid axillary'"/>
    <let name="chestWall" value="'chest wall'"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:boolean" name="f:int">
        <xsl:param name="input"/>
        <xsl:value-of select="$input castable as xs:integer"/>
    </xsl:function>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="node-numbers-add-up">
        <p>Note that the sum function returns 0 in the case of an empty input sequence.</p>
        <rule context="ecc:nodeGroup/ecc:tally">
            <!--  -->
            <let name="cnt" value="ecc:response"/>
            <let name="tot" value="sum($cnt[@type eq $total]/@value[f:int(.)])"/>
            <let name="neg" value="$cnt[@type eq $negative]"/>
            <let name="nen" value="sum($neg[empty(@qualifier)]/ecc:response/@value[f:int(.)])"/>
            <let name="mon" value="sum($neg[@qualifier eq $rtpcrNegative]/ecc:response/@value[f:int(.)])"/>
            <let name="mop" value="sum($neg[@qualifier eq $rtpcrPositive]/ecc:response/@value[f:int(.)])"/>
            <let name="reg" value="sum($neg[@qualifier eq $necroinflammatory]/ecc:response/@value[f:int(.)])"/>
            <let name="itc" value="sum($neg[@qualifier eq $isolatedTumorCells]/ecc:response/@value[f:int(.)])"/>
            <let name="pos" value="$cnt[@modifier eq $positive]"/>
            <let name="mic" value="sum($pos[@qualifier eq $micrometastasis]/ecc:response/@value[f:int(.)])"/>
            <let name="mac" value="sum($pos[empty(@qualifier)]/ecc:response/@value[f:int(.)])"/>
            <let name="sum" value="$nen + $mon + $mop + $reg + $itc + $mic + $mac"/>
            <!--  -->
            <assert test="$reg le $tot">
                Nodes positive for regressed tumor (<value-of select="$reg"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.
            </assert>
            <assert test="$itc le $tot">
                Nodes positive for isolated tumor cells (<value-of select="$itc"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.
            </assert>
            <assert test="$mic le $tot">
                Nodes positive for micrometastasis (<value-of select="$mic"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.
            </assert>
            <assert test="$mac le $tot">
                Nodes positive for macrometastasis (<value-of select="$mac"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.
            </assert>
            <assert test="$sum le $tot">
                Sum of nodes in all categories (<value-of select="$sum"/>) must not exceed stated node total (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="site-matches-procedure">
        <rule context="//ecc:specimen/ecc:site/ecc:response" role="warning">
            <let name="proc" value="//ecc:specimen/ecc:procedure/ecc:response/@value"/>
            <assert test="if (not($proc = $totalMastectomy)) then not(@value = $totalBreast) else $skip">
                The specimen is "total breast", so the expected procedure is "total mastectomy".
            </assert>
            <assert test="if ($proc = $partialMastectomy) then not(@value = $totalBreast) else $skip">
                The procedure is "partial mastectomy" so the specimen "total breast" is unexpected.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--
    <pattern id="tumor-site-subsets-specimen-site">
        <rule context="//ecc:tumorLocation">
            <assert test="@value = //ecc:site/@value or 'entire breast' = //ecc:site/@value">
                The tumor site "<value-of select="@value"/>" must be among the sites comprising the specimen. 
            </assert>
        </rule>
    </pattern>
    -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="node-subcategories-allowed">
        <rule context="ecc:margins/ecc:margin/ecc:tally/ecc:response">
            <!--  -->
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="ecc:pN" subject="@value">
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="grp" value="//ecc:nodeGroup"/>
            <let name="tot" value="sum($grp/ecc:tally/ecc:response[@type eq $total]/@value[f:int(.)])"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="sc" value="$grp[@name eq $supraclavicular]"/>
            <let name="ic" value="$grp[@name = ($infraclavicular,$highAxillary)]"/>
            <let name="im" value="$grp[@name eq $internalMammary]"/>
            <let name="ax" value="$grp[@name = ($lowAxillary,$midAxillary,$highAxillary)]"/>
            <!-- Sum function is useful here even though the input sequence is normally a singleton, because it
                 defaults to 0 when the input sequence is empty, whereas xs:integer() cast throws error. -->
            <let name="sc-pos" value="sum($sc/ecc:tally/ecc:response[@type eq $positive]/@value[f:int(.)])"/>
            <let name="ic-pos" value="sum($ic/ecc:tally/ecc:response[@type eq $positive]/@value[f:int(.)])"/>
            <let name="im-pos" value="sum($im/ecc:tally/ecc:response[@type eq $positive]/@value[f:int(.)])"/>
            <let name="ax-pos" value="sum($ax/ecc:tally/ecc:response[@type eq $positive]/@value[f:int(.)])"/>
            <let name="ax-mac" value="sum($ax/ecc:tally/ecc:response[@type eq $positive]/@value[f:int(.)])"/>
            <!--  -->
            <let name="micro"
                value="sum($grp/ecc:tally/ecc:response[@type eq $positive][@subtype eq $micrometastasis]/@value[f:int(.)])"/>
            <!--  -->
            <let name="im-mic"
                value="sum($im/ecc:tally/ecc:response[@type eq $positive][@subtype eq $micrometastasis]/@value[f:int(.)])"/>
            <let name="im-mac"
                value="sum($im/ecc:tally/ecc:response[@type eq $positive][empty(@subtype)]/@value[f:int(.)])"/>
            <let name="itc"
                value="sum($grp/ecc:tally/ecc:response[@type eq $negative][@subtype eq $isolatedTumorCells]/@value[f:int(.)])"/>
            <!--  -->
            <let name="reported-N" value="ecc:response/@value"/>
            <let name="calculated-N"
                value="
                     if ($sc-pos gt 0)                  then '3c'
                else if ($im-mac gt 0)                  then
                         if (ax-pos gt 3)               then '3b'
                    else if (ax-pos gt 0)               then '1c'
                    else                                     '1b'
                else if ($ic-pos gt 0)                  then '3a'
                else if ($ax-pos gt 9 and $ax-pos gt 0) then '3a'
                else if ($ax-pos eq 0 and $im-mac gt 0) then '2b'
                else if ($ax-pos gt 3 and $ax-mac gt 0) then '2a'
                else if ($ax-pos gt 0 and $im-mic gt 0) then '1c'
                else if ($im-pos gt 0)                  then '1b'
                else if ($ax-pos gt 0 and $ax-mac gt 0) then '1a'
                else if ($micro)                        then '1mi'
                else if ($itc)                          then '0(i+)'
                else if ($tot gt 0)                     then '0'
                else                                         'X'    "/>
            <assert test="$reported-N eq $calculated-N">
                Reported N-stage (<value-of select="$reported-N"/>) does not match calculated (<value-of select="$calculated-N"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-T-stage">
        <rule context="//ecc:pT" id="validate-T-stage">
            <!--  -->
            <let name="size" value="//ecc:tumor/ecc:focus/ecc:size/ecc:response"/>
            <let name="value" value="$size/@value"/>
            <let name="unit" value="$size/@unit"/>
            <let name="rel" value="$size/@relation"/>
            <let name="dim" value="max(for $n in 1 to count($value) return f:to-mm($value[$n],$unit[$n],$rel[$n]))"/>
            <!--  -->
            <let name="skin"
                value="//ecc:extent/(ecc:skinUlceration|ecc:skinEdema|ecc:skinSatelliteNodules)/ecc:response[@value eq $positive]"/>
            <let name="chest" value="//ecc:extent/ecc:underlyingStructures/ecc:response[@value eq $chestWall]"/>
            <let name="reported-T" value="ecc:response/@value cast as xs:string"/>
            <let name="calculated-T"
                value="              
                     if ($chest and $skin) then '4c'
                else if ($skin)            then '4b'
                else if ($chest)           then '4a'
                else if ($dim gt 50)       then '3'
                else if ($dim gt 20)       then '2'
                else if ($dim gt 10)       then '1c'
                else if ($dim gt 5)        then '1b'
                else if ($dim gt 1)        then '1a'
                else if ($dim gt 0)        then '1mic'
                else                            'X'    "/>
            <assert test="$reported-T eq $calculated-T">
                Reported T-stage (<value-of select="$reported-T"/>) does not match calculated (<value-of select="$calculated-T"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="stage">
        <rule context="//ecc:stage/ecc:group/ecc:response" id="validate-stage-group">
            <let name="T" value="//ecc:pT/ecc:response/@value"/>
            <let name="N" value="//ecc:pN/ecc:response/@value"/>
            <let name="M" value="//ecc:pM/ecc:response/@value"/>
            <let name="Tis" value="$T = ('is (Paget)','is (LCIS)','is (DCIS)','is')"/>
            <let name="T1" value="$T = ('1c','1b','1a','1mi','1')"/>
            <let name="T2" value="$T eq '2'"/>
            <let name="T3" value="$T eq '3'"/>
            <let name="T4" value="$T = ('4d','4c','4b','4a','4')"/>
            <let name="N0" value="$N = ('0(mol+)','0(mol-)','0(i+)','0(i-)','0')"/>
            <let name="N1mic" value="$N eq 'N1mic'"/>
            <let name="N1" value="$N = ('1c','1b','1a','1')"/>
            <let name="N2" value="$N = ('2b','2a','2')"/>
            <let name="N3" value="$N = ('3c','3b','3a','3')"/>
            <let name="M1" value="$M eq '1'"/>
            <let name="reported-group" value="@value"/>
            <let name="calculated-group"
                value="
            if ($M1)                then 'IV'
            else if ($N3)           then 'IIIC'
            else if ($T4)           then 'IIIB'
            else if ($N2)           then 'IIIA'
            else if ($T3)           then
                if ($N1 or $N1mic)      then 'IIIA'
                else if ($N0)           then 'IIB'
                                        else $indeterminate
            else if ($T2)           then
                if ($N1 or $N1mic)      then 'IIB'
                else if ($N0)           then 'IIA'
                else                    $indeterminate
            else if ($T1)           then
                if ($N1)                then 'IIB'
                else if ($N1mic)        then 'IB'
                else if ($N0)           then 'IA'
                                        else 'indeterminate'
            else if ($Tis)          then
                if ($N0)                then '0'
                else                    $indeterminate
                else                    $indeterminate"/>
            <assert test="$calculated-group eq $reported-group">
                Reported stage group (<value-of select="$reported-group"/>) does not match calculated (<value-of select="$calculated-group"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//ecc:M">
            <let name="M-reported" value="@value"/>
            <let name="met" value="exists(//ecc:distant)"/>
            <let name="report" value="exists(//ecc:metastases)"/>
            <let name="distant-pos" value="//ecc:distant/ecc:site/ecc:status/ecc:response[@value eq $positive]"/>
            <let name="M-calculated"
                value="if ($report) then 
                if ($met) then '1' 
                else '0' 
                else 'X'"/>
            <assert test="$M-reported eq $M-calculated">
                  Reported M-stage (<value-of select="$M-reported"/>) does not match calculated (<value-of select="$M-calculated"/>). 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="node-subtype-appropriate">
        <let name="list" value="($rtpcrNegative,$rtpcrPositive,$isolatedTumorCells)"/>
        <rule context="ecc:nodes/ecc:nodeGroup/ecc:tally/ecc:response">
            <assert test="if (@subtype = $list) then (@type = $negative) else $skip">
                A node subtype of "<value-of select="@subtype"/>" is possible only in the case of negative nodes.
            </assert>
        </rule>
    </pattern>
</schema>
