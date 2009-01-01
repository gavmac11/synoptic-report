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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0">
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <p>Schema for constraining CAP/PERT compliant XML breast cancer resection documents.</p>
    <ns prefix="breast" uri="http://www.cap.org/pert/2009/01/breast/"/>
    <ns prefix="grddl" uri="http://www.w3.org/2003/g/data-view#"/>
    <let name="skip" value="true()"/>
    <let name="report" value="true()"/>
    <pattern id="therapy-description-not-allowed">
        <rule context="//hasPriorTherapy" subject="@description @value">
            <assert test="@value ge count(@description)">
                Prior therapy description is forbidden because prior therapy value is not "true".
            </assert>
        </rule>
    </pattern>
    <pattern id="size-dimensions-in-decreasing-order">
        <rule context="//pert:tumorSize">
            <let name="d1" value="if (@dimension-1 castable as xs:float) then xs:float(@dimension-1) else 0.0"/>
            <let name="d2" value="if (@dimension-2 castable as xs:float) then xs:float(@dimension-2) else 0.0"/>
            <let name="d3" value="if (@dimension-3 castable as xs:float) then xs:float(@dimension-3) else 0.0"/>
            <assert test="$d1 ge $d2 and $d2 ge $d3"> 
                Tumor size dimensions must be in decreasing order. 
            </assert>
        </rule>
    </pattern>
    <pattern id="node-numbers-add-up">
        <rule context="//pert:nodeGroup">
            <let name="regressed"
                value="
                if (pert:nodeStatus[@value = 'regressed']/@count castable as xs:integer)
                then xs:integer(pert:nodeStatus[@value = 'regressed']/@count)
                else 0
            "/>
            <let name="itc"
                value="
                if (pert:nodeStatus[@value = 'isolated tumor cells']/@count castable as xs:integer)
                then xs:integer(pert:nodeStatus[@value = 'isolated tumor cells']/@count) 
                else 0
            "/>
            <let name="micrometastasis"
                value="
                if (pert:nodeStatus[@value = 'micrometastasis']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'micrometastasis']/@count) 
                else 0
            "/>
            <let name="macrometastasis"
                value="
                if (pert:nodeStatus[@value = 'macrometastasis']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'macrometastasis']/@count) 
                else 0
            "/>
            <let name="total"
                value="
                if (pert:nodeStatus[@value = 'total']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'total']/@count) 
                else -1
            "/>
            <assert test="$regressed le $total">
                Nodes positive for regressed tumor (<value-of select="$regressed"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$itc le $total">
                Nodes positive for isolated tumor cells (<value-of select="$itc"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$micrometastasis le $total">
                Nodes positive for micrometastasis (<value-of select="$micrometastasis"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$macrometastasis le $total">
                Nodes positive for macrometastasis (<value-of select="$macrometastasis"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$regressed + $itc + $micrometastasis + $macrometastasis le $total"> 
                Sum (<value-of select="$regressed + $itc + $micrometastasis + $macrometastasis"/>) of nodes with regressed tumor (<value-of select="$regressed"/>), isolated tumor cells (<value-of select="$itc"/>), micrometastasis (<value-of select="$micrometastasis"/>) and macrometastasis (<value-of select="$macrometastasis"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group.
            </assert>
        </rule>
    </pattern>
    <pattern id="site-matches-procedure">
        <rule context="//pert:site">
            <let name="proc" value="//pert:procedure/@value"/>
            <assert test="
                     if (not($proc = 'total mastectomy'))       then not(@value = ('entire breast'))                 
                else if ($proc = 'partial mastectomy')          then not(@value = ('entire breast')) 
                else                                            $skip    "> 
                Specimen site "<value-of select="@value"/>" must match a corresponding procedure.
            </assert>
        </rule>
    </pattern>
    <pattern id="other-histologic-type">
        <rule context="//pert:histologicType">
            <assert test="if (@value eq 'other') then exists(@other-value) else not(exists(@other-value))"> 
                If the histologic type is "other", then a value must be given in an "other-value" attribute. 
            </assert>
        </rule>
    </pattern>
    <pattern id="tumor-site-subsets-specimen-site">
        <rule context="//pert:tumorLocation">
            <assert test="@value = //pert:site/@value or 'entire breast' = //pert:site/@value"> 
                The tumor site "<value-of select="@value"/>" must be among the sites comprising the specimen. 
            </assert>
        </rule>
    </pattern>
    <pattern id="calculate-N-stage">
        <rule context="//pert:N" subject="@value">
            <let name="sc" value="//pert:nodeGroup[@location = 'supraclavicular']"/>
            <let name="ic" value="//pert:nodeGroup[@location = 'infraraclavicular']"/>
            <let name="im" value="//pert:nodeGroup[@location = 'internal mammary']"/>
            <let name="pos" value="('micrometastasis', 'macrometastasis')"/>
            <let name="mac" value="'macrometastasis'"/>
            <let name="mic" value="'micrometastasis'"/>
            <let name="ax" value="//pert:nodeGroup[@location = ('low axillary', 'mid axillary', 'high axillary')]"/>
            <let name="sc-pos" value="sum($sc/pert:nodeStatus[@value = $pos]/@count)"/>
            <let name="ic-pos" value="sum($ic/pert:nodeStatus[@value = $pos]/@count)"/>
            <let name="im-pos" value="sum($im/pert:nodeStatus[@value = $pos]/@count)"/>
            <let name="ax-pos" value="sum($ax/pert:nodeStatus[@value = $pos]/@count)"/>
            <let name="im-mac" value="sum($im/pert:nodeStatus[@value = $mac]/@count)"/>
            <let name="ax-mac" value="sum($ax/pert:nodeStatus[@value = $mac]/@count)"/>
            <let name="mic" value="//pert:nodeStatus[@value = $mic]/@count"/>
            <let name="im-mic" value="sum($im/pert:nodeStatus[@value = $mic]/@count)"/>
            <let name="itc" value="//pert:nodeStatus[@value = 'isolated tumor cells']/@count"/>
            <let name="N" value="@value"/>
            <let name="N_" value="substring($N, 1, 1)"/>
            <assert test="
                if ($sc-pos gt 0)                  then $N eq '3c'
                else if ($ax-pos gt 3 and $im-mac gt 0) then $N eq '3b'
                else if ($ax-pos gt 0 and $im-pos gt 0) then $N eq '3b'
                else if ($ic-pos gt 0)                  then $N eq '3a'
                else if ($ax-pos gt 9 and $ax-mac gt 0) then $N eq '3a'
                else if ($ax-pos eq 0 and $im-mac gt 0) then $N eq '2b'
                else if ($ax-pos gt 3 and $ax-mac gt 0) then $N eq '2a'
                else if ($ax-pos gt 0 and $im-mic gt 0) then $N eq '1c'
                else if ($im-pos gt 0)                  then $N eq '1b'
                else if ($ax-pos gt 0 and $ax-mac gt 0) then $N eq '1a'
                else if ($mic)                          then $N eq '1mi'
                else if ($itc)                          then $N_ = '0'
                else                                         $N eq 'X'    "> 
                Reported N-stage (<value-of select="$N"/>) does not match calculated (<value-of select="
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
                    else if ($mic)                          then '1mi'
                    else if ($itc)                          then '0'
                    else                                         'X'    "/>).
            </assert>
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
            <let name="T" value="@value cast as xs:string"/>
            <assert test="
                     if ($inflam)           then $T eq '4d'
                else if ($chwall and $skin) then $T eq '4c'
                else if ($skin)             then $T eq '4b'
                else if ($chwall)           then $T eq '4a'
                else if ($size gt 5.0)      then $T eq '3'
                else if ($size gt 2.0)      then $T eq '2'
                else if ($size gt 1.0)      then $T eq '1c'
                else if ($size gt 0.5)      then $T eq '1b'
                else if ($size gt 0.1)      then $T eq '1a'
                else if ($size gt 0.0)      then $T eq '1mic'
                else                             $T eq 'X'    
            ">    
                Reported T-stage (<value-of select="$T"/>) does not match calculated (<value-of select="
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
                    else                             'X'    "/>).
            </assert>
        </rule>
    </pattern>
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"> If reporting tumor treatment
                effect, you must also specify prior therapy in the clinical section. </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))">
                Treatment effect must be noted in the stage descriptor using the 'y' prefix.
            </report>
        </rule>
    </pattern>
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins" flag="closest-margin-problem">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin/@closest"/>
            <assert test="count(pert:margin[@closest=true()]) le 1"> Only one margin can be the
                closest margin. </assert>
            <assert test="if ($closest) then not($status = ('focally positive', 'positive',
                'extensively positive')) else $skip"> No margin may be designated "closest margin" because at least one margin is
                positive. </assert>
            <assert test="if (not($status = ('focally positive', 'positive', 'extensively
                positive'))) then $closest else $skip"> One margin must be designated with status "closest margin" because all margins are
                negative. </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//pert:nodeStatus">
            <assert test="if (exists(pert:largestMet)) then @value = ('micrometastasis', 'macrometastasis') else $skip">
                A largest metastasis is specified for a node group that does not have micro- or macrometastasis.
            </assert>
            <assert test="if (@value = ('micrometastasis', 'macrometastasis')) then exists(pert:largestMet) else $skip">
                Micro- or macrometastasis is present in a node group for which largest metastasis is unspecified.
            </assert>
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
                else $M = 'X'">
                Reported M-stage (<value-of select="$M"/>) does not match calculated (<value-of select=" 
                    if ($report) then 
                        if ($met) then '1' 
                        else '0' 
                    else 'X'"/>).
            </assert>
        </rule>
    </pattern>
</schema>
