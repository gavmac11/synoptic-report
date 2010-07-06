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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:data="http://purl.org/pathology/ecc/data" xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--    <xi:include href="shared/functions.xsl"/>-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This Schematron schema contains integrity rules that apply to the generic contents of any
        schema. Some of these rules apply structural constraints that are inconvenient to express in
        Relax NG (for example, a result value of "specify" mandates a {specify} element to contain
        the specified result). Others are "sanity" rules (for example, total nodes must be greater
        than or equal to sum of all the non-negative nodes).</p>
    <p>The following rules are supplied:</p>
    <p>1. If a response value is "specify", then a value MUST be specified in a child {specify}
        element (otherwise ERROR).</p>
    <p>2. If a child {specify} element is present, then the response to the parent query MUST be
        "specify" (otherwise ERROR).</p>
    <p>3. All dimensional units for a given size SHOULD be the same unit (e.g. all in cm),
        (otherwise WARNING).</p>
    <p>4. Dimensions SHOULD be presented in decreasing order by absolute size (otherwise
        WARNING).</p>
    <p>5. If a "closest" margin is specified, then all margins MUST be negative (otherwise
        ERROR).</p>
    <p>6. If all margins are negative, then a "closest" margin SHOULD be specified (otherwise
        WARNING).</p>
    <p>7. You MUST not report a "distance from margin" for any margin that is other than negative or
        equivocal (otherwise ERROR).</p>
    <p>8. You MUST not report a site as being involved by tumor unless that site is also reported as
        present in the specimen (otherwise ERROR).</p>
    <p>9. The tumor greatest dimension SHOULD not exceed the specimen greatest dimenson (otherwise
        WARNING).</p>
    <p>10. The number of non-negative nodes for any node group MUST not exceed the total number of
        nodes for that group (otherwise FATAL).</p>
    <p>11. If treatment effect is present pathologically, the there SHOULD be a specification of the
        prior therapy in the clinical section (otherwise WARNING).</p>
    <p>12. The assigned grade MUST occur in the assigned grading system, e.g. cannot assign G3 if a
        2-grade system is specified (otherwise ERROR). (Note that this works for the default grade
        specification system of 'G1'-'G4'. If you override this with a custom system, you must write
        your own rule.)</p>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="f" uri="http://purl.org/pathology/ecc/functions/"/>
    <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
    <ns prefix="data" uri="http://purl.org/pathology/ecc/data"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="positive" value="'positive'"/>
    <let name="negative" value="'negative'"/>
    <let name="noReport" value="('inapplicable','unreported')"/>
    <let name="specify" value="'specify'"/>
    <let name="indet" value="('equivocal','indeterminate')"/>
    <let name="total" value="'total'"/>
    <let name="principal" value="'principal'"/>
    <let name="focality" value="('unifocal','multifocal')"/>
    <let name="val" value="doc('values.rng')//rng:define"/>
    <let name="insitu" value="'in-situ'"/>
    <let name="invas" value="'invasive'"/>
    <let name="grades-2" value="('X','1','2','low','high')"/>
    <let name="grades-3"
        value="('X','1','2','3','well differentiated','moderately differentiated','poorly
        differentiated')"/>
    <let name="grades-4"
        value="('X','1','2','3','4','well differentiated','moderately differentiated','poorly
            differentiated','undifferentiated')"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This creates a variable named $skip that is available throughout the schema, and sets it
        equal to true(). This is used to make {assert}if-then-else{/assert} assertions more
        readable. Usually, it is in the idiom of "if (x) then y else $skip.</p>
    <let name="skip" value="true()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This does a similar thing, but creates one named $report to use in
        {assert}if-then-else{/assert} report clauses.</p>
    <let name="report" value="false()"/>
    <!--=============================================================-->
    <p>In this schema, there are multiple occasions when I need to convert a value expressed in
        centimeters or inches into millimeters. This is an xslt2 function that does this. The
        operative formula is just a cascade of if-then statements that applies the appropriate
        conversion factor. </p>
    <p>NOTA BENE: If the input is cannot be handled, the fallback is to report the result as 0.</p>
    <xsl:function as="xs:decimal" name="f:mm">
        <xsl:param name="value"/>
        <xsl:param name="unit"/>
        <xsl:param name="relation"/>
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
    <xsl:function as="xs:string*" name="f:sort">
        <xsl:param as="xs:anyAtomicType*" name="in"/>
        <xsl:perform-sort select="$in">
            <xsl:sort select="."/>
        </xsl:perform-sort>
    </xsl:function>
    <!--=============================================================-->
    <!-- RULE(S) FOR PREVENTING DUPLICATION OF RESPONSES -->
    <!--=============================================================-->
    <pattern id="response-unique">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>Some queries permit multiple responses. Repeats of the same response generate a warning,
            except in sizes or when there is a modifier.</p>
        <rule context="//ecc:*[not(ecc:response/@unit)][not(ecc:response/@value = $specify)]"
            role="warning">
            <let name="response"
                value="for $x in ecc:response return string-join(f:sort($x/@*),' ')"/>
            <assert test="count($response) eq count(distinct-values($response))">
            Duplicate responses in "<value-of select="name(.)"/>".
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULE(S) FOR PROPER USE OF "OTHER, SPECIFY"-->
    <!--=============================================================-->
    <pattern id="specify">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern ensures that a response value of 'specify' is accompanied by a child
            &lt;specify&gt; element where the user's specify string is reported. The point: you
            can't respond to an item by saying you're going to specify a different response from any
            of the available options, then fail to make such a specification. </p>
        <p>The pattern has three rules. The first ensures that for any {specify} element, the parent
            has an attribute with a value of 'specify'. The second and third ensure that if any
            response attribute has a value of 'specify', its that response must have a child
            &lt;specify&gt; element. </p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:specify" role="error">
            <assert test="../@* = $specify">
                A response contains a &lt;specify&gt; element, but the response value is "<value-of select="../@value"/>", rather than "specify".
            </assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="*[@* = $specify]" role="error">
            <assert test="exists(ecc:specify)">
                A response value is "specify", but no specification (no child "specify" element) is provided.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR PROPER QUANTITATIVE EXPRESSIONS -->
    <!--=============================================================-->
    <pattern id="dimensions-have-same-unit">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern emits a VALIDATION WARNING (=schematron {report} (not a VALIDATION FAILURE
            (=schematron {assert}) when a size is specified in which a different length unit is used
            for different dimensions. The framework permits this, but it is poor practice and is
            discouraged.</p>
        <p>The first rules check the second dimension's unit against that of the first dimension.
            The second rule checks the third dimension's unit against that of the first
            dimension.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:*[ecc:response[@unit][2]]">
            <report role="warning" test="exists(distinct-values(ecc:response/@unit)[2])">
                You should use the same unit for all dimensions of a size.
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="largest-dimension-comes-first">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern issues a validation warning when the first dimension of a size is not the
            largest dimension. The framework permits this, but it is poor practice and is
            discouraged. Normally, input validation in a user interface should ensure that this
            doesn't happen.</p>
        <p>This pattern makes use of the xsl:to-mm() function defined up at the beginning of this
            file, in order to ensure that all dimensions are converted to millimeters before the
            comparisons are made.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:*[ecc:response[@unit][2]]" role="warning">
            <let name="value"
                value="for $x in ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <assert test="max($value) eq $value[1] and (min($value) eq $value[last()])">   
                Dimensions should be in descending order in the "<value-of select="name(.)"/>" item. Dimensions with non-numeric values should be reported last.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR CONSISTENCY IN REPORTING MARGINS -->
    <!--=============================================================-->
    <pattern id="margins">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks a variety of consistency properties in the margins section. We set a
            a series of vectors. The first vector contains the names of the margin types that are
            being reported (e.g. "invasive carcinoma". "carcinoma-in-situ", "intraepithelial
            carcinoma", "high grade dysplasia", etc.) Typically, only one or two margin types will
            be reported, but some protocols might report three different types.</p>
        <p>- only one margin can be closest </p>
        <p>- closest margin should have smallest distance </p>
        <p>- only negative margins can have a distance</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <let name="in-situ"
            value="//ecc:margins/ecc:margin/ecc:status[@of eq $insitu]/ecc:result/ecc:response"/>
        <let name="invasive"
            value="//ecc:margins/ecc:margin/ecc:status[@of eq $invas]/ecc:result/ecc:response"/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:margins">
            <let name="location" value="distinct-values(ecc:margin/@name)"/>
            <let name="in-situ-closest-count" value="count($in-situ[@closest eq $positive])"/>
            <let name="in-situ-positive-count" value="count($in-situ[@value eq $positive])"/>
            <let name="invasive-closest-count" value="count($invasive[@closest eq $positive])"/>
            <let name="invasive-positive-count" value="count($invasive[@value eq $positive])"/>
            <report role="error" test="count(ecc:margin) gt count($location)">
                The same margin location is reported more than once.
            </report>
            <report role="error" test="$in-situ-closest-count gt 0 and $in-situ-positive-count gt 0">
                A margin is reported as "closest" for in-situ carcinoma, yet at least one margin is positive for in-situ carcinoma.
            </report>
            <report role="error" test="$invasive-closest-count gt 0 and $invasive-positive-count gt 0">
                A margin is reported as "closest" for invasive carcinoma, yet at least one margin is positive for invasive carcinoma.
            </report>
            <report role="warning" test="exists($in-situ) and $in-situ-positive-count eq 0 and $in-situ-closest-count eq 0">
                At least one margin should be designated as "closest" for in-situ carcinonoma, since no margin is positive for in-situ carcinonoma.
            </report>
            <report role="warning" test="$invasive-positive-count eq 0 and $invasive-closest-count eq 0">
                At least one margin should be designated as "closest" for invasive carcinonoma, since no margin is positive for invasive carcinonoma.
            </report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:margins//ecc:distance">
            <assert test="not(../ecc:status/ecc:response/@value = ($positive, $noReport))">
                You may not specify the distance to a positive, unreported or "inapplicable" margin.
            </assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:margins//ecc:response[@extent]">
            <assert role="error" test="@value = ('positive','equivocal')">
                You can specify extent only in the case of a positive or equivocal margin.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="closest-invasive-distance">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>Tests whether the margin desginated as "closest" has the smallest distance specified.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:margins">
            <let name="closest"
                value="//ecc:margin/ecc:status[@of eq $invas]/ecc:result/ecc:response[@closest eq $positive]/../../ecc:distance/ecc:response"/>
            <let name="closest-distances"
                value="for $x in $closest return f:mm($x/@value, $x/@unit, $x/@relation)"/>
            <let name="all-distances"
                value="for $x in //ecc:margin/ecc:status[@of eq $invas]/ecc:distance/ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <assert role="error" test="empty($closest-distances) or (max($closest-distances) le max($all-distances))">
				The margin designated as "closest" for invasive neoplasia does not have the smallest reported distance from the margin.C=<value-of select="max($closest-distances)"/>  A=<value-of select="max($all-distances)"/>
			</assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="closest-in-situ-distance">
        <rule context="//ecc:margins">
            <let name="closest"
                value="ecc:margin/ecc:status[@of eq $insitu]/ecc:result/ecc:response[@closest eq $positive]/../../ecc:distance"/>
            <let name="closest-distances"
                value="for $x in $closest return f:mm(@value, @unit, @relation)"/>
            <let name="all-distances"
                value="for $x in ecc:margin/ecc:status[@of eq $insitu]/ecc:distance/ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <assert role="error" test="empty($closest-distances) or (max($closest-distances) le max($all-distances))">
				The margin designated as "closest" for in-situ neoplasia does not have the smallest reported distance from the margin.C=<value-of select="$closest-distances"/>  A=<value-of select="$closest-distances"/>
			</assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR CONSISTENCY WHEN ONE SET OF RESPONSE VALUES MUST  -->
    <!-- SUBSET VALUES OF A DIFFERENT SET OF RESPONSES               -->
    <!-- An example would be the requirement that tumor sites must   -->
    <!-- subset sites present in the specimen                        -->
    <!--=============================================================-->
    <pattern abstract="true" id="subset-rule">
        <rule context="$where" role="warning">
            <!-- COPY THIS ABSTRACT RULE INTO SITE-SPECIFIC SCHEMAS AND INSTANTIATE IT THERE   -->
            <!-- ===== Parameters =====                                                        -->
            <!-- context:      context node for invoking the rule                              -->
            <!-- subset:       candidate subset                                                -->
            <!-- superset:     allowed superset                                                -->
            <!-- explode:      @of tag value of <data:explosions> element (as string)         -->
            <!-- subName:      description of the subset as plural noun (for error message, as string)    -->
            <!-- superName:    description of the superset as plural noun (for error message, as string)  -->
            <let name="explosions"
                value="document('')//data:explosions[@of eq $explode]/data:explosion"/>
            <let name="r"
                value="for $x in $explosions return if ($x/@of = $superset) then $x/data:value else ()"/>
            <assert test="empty(for $x in distinct-values($subset) return if ($x = ($superset, $r, $noReport, $specify)) then () else $x)">
                One or more <value-of select="$subName"/> are not included among the <value-of select="$superName"/>. (This may be due to different laterality.)
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="tumor-largest-dimension-should-not-exceed-specimen-largest-dimension">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This checks that you don't say the tumor is larger than the specimen. It makes no sense
            to say the tumor has a largest dimension of 15 cm if the largest dimension of the
            specimen is only 10 cm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:focus[@name eq $principal]/ecc:size">
            <let name="tumorDimensions"
                value="for $x in ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <let name="specimenDimensions"
                value="for $x in //ecc:specimen/ecc:size/ecc:response return f:mm($x/@value, $x/@unit,$x/@relation)"/>
            <let name="maxTumorDimension" value="max($tumorDimensions)"/>
            <let name="maxSpecimenDimension" value="max($specimenDimensions)"/>
            <report role="warning" test="$maxTumorDimension gt $maxSpecimenDimension">
                Largest gross tumor dimension (<value-of select="$maxTumorDimension"/> mm) exceeds specimen largest dimension (<value-of select="$maxSpecimenDimension"/> mm).
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR CONSISTENCY IN REPORTING NODES -->
    <!--=============================================================-->
    <pattern id="categories-versus-total-nodes">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>For any tally, the total must be less than or equal to the sum of the components.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:result[@for eq $total]">
            <let name="totalCount" value="sum(ecc:response/@value[. castable as xs:integer])"/>
            <let name="otherCount"
                value="sum(../ecc:result[@for ne $total]/ecc:response/@value[. castable as xs:integer])"/>
            <assert test="$totalCount ge $otherCount">
                In the <value-of select="name(../..)"/> named "<value-of select="../../@name"/>", you report a total (<value-of select="$totalCount"/>) less than the sum of the enumerated subcategories (<value-of select="$otherCount"/>).
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="largest-requires-positive-nodes">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:nodeGroup">
            <assert test="if (exists(ecc:largestMetastasis)) then (sum(ecc:status/ecc:result[@for eq $positive]/ecc:response/@value) gt 0) else $skip">
                You may not specify largest metastasis unless at least one node in the group is positive.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="ece-requires-positive-nodes">
        <rule context="//ecc:nodeGroup">
            <assert test="if (exists(ecc:extracapsularExtension)) then (sum(ecc:status/ecc:result[@for eq $positive]/ecc:response/@value) gt 0) else $skip">
                You may not specify extracapsular extension unless at least one node in the group is positive.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="node-response-type-appropriate">
        <rule context="ecc:nodes/ecc:nodeGroup/ecc:status/ecc:result">
            <assert test="if (@type eq 'necroinflammatory') then (@for eq $negative) else $skip">
                A node subtype of "necroinflammatory" is possible only in the case of negative nodes.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR CONSISTENCY IN REPORTING CLINICAL HISTORY -->
    <!--=============================================================-->
    <pattern id="clinical-treatment-and-pathologic-effect-consonant">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This issues a warning if you indicate there is pathologic evidence of treatment effect,
            but in the clinical history section you have not given any indication that tumor was
            previously treated, and how. This is allowed, but it is obviously bad practice.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:accessory/ecc:treatmentResponse/ecc:response">
            <let name="pathologic" value="@value"/>
            <let name="clinical" value="//ecc:priorTherapy/ecc:response/@value"/>
            <report role="warning" test="exists($pathologic) and $pathologic != $noReport and empty($clinical)">
                You report treatment response among the accessory findings, but there is no specification of any prior therapy in the
                history section.
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR CONSISTENCY IN REPORTING TUMOR PROPERTIES -->
    <!--=============================================================-->
    <pattern id="grade-appropriate-for-grade-system">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that a grade value is compatible with the grade system chosen. For
            example, if the grade system is "2-grade" then a grade of "G4" would be
            incompatible.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:tumor/ecc:grade">
            <assert test="if (@system eq '2-grade') then ecc:response/@value = $grades-2 else if (@system eq '3-grade')
                then ecc:response/@value = $grades-3 else if (@system eq '4-grade') then ecc:response/@value = $grades-4 else $skip">
                A grade of "<value-of select="ecc:response/@value"/>" is incompatible with a "<value-of select="@system"/>" system.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <!-- RULES FOR CONSISTENCY IN REPORTING TUMOR PROPERTIES -->
    <!--=============================================================-->
</schema>
