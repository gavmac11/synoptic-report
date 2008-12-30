<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:iso="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="therapy-description-not-allowed">
        <iso:rule context="//hasPriorTherapy">
            <iso:assert test="@value &gt;= count(@description)"> Description is not allowed
                unless value is true. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="size-dimensions-in-decreasing-order">
        <iso:rule context="//pert:tumorSize">
            <iso:let name="d1"
                value="if (@dimension-1 castable as xs:float) then
                xs:float(@dimension-1) else 0.0"/>
            <iso:let name="d2"
                value="if (@dimension-2 castable as xs:float) then
                xs:float(@dimension-2) else 0.0"/>
            <iso:let name="d3"
                value="if (@dimension-3 castable as xs:float) then
                xs:float(@dimension-3) else 0.0"/>
            <iso:assert test="$d1 ge $d2 and $d2 ge $d3"> Tumor size dimensions must be in
                decreasing order. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="node-numbers-add-up">
        <iso:rule context="//pert:nodeGroup">
            <iso:let name="positiveNodes"
                value="if (@positiveNodes castable as xs:integer) then
                xs:integer(@positiveNodes) else 0"/>
            <iso:let name="regressedNodes"
                value="if (@regressedNodes castable as xs:integer) then
                xs:integer(@regressedNodes) else 0"/>
            <iso:let name="totalNodes"
                value="if (@totalNodes castable as xs:integer) then
                xs:integer(@totalNodes) else -1"/>
            <iso:assert test="$positiveNodes le $totalNodes"> Positive nodes must not exceed total
                nodes in the "<iso:value-of select="@location"/>" lymph node group. </iso:assert>
            <iso:assert test="$regressedNodes le $totalNodes"> Regressed nodes must not exceed total
                nodes in the "<iso:value-of select="@location"/>" lymph node group. </iso:assert>
            <iso:assert test="$regressedNodes + $positiveNodes le $totalNodes"> Positive plus
                regressed nodes must not exceed total nodes in the "<iso:value-of select="@location"/>" lymph node group. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="other-histologic-type">
        <rule context="//pert:histologicType">
            <assert test="if (@value eq 'other') then exists(@other-value) else
                not(exists(@other-value))"> If the histologic type is "other", then a value must be
                given in an "other-value" attribute which may otherwise not be present. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="extraprostatic-specified-both-sides">
        <iso:rule context="//prostate:extension">
            <iso:let name="loc" value="prostate:extraprostatic/@location"/>
            <iso:assert test="$loc = 'right side' and $loc = 'left side'"> Extraprostatic extension
                must be reported for both right and left sides (at least). </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="seminal-vesicle-specified-both-sides">
        <iso:rule context="//prostate:extension">
            <iso:let name="lat" value="prostate:seminalVesicle/@laterality"/>
            <iso:assert test="$lat = 'right' and $lat = 'left'"> Seminal vesicle extension must be
                reported for both right and left sides. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="seminal-vesicle-extent-only-if-positive">
        <iso:rule context="//prostate:extension/prostate:seminalVesicle">
            <iso:report test="@value ne 'positive' and @extent"> Negative seminal vesicles must not
                report extent. </iso:report>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="calculate-overall-PTI">
        <iso:rule context="//prostate:percentTumorInvolvement[@laterality eq 'both sides']">
            <iso:let name="r" value="parent::*/*[@laterality eq 'right']/@value"/>
            <iso:let name="l" value="parent::*/*[@laterality eq 'left']/@value"/>
            <iso:let name="b" value="xs:double(./@value)"/>
            <iso:assert test="if ($r and $l and $b) then max (($r, $l)) ge $b and min (($r, $l)) le
                $b else $skip"> Bilateral cancer volume must be between the right and left
                unilateral volumes. </iso:assert>
        </iso:rule>
    </iso:pattern>
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
            <let name="closest" value="pert:closestMargin"/>
            <let name="closestLocation" value="pert:closestMargin/@location"/>
            <assert test="if (exists($status) and $status = 'positive') then not(exists($closest))
                else $skip"> "Closest margin" is not reportable if any margin is frankly positive. </assert>
            <assert test="if (exists($status) and not($status = 'positive')) then exists($closest)
                else $skip"> "Closest margin" must be reported if all margins are negative. </assert>
            <assert test="if (exists($closestLocation)) then $closestLocation = pert:margin[@status
                = 'negative']/@location else $skip"> Closest margin location must correspond to a
                reported negative margin location. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="prostate-calculate-T-stage">
        <iso:rule context="//pert:T">
            <iso:let name="T" value="@value cast as xs:string"/>
            <iso:let name="adj" value="//prostate:adjacentStructure/@value"/>
            <iso:let name="epe" value="//prostate:extraprostatic/@value"/>
            <iso:let name="svi" value="//prostate:seminalVesicle/@value"/>
            <iso:let name="rpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'right']/@value cast as xs:integer"/>
            <iso:let name="lpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'left']/@value cast as xs:integer"/>
            <iso:assert test="                                       if ($adj = 'bladder' or $adj =
                'rectum')  then $T = '4'                   else if ($svi = 'positive')
                then $T = '3b'                  else if ($epe = 'positive')                    then
                $T = '3a'                  else if ($rpti > 0 and $lpti > 0)              then $T =
                '2c'                   else if ($rpti = 0 and $lpti > 50)             then $T = '2b'
                else if ($lpti = 0 and $rpti > 50)             then $T = '2b'                  else
                if ($rpti = 0 and $lpti > 0)              then $T = '2a'                  else if
                ($lpti = 0 and $lpti > 0)              then $T = '2a'                 else if ($rpti
                = 0 and $lpti = 0)              then $T = '0'                 else
                $T = 'X'    "> Value of T-stage ("T<value-of select="$T"/>") does not match the
                given extension information. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <iso:pattern id="calculate-N-stage">
        <iso:rule context="//pert:N">
            <iso:let name="posNodes" value="sum(//pert:nodeGroup/@positiveNodes)"/>
            <iso:let name="N" value="@value cast as xs:integer"/>
            <iso:assert test="if ($posNodes eq 0) then $N eq 0 else $N eq 1"> N-stage ("N<value-of select="$N"/>") must match the number of positive nodes ("<value-of select="$posNodes"/>"). </iso:assert>
        </iso:rule>
    </iso:pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
