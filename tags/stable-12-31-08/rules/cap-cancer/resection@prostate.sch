<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="therapy-description-not-allowed">
        <rule context="//hasPriorTherapy">
            <assert test="@value &gt;= count(@description)"> Description is not allowed
                unless value is true. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="size-dimensions-in-decreasing-order">
        <rule context="//pert:tumorSize">
            <let name="d1"
                value="if (@dimension-1 castable as xs:float) then
                xs:float(@dimension-1) else 0.0"/>
            <let name="d2"
                value="if (@dimension-2 castable as xs:float) then
                xs:float(@dimension-2) else 0.0"/>
            <let name="d3"
                value="if (@dimension-3 castable as xs:float) then
                xs:float(@dimension-3) else 0.0"/>
            <assert test="$d1 ge $d2 and $d2 ge $d3"> Tumor size dimensions must be in
                decreasing order. </assert>
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
                Sum (<value-of select="$regressed + $pos"/>) of nodes with regressed tumor (<value-of select="$regressed"/>)  and positive (<value-of select="$pos"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="other-histologic-type">
        <rule context="//pert:histologicType">
            <assert test="if (@value eq 'other') then exists(@other-value) else
                not(exists(@other-value))"> If the histologic type is "other", then a value must be
                given in an "other-value" attribute which may otherwise not be present. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="extraprostatic-specified-both-sides">
        <rule context="//prostate:extension">
            <let name="loc" value="prostate:extraprostatic/@location"/>
            <assert test="$loc = 'right side' and $loc = 'left side'"> Extraprostatic extension
                must be reported for both right and left sides (at least). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="seminal-vesicle-specified-both-sides">
        <rule context="//prostate:extension">
            <let name="lat" value="prostate:seminalVesicle/@laterality"/>
            <assert test="$lat = 'right' and $lat = 'left'"> Seminal vesicle extension must be
                reported for both right and left sides. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="seminal-vesicle-extent-only-if-positive">
        <rule context="//prostate:extension/prostate:seminalVesicle">
            <report test="@value ne 'positive' and @extent"> Negative seminal vesicles must not
                report extent. </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-overall-PTI">
        <rule context="//prostate:percentTumorInvolvement[@laterality eq 'both sides']">
            <let name="r" value="parent::*/*[@laterality eq 'right']/@value"/>
            <let name="l" value="parent::*/*[@laterality eq 'left']/@value"/>
            <let name="b" value="xs:double(./@value)"/>
            <assert test="if ($r and $l and $b) then max (($r, $l)) ge $b and min (($r, $l)) le
                $b else $skip"> Bilateral cancer volume must be between the right and left unilateral volumes.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin/@closest"/>
            <let name="closestLocation" value="pert:margin[@closest = 'true()']/@location"/>
            <assert test="if ($status = 'positive') then not(exists($closest)) else $skip"> 
                "Closest margin" is not reportable if any margin is frankly positive. 
            </assert>
            <assert test="if (not($status = 'positive')) then exists($closest) else $skip"> 
                "Closest margin" must be reported if all margins are negative. 
            </assert>
            <assert test="if (exists($closestLocation)) then $closestLocation = pert:margin[@status
                = 'negative']/@location else $skip"> 
                Closest margin location must correspond to a reported negative margin location."/>
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="prostate-calculate-T-stage">
        <rule context="//pert:T">
            <let name="T" value="@value cast as xs:string"/>
            <let name="adj" value="//prostate:adjacentStructure/@value"/>
            <let name="epe" value="//prostate:extraprostatic/@value"/>
            <let name="svi" value="//prostate:seminalVesicle/@value"/>
            <let name="rpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'right']/@value cast as xs:integer"/>
            <let name="lpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'left']/@value cast as xs:integer"/>
            <assert test="                                       if ($adj = 'bladder' or $adj =
                'rectum')  then $T = '4'                   else if ($svi = 'positive')
                then $T = '3b'                  else if ($epe = 'positive')                    then
                $T = '3a'                  else if ($rpti > 0 and $lpti > 0)              then $T =
                '2c'                   else if ($rpti = 0 and $lpti > 50)             then $T = '2b'
                else if ($lpti = 0 and $rpti > 50)             then $T = '2b'                  else
                if ($rpti = 0 and $lpti > 0)              then $T = '2a'                  else if
                ($lpti = 0 and $lpti > 0)              then $T = '2a'                 else if ($rpti
                = 0 and $lpti = 0)              then $T = '0'                 else
                $T = 'X'    "> Value of T-stage ("T<value-of select="$T"/>") does not match the given extension
                information. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="//pert:N">
            <let name="posNodes" value="sum(//pert:nodeGroup/@positiveNodes)"/>
            <let name="N" value="@value cast as xs:integer"/>
            <assert test="if ($posNodes eq 0) then $N eq 0 else $N eq 1"> N-stage ("N<value-of select="$N"/>") must match the number of positive nodes ("<value-of select="$posNodes"/>"). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
