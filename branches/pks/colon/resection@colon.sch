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
    <ns prefix="ecc" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="colon" uri="http://www.cap.org/pert/2009/01/colon/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-site-matches-procedure">
        <p>This pattern checks that the reported procedures and reported specimen sites match properly. The challenges
            here are that: (i) We allow both multiple sites and multiple procedures to be reported. So we don't want to
            claim a wrong site just because of a mismatch with only a single procedure; and vice versa. And (ii)
            typically, a given procedure has more *possible* sites than *necessary* sites. And a given site is usually a
            match for more than one procedure. </p>
        <p> This is a long, but "dumb" rule. Most of it is data setup. It fires once, when the processor encounters a
            "specimen" section.</p>
        <p> The first thing it does is to set up a buch of temporary variables. These are convenience shortnames for all
            the possible procedure strings and site strings. These strings are identical to those allowed by the RNG as
            responses to the {specimenSite} and {procedure} queries; these are obtained by checking the valuesets.rng
            file. A good enhancement of this rule would be to reference those strings directly via an xpath external
            document reference; this would prevent problems of maintaining this schematron file in synch with the RNG
            model. However, for now this is not done and we will have to manually ensure that this list is in synch with
            the valuesets.rng file.</p>
        <p>The next thing is to set up lists of "necessary" and "sufficient" matches between sites and procedures (see
            below). The "sufficient" ones match site-to-procedure. The "necessary" ones match procedure-to-site. (For
            why this choice, see challenge (ii) in the first paragraph above.)</p>
        <p>The final thing is to evaluate two assertions. The first assertion insists that for every site, there is at
            least one procedural match in the patient's report. The second assertion insists that for every procedure,
            the minimally matching set of site(s) is on the patient's report.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="/ecc:synopsis/ecc:specimen">
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--procedure strings (cf. specimen.procedure.response.value.valueset in project/colon/components/valuesets.rng)-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
            <let name="pox" value="'polypectomy'"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--procedure strings (cf. specimen.site.response.value.valueset in project/colon/components/valuesets.rng)-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="anu" value="'anus'"/>
            <let name="rec" value="'rectum'"/>
            <let name="rsj" value="'rectosigmoid junction'"/>
            <let name="sig" value="'sigmoid colon'"/>
            <let name="des" value="'left colon'"/>
            <let name="spl" value="'splenic flexure'"/>
            <let name="tra" value="'transverse colon'"/>
            <let name="hep" value="'hepatic flexure'"/>
            <let name="asc" value="'right colon'"/>
            <let name="cec" value="'cecum'"/>
            <let name="ter" value="'terminal ileum'"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--lists of procedures matching each site-->
            <!--e.g. $anu-procs is **possibly matching** procedures that can give rise to an anus specimen-->
            <!--in this sense, these are "maximal" lists, e.g. -->
            <!--put another way, there are the procedures that are **acceptable** matches to each site-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="anu-procs" value="$tox, $sex, $pox, $prx, $apx, $lax, $tdx"/>
            <let name="rec-procs" value="$tox, $sex, $pox, $prx, $apx, $lax, $tdx, $six, $lhx"/>
            <let name="rsj-procs" value="$tox, $sex, $pox, $prx, $apx, $lax, $six, $lhx"/>
            <let name="sig-procs" value="$tox, $sex, $pox, $apx, $lax, $six, $lhx"/>
            <let name="des-procs" value="$tox, $sex, $pox, $six, $lhx"/>
            <let name="spl-procs" value="$tox, $sex, $pox, $lhx, $trx"/>
            <let name="tra-procs" value="$tox, $sex, $pox, $lhx, $trx, $rhx"/>
            <let name="hep-procs" value="$tox, $sex, $pox, $trx, $rhx"/>
            <let name="asc-procs" value="$tox, $sex, $pox, $rhx, $asx"/>
            <let name="cec-procs" value="$tox, $sex, $pox, $rhx, $asx"/>
            <let name="ter-procs" value="$tox, $rhx, $asx"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--lists of sites matching each procedure-->
            <!--e.g. $prx-sites is **necessarily matching** sites yielded by a proctocolectomy procedure-->
            <!--in this sense, these are "minimal" lists-->
            <!--put another way, these are sites that are **required matches** to each procedure-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="tox-sites" value="$des, $spl, $tra, $hep, $hep, $asc, $cec"/>
            <!--<let name="sex-sites" value=""/>-->
            <!--<let name="pox-sites" value=""/>-->
            <let name="prx-sites" value="$anu, $rec"/>
            <let name="apx-sites" value="$rec"/>
            <let name="lax-sites" value="$rec"/>
            <let name="tdx-sites" value="$rec"/>
            <let name="six-sites" value="$sig"/>
            <let name="lhx-sites" value="$des"/>
            <let name="trx-sites" value="$tra"/>
            <let name="rhx-sites" value="$asc"/>
            <let name="asx-sites" value="$asc"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="procs" value="ecc:procedure/ecc:response/@value"/>
            <let name="sites" value="ecc:specimenSite/ecc:response/@value"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="msg1" value=" is among the reported sites, but no matching procedure is reported."/>
            <let name="msg2" value=" is reported, but corresponding specimen sites are absent."/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--This assertions tests that for every reported site, at least one possibly matching procedure is reported-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <assert test="not($anu = $sites and not($procs = $anu-procs))">Anus<value-of select="$msg1"/></assert>
            <assert test="not($rec = $sites and not($procs = $rec-procs))">Rectum<value-of select="$msg1"/></assert>
            <assert test="not($rsj = $sites and not($procs = $rsj-procs))">Rectosigmoid junction<value-of select="$msg1"/></assert>
            <assert test="not($sig = $sites and not($procs = $sig-procs))">Sigmoid colon<value-of select="$msg1"/></assert>
            <assert test="not($des = $sites and not($procs = $des-procs))">Left colon<value-of select="$msg1"/></assert>
            <assert test="not($spl = $sites and not($procs = $spl-procs))">Splenic flexure<value-of select="$msg1"/></assert>
            <assert test="not($tra = $sites and not($procs = $tra-procs))">Transverse colon<value-of select="$msg1"/></assert>
            <assert test="not($hep = $sites and not($procs = $hep-procs))">Hepatic flexure<value-of select="$msg1"/></assert>
            <assert test="not($asc = $sites and not($procs = $asc-procs))">Right colon<value-of select="$msg1"/></assert>
            <assert test="not($cec = $sites and not($procs = $cec-procs))">Cecum<value-of select="$msg1"/></assert>
            <assert test="not($ter = $sites and not($procs = $ter-procs))">Terminal ileum<value-of select="$msg1"/></assert>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--This assertion tests that for every reported procedure, at least the minimal set of necessarily matching site(s) is reported-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <assert test="not($tox = $procs and not(every $s in $tox-sites satisfies $s = $sites))">Total colectomy<value-of select="$msg2"/></assert>
            <assert test="not($prx = $procs and not(every $s in $prx-sites satisfies $s = $sites))">Proctocolectomy<value-of select="$msg2"/></assert>
            <assert test="not($apx = $procs and not(every $s in $apx-sites satisfies $s = $sites))">Abdominoperineal resection<value-of select="$msg2"/></assert>
            <assert test="not($lax = $procs and not(every $s in $lax-sites satisfies $s = $sites))">Low anterior resection<value-of select="$msg2"/></assert>
            <assert test="not($tdx = $procs and not(every $s in $tdx-sites satisfies $s = $sites))">Transanal disk excision<value-of select="$msg2"/></assert>
            <assert test="not($six = $procs and not(every $s in $six-sites satisfies $s = $sites))">Sigmoidectomy<value-of select="$msg2"/></assert>
            <assert test="not($lhx = $procs and not(every $s in $lhx-sites satisfies $s = $sites))">Left hemicolectomy<value-of select="$msg2"/></assert>
            <assert test="not($trx = $procs and not(every $s in $trx-sites satisfies $s = $sites))">Transverse colectomy<value-of select="$msg2"/></assert>
            <assert test="not($rhx = $procs and not(every $s in $rhx-sites satisfies $s = $sites))">Right hemicolectomy<value-of select="$msg2"/></assert>
            <assert test="not($asx = $sites and not(every $s in $asx-sites satisfies $s = $sites))">Ascending colectomy<value-of select="$msg2"/></assert>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--<pattern abstract="true" id="stage">
		<rule context="$which">
			<let name="x" value="$x"/>
			<let name="y" value="$y"/>
			<let name="z" value="$z"/>
			<report test="ecc:response/@value ne $calculated-stage">Reported stage
					(<name/><value-of select="ecc:response/@value"/>) does not match
				calculated (<name/><value-of select="$calculated-stage"/>).
			</report>
		</rule>
	</pattern>-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--<pattern id="T-stage" is-a="stage">
		<param name="which" value="/ecc:synopsis/ecc:stage/ecc:T"/>
		<param name="criterion-1"
			value="/ecc:synopsis/ecc:extent/colon:invasion/ecc:response/@value"/>
		<param name="criterion-2" value="()"/>
		<param name="criterion-3" value="()"/>
		<param name="calculated-stage"
			value="
			    (if ($x = 'adjacent structure')          then '4b'                   
			else if ($x = 'visceral peritoneal surface') then '4a'                  
			else if ($x = 'through muscularis propria')  then '3'
			else if ($x = 'muscularis propria')          then '2'                  
			else if ($x = 'submucosa')                   then '1'                  
			else if ($x = 'lamina propria')              then 'is'                  
			else if ($x = 'intraepithelial carcinoma')   then 'is'                  
			else if ($x = 'no evidence of tumor')        then '0'                  
			else 														     'X')"
		/>
	</pattern>-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-calculate-T-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pT assignment is correct, given the invasion reported in the "extent" section of
            the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="/ecc:synopsis/ecc:extent/colon:invasion/ecc:response">
            <let name="invasion" value="@value"/>
            <let name="T-reported" value="/ecc:synopsis/ecc:stage/ecc:T/ecc:response/@value"/>
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
                else                                                     'X' "/>
            <report test="$T-reported ne $T-calculated"> Reported T-stage (T<value-of select="$T-reported"/>) does not match calculated (T<value-of select="$T-calculated"/>).</report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--<pattern id="N-stage" is-a="stage">
		<param name="x" value="sum(//ecc:nodeGroup/ecc:count[@status='positive']/ecc:response/@value)"/>
		<param name="y" value="exists(//colon:tumorDeposits[@status='positive'])"/>
		<param name="z" value="()"/>
		<param name="query" value="/ecc:synopsis/ecc:stage/ecc:N"/>
	</pattern>-->
    <pattern id="colon-calculate-N-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pN assignment is correct, given the node statuses reported in the "nodes"
            section of the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="/ecc:synopsis/ecc:nodes">
            <let name="posNodes" value="sum(ecc:nodeGroup/ecc:count[@status='positive']/ecc:response/@value)"/>
            <let name="tumorDeposits" value="exists(colon:tumorDeposits[@status='positive'])"/>
            <let name="N-reported" value="../ecc:stage/ecc:N/ecc:response/@value"/>
            <let name="N-calculated"
                value="          if ($posNodes ge 7) then '2b'      else if ($posNodes ge 4) then '2a'      else if ($posNodes ge 2) then '1b'     else if ($posNodes eq 1) then '1a'     else if ($posNodes eq 0) then '0'     else if ($tumorDeposits) then '1c'     else                          'X'"/>
            <report test="$N-reported ne $N-calculated"> Reported N-stage (N<value-of select="$N-reported"/>) does not match calculated (N<value-of select="$N-calculated"/>).</report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pM assignment is correct, given the metastasis statuses reported in the
            "metastases" section of the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="/ecc:synopsis/ecc:metastases/ecc:metastasis">
            <let name="peritonealMet" value="@location eq 'peritoneum'"/>
            <let name="M-reported" value="/ecc:synopsis/ecc:stage/ecc:M/ecc:response/@value"/>
            <let name="M-calculated"
                value="          if ($peritonealMet) then '1b'     else if (count(.) gt 1)  then '1b'     else if (count(.) gt 0)  then '1a'     else                          'unreported'"/>
            <report test="($M-reported ne $M-calculated) and ($M-calculated ne 'unreported')"> >
            Reported M-stage (M<value-of select="$M-reported"/>) does not match calculated
               (M<value-of select="$M-calculated"/>).</report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="adjacent-structure-involvement">
        <rule context="/ecc:synopsis/ecc:extent/colon:invasion/ecc:response">
            <assert test="if (@value eq 'adjacent structure') then colon:adjacent else $skip"> You
            report invasion of an adjacent structure, but you do not specify which structure is
            involved and to what degree. (Use a {colon:adjacent} child element for this.) </assert>
            <assert test="if (colon:adjacent) then @value eq 'adjacent structure' else $skip">
            {adjacentStructure} element can be used only if deepest invasion is to adjacent
            structure. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="polyp-iff-polypectomy">
        <rule context="/ecc:synopsis/ecc:specimen">
            <assert test="if (exists(colon:polyp)) then ecc:procedure/ecc:response/@value = 'polypectomy' else $skip"> Polyp ("colon:polypectomy" element) is reported in the specimen section but the
            procedure is not polypectomy.</assert>
            <assert test="if (ecc:procedure/ecc:response/@value = 'polypectomy') then exists(colon:polyp) else $skip"> If the procedure is polypectomy then polyp features must be reported
            ("colon:polypectomy" element).</assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-grade">
        <rule context="/ecc:synopsis/ecc:tumor/ecc:grade">
            <report test="@system ne '2-grade'"> A 2-grade ("low-grade" vs. "high-grade") reporting
            system is recommended for colon carcinoma.</report>
        </rule>
    </pattern>
    <diagnostics>
        <diagnostic id="grade-dxic"> You have specified a <value-of select="@system"/> system. </diagnostic>
    </diagnostics>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
