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
	<p>This sets the prefix "<!--enter-site-name-here-->" to the
		<!--enter-site-name-here--> namespace.</p>
	<ns prefix="enter-a-prefix-here" uri="enter-site-uri-here"/>
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
		<xsl:param name="relation"/>
		<xsl:variable name="correction">
			<xsl:value-of select="if ($relation eq 'lessThan') then -1.0 else if ($relation eq 'greaterThan') then 1.0 else 0.0"/>
		</xsl:variable>
		<xsl:value-of select="if ($value castable as xs:decimal) then if ($unit eq 'mm') then (xs:decimal($value) + $correction) else if ($unit eq 'cm') then ($value*10.0 + $correction) else if ($unit eq 'in') then ($value*25.4 + $correction) else () else ()"/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This is an xslt2 function that returns a descending sort of a supplied
		sequence.</p>
	<xsl:function name="ecc:sort">
		<xsl:param as="xs:decimal*" name="input"/>
		<xsl:variable name="output">
			<xsl:perform-sort select="$input">
				<xsl:sort order="descending" select="."/>
			</xsl:perform-sort>
		</xsl:variable>
		<xsl:value-of select="$output"/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>The following rules are part of the common rules schema that runs against
		any site, and you do not need to supply them.</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>1. If a response value is "specify", then a value MUST be specified in a
		child {specify} element (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>2. If a child {specify} element is present, then the response to the
		parent query MUST be "specify" (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>3. All dimensional units for a given size SHOULD be the same unit (e.g.
		all in cm), (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>4. Dimensions SHOULD be presented in decreasing order by absolute size
		(otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>5. If a "closest" margin is specified, then all margins MUST be negative
		(otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>6. If all margins are negative, then a "closest" margin SHOULD be
		specified (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>7. You MUST not report a "distance from margin" for any margin that is
		other than negative or equivocal (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>8. You MUST not report a site as being involved by tumor unless that site
		is also reported as present in the specimen (ptherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>9. The tumor greatest dimension SHOULD not exceed the specimen greatest
		dimenson (otherwise WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>10. The number of non-negative nodes for any node group MUST not exceed
		the total number of nodes for that group (otherwise ERROR).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>11. If treatment effect is present pathologically, the there SHOULD be a
		specification of the prior therapy in the clinical section (otherwise
		WARNING).</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>12. The assigned grade MUST occur in the assigned grading system, e.g.
		cannot assign G3 if a 2-grade system is specified (otherwise ERROR). (Note
		that this works for the default grade specification system of 'G1'-'G4'.
		If you override this with a custom system, you must write your own
		rule.)</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~GENERIC RULE TEMPLATE~~~~~~~~~~~~~~~~~~~~~~-->
	<p>You can use this template as a starting point for any rule pattern you
		might wish to create.</p>
	<p>If you do not know anything about Schematron, a good free tutorial is at:
		http://www.dpawson.co.uk/schematron/index.html</p>
	<p>NOTE: These templates use ISO Schematron. See
		http://www.schematron.com/</p>
	<p>You can look at samples of Schematron rules used in this framework in the
		file [project]/framework/rules/common.sch</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<pattern id="enter-your-name-here">
		<!-- TEMPLATE USER: enter a descriptive name for your pattern above -->
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<p>Enter your documentation here.</p>
		<!-- TEMPLATE USER: enter some English-language description of the code here -->
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
		<rule context="/ecc:synopsis">
			<!-- TEMPLATE USER: enter a path for the context node above -->
			<let name="enter-variable-name-here" value="true()"/>
			<!-- TEMPLATE USER: optional variable definitions above -->
			<assert test="$skip"> Enter an error message here. </assert>
			<!-- TEMPLATE USER: Enter a test in xpath and an error message above -->
			<report test="$no-report">Enter a warning message here. </report>
		</rule>
		<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	</pattern>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>Below are a couple of xlst2 functions that I have found useful in my
		rulemaking. Feel free to reference them in your rules (or not).</p>
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
		<xsl:param name="relation"/>
		<xsl:variable name="correction">
			<xsl:value-of select="if ($relation eq 'lessThan') then -1.0 else if ($relation eq 'greaterThan') then 1.0 else 0.0"/>
		</xsl:variable>
		<xsl:value-of select="if ($value castable as xs:decimal) then if ($unit eq 'mm') then (xs:decimal($value) + $correction) else if ($unit eq 'cm') then ($value*10.0 + $correction) else if ($unit eq 'in') then ($value*25.4 + $correction) else () else ()"/>
	</xsl:function>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This is an xslt2 function that returns a descending sort of a supplied
		sequence.</p>
	<xsl:function name="ecc:sort">
		<xsl:param as="xs:decimal*" name="input"/>
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
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>Below are a number of rules (uncomment them if you wish to use them) from
		the colon.sch file that you can use as starting points for your
		site-specific rules.</p>
	<p>In many cases, customizing them for a new site will involve just replacing
		some nodeset names or variable definitions with the ones appropriate to
		your site.</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This first example shows how you would match sites with procedures, and
		vice versa:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--
		<pattern id="site-matches-procedure">
		<p>This pattern checks that the reported procedures and reported specimen
			sites match properly. The challenges here are that: (i) We allow both
			multiple sites and multiple procedures to be reported. So we don't want
			to claim a wrong site just because of a mismatch with only a single
			procedure; and vice versa. And (ii) typically, a given procedure has
			more *possible* sites than *necessary* sites. And a given site is
			usually a match for more than one procedure. </p>
		<p> This is a long, but "dumb" rule. Most of it is data setup. It fires
			once, when the processor encounters a "specimen" section.</p>
		<p> The first thing it does is to set up a buch of temporary variables.
			These are convenience shortnames for all the possible procedure strings
			and site strings. These strings are identical to those allowed by the
			RNG as responses to the {specimenSite} and {procedure} queries; these
			are obtained by checking the valuesets.rng file. A good enhancement of
			this rule would be to reference those strings directly via an xpath
			external document reference; this would prevent problems of maintaining
			this schematron file in synch with the RNG model. However, for now this
			is not done and we will have to manually ensure that this list is in
			synch with the valuesets.rng file.</p>
		<p>The next thing is to set up lists of "necessary" and "sufficient"
			matches between sites and procedures (see below). The "sufficient" ones
			match site-to-procedure. The "necessary" ones match procedure-to-site.
			(For why this choice, see challenge (ii) in the first paragraph
			above.)</p>
		<p>The final thing is to evaluate two assertions. The first assertion
			insists that for every site, there is at least one procedural match in
			the patient's report. The second assertion insists that for every
			procedure, the minimally matching set of site(s) is on the patient's
			report.</p>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<rule context="/ecc:synopsis/ecc:specimen">
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-procedure strings (cf. specimen.procedure.response.value.valueset in project/colon/components/valuesets.rng)-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<let name="tox" value="'total colectomy'"/>
			<let name="sex" value="'segmental colectomy'"/>
			<let name="prx" value="'proctocolectomy'"/>
			<let name="apx" value="'abdominoperineal resection'"/>
			<let name="lax" value="'low anterior resection'"/>
			<let name="tdx" value="'transanal disk excision'"/>
			<let name="six" value="'sigmoidectomy'"/>
			<let name="lhx" value="'left hemicolectomy'"/>
			<let name="trx" value="'transverse colectomy'"/>
			<let name="rhx" value="'right hemicolectomy'"/>
			<let name="asx" value="'ascending colectomy'"/>
			<let name="pox" value="polypectomy"/>
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-procedure strings (cf. specimen.site.response.value.valueset in project/colon/components/valuesets.rng)-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<let name="anu" value="'anus'"/>
			<let name="rec" value="'rectum'"/>
			<let name="rsj" value="'rectosigmoid junction'"/>
			<let name="sig" value="'sigmoid colon'"/>
			<let name="des" value="'descending colon'"/>
			<let name="spl" value="'splenic flexure'"/>
			<let name="tra" value="'transverse colon'"/>
			<let name="hep" value="'hepatic flexure'"/>
			<let name="asc" value="'ascending colon'"/>
			<let name="cec" value="'cecum'"/>
			<let name="ter" value="'terminal ileum'"/>
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-lists of procedures matching each site-\->
			<!-\-e.g. $anu-procs is **possibly matching** procedures that can give rise to an anus specimen-\->
			<!-\-in this sense, these are "maximal" lists, e.g. -\->
			<!-\-put another way, there are the procedures that are **acceptable** matches to each site-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<let name="anu-procs" value="$tox, $sex, $prx, $apx, $lax, $tdx"/>
			<let name="rec-procs"
				value="$tox, $sex, $prx, $apx, $lax, $tdx, $six, $lhx"/>
			<let name="rsj-procs" value="$tox, $sex, $prx, $apx, $lax, $six, $lhx"/>
			<let name="sig-procs" value="$tox, $sex, $apx, $lax, $six, $lhx"/>
			<let name="des-procs" value="$tox, $sex, $six, $lhx"/>
			<let name="spl-procs" value="$tox, $sex, $lhx, $trx"/>
			<let name="tra-procs" value="$tox, $sex, $lhx, $trx, $rhx"/>
			<let name="hep-procs" value="$tox, $sex, $trx, $rhx"/>
			<let name="asc-procs" value="$tox, $sex, $rhx, $asx"/>
			<let name="cec-procs" value="$tox, $sex, $rhx, $asx"/>
			<let name="ter-procs" value="$rhx, $asx"/>
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-lists of sites matching each procedure-\->
			<!-\-e.g. $prx-sites is **necessarily matching** sites yielded by a proctocolectomy procedure-\->
			<!-\-in this sense, these are "minimal" lists-\->
			<!-\-put another way, these are sites that are **required matches** to each procedure-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-<let name="tox-sites" value=""/> any site is fine-\->
			<!-\-<let name="sex-sites" value=""/> any site is fine-\->
			<!-\-<let name="pox-sites" value=""/> any site is fine-\->
			<let name="prx-sites" value="$anu, $rec"/>
			<let name="apx-sites" value="$rec"/>
			<let name="lax-sites" value="$rec"/>
			<let name="tdx-sites" value="$rec"/>
			<let name="six-sites" value="$sig"/>
			<let name="lhx-sites" value="$des"/>
			<let name="trx-sites" value="$tra"/>
			<let name="rhx-sites" value="$asc"/>
			<let name="asx-sites" value="$asc"/>
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<let name="procs" value="ecc:procedure/ecc:response/@value"/>
			<let name="sites" value="ecc:specimenSite/ecc:response/@value"/>
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-This assertions tests that for every reported site, at least one possibly matching procedure is reported-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<assert
				test="
				(if ($anu = $sites) then $procs = $anu-procs else $skip) and
				(if ($rec = $sites) then $procs = $rec-procs else $skip) and
				(if ($rsj = $sites) then $procs = $rsj-procs else $skip) and
				(if ($sig = $sites) then $procs = $sig-procs else $skip) and
				(if ($des = $sites) then $procs = $des-procs else $skip) and
				(if ($spl = $sites) then $procs = $spl-procs else $skip) and
				(if ($tra = $sites) then $procs = $tra-procs else $skip) and
				(if ($hep = $sites) then $procs = $hep-procs else $skip) and
				(if ($asc = $sites) then $procs = $asc-procs else $skip) and
				(if ($cec = $sites) then $procs = $cec-procs else $skip) and
				(if ($ter = $sites) then $procs = $ter-procs else $skip)"
				>Specimen site(s) are claimed (claimed = <value-of
					select="string-join($sites,', ')"/>) for which no matching
				procedure(s) are reported (reported = <value-of
					select="string-join($procs,', ')"/>).</assert>
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<!-\-This assertion tests that for every reported procedure, at least the minimal set of necessarily matching site(s) is reported-\->
			<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
			<assert
				test="				
				(if ($prx = $procs) then not($prx-sites != $sites) else $skip) and
				(if ($apx = $procs) then not($apx-sites != $sites) else $skip) and
				(if ($lax = $procs) then not($lax-sites != $sites) else $skip) and
				(if ($tdx = $procs) then not($tdx-sites != $sites) else $skip) and
				(if ($six = $procs) then not($six-sites != $sites) else $skip) and
				(if ($lhx = $procs) then not($lhx-sites != $sites) else $skip) and
				(if ($trx = $procs) then not($trx-sites != $sites) else $skip) and
				(if ($rhx = $procs) then not($rhx-sites != $sites) else $skip) and
				(if ($asx = $sites) then not($asx-sites != $sites) else $skip)"
				>Procedure(s) are claimed (claimed = <value-of
					select="string-join($procs,', ')"/>) for which no matching
				specimen sites are reported (reported = <value-of
					select="string-join($sites,', ')"/>).</assert>
		</rule>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
	</pattern>
	-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>The second example shows how you calculate T-stage:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--
		<pattern id="colon-calculate-T-stage">
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<p>This pattern checks that the pT assignment is correct, given the
			invasion reported in the "extent" section of the patient's report. This
			is the AJCC 7th edition algorithm.</p>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<rule context="/ecc:synopsis/ecc:extent/colon:invasion/ecc:response">
			<let name="invasion" value="@value"/>
			<let name="T-reported"
				value="/ecc:synopsis/ecc:stage/ecc:N/ecc:response/@value"/>
			<let name="T-calculated"
				value="
				if ($invasion = 'adjacent structure')          then '4b'                   
				else if ($invasion = 'visceral peritoneal surface') then '4a'                  
				else if ($invasion = 'pericolorectal tissues')      then '3'                  
				else if ($invasion = 'through muscularis propria')  then '3'
				else if ($invasion = 'muscularis propria')          then '2'                  
				else if ($invasion = 'submucosa')                   then '1'                  
				else if ($invasion = 'lamina propria')              then 'is'                  
				else if ($invasion = 'intraepithelial carcinoma')   then 'is'                  
				else if ($invasion = 'no evidence of tumor')        then '0'                  
				else 																      'X'"/>
			<report test="$T-reported ne $T-calculated"> Reported T-stage
					(T<value-of select="$T-reported"/>) does not match calculated
					(T<value-of select="$T-calculated"/>).</report>
		</rule>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
	</pattern>
	-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This one shows how to calculate N-stage:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--
		<pattern id="colon-calculate-N-stage">
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<p>This pattern checks that the pN assignment is correct, given the node
			statuses reported in the "nodes" section of the patient's report. This
			is the AJCC 7th edition algorithm.</p>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<rule context="/ecc:synopsis/ecc:nodes">
			<let name="posNodes"
				value="sum(ecc:nodeGroup/ecc:count[@status='positive']/ecc:response/@value)"/>
			<let name="tumorDeposits"
				value="exists(colon:tumorDeposits[@status='positive'])"/>
			<let name="N-reported" value="../ecc:stage/ecc:N/ecc:response/@value"/>
			<let name="N-calculated"
				value="
				if ($posNodes ge 7) then '2b' 
				else if ($posNodes ge 4) then '2a' 
				else if ($posNodes ge 2) then '1b'
				else if ($posNodes eq 1) then '1a'
				else if ($posNodes eq 0) then '0'
				else if ($tumorDeposits) then '1c'
				else                          'X'"/>
			<report test="$N-reported ne $N-calculated"> Reported N-stage
					(N<value-of select="$N-reported"/>) does not match calculated
					(N<value-of select="$N-calculated"/>).</report>
		</rule>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
	</pattern>
	-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This one shows how to calculate M-stage:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--
		<pattern>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<p>This pattern checks that the pM assignment is correct, given the
			metastasis statuses reported in the "metastases" section of the
			patient's report. This is the AJCC 7th edition algorithm.</p>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
		<rule context="/ecc:synopsis/ecc:metastases/ecc:metastasis">
			<let name="peritonealMet" value="@location eq 'peritoneum'"/>
			<let name="M-reported"
				value="/ecc:synopsis/ecc:stage/ecc:M/ecc:response/@value"/>
			<let name="M-calculated"
				value="
				if ($peritonealMet) then '1b'
				else if (count(.) gt 1)  then '1b'
				else if (count(.) gt 0)  then '1a'
				else                          'unreported'"/>
			<report
				test="($M-reported ne $M-calculated) and ($M-calculated ne 'unreported')"
				> > Reported M-stage (M<value-of select="$M-reported"/>) does not
				match calculated (M<value-of select="$M-calculated"/>).</report>
		</rule>
		<!-\-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-\->
	</pattern>
	-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This one shows how check that one element is present if another element in
		a different hierarchy has a certain value:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--
		<pattern id="adjacent-structure-involvement">
		<rule context="/ecc:synopsis/ecc:extent/colon:invasion/ecc:response">
			<assert
				test="if (@value eq 'adjacent structure') then colon:adjacentStructure else $skip"
				> You report invasion of an adjacent structure, but you do not
				specify which structure is involved. (Use an {adjacentStructure}
				child element for this.) </assert>
			<assert
				test="if (colon:adjacentStructure) then @value eq 'adjacent structure' else $skip"
				> {adjacentStructure} element can be used only if deepest invasion
				is to adjacent structure. </assert>
		</rule>
	</pattern>
	-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<p>This one also shows how check that one element is present if another
		element in a different hierarchy has a certain value:</p>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--
		<pattern id="polyp-iff-polypectomy">
		<rule context="/ecc:synopsis/ecc:specimen">
			<assert
				test="exists(colon:polyp) eq (ecc:procedure/ecc:response/@value = 'polypectomy')"
				> Polyp is reportable in the specimen section if and only if the
				procedure is polypectomy.</assert>
		</rule>
	</pattern>
	-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
