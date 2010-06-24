<?xml version="1.0" encoding="UTF-8"?>
<!--
 
 ===========================================================================
 Copyright 2009 College of American Pathologists (CAP)
 
 This file is part of the "CAP Schemas for Synoptic Cancer Reports".
 
 The "CAP Schema for Synoptic Cancer Reports" is licensed under the Apache 
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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--    <xi:include href="shared/functions.xsl"/>-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This Schematron schema contains integrity rules that apply to the generic contents of any schema. Some of these
        rules apply structural constraints that are inconvenient to express in Relax NG (for example, a result value of
        "specify" mandates a {specify} element to contain the specified result). Others are "sanity" rules (for example,
        total nodes must be greater than or equal to sum of all the non-negative nodes).</p>
    <p>The following rules are supplied:</p>
    <p>1. If a response value is "specify", then a value MUST be specified in a child {specify} element (otherwise
        ERROR).</p>
    <p>2. If a child {specify} element is present, then the response to the parent query MUST be "specify" (otherwise
        ERROR).</p>
    <p>3. All dimensional units for a given size SHOULD be the same unit (e.g. all in cm), (otherwise WARNING).</p>
    <p>4. Dimensions SHOULD be presented in decreasing order by absolute size (otherwise WARNING).</p>
    <p>5. If a "closest" margin is specified, then all margins MUST be negative (otherwise ERROR).</p>
    <p>6. If all margins are negative, then a "closest" margin SHOULD be specified (otherwise WARNING).</p>
    <p>7. You MUST not report a "distance from margin" for any margin that is other than negative or equivocal
        (otherwise ERROR).</p>
    <p>8. You MUST not report a site as being involved by tumor unless that site is also reported as present in the
        specimen (otherwise ERROR).</p>
    <p>9. The tumor greatest dimension SHOULD not exceed the specimen greatest dimenson (otherwise WARNING).</p>
    <p>10. The number of non-negative nodes for any node group MUST not exceed the total number of nodes for that group
        (otherwise FATAL).</p>
    <p>11. If treatment effect is present pathologically, the there SHOULD be a specification of the prior therapy in
        the clinical section (otherwise WARNING).</p>
    <p>12. The assigned grade MUST occur in the assigned grading system, e.g. cannot assign G3 if a 2-grade system is
        specified (otherwise ERROR). (Note that this works for the default grade specification system of 'G1'-'G4'. If
        you override this with a custom system, you must write your own rule.)</p>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="f" uri="http://purl.org/pathology/ecc/functions/"/>
    <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
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
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This creates a variable named $skip that is available throughout the schema, and sets it equal to true(). This is
        used to make {assert}if-then-else{/assert} assertions more readable. Usually, it is in the idiom of "if (x) then
        y else $skip.</p>
    <let name="skip" value="true()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <p>This does a similar thing, but creates one named $report to use in {assert}if-then-else{/assert} report
        clauses.</p>
    <let name="report" value="false()"/>
    <!--=============================================================-->
    <p>In this schema, there are multiple occasions when I need to convert a value expressed in centimeters or inches
        into millimeters. This is an xslt2 function that does this. The operative formula is just a cascade of if-then
        statements that applies the appropriate conversion factor. </p>
    <p>NOTA BENE: If the input is cannot be handled, the fallback is to report the result as 0.</p>
    <xsl:function as="xs:decimal" name="f:mm">
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
    <!--=============================================================-->
    <pattern id="specify">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern ensures that a response value of 'specify' is accompanied by a child {specify} element where the
            user's specify string is reported. The point: you can't respond to an item by saying you're going to specify
            a different response from any of the available options, then fail to make such a specification. </p>
        <p>The pattern has three rules. The first ensures that for any {specify} element, the parent has an attribute
            with a value of 'specify'. The second and third ensure that if any response attribute has a value of
            'specify', its that response must have a child {specify} element. </p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:specify" role="error">
            <assert test="../@* = $specify">
                A response contains a "specify" element, but the response value is "<value-of select="../@value"/>", rather than "specify".
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
    <pattern id="dimensions-have-same-unit">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern emits a VALIDATION WARNING (=schematron {report} (not a VALIDATION FAILURE (=schematron
            {assert}) when a size is specified in which a different length unit is used for different dimensions. The
            framework permits this, but it is poor practice and is discouraged.</p>
        <p>The first rules check the second dimension's unit against that of the first dimension. The second rule checks
            the third dimension's unit against that of the first dimension.</p>
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
        <p>This pattern issues a validation warning when the first dimension of a size is not the largest dimension. The
            framework permits this, but it is poor practice and is discouraged. Normally, input validation in a user
            interface should ensure that this doesn't happen.</p>
        <p>This pattern makes use of the xsl:to-mm() function defined up at the beginning of this file, in order to
            ensure that all dimensions are converted to millimeters before the comparisons are made.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:*[ecc:response[@unit][2]]" role="warning">
            <let name="value" value="for $x in ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <assert test="max($value) eq $value[1] and (min($value) eq $value[last()])">   
                Dimensions should be in descending order in the "<value-of select="@name"/>" item. Dimensions with non-numeric values should be reported last.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="margins">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks a variety of consistency properties in the margins section. We set a a series of vectors.
            The first vector contains the names of the margin types that are being reported (e.g. "invasive carcinoma".
            "carcinoma-in-situ", "intraepithelial carcinoma", "high grade dysplasia", etc.) Typically, only one or two
            margin types will be reported, but some protocols might report three different types.</p>
        <p>- only one margin can be closest </p>
        <p>- closest margin should have smallest distance </p>
        <p>- only negative margins can have a distance</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <let name="in-situ" value="//ecc:margins/ecc:margin/ecc:in-situ/ecc:status/ecc:response"/>
        <let name="invasive" value="//ecc:margins/ecc:margin/ecc:invasive/ecc:status/ecc:response"/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:margins">
            <let name="location" value="distinct-values(ecc:margin/@name)"/>
            <let name="in-situ-closest-count" value="count($in-situ/@closest[. eq $positive])"/>
            <let name="in-situ-positive-count" value="count($in-situ/@value[. eq $positive])"/>
            <let name="invasive-closest-count" value="count($invasive/@closest[. eq $positive])"/>
            <let name="invasive-positive-count" value="count($invasive/@value[. eq $positive])"/>
            <report role="error" test="count(ecc:margin) gt count($location)">
                The same margin location is reported more than once.
            </report>
            <report role="error" test="$in-situ-closest-count gt 0 and $in-situ-positive-count gt 0">
                A margin is reported as "closest" for in-situ carcinoma, yet at least one margin is positive for in-situ carcinoma.
            </report>
            <report role="error" test="$invasive-closest-count gt 0 and $invasive-positive-count gt 0">
                A margin is reported as "closest" for invasive carcinoma, yet at least one margin is positive for invasive carcinoma.
            </report>
            <report role="warning" test="$in-situ-positive-count eq 0 and $in-situ-closest-count eq 0">
                At least one margin should be designated as "closest" for in-situ carcinonoma, since no margin is positive for in-situ carcinonoma.
            </report>
            <report role="warning" test="$invasive-positive-count eq 0 and $invasive-closest-count eq 0">
                At least one margin should be designated as "closest = 'positive'" for invasive carcinonoma, since no margin is positive for invasive carcinonoma.
            </report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:margins//ecc:distance">
            <assert test="not(../ecc:status/ecc:response/@value = ($positive, $noReport))">
                You may not specify the distance for a positive, unreported or 'inapplicable' margin.
            </assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:margins//ecc:response[@closest eq $positive]">
            <assert role="warning" test="exists(../../ecc:distance)">
				You should specify the distance to the closest margin.
			</assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:margins//ecc:response[@extent]">
            <assert role="error" test="@value = ('positive','equivocal')">
                You can specify focality only in the case of a positive (or equivocal) margin.
            </assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:margins//ecc:response[@closest]">
            <assert role="error" test="@value eq $negative">
                You can specify closest only in the case of a negative margin.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="closest-distance">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>Tests whether the margin desginated as "closest" has the smallest distance specified.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:in-situ//ecc:response[@closest eq $positive]">
            <let name="all-distances"
                value="for $x in //ecc:in-situ/ecc:distance/ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <let name="temp" value="../../ecc:distance/ecc:response"/>
            <let name="closest-distance" value="f:mm($temp/@value,$temp/@unit,$temp/@relation)"/>
            <assert role="error" test="not($closest-distance &gt; $all-distances)">
				The margin designated as closest for in-situ neoplasia does not have the smallest reported distance from the margin.
			</assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:invasive//ecc:response[@closest eq $positive]">
            <let name="all-distances"
                value="for $x in //ecc:invasive/ecc:distance/ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
            <let name="temp" value="../../ecc:distance/ecc:response"/>
            <let name="closest-distance" value="f:mm($temp/@value,$temp/@unit,$temp/@relation)"/>
            <assert role="error" test="not($closest-distance &gt; $all-distances)">
				The margin designated as closest for invasive neoplasia does not have the smallest reported distance from the margin.
			</assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="margin-modifier">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:margin//ecc:status/ecc:response[@closest|@extent]">
            <assert role="error" test="not(@value = ($indet, $noReport))">
				You indicate the margin result is 'inapplicable', 'indeterminate' or 'unreported', yet you designate a modifier.
			</assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="tumorSite-subsets-specimenSite">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This checks that every site that you specify as being involved by tumor is actually a site that you also have
            specified as being contained in the specimen. It would make no sense to say that tumor involves the left
            ear, if the left ear is not listed as part of the specimen.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:tumor/ecc:focus">
            <let name="tumorSites" value="distinct-values(ecc:site/ecc:response/@value)"/>
            <let name="specimenSites" value="//ecc:specimen/ecc:site/ecc:response/@value"/>
            <let name="mismatch"
                value="for $x in $tumorSites return if ($x = ($specimenSites, $noReport, $specify)) then () else $x"/>
            <assert test="empty($mismatch)">
                You report tumor at one or more site(s) ("<value-of select="string-join($mismatch, '&quot;, ')"/>") not included in the specimen.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="tumor-largest-dimension-should-not-exceed-specimen-largest-dimension">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This checks that you don't say the tumor is larger than the specimen. It makes no sense to say the tumor has
            a largest dimension of 15 cm if the largest dimension of the specimen is only 10 cm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:focus[@name eq $principal]/ecc:size">
            <let name="tumorDimensions" value="for $x in ecc:response return f:mm($x/@value,$x/@unit,$x/@relation)"/>
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
    <pattern id="non-negative-nodes-cannot-exceed-total-nodes">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This checks that the total number of nodes you report is not less than the sum of the
            positive+regressed+specify count of nodes. It makes no sense e.g. to say that you have a total of 10 nodes,
            of which 20 are positive.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:nodeGroup">
            <let name="totalNodes"
                value="sum(ecc:tally/ecc:response[@type eq $total]/@value[. castable as
                xs:integer])"/>
            <let name="otherNodes" value="sum(ecc:tally/ecc:response[@type ne $total]/@value[. castable as xs:integer])"/>
            <assert test="$totalNodes ge $otherNodes">
                In the "<value-of select="string-join((@laterality,@name),' ')"/>" node group, you report fewer total nodes (<value-of select="$totalNodes"/>) than the sum of the enumerated node status categories (<value-of select="$otherNodes"/>).
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="requires-positive-nodes">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:nodeGroup">
            <assert test="if (exists(ecc:largestMetastasis) or exists(ecc:extracapsularExtension)) then (sum(ecc:tally/ecc:response[@type eq $positive]/@value) gt 0) else $skip">
                You may not specify largest metastasis or extracapsular extension unless at least one node in the group is positive.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="clinical-treatment-and-pathologic-effect-consonant">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This issues a warning if you indicate there is pathologic evidence of treatment effect, but in the clinical
            history section you have not given any indication that tumor was previously treated, and how. This is
            allowed, but it is obviously bad practice.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="ecc:accessory/ecc:treatmentEffect/ecc:response">
            <let name="pathologic" value="@value"/>
            <let name="clinical" value="//ecc:priorTherapy/ecc:response/@value"/>
            <report role="warning" test="exists($pathologic) and $pathologic != $noReport and empty($clinical)">
                You report treatment response among the accessory findings, but there is no prior therapy report in the clinical section.
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="grade-comports-with-grade-system">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that a grade value is compatible with the grade system chosen. For example, if the grade
            system is "2-grade" then a grade of "G4" would be incompatible.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:histologicGrade/ecc:response">
            <let name="ignore" value="($specify,'equivocal','indeterminate',$noReport)"/>
            <assert test="if (@value = $ignore) then $skip else if (@system eq '2-grade') then @value = ('low','high') else if (@system eq '3-grade') then @value = ('well-differentiated','moderately-differentiated','poorly-differentiated') else if (@system eq '4-grade') then @value = ('GX','G1','G2','G3','G4') else $skip">
                A grade of "<value-of select="@value"/>" is incompatible with a "<value-of select="@system"/>" system.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="response-unique">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>Some queries permit multiple responses. Repeats of the same response generate a warning, except in sizes or
            when there is a modifier.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:*[not(ecc:response/@unit)][not(ecc:response/@type)]" role="warning">
            <let name="response" value="ecc:response/@value[not(. = $specify)]"/>
            <assert test="count($response) eq count(distinct-values($response))">
                Possible duplicate responses detected in "<value-of select="name(.)"/>".
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="node-subtype-appropriate">
        <rule context="ecc:nodes/ecc:nodeGroup/ecc:tally/ecc:response">
            <assert test="if (@subtype eq 'necroinflammatory') then (@type eq $negative) else $skip">
                A node subtype of "necroinflammatory" is possible only in the case of negative nodes.
            </assert>
        </rule>
    </pattern>
</schema>
