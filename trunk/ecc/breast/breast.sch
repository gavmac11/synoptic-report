<?xml version="1.0" encoding="UTF-8"?>
<!--    
    ===========================================================================
    Copyright 2010 Pathology Consulting Services
    
    This file is part of the "PCS Schema for Synoptic Cancer Reports".
    
    The "PCS Schema for Synoptic Cancer Reports" is licensed under the Apache 
    License, Version 2.0 (the "License"); you may not use this file except in 
    compliance with the License.
    
    You may obtain a copy of the License at:
    
    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software 
    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    
    See the License for the specific language governing permissions and
    limitations under the License.
    ===========================================================================  
-->
<!-- rules

	1. procedure must match procedure modifier
	2. histologic grade must match component scores
	3. calculated T
	4. technique only allowed for sentinel nodes

-->
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0" xmlns:data="http://purl.org/pathology/ecc/rules/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <p>Schema for constraining CAP/PERT compliant XML breast cancer resection documents.</p>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="grddl" uri="http://www.w3.org/2003/g/data-view#"/>
    <ns prefix="f" uri="http://purl.org/pathology/ecc/functions/"/>
    <ns prefix="data" uri="http://purl.org/pathology/ecc/rules/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="report" value="true()"/>
    <let name="positive" value="'positive'"/>
    <let name="negative" value="'negative'"/>
    <let name="indeterminate" value="'indeterminate'"/>
    <let name="inapplicable" value="'inapplicable'"/>
    <let name="unreported" value="'unreported'"/>
    <let name="iiu" value="$indeterminate,$inapplicable,$unreported"/>
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
    <let name="sentinel" value="'sentinel'"/>
    <let name="chestWall" value="'chest wall'"/>
    <let name="eic" value="'extensive intraductal component'"/>
    <let name="noReport" value="('inapplicable','unreported')"/>
    <let name="specify" value="'specify'"/>
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
    <!--<pattern id="node-numbers-add-up">
        <p>Note that the sum function returns 0 in the case of an empty input
            sequence.</p>
        <rule context="ecc:nodeGroup/ecc:status">
            <!-\-  -\->
            <let name="cnt" value="ecc:result"/>
            <let name="tot"
                value="sum($cnt[@type eq $total]/ecc:response/@value[f:int(.)])"/>
            <let name="neg" value="$cnt[@type eq $negative]"/>
            <let name="nen"
                value="sum($neg[empty(@subtype)]/ecc:response/@value[f:int(.)])"/>
            <let name="mon"
                value="sum($neg[@subtype eq $rtpcrNegative]/ecc:response/@value[f:int(.)])"/>
            <let name="mop"
                value="sum($neg[@subtype eq $rtpcrPositive]/ecc:response/@value[f:int(.)])"/>
            <let name="reg"
                value="sum($neg[@subtype eq $necroinflammatory]/ecc:response/@value[f:int(.)])"/>
            <let name="itc"
                value="sum($neg[@subtype eq $isolatedTumorCells]/ecc:response/@value[f:int(.)])"/>
            <let name="pos" value="$cnt[@type eq $positive]"/>
            <let name="mic"
                value="sum($pos[@subtype eq $micrometastasis]/ecc:response/@value[f:int(.)])"/>
            <let name="mac"
                value="sum($pos[empty(@subtype)]/ecc:response/@value[f:int(.)])"/>
            <let name="sum"
                value="$nen + $mon + $mop + $reg + $itc + $mic + $mac"/>
            <!-\-  -\->
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
        </rule>
    </pattern>-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="eic-in-positive-dcis-only">
        <rule context="//ecc:accessory/ecc:lobularCarcinoma-in-situ/ecc:status/ecc:response">
            <report test="@type">
                The "type" attribute is permitted only for ductal carcinoma-in-situ status.
            </report>
        </rule>
        <rule context="//ecc:accessory/ecc:ductalCarcinoma-in-situ/ecc:status/ecc:response">
            <assert test="if (@type eq $eic) then @value eq $positive else $skip ">
                Extensive intraductal component requires DCIS to be "positive'.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern abstract="true" id="subset-rule">
        <rule context="$where" role="warning">
            <!-- COPY THIS ABSTRACT RULE INTO SITE-SPECIFIC SCHEMAS AND INSTANTIATE IT THERE   -->
            <!-- ===== Parameters =====                                                        -->
            <!-- context:      context node for invoking the rule                              -->
            <!-- subset:       candidate subset                                                -->
            <!-- superset:     allowed superset                                                -->
            <!-- explode:      @for tag value of <data:explosions root element                 -->
            <!-- subName:      description of the subset as plural noun (for error message)    -->
            <!-- superName:    description of the superset as plural noun (for error message)  -->
            <let name="explosions"
                value="document('')//data:explosions[xs:string(@for) eq xs:string($explode)]/data:explosion"/>
            <let name="r" value="for $x in $explosions return if ($x/@of = $superset) then $x/data:value else ()"/>
            <assert test="empty(for $x in distinct-values($subset) return if ($x = ($superset, $r, $noReport, $specify)) then () else $x)">
                Warning: One or more <value-of select="$subName"/> may not be represented among the <value-of select="$superName"/>.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="tumorSite-subsets-specimenSite" is-a="subset-rule">
        <param name="where" value="//ecc:tumor/ecc:focus"/>
        <param name="subset" value="ecc:site/ecc:response/@value"/>
        <param name="superset" value="//ecc:specimen/ecc:site/ecc:response/@value"/>
        <param name="explode" value="'site'"/>
        <param name="subName" value="'tumor sites'"/>
        <param name="superName" value="'specimen sites'"/>
        <data:explosions for="site">
            <data:explosion of="total breast">
                <data:value>upper outer quadrant</data:value>
                <data:value>lower outer quadrant</data:value>
                <data:value>upper inner quadrant</data:value>
                <data:value>upper outer quadrant</data:value>
                <data:value>nipple</data:value>
                <data:value>central</data:value>
                <data:value>1:00</data:value>
                <data:value>2:00</data:value>
                <data:value>3:00</data:value>
                <data:value>4:00</data:value>
                <data:value>5:00</data:value>
                <data:value>6:00</data:value>
                <data:value>7:00</data:value>
                <data:value>8:00</data:value>
                <data:value>9:00</data:value>
                <data:value>10:00</data:value>
                <data:value>11:00</data:value>
                <data:value>12:00</data:value>
            </data:explosion>
            <data:explosion of="upper outer quadrant">
                <data:value>9:00</data:value>
                <data:value>10:00</data:value>
                <data:value>11:00</data:value>
                <data:value>12:00</data:value>
                <data:value>1:00</data:value>
                <data:value>2:00</data:value>
                <data:value>3:00</data:value>
            </data:explosion>
            <data:explosion of="lower outer quadrant">
                <data:value>3:00</data:value>
                <data:value>4:00</data:value>
                <data:value>5:00</data:value>
                <data:value>6:00</data:value>
                <data:value>7:00</data:value>
                <data:value>8:00</data:value>
                <data:value>9:00</data:value>
            </data:explosion>
            <data:explosion of="upper inner quadrant">
                <data:value>9:00</data:value>
                <data:value>10:00</data:value>
                <data:value>11:00</data:value>
                <data:value>12:00</data:value>
                <data:value>1:00</data:value>
                <data:value>2:00</data:value>
                <data:value>3:00</data:value>
            </data:explosion>
            <data:explosion of="lower inner quadrant">
                <data:value>3:00</data:value>
                <data:value>4:00</data:value>
                <data:value>5:00</data:value>
                <data:value>6:00</data:value>
                <data:value>7:00</data:value>
                <data:value>8:00</data:value>
                <data:value>9:00</data:value>
            </data:explosion>
        </data:explosions>
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
    <pattern id="calculate-N-stage">
        <rule context="ecc:pN" subject="@value">
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="grp" value="//ecc:nodes/ecc:status"/>
            <let name="tot" value="sum($grp/ecc:result[@for eq $total]/ecc:response/@value[f:int(.)])"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="sc" value="$grp[@of eq $supraclavicular]"/>
            <let name="ic" value="$grp[@of = ($infraclavicular,$highAxillary)]"/>
            <let name="im" value="$grp[@of eq $internalMammary]"/>
            <let name="ax" value="$grp[@of = ($lowAxillary,$midAxillary,$highAxillary,$sentinel,$iiu)]"/>
            <!-- Sum function is useful here even though the input sequence is normally a singleton, because it
                 defaults to 0 when the input sequence is empty, whereas xs:integer() cast throws error. -->
            <let name="sc-pos" value="sum($sc/ecc:result[@for eq $positive]/ecc:response/@value[f:int(.)])"/>
            <let name="ic-pos" value="sum($ic/ecc:result[@for eq $positive]/ecc:response/@value[f:int(.)])"/>
            <let name="im-pos" value="sum($im/ecc:result[@for eq $positive]/ecc:response/@value[f:int(.)])"/>
            <let name="ax-pos" value="sum($ax/ecc:result[@for eq $positive]/ecc:response/@value[f:int(.)])"/>
            <let name="ax-mac" value="sum($ax/ecc:result[@for eq $positive]/ecc:response/@value[f:int(.)])"/>
            <!--  -->
            <let name="micro"
                value="sum($grp/ecc:result[@for eq $positive][@type eq $micrometastasis]/ecc:response/@value[f:int(.)])"/>
            <!--  -->
            <let name="im-mic"
                value="sum($im/ecc:result[@for eq $positive][@type eq $micrometastasis]/ecc:response/@value[f:int(.)])"/>
            <let name="im-mac"
                value="sum($im/ecc:result[@for eq $positive][empty(@type)]/ecc:response/@value[f:int(.)])"/>
            <let name="itc"
                value="sum($grp/ecc:result[@for eq $negative][@type eq $isolatedTumorCells]/ecc:response/@value[f:int(.)])"/>
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
                else if ($dim gt 0)        then '1mi'
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
            <let name="N1mi" value="$N eq 'N1mi'"/>
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
                if ($N1 or $N1mi)       then 'IIIA'
                else if ($N0)           then 'IIB'
                                        else $indeterminate
            else if ($T2)           then
                if ($N1 or $N1mi)       then 'IIB'
                else if ($N0)           then 'IIA'
                else                    $indeterminate
            else if ($T1)           then
                if ($N1)                then 'IIB'
                else if ($N1mi)         then 'IB'
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
        <rule context="//ecc:pM/ecc:response">
            <let name="M-reported" value="@value"/>
            <let name="report" value="exists(//ecc:distant)"/>
            <let name="distant-pos" value="//ecc:distant/ecc:status/ecc:result/ecc:response[@value eq $positive]"/>
            <let name="M-calculated"
                value="if ($report) then 
                if ($distant-pos) then '1' 
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
        <rule context="ecc:nodes/ecc:nodeGroup/ecc:result/ecc:positive|ecc:nodes/ecc:nodeGroup/ecc:result/ecc:total">
            <assert test="not(@type = $list)">
                A type of "<value-of select="@type"/>" is possible only in the case of negative nodes."/>
            </assert>
        </rule>
    </pattern>
</schema>
