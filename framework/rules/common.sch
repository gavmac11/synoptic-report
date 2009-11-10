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
		rules apply structural constraints that are inconvenient to express in Relax NG (for example, a result value
		of "specify" mandates a {specify} element to contain the specified result). Others are "sanity" rules (for
		example, total nodes must be greater than or equal to sum of all the non-negative nodes).</p>
	<!-- TODO: rules that apply to all generic schemas
    - if exists(/synopsis/accessory/treatmentEffect/response/@value) and  != "inapplicable" then exists(/synopsis/clinical/priorTherapy/response/@value) and it != "unreported"
  -->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<ns prefix="ecc" uri="http://www.cap.org/pert/2009/01/"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<let name="skip" value="true()"/>
	<let name="no-report" value="false()"/>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<xsl:function name="ecc:to-mm">
		<xsl:param name="value"/>
		<xsl:param name="unit"/>
		<xsl:value-of select="if ($value castable as xs:double) then (if ($unit eq 'mm') then xs:double($value)
			else if ($unit eq 'cm') then $value*10.0 else if ($unit eq 'in') then $value*25.4 else 0.0) else
			'unreported'"/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="specify-element-iff-value-of-specify">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:response">
			<assert test="if(@value='specify') then exists(./ecc:specify) else not(exists(./ecc:specify))">
				A response value of "specify" requires a child {specify} element, and vice versa.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="*[@name]">
			<assert test="if(@name='specify') then exists(./ecc:specify) else not(exists(./ecc:specify))">
				An item name of "specify" requires a child {specify} element, and vice versa.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="*[@location]">
			<assert test="if(@location='specify') then exists(./ecc:specify) else not(exists(./ecc:specify))">
				An item location of "specify" requires a child {specify} element, and vice versa.
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
	<pattern id="largest-dimension-comes-first">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[2]/ecc:response">
			<let name="dim-1" value="ecc:to-mm(../../ecc:dimension[1]/ecc:response/@value,
				../../ecc:dimension[1]/ecc:response/@unit)[1]"/>
			<let name="dim-2" value="ecc:to-mm(@value, @unit)[1]"/>
			<report test="($dim-2 castable as xs:double) and ($dim-1 castable as xs:double) and (xs:double($dim-1) lt
				xs:double($dim-2))"> Larger dimension (<value-of select="max((xs:double($dim-1),xs:double($dim-2)))"
				/> mm) should be reported first. </report>
			<!---->
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="ecc:dimension[3]/ecc:response">
			<let name="dim-1" value="ecc:to-mm(../../ecc:dimension[1]/ecc:response/@value,
				../../ecc:dimension[1]/ecc:response/@unit)[1]"/>
			<let name="dim-3" value="ecc:to-mm(@value, @unit)[1]"/>
			<report test="($dim-3 castable as xs:double) and ($dim-1 castable as xs:double) and (xs:double($dim-1) lt
				xs:double($dim-3))"> Larger dimension (<value-of select="max((xs:double($dim-1),xs:double($dim-3)))"
				/> mm) should be reported first. </report>
			<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
	<pattern id="total-nodes-cannot-exceed-non-negative-nodes">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis/ecc:nodes/ecc:nodeGroup">
			<let name="total" value="ecc:count[@status eq 'total']/ecc:response/@value[. castable as xs:double]"/>
			<let name="other" value="ecc:count[@status ne 'total']/ecc:response/@value[. castable as xs:double]"/>
			<let name="location" value="if (@location = 'specify') then ecc:specify else if (@location = 'unreported') then 'unreported location' else @location"/>
			<assert test="if (exists($total)) then number($total) ge sum($other) else $skip">
				In the "<value-of select="$location"/>" group, you report fewer total nodes (<value-of select="$total"/>) than the sum of the individually enumerated node status categories (<value-of select="sum($other)"/>).
			</assert>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="clinical-treatment-and-pathologic-effect-consonant">
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis">
			<let name="pathologic" value="ecc:accessory/ecc:treatmentEffect/ecc:response/@value"/>
			<let name="clinical" value="ecc:clinical/ecc:priorTherapy/ecc:response/@value"/>
			<report test="exists($pathologic) and $pathologic != ('inapplicable','unreported') and empty($clinical)">
				You report treatment effect among the accessory findings, but there is no prior therapy report in the clinical section.
			</report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
