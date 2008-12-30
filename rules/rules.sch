<?xml version="1.0" encoding="UTF-8"?>
<schema defaultPhase="common" queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:iso="http://purl.oclc.org/dsdl/schematron">
    <include href="common.sch"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <phase id="common">
        <active pattern="therapy-description-not-allowed"/>
        <active pattern="size-dimensions-in-decreasing-order"/>
        <active pattern="node-numbers-add-up"/>
    </phase>
    <phase id="colon">
        <active pattern="therapy-description-not-allowed"/>
        <active pattern="size-dimensions-in-decreasing-order"/>
        <active pattern="node-numbers-add-up"/>
        <active pattern="mucinous-percentage-only-if-present"/>
        <active pattern="other-histologic-type"/>
        <active pattern="colon-site-matches-procedure"/>
        <active pattern="colon-tumor-site-subsets-specimen-site"/>
        <active pattern="colon-calculate-N-stage"/>
        <active pattern="colon-calculate-T-stage"/>
        <active pattern="adjacent-structure-involvement"/>
        <active pattern="report-closest-if-all-margins-negative"/>
        <active pattern="treatment-effect-implies-prior-therapy"/>
    </phase>
    <phase id="prostate">
        <active pattern="therapy-description-not-allowed"/>
        <active pattern="size-dimensions-in-decreasing-order"/>
        <active pattern="node-numbers-add-up"/>
        <active pattern="extraprostatic-specified-both-sides"/>
        <active pattern="seminal-vesicle-specified-both-sides"/>
        <active pattern="seminal-vesicle-extent-only-if-positive"/>
        <active pattern="calculate-overall-PTI"/>
        <active pattern="prostate-calculate-T-stage"/>
    </phase>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="therapy-description-not-allowed">
        <iso:rule context="//hasPriorTherapy">
            <iso:assert test="@value &gt;= count(@description)">
                Description is not allowed unless value is true.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="size-dimensions-in-decreasing-order">
        <iso:rule context="//pert:tumorSize">
            <iso:let name="d1" value="if (@dimension-1 castable as xs:float) then xs:float(@dimension-1) else 0.0"/>
            <iso:let name="d2" value="if (@dimension-2 castable as xs:float) then xs:float(@dimension-2) else 0.0"/>
            <iso:let name="d3" value="if (@dimension-3 castable as xs:float) then xs:float(@dimension-3) else 0.0"/>
            <iso:assert test="$d1 ge $d2 and $d2 ge $d3">
                Tumor size dimensions must be in decreasing order.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="node-numbers-add-up">
        <iso:rule context="//pert:nodeGroup">
            <iso:let name="positiveNodes"
                value="if (@positiveNodes castable as xs:integer) then xs:integer(@positiveNodes) else 0"/>
            <iso:let name="regressedNodes"
                value="if (@regressedNodes castable as xs:integer) then xs:integer(@regressedNodes) else 0"/>
            <iso:let name="totalNodes"
                value="if (@totalNodes castable as xs:integer) then xs:integer(@totalNodes) else -1"/>
            <iso:assert test="$positiveNodes le $totalNodes">
                Positive nodes must not exceed total nodes in the "<iso:value-of select="@location"/>" lymph node group.
            </iso:assert>
            <iso:assert test="$regressedNodes le $totalNodes">
                Regressed nodes must not exceed total nodes in the "<iso:value-of select="@location"/>" lymph node group.
            </iso:assert>
            <iso:assert test="$regressedNodes + $positiveNodes le $totalNodes">
                Positive plus regressed nodes must not exceed total nodes in the "<iso:value-of select="@location"/>" lymph node group.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="mucinous-percentage-only-if-present">
        <iso:rule context="//colon:mucinousComponent">
            <iso:assert test="if (@value ne 'positive') then empty (@percentage) else $skip">
                Mucinous component must be positive to specify a percentage.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="colon-site-matches-procedure">
        <iso:rule context="//pert:site">
            <let name="proc" value="//pert:procedure/@value"/>
            <iso:assert test="
                
                     if ($proc = 'right hemicolectomy')        then @value = ('cecum', 'ascending colon', 'hepatic flexure', 'transverse colon')
                else if ($proc = 'transverse colectomy')       then @value = ('hepatic flexure', 'transverse colon', 'splenic flexure')
                else if ($proc = 'left hemicolectomy')         then @value = ('splenic flexure', 'descending colon', 'sigmoid colon')
                else if ($proc = 'sigmoidectomy')              then @value = ('descending colon', 'sigmoid colon', 'rectum')
                else if ($proc = 'low anterior resection')     then @value = ('sigmoid colon', 'rectum', 'anus')
                else if ($proc = 'abdominoperineal resection') then @value = ('sigmoid colon', 'rectum', 'anus') 
                else if ($proc = 'transanal disk excision')    then @value = ('sigmoid colon', 'rectum', 'anus')
                else                                           $skip    ">
                
                Specimen site "<value-of select="@value"/>" must match a corresponding procedure.
                
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="other-histologic-type">
        <rule context="//pert:histologicType">
            <assert test="if (@value eq 'other') then exists(@other-value) else not(exists(@other-value))">
                If the histologic type is "other", then a value must be given in an "other-value" attribute which may otherwise not be present.
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
    <iso:pattern id="colon-calculate-N-stage">
        <iso:rule context="//pert:N">
            <iso:let name="posNodes" value="sum(//pert:nodeGroup/@positiveNodes) cast as
                xs:integer"/>
            <iso:let name="N" value="@value cast as xs:integer"/>
            <iso:assert test="if ($posNodes eq 0) then $N eq 0 else if ($posNodes lt 4)
                then $N eq 1 else $N eq 2">
                N-stage (<value-of select="$N"/>) must match the number of positive nodes (<value-of select="$posNodes"/>).
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="colon-calculate-T-stage">
        <iso:rule context="//pert:T">
            <iso:let name="depth" value="//colon:deepestInvasion/@value cast as xs:string"/>
            <iso:let name="T" value="@value cast as xs:string"/>
            <iso:assert test="
            
                     if ($depth = 'adjacent structure')        then $T = '4'  
                else if ($depth = 'serosal surface')           then $T = '3' 
                else if ($depth = 'periolic tissue')           then $T = '3' 
                else if ($depth = 'subserosa')                 then $T = '3'  
                else if ($depth = 'muscularis propria')        then $T = '2' 
                else if ($depth = 'submucosa')                 then $T = '1' 
                else if ($depth = 'lamina propria')            then $T = 'is' 
                else if ($depth = 'intraepithelial carcinoma') then $T = 'is' 
                else if ($depth = 'no evidence of tumor')      then $T = '0' 
                else                                                $T = 'X'    ">
                
                Value of T-stage does not match value given for deepest invasion.
                
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="adjacent-structure-involvement">
        <rule context="//pert:invasion">
            <assert test="if (colon:deepestInvasion/@value eq 'adjacent structure') then colon:adjacentStructure else $skip">
                Deepest invasion of adjacent structure(s) requires specifying which structure(s) and extent.
            </assert>
            <assert test="if (colon:adjacentStructure) then colon:deepestInvasion eq 'adjacent structure' else $skip"> 
                Adjacent structure(s) must be specified only if deepest invasion is of adjacent structure.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="extraprostatic-specified-both-sides">
        <iso:rule context="//prostate:extension">
            <iso:let name="loc" value="prostate:extraprostatic/@location"/>
            <iso:assert test="$loc = 'right side' and $loc = 'left side'">
                Extraprostatic extension must be reported for both right and left sides (at least).
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="seminal-vesicle-specified-both-sides">
        <iso:rule context="//prostate:extension">
            <iso:let name="lat" value="prostate:seminalVesicle/@laterality"/>
            <iso:assert test="$lat = 'right' and $lat = 'left'">
                Seminal vesicle extension must be reported for both right and left sides.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="seminal-vesicle-extent-only-if-positive">
        <iso:rule context="//prostate:extension/prostate:seminalVesicle">
            <iso:report test="@value ne 'positive' and @extent">
                Negative seminal vesicles must not report extent.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="calculate-overall-PTI">
        <iso:rule context="//prostate:percentTumorInvolvement[@laterality eq 'both sides']">
            <iso:let name="r" value="parent::*/*[@laterality eq 'right']/@value"/>
            <iso:let name="l" value="parent::*/*[@laterality eq 'left']/@value"/>
            <iso:let name="b" value="xs:double(./@value)"/>
            <iso:assert test="if ($r and $l and $b) then max (($r, $l)) ge $b and min (($r, $l)) le $b else $skip">
                Bilateral cancer volume must be between the right and left unilateral volumes.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
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
            <assert test="if (exists($status) and $status = 'positive') then not(exists(pert:closestMargin)) else $skip">
                "Closest margin" is not reportable if any margin is frankly positive. 
            </assert>
            <assert test="if (exists($status) and $status != 'positive') then exists(pert:closestMargin) else $skip"> 
                "Closest margin" must be reported if all margins are negative. 
            </assert>
            <assert test="pert:closestMargin/@location = pert:margin[@status = 'negative']/@location"> 
                Closest margin location must correspond to a reported negative margin location. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="prostate-calculate-T-stage">
        <iso:rule context="//pert:T">
            <iso:let name="T" value="@value cast as xs:string"/>
            <iso:let name="adj" value="//prostate:adjacentStructure/@value cast as xs:string"/>
            <iso:let name="ece" value="//prostate:extracapsular/@value cast as xs:string"/>
            <iso:let name="sv" value="//prostate:seminalVesicle/@value cast as xs:string"/>
            <iso:let name="rpti"
                value="//prostate:percentTumorInvolvement[@laterality = 'right']/@value cast as xs:string"/>
            <iso:let name="lpti"
                value="//prostate:percentTumorInvolvement[@laterality = 'left']/@value cast as xs:string"/>
            <!--
            <iso:assert test="
            
                     if ($depth = 'adjacent structure')        then $T = '4'  
                else if ($depth = 'serosal surface')           then $T = '3' 
                else if ($depth = 'periolic tissue')           then $T = '3' 
                else if ($depth = 'subserosa')                 then $T = '3'  
                else if ($depth = 'muscularis propria')        then $T = '2' 
                else if ($depth = 'submucosa')                 then $T = '1' 
                else if ($depth = 'lamina propria')            then $T = 'is' 
                else if ($depth = 'intraepithelial carcinoma') then $T = 'is' 
                else if ($depth = 'no evidence of tumor')      then $T = '0' 
                else                                                $T = 'X'    ">
                
                Value of T-stage does not match the given extension information.
            
            </iso:assert>
            -->
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
