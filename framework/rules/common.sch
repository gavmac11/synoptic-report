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
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This Schematron schema contains integrity rules that apply to the generic contents of any schema. Some of these
		rules apply structural constraints that are inconvenient to express in Relax NG (for example, a result value of
		"specify" mandates a {specify} element to contain the specified result). Others are "sanity" rules (for example,
		total nodes must be greater than or equal to sum of all the non-negative nodes).</p>
	<!-- TODO: rules that apply to all generic schemas
    - if exists(/synopsis/accessory/treatmentEffect/response/@value) and  != "inapplicable" then exists(/synopsis/clinical/priorTherapy/response/@value) and it != "unreported"
  -->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This sets the prefix "ecc' to the pert namespace.</p>
	<ns prefix="ecc" uri="http://www.cap.org/pert/2009/01/"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This creates a variable named $skip that is available throughout the schema, and sets it equal to true(). This is
		used to make {assert}if-then-else{/assert} assertions more readable. Usually, it is in the idiom of "if (x) then y
		else $skip.</p>
	<let name="skip" value="true()"/>
	<p>This does a similar thing, but creates one named $no-report to use in {report}if-then-else{/report} report
		clauses.</p>
	<let name="no-report" value="false()"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>In this schema, there are multiple occasions when I need to convert a value expressed in centimeters or inches
		into millimeters. This is an xslt2 function that does this. The operative formula is just a cascade of if-then
		statements that applies the appropriate conversion factor. If the input is cannot be handled, the fallback is to
		report the result as 'unreported'.</p>
	<xsl:function name="ecc:to-mm">
		<xsl:param name="value"/>
		<xsl:param name="unit"/>
		<xsl:value-of
			select="
			if ($value castable as xs:double) then 
				if ($unit eq 'mm') then xs:double($value)
				else if ($unit eq 'cm') then $value*10.0 
				else if ($unit eq 'in') then $value*25.4 
				else 'unreported' 
			else 'unreported'"
		/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This is a pattern that ensures that if a response value to an item is 'specify', then there has to be a child
		{specify} element present where the user's specify string is reported. The idea is, you can't respond to an item
		by saying you're going to specify a different response from any of the available options, then fail to make such a
		specification. </p>
	<p>The pattern has two rules. The first ensures that if any attribute has a value of 'specify', its parent must have
		a child {specify} element. The second rule is the inverse; it ensures that for any {specify} element, the parent
		has an attribute with a value of 'specify'.</p>
	<pattern id="specify-element-iff-value-of-specify">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="//*[attribute::node() = 'specify']">
			<assert test="exists(../*/ecc:specify)">
				An item name of "specify" requires a child {specify} element.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:specify">
			<assert test="../attribute::node() = 'specify'">
				A {specify} element requires an attribute with the value 'specify' on the parent element.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This pattern emits a VALIDATION WARNING (=schematron {report} (not a VALIDATION FAILURE (=schematron {assert})
		when a size is specified in which a different length unit is used for different dimensions. The framework permits
		this, but it is poor practice and is discouraged.</p>
	<p>The first rules check the second dimension's unit against that of the first dimension. The second rule checks the
		third dimension's unit against that of the first dimension.</p>
	<!-- TODO: a rewrite of the xpath could surely compress these into a single rule -->
	<pattern id="dimensions-have-same-unit">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[2]/ecc:response">
			<let name="u2" value="@unit"/>
			<let name="u1" value="../../ecc:dimension[1]/ecc:response/@unit"/>
			<report test="($u2 ne $u1)"> You should use the same length unit for all dimensions of a size. </report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[3]/ecc:response">
			<let name="u3" value="@unit"/>
			<let name="u2" value="../../ecc:dimension[1]/ecc:response/@unit"/>
			<report test="($u3 ne $u2)"> You should use the same length unit for all dimensions of a size. </report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This pattern issues a validation warning when the first dimension of a size is not the largest dimension. The
		framework permits this, but it is poor practice and is discouraged. Normally, input validation in a user interface
		should ensure that this doesn't happen.</p>
	<p>This pattern makes use of the xsl:to-mm() function defined up at the beginning of this file, in order to ensure
		that all dimensions are converted to millimeters before the comparisons are made.</p>
	<p>There are two rules: the first compares the second dimension against the first. The other one compares the third
		dimension against the first.</p>
	<pattern id="largest-dimension-comes-first">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[2]/ecc:response">
			<let name="dim-1"
				value="ecc:to-mm(../../ecc:dimension[1]/ecc:response/@value,
				../../ecc:dimension[1]/ecc:response/@unit)[1]"/>
			<let name="dim-2" value="ecc:to-mm(@value, @unit)[1]"/>
			<report
				test="($dim-2 castable as xs:double) and ($dim-1 castable as xs:double) and (xs:double($dim-1) lt
				xs:double($dim-2))"
				> Larger dimension (<value-of select="max((xs:double($dim-1),xs:double($dim-2)))"/> mm) should be reported
				first. </report>
			<!---->
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[3]/ecc:response">
			<let name="dim-1"
				value="ecc:to-mm(../../ecc:dimension[1]/ecc:response/@value,
				../../ecc:dimension[1]/ecc:response/@unit)[1]"/>
			<let name="dim-3" value="ecc:to-mm(@value, @unit)[1]"/>
			<report
				test="($dim-3 castable as xs:double) and ($dim-1 castable as xs:double) and (xs:double($dim-1) lt
				xs:double($dim-3))"
				> Larger dimension (<value-of select="max((xs:double($dim-1),xs:double($dim-3)))"/> mm) should be reported
				first. </report>
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This checks to make sure that you don't specify a closest margin if there is any positive margin, as this wouldn't
		make any sense. Closest margin is only defined if all margins are negative. (Otherwise the "closest" margin is
		obviously the positive margin -- which is not a usage that pathologists employ.)</p>
	<pattern id="closest-margin-negative">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:margins">
			<let name="closest" value="ecc:margin/ecc:response/@closest"/>
			<let name="value" value="ecc:margin/ecc:response/@value"/>
			<assert test="if ($closest = 'positive') then not($value = 'positive') else $skip">
				A margin-positive case may not have a closest margin.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This checks that you don't report a distance from the margin if the margin is positive. Distance from margin is
		only meaningful if the margin is negative.</p>
	<pattern id="margin-distance-only-if-negative">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:margins/ecc:margin/ecc:response/ecc:distance">
			<assert test="../@value = ('negative', 'equivocal')">
				Distance from margin may not be specified for "<value-of select="../@value"/>" margins.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This checks that every site that you specify as being involved by tumor is actually a site that you also have
		specified as being contained in the specimen. It would make no sense to say that tumor involves the left ear, if
		the left ear is not listed as part of the specimen.</p>
	<pattern id="tumorSite-subsets-specimenSite">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:specimen/ecc:tumorSite/ecc:response">
			<let name="specimenSite" value="/ecc:synopsis/ecc:specimen/ecc:specimenSite/ecc:response/@value"/>
			<assert test="false() != (for $tumorSite in @value return $tumorSite = ($specimenSite,'specify','unreported'))">
				You report tumor at a site ("<value-of select="@value except $specimenSite"/>") that is not part of the specimen.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This checks that you don't say the tumor is larger than the specimen. It makes no sense to say the tumor has a
		largest dimension of 15 cm if the largest dimension of the specimen is only 10 cm.</p>
	<pattern id="tumor-largest-dimension-cannot-exceed-specimen-largest-dimension">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:specimen">
			<let name="tumorSize" value="ecc:tumorGrossSize/ecc:dimension[1]/ecc:response/@value"/>
			<let name="tumorSizeUnit" value="ecc:tumorGrossSize/ecc:dimension[1]/ecc:response/@unit"/>
			<let name="tumorSize-mm" value="ecc:to-mm($tumorSize,$tumorSizeUnit)[1]"/>
			<let name="specimenSize" value="ecc:specimenSize/ecc:dimension[1]/ecc:response/@value"/>
			<let name="specimenSizeUnit" value="ecc:specimenSize/ecc:dimension[1]/ecc:response/@unit"/>
			<let name="specimenSize-mm" value="ecc:to-mm($specimenSize,$specimenSizeUnit)[1]"/>
			<assert test="if ($tumorSize-mm castable as xs:double and $specimenSize-mm castable as xs:double) then xs:double($tumorSize-mm) le xs:double($specimenSize-mm) else $skip">
				Tumor largest dimension (<value-of select="xs:double($tumorSize-mm)"/> mm) cannot be larger than specimen largest dimension (<value-of select="xs:double($specimenSize-mm)"/> mm).
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This checks that the total number of nodes you report is not less than the sum of the positive+regressed+specify
		count of nodes. It makes no sense e.g. to say that you have a total of 10 nodes, of which 20 are positive.</p>
	<pattern id="total-nodes-cannot-exceed-non-negative-nodes">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:nodes/ecc:nodeGroup">
			<let name="total" value="ecc:count[@status eq 'total']/ecc:response/@value[. castable as xs:double]"/>
			<let name="other" value="ecc:count[@status ne 'total']/ecc:response/@value[. castable as xs:double]"/>
			<let name="location"
				value="if (@location = 'specify') then ecc:specify else if (@location =
				'unreported') then 'unreported location' else @location"/>
			<assert test="if (exists($total)) then number($total) ge sum($other) else $skip">
				In the "<value-of select="$location"/>" group, you report fewer total nodes (<value-of select="$total"/>) than the sum of the individually enumerated node status categories (<value-of select="sum($other)"/>).
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This issues a warning if you indicate there is pathologic evidence of treatment effect, but in the clinical
		history section you have not given any indication that tumor was previously treated, and how. This is allowed, but
		it is obviously bad practice.</p>
	<pattern id="clinical-treatment-and-pathologic-effect-consonant">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis">
			<let name="pathologic" value="ecc:accessory/ecc:treatmentEffect/ecc:response/@value"/>
			<let name="clinical" value="ecc:clinical/ecc:priorTherapy/ecc:response/@value"/>
			<report test="exists($pathologic) and $pathologic != ('inapplicable','unreported') and empty($clinical)"> You
				report treatment effect among the accessory findings, but there is no prior therapy report in the clinical
				section. </report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
