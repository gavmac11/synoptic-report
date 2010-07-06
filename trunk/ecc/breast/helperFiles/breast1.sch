<?xml version="1.0" encoding="UTF-8"?>
<!--
    
    Schema for Synoptic Reports
    (c) Copyright 2010 Pathology Consulting Services
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
    This file is part of the "PCS Schema for Synoptic Reports".
    
    The "PCS Schema for Synoptic Reports" is free software: 
    you can redistribute it and/or modify it under the terms of the 
    GNU General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or (at your option) any later version.
    
    The "PCS Schema for Synoptic Reports" is distributed 
    in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
    without even the implied warranty of MERCHANTABILITY or 
    FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
    for more details.
    
    You should have received a copy of the GNU General Public License
    along with the "PCS Schema for Synoptic Reports".  
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
    <ns prefix="pert" uri="http://cap#"/>
    <p>Schema for constraining CAP/PERT compliant XML breast cancer resection documents.</p>
    <ns prefix="breast" uri="http://www.cap.org/pert/2009/01/breast/"/>
    <ns prefix="grddl" uri="http://www.w3.org/2003/g/data-view#"/>
    <let name="skip" value="true()"/>
    <let name="report" value="true()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This sets the prefix "ecc' to the pert namespace.</p>
    <ns prefix="ecc" uri="http://cap#"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:integer" name="ecc:int">
        <xsl:param name="value"/>
        <xsl:value-of select="if ($value castable as xs:integer) then xs:integer($value) else 0"/>
    </xsl:function>
    <pattern id="node-numbers-add-up">
        <rule context="//pert:section[@name='node group']">
            <!--  -->
            <let name="cnt" value="pert:item[@name='count']"/>
            <let name="tot" value="ecc:int($cnt[@modifier='total']/pert:response/@value)"/>
            <let name="neg" value="ecc:int($cnt[@modifier='negative'][empty(@qualifier)]/pert:response/@value)"/>
            <let name="mon"
                value="ecc:int($cnt[@modifier='negative'][@qualifier='RT-PCR negative']/pert:response/@value)"/>
            <let name="mop"
                value="ecc:int($cnt[@modifier='negative'][@qualifier='RT-PCR positive']/pert:response/@value)"/>
            <let name="reg"
                value="ecc:int($cnt[@modifier='negative'][@qualifier='necroinflammatory']/pert:response/@value)"/>
            <let name="itc"
                value="ecc:int($cnt[@modifier='negative'][@qualifier='isolated tumor cells']/pert:response/@value)"/>
            <let name="mic"
                value="ecc:int($cnt[@modifier='positive'][@qualifier='micrometastases']/pert:response/@value)"/>
            <let name="pos" value="ecc:int($cnt[@modifier='positive'][empty(@qualifier)]/pert:response/@value)"/>
            <let name="sum" value="$neg + $mon + $mop + $reg + $itc + $mic + $pos"/>
            <!--  -->
            <assert test="$reg le $tot">Nodes positive for regressed tumor (<value-of select="$reg"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.</assert>
            <assert test="$itc le $tot">Nodes positive for isolated tumor cells (<value-of select="$itc"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.</assert>
            <assert test="$mic le $tot">Nodes positive for micrometastasis (<value-of select="$mic"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.</assert>
            <assert test="$pos le $tot">Nodes positive for macrometastasis (<value-of select="$pos"/>) must not exceed total nodes (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.</assert>
            <assert test="$sum le $tot">Sum of node counts (<value-of select="$sum"/>) must not specified node total (<value-of select="$tot"/>) in the "<value-of select="@location"/>" node group.</assert>
        </rule>
    </pattern>
    <!--
    <pattern id="site-matches-procedure">
        <rule context="//pert:site">
            <let name="proc" value="//pert:procedure/@value"/>
            <assert test="
                     if (not($proc = 'total mastectomy'))       then not(@value = ('entire breast'))                 
                else if ($proc = 'partial mastectomy')          then not(@value = ('entire breast')) 
                else                                            $skip    "> Specimen site "<value-of select="@value"/>" must match a
                corresponding procedure. </assert>
        </rule>
    </pattern>
-->
    <!--
    <pattern id="other-histologic-type">
        <rule context="//pert:histologicType">
            <assert test="if (@value eq 'other') then exists(@other-value) else not(exists(@other-value))"> If the histologic type is "other", then a value must be given
                in an "other-value" attribute. </assert>
        </rule>
    </pattern>
-->
    <!--
    <pattern id="tumor-site-subsets-specimen-site">
        <rule context="//pert:tumorLocation">
            <assert test="@value = //pert:site/@value or 'entire breast' = //pert:site/@value"> The tumor site "<value-of select="@value"/>" must be among the
                sites comprising the specimen. </assert>
        </rule>
    </pattern>
-->
    <pattern id="calculate-N-stage">
        <rule context="//pert:item[@name='pN']" subject="@value">
            <let name="grp" value="//pert:section[@name='node group']"/>
            <!--  -->
            <let name="sc" value="$grp[@location='supraclavicular']"/>
            <let name="ic" value="$grp[@location='infraraclavicular']"/>
            <let name="im" value="$grp[@location='internal mammary']"/>
            <let name="ax" value="$grp[@location=('low axillary','mid axillary','high axillary')]"/>
            <!--  -->
            <let name="sc-pos" value="sum($sc/pert:item[@name='count'][@modifier='positive']/pert:result/@value)"/>
            <let name="ic-pos" value="sum($ic/pert:item[@name='count'][@modifier='positive']/pert:result/@value)"/>
            <let name="im-pos" value="sum($im/pert:item[@name='count'][@modifier='positive']/pert:result/@value)"/>
            <let name="ax-pos" value="sum($ax/pert:item[@name='count'][@modifier='positive']/pert:result/@value)"/>
            <!--  -->
            <let name="micro" value="sum($grp/pert:item[@name='count'][@modifier='micrometastasis']/pert:result/@value)"/>
            <let name="im-mic" value="sum($im/pert:nodeStatus[@value = $mic]/@count)"/>
            <let name="itc" value="sum(//pert:nodeStatus[@value = 'isolated tumor cells']/@count)"/>
            <let name="reported-N" value="@value"/>
            <let name="calculated-N"
                value="
                     if ($sc-pos gt 0)                  then '3c'
                else if ($ax-pos gt 3 and $im-mac gt 0) then '3b'
                else if ($ax-pos gt 0 and $im-pos gt 0) then '3b'
                else if ($ic-pos gt 0)                  then '3a'
                else if ($ax-pos gt 9 and $ax-mac gt 0) then '3a'
                else if ($ax-pos eq 0 and $im-mac gt 0) then '2b'
                else if ($ax-pos gt 3 and $ax-mac gt 0) then '2a'
                else if ($ax-pos gt 0 and $im-mic gt 0) then '1c'
                else if ($im-pos gt 0)                  then '1b'
                else if ($ax-pos gt 0 and $ax-mac gt 0) then '1a'
                else if ($micro)                        then '1mi'
                else if ($itc)                          then '0'
                else                                         'X'    "/>
            <assert test="$reported-N eq $calculated-N"> Reported N-stage
                    (<value-of select="$reported-N"/>) does not match calculated
                    (<value-of select="$calculated-N"/>). </assert>
        </rule>
    </pattern>
    <pattern id="calculate-T-stage">
        <rule context="//pert:T" id="validate-T-stage">
            <let name="unit" value="//pert:tumorSize/@unit"/>
            <let name="size"
                value="if ($unit = 'cm') then xs:float(//pert:tumorSize/@dimension-1) else if ($unit = 'mm') then xs:float(//pert:tumorSize/@dimension-1) * 0.1 else 0.0"/>
            <let name="inflam"
                value="//breast:invasionFinding[@location = 'inflammatory carcinoma (clinical finding)']/@value = 'positive'"/>
            <let name="chwall"
                value="//breast:invasionFinding[@location = 'extension to chest wall']/@value = 'positive'"/>
            <let name="ulcer"
                value="//breast:invasionFinding[@location = 'extension to chest wall']/@value = 'positive'"/>
            <let name="edema" value="//breast:invasionFinding[@location = 'skin ulceration']/@value = 'positive'"/>
            <let name="sat" value="//breast:invasionFinding[@location = 'skin satellite nodules']/@value = 'positive'"/>
            <let name="skin" value="$edema or $ulcer or $sat"/>
            <let name="reported-T" value="@value cast as xs:string"/>
            <let name="calculated-T"
                value="              
                     if ($inflam)           then '4d'
                else if ($chwall and $skin) then '4c'
                else if ($skin)             then '4b'
                else if ($chwall)           then '4a'
                else if ($size gt 5.0)      then '3'
                else if ($size gt 2.0)      then '2'
                else if ($size gt 1.0)      then '1c'
                else if ($size gt 0.5)      then '1b'
                else if ($size gt 0.1)      then '1a'
                else if ($size gt 0.0)      then '1mic'
                else                             'X'    "/>
            <assert test="$reported-T eq $calculated-T"> Reported T-stage
                    (<value-of select="$reported-T"/>) does not match calculated
                    (<value-of select="$calculated-T"/>). </assert>
        </rule>
    </pattern>
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"> If reporting
                tumor treatment effect, you must also specify prior therapy in
                the clinical section. </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))"> Treatment effect must be noted in the stage descriptor using
                the 'y' prefix. </report>
        </rule>
    </pattern>
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins" flag="closest-margin-problem">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin/@closest"/>
            <assert test="count(pert:margin[@closest=true()]) le 1"> Only one
                margin can be the closest margin. </assert>
            <assert test="if ($closest) then not($status = ('focally positive', 'positive',
                'extensively positive')) else $skip"> No margin may be designated "closest margin" because at least
                one margin is positive. </assert>
            <assert test="if (not($status = ('focally positive', 'positive', 'extensively
                positive'))) then $closest else $skip"> One margin must be designated with status "closest margin"
                because all margins are negative. </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//pert:nodeStatus">
            <assert test="if (exists(pert:largestMet)) then @value = ('micrometastasis', 'macrometastasis') else $skip"> A largest metastasis is specified for a node group that does
                not have micro- or macrometastasis. </assert>
            <assert test="if (@value = ('micrometastasis', 'macrometastasis')) then exists(pert:largestMet) else $skip"> Micro- or macrometastasis is present in a node group for which
                largest metastasis is unspecified. </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//pert:M">
            <let name="M" value="@value"/>
            <let name="met" value="exists(//pert:metastasis)"/>
            <let name="report" value="exists(//pert:metastases)"/>
            <assert test="
                if ($report) then 
                if ($met) then $M = '1' 
                else $M = '0' 
                else $M = 'X'"> Reported M-stage (<value-of select="$M"/>) does not match
                calculated (<value-of select=" 
                    if ($report) then 
                        if ($met) then '1' 
                        else '0' 
                    else 'X'"/>). </assert>
        </rule>
    </pattern>
</schema>
