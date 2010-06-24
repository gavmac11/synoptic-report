<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <ns prefix="ecc" uri="http://cap#"/>
    <let name="skip" value="true()"/>
    <pattern id="mesorectum-iff-rectum-specimen">
        <rule context="//ecc:item[@name eq 'mesorectum intactness']/ecc:response[@value ne 'unreported']">
            <assert role="error" test="//ecc:section[@name eq 'specimen']/ecc:item[@name eq 'site']/ecc:response[@value eq 'rectum']">You may not report on mesorectum intactness unless the specimen includes
				rectum.</assert>
        </rule>
        <rule context="//ecc:section[@name eq 'specimen']/ecc:item[@name eq 'site']/ecc:response[@value = 'rectum']">
            <assert role="warning" test="//ecc:item[@name eq 'mesorectum intactness']/ecc:response[@value ne                 'unreported']">Since the
				specimen includes rectum, you should report on mesorectum intactness.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//ecc:section[@name eq 'specimen']">
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
            <!--table of procedures matching each site-->
            <!--e.g. $anu-procs is **possibly matching** procedures that can give rise to an anus specimen-->
            <!--in this sense, this is a "maximal" table, e.g. -->
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
            <!--table of required sites for each procedure-->
            <!--e.g. $prx-sites is **necessarily matching** sites yielded by a proctocolectomy procedure-->
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
            <let name="procs"
                value="//ecc:section[@name eq 'specimen']/ecc:item[@name eq 'procedure']/ecc:response/@value"/>
            <let name="sites" value="//ecc:section[@name eq 'specimen']/ecc:item[@name eq 'site']/ecc:response/@value"/>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <let name="msg1" value="' is among the reported sites, but no matching procedure is reported.'"/>
            <let name="msg2" value="' is reported, but corresponding specimen sites are absent.'"/>
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
            <report test="$tox = $procs and not(every $s in $tox-sites satisfies $s = $sites)">Total colectomy<value-of select="$msg2"/></report>
            <report test="$prx = $procs and not(every $s in $prx-sites satisfies $s = $sites)">Proctocolectomy<value-of select="$msg2"/></report>
            <report test="$apx = $procs and not(every $s in $apx-sites satisfies $s = $sites)">Abdominoperineal resection<value-of select="$msg2"/></report>
            <report test="$lax = $procs and not(every $s in $lax-sites satisfies $s = $sites)">Low anterior resection<value-of select="$msg2"/></report>
            <report test="$tdx = $procs and not(every $s in $tdx-sites satisfies $s = $sites)">Transanal disk excision<value-of select="$msg2"/></report>
            <report test="$six = $procs and not(every $s in $six-sites satisfies $s = $sites)">Sigmoidectomy<value-of select="$msg2"/></report>
            <report test="$lhx = $procs and not(every $s in $lhx-sites satisfies $s = $sites)">Left hemicolectomy<value-of select="$msg2"/></report>
            <report test="$trx = $procs and not(every $s in $trx-sites satisfies $s = $sites)">Transverse colectomy<value-of select="$msg2"/></report>
            <report test="$rhx = $procs and not(every $s in $rhx-sites satisfies $s = $sites)">Right hemicolectomy<value-of select="$msg2"/></report>
            <report test="$asx = $sites and not(every $s in $asx-sites satisfies $s = $sites)">Ascending colectomy<value-of select="$msg2"/></report>
        </rule>
    </pattern>
    <pattern id="colon-calculate-T-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pT assignment is correct, given the invasion reported in the "extent" section of
            the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:section[@name eq 'extent']/ecc:item[@name eq 'deepest invasion']/ecc:response">
            <let name="invasion" value="@value"/>
            <let name="T-reported" value="//ecc:section[@name eq 'stage']/ecc:item[@name eq 'pT']/ecc:response/@value"/>
            <let name="T-calculated"
                value="  if ($invasion = 'adjacent structure')          then '4b'
					else if ($invasion = 'visceral peritoneal surface') then '4a'
					else if ($invasion = 'pericolorectal tissues')      then '3'
					else if ($invasion = 'through muscularis propria')  then '3'
					else if ($invasion = 'muscularis propria')          then '2'
					else if ($invasion = 'submucosa')                   then '1'
					else if ($invasion = 'lamina propria')              then 'is'
					else if ($invasion = 'intraepithelial carcinoma')   then 'is'
					else if ($invasion = 'no evidence of tumor')        then '0'
					else                                                     'X'"/>
            <report test="$T-reported ne $T-calculated"> Reported T-stage (<value-of select="$T-reported"/>) does not match calculated (<value-of select="$T-calculated"/>).</report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <pattern id="colon-calculate-N-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pN assignment is correct, given the node statuses reported in the "nodes"
            section of the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:section[@name eq 'nodes']">
            <let name="posNodes" value="sum(.//ecc:item[@name eq 'positive']/ecc:response/@value)"/>
            <let name="tumorDeposits"
                value="ecc:section[@site eq 'tumor deposits']/ecc:item[@name='positive']/ecc:response/@value gt 0"/>
            <let name="N-reported" value="//ecc:item[@name eq 'pN']/ecc:response/@value"/>
            <let name="N-calculated"
                value="  if ($posNodes ge 7) then '2b'
					else if ($posNodes ge 4) then '2a'
					else if ($posNodes ge 2) then '1b'
					else if ($posNodes eq 1) then '1a'
					else if ($posNodes eq 0) then '0'
					else if ($tumorDeposits) then '1c'
					else                          'X'"/>
            <report test="$N-reported ne $N-calculated"> Reported N-stage (<value-of select="$N-reported"/>) does not match calculated (<value-of select="$N-calculated"/>).</report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <pattern>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pM assignment is correct, given the metastasis statuses reported in the
            "metastases" section of the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:section[@name eq 'distant']">
            <let name="peritoneum"
                value="ecc:section[@site eq 'peritoneum']/ecc:item[@name eq 'result']/ecc:response/@value eq 'positive'"/>
            <let name="M-reported" value="//ecc:item[@name eq 'pM']/ecc:response/@value"/>
            <let name="positive-count" value="count(./*/*/ecc:response[@value eq 'positive'])"/>
            <let name="M-calculated"
                value="  if ($peritoneum)          then '1b'
					else if ($positive-count gt 1) then '1b'
					else if ($positive-count gt 0) then '1a'
					else                                'unreported'"/>
            <report test="$M-reported ne $M-calculated">
                Reported M-stage (<value-of select="$M-reported"/>) does not match calculated (<value-of select="$M-calculated"/>).
            </report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <pattern id="colon-grade">
        <rule role="warning" context="//item[@name eq 'histologic grade']">
            <assert test="@modifier eq '2-grade'"> A 2-grade ("low-grade" vs. "high-grade") reporting
            system is recommended for colon carcinoma.</assert>
        </rule>
    </pattern>
</schema>
