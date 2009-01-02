<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern abstract="true" id="a-subsets-b">
        <rule context="$context">
            <assert test="$a = $b or $escape">
                Every <value-of select="$a-name"/> must be <value-of select="$b-name"/>
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern abstract="true" id="bilaterality">
        <rule context="$context">
            <assert test="$finding/@location = 'right' and $finding/@location = 'left'">
                The <value-of select="'finding-name'"/> must be reported for both right and left sides, at least.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern abstract="true" id="x-iff-y">
        <rule context="$context">
            <assert test="if (exists($x)) then exists($y) else not(exists($y))">
                In <name/>, <value-of select="$x-name"/> must be accompanied by <value-of select="$y-name"/>, and vice-versa.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern abstract="true" id="dimensions-decreasing">
        <rule context="$context">
            <let name="d1" value="if (@dimension-1 castable as xs:float) then xs:float(@dimension-1) else 0.0"/>
            <let name="d2" value="if (@dimension-2 castable as xs:float) then xs:float(@dimension-2) else 0.0"/>
            <let name="d3" value="if (@dimension-3 castable as xs:float) then xs:float(@dimension-3) else 0.0"/>
            <assert test="$d1 ge $d2 and $d2 ge $d3"> 
                In <name/>, size dimensions must be in decreasing order. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="x-iff-y">
        <param name="context" value="//hasPriorTherapy"/>
        <param name="x" value="@value"/>
        <param name="x-name" value="'a prior therapy element marked as positive'"/>
        <param name="y" value="@description"/>
        <param name="y-name" value="'a prior therapy description'"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="x-iff-y">
        <param name="context" value="//pert:histologicType"/>
        <param name="x" value="@value eq 'other'"/>
        <param name="x-name" value="'a histologic type of other'"/>
        <param name="y" value="@otherValue"/>
        <param name="y-name" value="'a specification of the other value'"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="dimensions-decreasing">
        <param name="$context" value="//pert:tumorSize"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="total-nodes-must-be-specified-for-each-nodeGroup">
        <rule context="//pert:nodeGroup">
            <assert test="exists(pert:nodeStatus[@value = 'total'])">
                The total number of nodes in every group must be specified (missing for "<value-of select="@location"/>").
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"> 
                If reporting tumor treatment effect, the clinical section must specify prior therapy. 
            </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))">
                Stage must note treatment effect using the 'y' prefix.
            </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins" flag="closest-margin-problem">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin/@closest"/>
            <assert test="count(pert:margin[@closest=true()]) le 1"> 
                Only one margin can be the closest margin. 
            </assert>
            <assert test="if ($closest) then not($status = ('focally positive', 'positive', 'extensively positive')) else $skip"> 
                No margin may be designated "closest margin" because at least one margin is positive. 
            </assert>
            <assert test="if (not($status = ('focally positive', 'positive', 'extensively positive'))) then $closest else $skip"> 
                One margin must be designated closest, because all margins are negative. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="a-subsets-b">
        <param name="context" value="pert:tumorLocation"/>
        <param name="a" value="@value"/>
        <param name="b" value="//pert:site/@value"/>
        <param name="escape" value="'entire breast' = $b"/>
        <param name="a-name" value="tumor locqtion"/>
        <param name="b-name" value="a specimen site"/>
    </pattern>
    <pattern id="tumor-site-subsets-specimen-site">
        <rule context="//pert:tumorLocation">
            <assert test="@value = //pert:site/@value or 'entire breast' = //pert:site/@value"> 
                The tumor site "<value-of select="@value"/>" must be among the sites comprising the specimen. 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="bilaterality">
        <param name="context" value="//prostate:extension"/>
        <param name="finding" value="prostate:extraprostatic"/>
        <param name="finding-name" value="'extraprostatic extension status'"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="bilaterality">
        <param name="context" value="//prostate:extension"/>
        <param name="finding" value="prostate:seminalVesicle"/>
        <param name="finding-name" value="'seminal vesicle extension status'"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
