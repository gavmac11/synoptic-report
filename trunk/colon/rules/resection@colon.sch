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
   <ns prefix="ecc" uri="http://www.cap.org/pert/2009/01/"/>
   <ns prefix="colon" uri="http://www.cap.org/pert/2009/01/colon/"/>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <let name="skip" value="true()"/>
   <let name="no-report" value="false()"/>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <pattern id="colon-site-matches-procedure">
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
         <let name="pox" value="polypectomy"/>
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--procedure strings (cf. specimen.site.response.value.valueset in project/colon/components/valuesets.rng)-->
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--lists of procedures matching each site-->
         <!--e.g. $anu-procs is **possibly matching** procedures that can give rise to an anus specimen-->
         <!--in this sense, these are "maximal" lists, e.g. -->
         <!--put another way, there are the procedures that are **acceptable** matches to each site-->
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--lists of sites matching each procedure-->
         <!--e.g. $prx-sites is **necessarily matching** sites yielded by a proctocolectomy procedure-->
         <!--in this sense, these are "minimal" lists-->
         <!--put another way, these are sites that are **required matches** to each procedure-->
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--<let name="tox-sites" value=""/> any site is fine-->
         <!--<let name="sex-sites" value=""/> any site is fine-->
         <!--<let name="pox-sites" value=""/> any site is fine-->
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
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--This assertions tests that for every reported site, at least one possibly matching procedure is reported-->
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
         <!--This assertion tests that for every reported procedure, at least the minimal set of necessarily matching site(s) is reported-->
         <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   </pattern>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <pattern id="colon-calculate-T-stage">
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
      <p>This pattern checks that the pT assignment is correct, given the
         invasion reported in the "extent" section of the patient's report. This
         is the AJCC 7th edition algorithm.</p>
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   </pattern>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <pattern id="colon-calculate-N-stage">
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
      <p>This pattern checks that the pN assignment is correct, given the node
         statuses reported in the "nodes" section of the patient's report. This
         is the AJCC 7th edition algorithm.</p>
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   </pattern>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <pattern>
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
      <p>This pattern checks that the pM assignment is correct, given the
         metastasis statuses reported in the "metastases" section of the
         patient's report. This is the AJCC 7th edition algorithm.</p>
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
      <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   </pattern>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
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
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <pattern id="polyp-iff-polypectomy">
      <rule context="/ecc:synopsis/ecc:specimen">
         <assert
            test="exists(colon:polyp) eq (ecc:procedure/ecc:response/@value = 'polypectomy')"
            > Polyp is reportable in the specimen section if and only if the
            procedure is polypectomy.</assert>
      </rule>
   </pattern>
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
   <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
</schema>
