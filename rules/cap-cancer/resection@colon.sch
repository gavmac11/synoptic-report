<?xml version="1.0" encoding="UTF-8"?>
<!--
    
    CAP Schema for Synoptic Reports
    (c) Copyright 2008 College of American Pathologists
    ===========================================================================
    Component name:
    resection@colon.sch
    
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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="colon" uri="http://www.cap.org/pert/2009/01/colon/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="therapy-description-not-allowed">
        <rule context="//hasPriorTherapy">
            <assert test="@value &gt;= count(@description)"> Description is not allowed unless value is true. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="size-dimension-spositive">
        <rule context="//pert:size/pert:dimension">
            <let name="value" value="./@value > 0.0 or not(exists(.))"/>
            <assert test="$value"> Dimensions must be positive. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="total-nodes-must-be-specified-for-each-nodeGroup">
        <rule context="//pert:nodeGroup">
            <assert test="exists(pert:nodeStatus[@value = 'total'])"> At a minimum, the total number of nodes in every group must
                be specified (missing for "<value-of select="@location"/>"). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//*">
            <assert test="if (@value = 'other') then exists(@otherValue) else not(exists(@otherValue))"> In <name/>, a value of
                'other" requires a specified 'otherValue', and vice versa. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="node-numbers-add-up">
        <rule context="//pert:nodeGroup">
            <let name="regressed"
                value="
                if (pert:nodeStatus[@value = 'regressed']/@count castable as xs:integer)
                then xs:integer(pert:nodeStatus[@value = 'regressed']/@count)
                else 0
                "/>
            <let name="pos"
                value="
                if (pert:nodeStatus[@value = 'positive']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'positive']/@count) 
                else 0
                "/>
            <let name="total"
                value="
                if (pert:nodeStatus[@value = 'total']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'total']/@count) 
                else -1
                "/>
            <assert test="$regressed le $total"> Nodes positive for regressed tumor (<value-of select="$regressed"/>) must not
                exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. </assert>
            <assert test="$pos le $total"> Nodes positive (<value-of select="$pos"/>) must not exceed total nodes (<value-of
                    select="$total"/>) in the "<value-of select="@location"/>" lymph node group. </assert>
            <assert test="$regressed + $pos le $total"> Sum (<value-of select="$regressed + $pos"/>) of nodes with regressed tumor
                    (<value-of select="$regressed"/>) and positive (<value-of select="$pos"/>) must not exceed total nodes
                    (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="mucinous-percentage-only-if-present">
        <rule context="//colon:mucinousComponent">
            <assert test="if (@value ne 'positive') then empty (@percentage) else $skip"> Mucinous component must be positive to
                specify a percentage. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-site-matches-procedure">
        <rule context="//pert:site">
            <let name="proc" value="//pert:procedure/@value"/>
            <assert
                test="                                  
                if ($proc = 'right hemicolectomy')        
                    then @value = ('cecum', 'ascending colon', 'hepatic flexure', 'transverse colon')
                else if ($proc = 'transverse colectomy')       
                    then @value = ('hepatic flexure', 'transverse colon', 'splenic flexure')  
                else if ($proc = 'left hemicolectomy')         
                    then @value = ('splenic flexure', 'descending colon', 'sigmoid colon')                 
                else if ($proc = 'sigmoidectomy')              
                    then @value = ('descending colon', 'sigmoid colon', 'rectum')                 
                else if ($proc = 'low anterior resection')     
                    then @value = ('sigmoid colon', 'rectum', 'anus')                 
                else if ($proc = 'abdominoperineal resection') 
                    then @value = ('sigmoid colon', 'rectum', 'anus')                  
                else if ($proc = 'transanal disk excision')    
                    then @value = ('sigmoid colon', 'rectum', 'anus')
                else $skip    "
                > Specimen site "<value-of select="@value"/>" must match a corresponding procedure. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-tumor-site-subsets-specimen-site">
        <rule context="//pert:tumorLocation">
            <assert test="@value = //pert:site/@value"> The tumor site "<value-of select="@value"/>" must be among the sites
                comprising specimen. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-calculate-N-stage">
        <rule context="//pert:N">
            <let name="posNodes" value="sum(pert:nodeStatus[@value='positive']/@count) cast as
                xs:integer"/>
            <let name="N" value="@value cast as xs:integer"/>
            <assert
                test="
                     if ($posNodes eq 0) then $N eq 0 
                else if ($posNodes lt 4) then $N eq 1 
                else                          $N eq 2"
                > Reported N-stage (<value-of select="$N"/>) does not match calculated (<value-of
                    select="
                     if ($posNodes eq 0) then '0' 
                else if ($posNodes lt 4) then '1' 
                else                          '2'        "
                />). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-calculate-T-stage">
        <rule context="//pert:T">
            <let name="depth" value="//colon:deepestInvasion/@value cast as xs:string"/>
            <let name="T" value="@value cast as xs:string"/>
            <assert
                test="                             
                     if ($depth = 'adjacent structure')        then $T = '4'                   
                else if ($depth = 'serosal surface')           then $T = '3'                  
                else if ($depth = 'periolic tissue')           then $T = '3'                  
                else if ($depth = 'subserosa')                 then $T = '3'
                else if ($depth = 'muscularis propria')        then $T = '2'                  
                else if ($depth = 'submucosa')                 then $T = '1'                  
                else if ($depth = 'lamina propria')            then $T = 'is'                  
                else if ($depth = 'intraepithelial carcinoma') then $T = 'is'                  
                else if ($depth = 'no evidence of tumor')      then $T = '0'                  
                else                                                $T = 'X'    "
                > Reported T-stage (T<value-of select="$T"/>) does not match calculated (T<value-of
                    select="
                    if ($depth = 'adjacent structure')         then '4'                   
                else if ($depth = 'serosal surface')           then '3'                  
                else if ($depth = 'periolic tissue')           then '3'                  
                else if ($depth = 'subserosa')                 then '3'
                else if ($depth = 'muscularis propria')        then '2'                  
                else if ($depth = 'submucosa')                 then '1'                  
                else if ($depth = 'lamina propria')            then 'is'                  
                else if ($depth = 'intraepithelial carcinoma') then 'is'                  
                else if ($depth = 'no evidence of tumor')      then '0'    
                else                                                'X'    "
                />). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="adjacent-structure-involvement">
        <rule context="//pert:invasion">
            <assert test="if (colon:deepestInvasion/@value eq 'adjacent structure') then colon:adjacentStructure else $skip">
                Deepest invasion of adjacent structure(s) requires specifying which structure(s) and extent. </assert>
            <assert test="if (colon:adjacentStructure) then colon:deepestInvasion eq 'adjacent structure' else $skip"> Adjacent
                structure(s) must be specified only if deepest invasion is of adjacent structure. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"> If reporting tumor treatment effect, you must also specify
                prior therapy in the clinical section. </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))"> Treatment effect must be noted in
                the stage descriptor using the 'y' prefix. </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin[@closest = 'true']"/>
            <let name="closestLocation" value="$closest/@location"/>
            <assert test="if (exists($status) and $status = 'positive') then not(exists($closest)) else $skip"> Closest margin is
                not reportable if any margin is frankly positive. </assert>
            <assert test="if (exists($status) and not($status = 'positive')) then exists($closest) else $skip"> "Closest margin"
                must be reported if all margins are negative. </assert>
            <assert test="if (exists($closest)) then $closest/@status = 'negative' else $skip"> Closest margin must be negative
                margin. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:M">
            <let name="M" value="@value"/>
            <let name="met" value="exists(//pert:metastasis)"/>
            <let name="report" value="exists(//pert:metastases)"/>
            <assert
                test="
                if ($report) then 
                if ($met) then $M = '1' 
                else $M = '0' 
                else $M = 'X'"
                > Reported M-stage (M<value-of select="$M"/>) does not match calculated (M<value-of
                    select=" 
                    if ($report) then 
                        if ($met) then '1' 
                        else '0' 
                    else 'X'"
                />). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:specimen">
            <assert test="exists(colon:polyp) = (procedures/procedure/@value eq 'polypectomy')"> Polyp is reportable in the
                specimen section if and only if the procedure is polypectomy. </assert>
        </rule>
    </pattern>
</schema>
