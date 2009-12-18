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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This Schematron schema contains integrity rules that apply to the generic contents of any schema. Some of these
        rules apply structural constraints that are inconvenient to express in Relax NG (for example, a result value of
        "specify" mandates a {specify} element to contain the specified result). Others are "sanity" rules (for example,
        total nodes must be greater than or equal to sum of all the non-negative nodes).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>The following rules are supplied:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>1. If a response value is "specify", then a value MUST be specified in a child {specify} element (otherwise
        ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>2. If a child {specify} element is present, then the response to the parent query MUST be "specify" (otherwise
        ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>3. All dimensional units for a given size SHOULD be the same unit (e.g. all in cm), (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>4. Dimensions SHOULD be presented in decreasing order by absolute size (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>5. If a "closest" margin is specified, then all margins MUST be negative (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>6. If all margins are negative, then a "closest" margin SHOULD be specified (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>7. You MUST not report a "distance from margin" for any margin that is other than negative or equivocal
        (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>8. You MUST not report a site as being involved by tumor unless that site is also reported as present in the
        specimen (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>9. The tumor greatest dimension SHOULD not exceed the specimen greatest dimenson (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>10. The number of non-negative nodes for any node group MUST not exceed the total number of nodes for that group
        (otherwise FATAL).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>11. If treatment effect is present pathologically, the there SHOULD be a specification of the prior therapy in
        the clinical section (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>12. The assigned grade MUST occur in the assigned grading system, e.g. cannot assign G3 if a 2-grade system is
        specified (otherwise ERROR). (Note that this works for the default grade specification system of 'G1'-'G4'. If
        you override this with a custom system, you must write your own rule.)</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This sets the prefix "ecc' to the pert namespace.</p>
	<ns prefix="ecc" uri="http://cap#"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This creates a variable named $skip that is available throughout the schema, and sets it equal to true(). This is
        used to make {assert}if-then-else{/assert} assertions more readable. Usually, it is in the idiom of "if (x) then
        y else $skip.</p>
	<let name="skip" value="true()"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This does a similar thing, but creates one named $no-report to use in {report}if-then-else{/report} report
        clauses.</p>
	<let name="no-report" value="false()"/>
	<!--=============================================================-->
	<p>In this schema, there are multiple occasions when I need to convert a value expressed in centimeters or inches
        into millimeters. This is an xslt2 function that does this. The operative formula is just a cascade of if-then
        statements that applies the appropriate conversion factor. If the input is cannot be handled, the fallback is to
        report the result as an empty sequence.</p>
	<xsl:function name="ecc:to-mm">
		<xsl:param name="value"/>
		<xsl:param name="unit"/>
		<xsl:param name="relation"/>
		<xsl:variable name="correction">
			<xsl:value-of select="if ($relation eq 'less than') then -1.0 else if ($relation eq 'greater than') then 1.0 else 0.0"/>
		</xsl:variable>
		<xsl:value-of
			select="if ($value castable as xs:decimal) then if ($unit eq 'mm') then ($value + $correction) else if ($unit eq 'cm') then ($value*10.0 + $correction) else if ($unit eq 'in') then ($value*25.4 + $correction) else () else ()"
		/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This is an xslt2 function that returns a descending sort of a supplied sequence of decimals.</p>
	<xsl:function name="ecc:sort">
		<xsl:param name="input"/>
		<xsl:perform-sort select="$input">
			<xsl:sort order="descending" select="."/>
		</xsl:perform-sort>
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
			<assert test="(../attribute::* = 'specify') or (some $x in ../attribute::* satisfies ends-with($x,'(specify)'))"
				>
                In a "<value-of select="../../@name"/>" item, the response contains a "specify" element, but the response value is "<value-of select="../@value"/>", rather than "specify".
            </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//ecc:response[attribute::* = 'specify']">
			<assert test="exists (ecc:specify)"
				>
                Item "<value-of select="../@name"/>" has a response value of "specify", but no specification ("specify" element) is given.
            </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//ecc:response[ends-with(@value,'(specify)')]">
			<assert test="exists (ecc:specify)"
				>
                Item "<value-of select="../@name"/>" has a response value of "specify", but no specification ("specify" element) is given.
            </assert>
		</rule>
	</pattern>
	<!--=============================================================-->
	<pattern id="unit-inapplicable">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This pattern ensures that if any measurement has either the unit or the value equal to inapplicable, then
            both are inapplicable.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//ecc:response[@unit]">
			<report test="('inapplicable' = (@unit, @value)) and ('inapplicable' != (@unit,@value))"
				>
                In the "<value-of select="../@name"/>" item, an "inapplicable" response for either unit or value requires the same response for both.
            </report>
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
		<rule context="//ecc:item[ecc:response[@unit][2]]">
			<let name="units" value="ecc:response/@unit"/>
			<report role="warning" test="distinct-values($units)[2]"
				>
                You should use the same unit for all dimensions of the "<value-of select="@name"/>" item.
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
		<p>There are two rules: the first compares the second dimension against the first. The other one compares the
            third dimension against the first.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//ecc:item[ecc:response[@unit][2]]" role="warning">
			<let name="value" value="for $x in ecc:response return ecc:to-mm($x/@value,$x/@unit,$x/@relation)"/>
			<let name="first" value="xs:decimal($value[1])"/>
			<let name="last" value="xs:decimal($value[last()])"/>
			<assert test="(max($value) eq $first) and (min($value) eq $last)"
				>   
                Dimensions should be in descending order in the "<value-of select="@name"/>" item.
            </assert>
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		</rule>
	</pattern>
	<!--=============================================================-->
	<pattern id="margins">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This pattern checks a variety of consistency properties in the margins section. We set a a series of vectors.
            The first vector contains the names of the margin types that are being reported (e.g. "invasive carcinoma".
            "carcinoma-in-situ", "intraepithelial carcinoma", "high grade dysplasia", etc.) Typically, only one or two
            margin types will be reported, but some protocols might report three different types. </p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<!--
				negative margin incompatible with focality
				closest margin should have smallest distance
        -->
		<rule context="//ecc:section[@name eq 'margins']">
			<let name="margin" value="ecc:section/ecc:section">
				<p>This selects all the margin-type elements.</p>
			</let>
			<let name="margin-type" value="distinct-values($margin/@name)">
				<p>This filters down to a vector of unique margin type names.</p>
			</let>
			<let name="type-count" value="count($margin-type)">
				<p>This counts the number of unique margin types.</p>
			</let>
			<let name="total-count" value="for $x in $margin-type return count($margin[@name eq $x]/ecc:item[@name eq 'status'])">
				<p>This creates a vector of the number of reports for each uniquely named margin types. Now we have a vector of names ($margin-type) and
				a corresponding vector of counts ($total-count).</p>
			</let>
			<let name="closest-count"
				value="for $x in $margin-type return count($margin[@name eq $x]/ecc:item[@name eq 'closest']/ecc:response[@value eq 'positive'])">
				<p>This creates a vector that counts for each margin type is reported as both"closest" AND reported as positive. This vector should
					consist of all zeroes.</p>
			</let>
			<let name="negative-count"
				value="for $x in $margin-type return count($margin[@name eq $x]/ecc:item[@name eq 'status']/ecc:response[@value eq 'negative'])">
				<p>This creates a vector of the number of times a margin of each type is reported as "negative".</p>
			</let>
			<let name="closest-not-unique" value="for $x in (1 to $type-count) return $margin-type[$x][$closest-count[$x] gt 1]">
				<p>This creates a vector of booleans that report whether any margin type violates the rule that only one margin of each type can be
					"closest".</p>
			</let>
			<let name="closest-but-not-all-negative"
				value="for $x in (1 to $type-count) return $margin-type[$x][$negative-count[$x] lt $total-count[$x]][$closest-count[$x] gt 0]">
				<p>This creates a vector of booleans. The boolean is true() if the margin-type in question (i) has a "closest" margin reported and (ii)
					has at least one non-negative margin. </p>
			</let>
			<let name="negative-but-no-closest"
				value="for $x in (1 to $type-count) return $margin-type[$x][$negative-count[$x] eq $total-count[$x]][$closest-count[$x] eq 0]">
				<p>This creates a vector of booleans. The boolean is true() if the margin type in question (i) has no reported "closest" margin and (ii)
				has only negative margins.</p>
			</let>
			<assert test="empty($closest-but-not-all-negative)"
				>
                For margin type(s) "<value-of select="string-join($closest-but-not-all-negative, '&quot; and &quot;')"/> a "closest" margin is specified even though not all margins are negative.
            </assert>
			<assert test="empty($closest-not-unique)"
				>
                For margin type(s) "<value-of select="string-join($closest-not-unique, '&quot; and &quot;')"/>" more than one closest margin is claimed.
            </assert>
			<report role="warning" test="$negative-but-no-closest"
				>
                All margins are negative for "<value-of select="string-join($negative-but-no-closest, '&quot; and &quot;')"/>"; therefore one margin should be designated as "closest".
            </report>
		</rule>
	</pattern>
	<!--=============================================================-->
	<pattern id="margin-distance-only-if-negative">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This checks that you don't report a distance from the margin if the margin is positive. Distance from margin
            is only meaningful if the margin is negative.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//ecc:section[@name eq 'margin']/ecc:section[ecc:item[@name eq 'status'][ecc:response/@value eq 'positive']]">
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
			<assert test="not(ecc:item[@name eq 'distance'])"
				>
                Distance from margin may not be specified for "<value-of select="@name"/>" at the "<value-of select="../ecc:item[@name eq 'location']/ecc:response/@value"/>" margin because that margin is positive.
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
		<rule context="//ecc:item[@name eq 'tumor sites']">
			<let name="tumorSites" value="ecc:response/@value"/>
			<let name="specimenSites" value="//ecc:item[@name eq 'specimen sites']/ecc:response/@value"/>
			<let name="mismatch"
				value="for $x in $tumorSites return if ($x = ($specimenSites,'inapplicable','unreported','specify')) then () else $x"/>
			<assert test="empty($mismatch)"
				>
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
		<rule context="//ecc:section[@name eq 'specimen']/ecc:item[@name eq 'tumor size']">
			<let name="tumorDimensions" value="for $x in ecc:response return ecc:to-mm($x/@value,$x/@unit,$x/@relation)"/>
			<let name="specimenDimensions"
				value="for $x in ../ecc:item[@name eq 'specimen size']/ecc:response return ecc:to-mm($x/@value, $x/@unit,$x/@relation)"/>
			<let name="maxTumorDimension" value="max($tumorDimensions)"/>
			<let name="maxSpecimenDimension" value="max($specimenDimensions)"/>
			<report test="$maxTumorDimension gt $maxSpecimenDimension"
				>
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
		<rule context="//ecc:section[@name eq 'tally']">
			<let name="total" value="ecc:item[@name eq 'total']/ecc:response/@value[. castable as xs:decimal]"/>
			<let name="other" value="ecc:item[@name ne 'total']/ecc:response/@value[. castable as xs:decimal]"/>
			<let name="loc" value="../ecc:item[@name eq 'location']/ecc:response/@value"/>
			<let name="location"
				value="if ($loc eq 'specify') then ecc:specify else if ($loc = 'unreported') then 'unreported location' else @loc"/>
			<assert test="if (exists($total)) then number($total) ge sum($other) else $skip"
				>
                In the "<value-of select="$location"/>" group, you report fewer total nodes (<value-of select="$total"/>) than the sum of the enumerated node status categories (<value-of select="sum($other)"/>).
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
		<rule context="/ecc:section">
			<let name="pathologic" value="ecc:section[@name eq 'accessory']/ecc:item[@name eq 'treatment effect']/ecc:response/@value"/>
			<let name="clinical" value="ecc:section[@name eq 'clinical']/ecc:item [@name eq 'prior therapies']/ecc:response/@value"/>
			<report role="warning" test="exists($pathologic) and $pathologic != ('inapplicable','unreported') and empty($clinical)"
				>
                You report treatment effect among the accessory findings, but there is no prior therapy report in the clinical section.
            </report>
		</rule>
	</pattern>
	<!--=============================================================-->
	<pattern id="grade-comports-with-grade-system">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This pattern checks that a grade value is compatible with the grade system chosen. For example, if the grade
            system is "2-grade" then a grade of "G4" would be incompatible.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//ecc:item[@name eq 'histologic grade']/ecc:response">
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
			<let name="ignore" value="('specify','unreported','equivocal','indeterminate','inapplicable')"/>
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
			<assert
				test="if (@value = $ignore) then $skip else if (@system eq '2-grade') then @value = ('low','high') else if (@system eq '3-grade') then @value = ('well-differentiated','moderately-differentiated','poorly-differentiated') else if (@system eq '4-grade') then @value = ('GX','G1','G2','G3','G4') else $skip"
				>
                A grade of "<value-of select="@value"/>" is incompatible with a "<value-of select="@system"/>" system.
            </assert>
		</rule>
	</pattern>
	<!--=============================================================-->
	<pattern id="response-unique">
		<p>Some queries permit multiple responses. No repeats of the same response are allowed except in sizes.</p>
		<rule context="//ecc:item[not(ecc:response/@unit = ('m', 'cm', 'mm', 'in'))]" role="info">
			<let name="response" value="ecc:response/@value[. ne 'specify'][. ne 'inapplicable'][. ne 'unreported']"/>
			<assert test="count($response) eq count(distinct-values($response))"
				>
                Duplicate responses for "<value-of select="@name"/>".
            </assert>
		</rule>
	</pattern>
	<!--=============================================================-->
</schema>
