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
    Copyright 2009 College of American Pathologists (CAP)
    
    This file is part of the "CAP Schema for Synoptic Cancer Reports".
    
    The "CAP Schema for Synoptic Cancer Reports" is licensed under the 
    Apache License, Version 2.0 (the "License"); you may not use this 
    file except in compliance with the License.
    
    You may obtain a copy of the License at
    
    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    ===========================================================================
    
-->
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron">
    <title>Validation rules for colon resection instances</title>
    <p>Instance must conform to resection@colon.rng.</p>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="colon" uri="http://www.cap.org/pert/2009/01/colon/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="therapy-description-not-allowed">
        <title>
            Prior therapy iff Description of prior therapy
        </title>
        <p>
            If prior therapy was given (hasPriorTherapy = true(), then it must 
            be described (exists(@description); if a prior therapy is described, 
            then it must have been given.
        </p>
        <rule context="//hasPriorTherapy">
            <assert test="@value &gt;= count(@description)">
                In <name/>, prior therapy description must be present if and only if prior therapy was performed.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="total-nodes-must-be-specified-for-each-nodeGroup">
        <rule context="//pert:nodeGroup">
            <assert test="exists(pert:nodeStatus[@value = 'total'])">
                At a minimum, the total number of nodes in every group must be specified (missing for "<value-of select="@location"/>").
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//*">
            <assert test="if (@value = 'other') then exists(@otherValue) else not(exists(@otherValue))">
                In <name/>, a value of 'other" requires a specified 'otherValue', and vice versa.
            </assert>
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
            <assert test="$regressed le $total">
                Nodes positive for regressed tumor (<value-of select="$regressed"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$pos le $total"> 
                Nodes positive (<value-of select="$pos"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$regressed + $pos le $total"> 
                Sum (<value-of select="$regressed + $pos"/>) of nodes with regressed tumor
                    (<value-of select="$regressed"/>) and positive (<value-of select="$pos"/>) must not exceed total nodes
                    (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="mucinous-percentage-only-if-present">
        <rule context="//colon:mucinousComponent">
            <assert test="if (@value ne 'positive') then empty (@percentage) else $skip"> 
                Mucinous component must be positive to specify a percentage. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-site-matches-procedure">
        <rule context="//pert:site">
            <let name="proc" value="//pert:procedure/@value"/>
            <assert test="                                  
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
                else $skip    "> 
                Specimen site "<value-of select="@value"/>" must match a corresponding procedure. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-tumor-site-subsets-specimen-site">
        <rule context="//pert:tumorLocation">
            <assert test="@value = //pert:site/@value"> 
                The tumor site "<value-of select="@value"/>" must be among the sites comprising specimen. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-calculate-N-stage">
        <rule context="//pert:N">
            <let name="posNodes"
                value="sum(pert:nodeStatus[@value='positive']/@count) cast as xs:integer"/>
            <let name="reported-N" value="@value"/>
            <let name="calculated-N"
                value="if ($posNodes eq 0) then '0' else if ($posNodes lt 4) then '1' else '2'"/>
            <assert test="$reported-N eq $calculated-N"> 
                Reported N-stage (<value-of select="$reported-N"/>) does not match calculated (<value-of select="$calculated-N"/>). 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-calculate-T-stage">
        <rule context="//pert:T">
            <let name="depth"
                value="//colon:deepestInvasion/@value cast as xs:string"/>
            <let name="reported-T" value="@value cast as xs:string"/>
            <let name="adjacent" value="$depth = 'adjacent structure'"/>
            <let name="serosal" value="$depth = 'serosal surface'"/>
            <let name="pericolic" value="$depth = 'periolic tissue'"/>
            <let name="subserosa" value="$depth = 'subserosa'"/>
            <let name="muscularis" value="$depth = 'muscularis propria'"/>
            <let name="submucosa" value="$depth = 'subserosa'"/>
            <let name="lp" value="$depth = 'lamina propria'"/>
            <let name="iec" value="$depth = 'intraepithelial carcinoma'"/>
            <let name="net" value="$depth = 'no evidence of tumor'"/>
            <let name="calculated-T"
                value="
                     if ($adjacent)   then '4'                   
                else if ($serosal)    then '3'                  
                else if ($pericolic)  then '3'                  
                else if ($subserosa)  then '3'
                else if ($muscularis) then '2'                  
                else if ($submucosa)  then '1'                  
                else if ($lp)         then 'is'                  
                else if ($iec)        then 'is'                  
                else if ($net)        then '0'    
                else                       'X'"/>
            <assert test="$reported-T eq $calculated-T">
                Reported T-stage (T<value-of select="$reported-T"/>) does not match calculated (T<value-of select="$calculated-T"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="adjacent-structure-involvement">
        <rule context="//pert:invasion">
            <assert test="if (colon:deepestInvasion/@value eq 'adjacent structure') then colon:adjacentStructure else $skip">
                Deepest invasion of adjacent structure(s) requires specifying which structure(s) and extent. 
            </assert>
            <assert test="if (colon:adjacentStructure) then colon:deepestInvasion eq 'adjacent structure' else $skip"> Adjacent
                structure(s) must be specified only if deepest invasion is of adjacent structure. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"> 
                If reporting tumor treatment effect, you must also specify prior therapy in the clinical section. 
            </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))"> 
                Treatment effect must be noted in the stage descriptor using the 'y' prefix. 
            </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin[@closest = 'true']"/>
            <let name="closestLocation" value="$closest/@location"/>
            <assert test="if (exists($status) and $status = 'positive') then not(exists($closest)) else $skip"> 
                Closest margin is not reportable if any margin is frankly positive. 
            </assert>
            <assert test="if (exists($status) and not($status = 'positive')) then exists($closest) else $skip"> 
                "Closest margin" must be reported if all margins are negative. 
            </assert>
            <assert test="if (exists($closest)) then $closest/@status = 'negative' else $skip"> 
                Closest margin must be negative margin. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:M">
            <let name="met" value="exists(//pert:metastasis)"/>
            <let name="report" value="exists(//pert:metastases)"/>
            <let name="calculated-M"
                value="if ($report) then if ($met) then '1' else '0' else 'X'"/>
            <let name="reported-M" value="//pert:M"/>
            <assert test="$reported-M eq $calculated-M"> 
                Reported M-stage (M<value-of select="$reported-M"/>) does not match calculated (M<value-of select="$calculated-M"/>). 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:specimen">
            <!-- check and make sure that this works now that multiple procedures are possible, i.e. ANY polypectomy gives rhs a value of true -->
            <assert test="exists(colon:polyp) = (procedure/@value eq 'polypectomy')"> Polyp is reportable in the
                specimen section if and only if the procedure is polypectomy. </assert>
        </rule>
    </pattern>
</schema>
