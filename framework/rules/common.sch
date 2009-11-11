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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This Schematron schema contains integrity rules that apply to the generic
		contents of any schema. Some of these rules apply structural constraints
		that are inconvenient to express in Relax NG (for example, a result value
		of "specify" mandates a {specify} element to contain the specified
		result). Others are "sanity" rules (for example, total nodes must be
		greater than or equal to sum of all the non-negative nodes).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This sets the prefix "ecc' to the pert namespace.</p>
	<ns prefix="ecc" uri="http://www.cap.org/pert/2009/01/"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This creates a variable named $skip that is available throughout the
		schema, and sets it equal to true(). This is used to make
		{assert}if-then-else{/assert} assertions more readable. Usually, it is in
		the idiom of "if (x) then y else $skip.</p>
	<let name="skip" value="true()"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This does a similar thing, but creates one named $no-report to use in
		{report}if-then-else{/report} report clauses.</p>
	<let name="no-report" value="false()"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>In this schema, there are multiple occasions when I need to convert a
		value expressed in centimeters or inches into millimeters. This is an
		xslt2 function that does this. The operative formula is just a cascade of
		if-then statements that applies the appropriate conversion factor. If the
		input is cannot be handled, the fallback is to report the result as an
		empty sequence.</p>
	<xsl:function name="ecc:to-mm">
		<xsl:param name="value"/>
		<xsl:param name="unit"/>
		<xsl:value-of
			select="
			if ($value castable as xs:double) then 
				if ($unit eq 'mm') then xs:double($value)
				else if ($unit eq 'cm') then $value*10.0 
				else if ($unit eq 'in') then $value*25.4 
				else () 
			else ()"
		/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This is an xslt2 function that returns a descending sort of a supplied
		sequence.</p>
	<xsl:function name="ecc:sort">
		<xsl:param as="xs:double*" name="input"/>
		<xsl:variable name="output">
			<xsl:perform-sort select="$input">
				<xsl:sort order="descending" select="."/>
			</xsl:perform-sort>
		</xsl:variable>
		<xsl:value-of select="$output"/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="specify-element-iff-value-of-specify">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This pattern ensures that a response value of 'specify' is accompanied
			by a child {specify} element where the user's specify string is
			reported. The point: you can't respond to an item by saying you're
			going to specify a different response from any of the available
			options, then fail to make such a specification. </p>
		<p>The pattern has two rules. The first ensures that if any attribute has
			a value of 'specify', its parent must have a child {specify} element.
			The second rule is the inverse; it ensures that for any {specify}
			element, the parent has an attribute with a value of 'specify'.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//*[attribute::node() = 'specify']">
			<assert test="exists(../*/ecc:specify)"> An item name of "specify"
            requires a child {specify} element. </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:specify">
			<assert test="../attribute::node() = 'specify'"> A {specify} element
            requires an attribute with the value 'specify' on the parent
            element. </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="dimensions-have-same-unit">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This pattern emits a VALIDATION WARNING (=schematron {report} (not a
			VALIDATION FAILURE (=schematron {assert}) when a size is specified in
			which a different length unit is used for different dimensions. The
			framework permits this, but it is poor practice and is discouraged.</p>
		<p>The first rules check the second dimension's unit against that of the
			first dimension. The second rule checks the third dimension's unit
			against that of the first dimension.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[2]">
			<let name="units" value="../ecc:dimension/ecc:response/@unit"/>
			<report test="count(distinct-values($units)) gt 1"> You should use the
				same unit for all dimensions of a size in the "<name path=".."/>" element. </report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="largest-dimension-comes-first">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This pattern issues a validation warning when the first dimension of a
			size is not the largest dimension. The framework permits this, but it
			is poor practice and is discouraged. Normally, input validation in a
			user interface should ensure that this doesn't happen.</p>
		<p>This pattern makes use of the xsl:to-mm() function defined up at the
			beginning of this file, in order to ensure that all dimensions are
			converted to millimeters before the comparisons are made.</p>
		<p>There are two rules: the first compares the second dimension against
			the first. The other one compares the third dimension against the
			first.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//*[child::node() = ecc:dimension]">
			<let name="unsorted"
				value="for $x in ecc:dimension return ecc:to-mm($x/ecc:response/@value,$x/ecc:response/@unit)"/>
			<let name="sorted" value="tokenize(ecc:sort($unsorted), ' ')"/>
			<report test="not(every $x in (1 to count($sorted)) satisfies xs:double($sorted[$x]) eq xs:double($unsorted[$x]))"> Dimensions should be
				in descending order in the {<name path="."/>} element."/></report>
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="closest-margin-negative">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This checks to make sure that you don't specify a closest margin if
			there is any positive margin, as this wouldn't make any sense. Closest
			margin is only defined if all margins are negative. (Otherwise the
			"closest" margin is obviously the positive margin -- which is not an
			idiom that pathologists use.)</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:margins">
			<let name="closest" value="ecc:margin/ecc:response/@closest"/>
			<let name="value" value="ecc:margin/ecc:response/@value"/>
			<assert test="if ($closest = 'positive') then not($value = 'positive') else $skip"> A margin-positive case may not have a closest margin. </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="margin-distance-only-if-negative">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This checks that you don't report a distance from the margin if the
			margin is positive. Distance from margin is only meaningful if the
			margin is negative.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule
			context="/ecc:synopsis/ecc:margins/ecc:margin/ecc:response/ecc:distance">
			<assert test="../@value = ('negative', 'equivocal')"> Distance from
            margin may not be specified for "<value-of select="../@value"/>"
            margins. </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="tumorSite-subsets-specimenSite">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This checks that every site that you specify as being involved by tumor
			is actually a site that you also have specified as being contained in
			the specimen. It would make no sense to say that tumor involves the
			left ear, if the left ear is not listed as part of the specimen.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:specimen/ecc:tumorSite/ecc:response">
			<let name="specimenSite"
				value="/ecc:synopsis/ecc:specimen/ecc:specimenSite/ecc:response/@value"/>
			<assert test="false() != (for $tumorSite in @value return $tumorSite = ($specimenSite,'specify','unreported'))"> You report tumor at a site ("<value-of select="@value except $specimenSite"/>") that is not part of the
            specimen. </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern
		id="tumor-largest-dimension-cannot-exceed-specimen-largest-dimension">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This checks that you don't say the tumor is larger than the specimen.
			It makes no sense to say the tumor has a largest dimension of 15 cm if
			the largest dimension of the specimen is only 10 cm.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:specimen/ecc:tumorGrossSize">
			<!--<let name="tumorSize" value="ecc:tumorGrossSize/ecc:dimension/ecc:response/@value"/>-->
			<let name="tumorDimensions"
				value="for $x in ../ecc:tumorGrossSize/ecc:dimension return ecc:to-mm($x/ecc:response/@value, $x/ecc:response/@unit)"/>
			<let name="specimenDimensions"
				value="for $x in ../ecc:specimenSize/ecc:dimension return ecc:to-mm($x/ecc:response/@value, $x/ecc:response/@unit)"/>
			<!--<report test="$tumorSize &gt; $specimenSize"> Tumor largest dimension (<value-of select="max($tumorSize)"/> mm) may not exceed specimen largest dimension (<value-of select="max($specimenSize)"/> mm). </report>-->
			<assert test="not($tumorDimensions &gt; max($specimenDimensions))"> Tumor largest dimension (<value-of select="max($tumorDimensions)"/> mm) may not exceed specimen largest dimension (<value-of select="max($specimenDimensions)"/> mm). </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="total-nodes-cannot-exceed-non-negative-nodes">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This checks that the total number of nodes you report is not less than
			the sum of the positive+regressed+specify count of nodes. It makes no
			sense e.g. to say that you have a total of 10 nodes, of which 20 are
			positive.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:nodes/ecc:nodeGroup">
			<let name="total"
				value="ecc:count[@status eq 'total']/ecc:response/@value[. castable as xs:double]"/>
			<let name="other"
				value="ecc:count[@status ne 'total']/ecc:response/@value[. castable as xs:double]"/>
			<let name="location"
				value="if (@location = 'specify') then ecc:specify else if (@location =
				'unreported') then 'unreported location' else @location"/>
			<assert test="if (exists($total)) then number($total) ge sum($other) else $skip"> In the "<value-of select="$location"/>" group, you report fewer
            total nodes (<value-of select="$total"/>) than the sum of the
            enumerated node status categories (<value-of select="sum($other)"/>). </assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="clinical-treatment-and-pathologic-effect-consonant">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>This issues a warning if you indicate there is pathologic evidence of
			treatment effect, but in the clinical history section you have not
			given any indication that tumor was previously treated, and how. This
			is allowed, but it is obviously bad practice.</p>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis">
			<let name="pathologic"
				value="ecc:accessory/ecc:treatmentEffect/ecc:response/@value"/>
			<let name="clinical"
				value="ecc:clinical/ecc:priorTherapy/ecc:response/@value"/>
			<report
				test="exists($pathologic) and $pathologic != ('inapplicable','unreported') and empty($clinical)"
				> You report treatment effect among the accessory findings, but
				there is no prior therapy report in the clinical section. </report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
