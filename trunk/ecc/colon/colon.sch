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
    xmlns:data="http://purl.org/pathology/ecc/data" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="data" uri="http://purl.org/pathology/ecc/data"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="positive" value="'positive'"/>
    <!--=============================================================-->
    <pattern id="mesorectum-iff-rectum-specimen">
        <rule context="//ecc:mesorectumIntact/ecc:response[@value ne 'unreported']">
            <assert role="error" test="//ecc:specimen/ecc:site/ecc:response[@value eq 'rectum']">
                You may not report on mesorectum intactness unless the specimen includes rectum.
            </assert>
        </rule>
        <rule context="//ecc:specimen/ecc:site/ecc:response[@value = 'rectum']">
            <assert role="warning" test="//ecc:mesorectumIntact/ecc:response[@value ne 'unreported']">
                Since the specimen includes rectum, you should report on mesorectum intactness.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <include href="../framework/shared/abstractPatterns/site-proc-match.sch"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-site-proc-match" is-a="site-proc-match">
        <param name="data-source" value="''"/>
    </pattern>
    <!--=============================================================-->
    <include href="../framework/shared/abstractPatterns/proc-site-match.sch"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="colon-proc-site-match" is-a="proc-site-match">
        <param name="data-source" value="''"/>
    </pattern>
    <!--=============================================================-->
    <pattern id="colon-calculate-T-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pT assignment is correct, given the invasion reported in the "extent" section of
            the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:pT/ecc:response">
            <let name="T-reported" value="@value"/>
            <let name="invasion" value="//ecc:extent/ecc:deepestInvasion/ecc:response/@value"/>
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
            <report test="$T-reported ne $T-calculated">
                Reported T-stage (<value-of select="$T-reported"/>) does not match calculated (<value-of select="$T-calculated"/>).
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="colon-calculate-N-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pN assignment is correct, given the node statuses reported in the "nodes"
            section. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:pN/ecc:response">
            <let name="N-reported" value="@value"/>
            <let name="posNodes" value="sum(//ecc:nodes/ecc:status/ecc:result[@for eq $positive]/ecc:response/@value)"/>
            <let name="tumorDeposits" value="//ecc:peritumoralDeposits/ecc:response/@value eq 'positive'"/>
            <let name="N-calculated"
                value="  if ($posNodes ge 7) then '2b'
					else if ($posNodes ge 4) then '2a'
					else if ($posNodes ge 2) then '1b'
					else if ($posNodes eq 1) then '1a'
					else if ($posNodes eq 0) then '0'
					else if ($tumorDeposits) then '1c'
					else                          'X'"/>
            <report test="$N-reported ne $N-calculated">
                Reported N-stage (<value-of select="$N-reported"/>) does not match calculated (<value-of select="$N-calculated"/>).
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pM assignment is correct, given the metastasis statuses reported in the
            "metastases" section of the patient's report. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:pM/ecc:response">
            <let name="M-reported" value="@value"/>
            <let name="peritoneum"
                value="//ecc:distant/ecc:status[@of eq 'peritoneum']/ecc:result/ecc:response/@value eq 'positive' or
                //ecc:contiguousExtension/ecc:status[@of eq 'peritoneum']/ecc:result[@for eq
                'invades']/ecc:response/@value eq 'positive'"/>
            <let name="positive-count" value="count(ecc:site/ecc:status/ecc:result/ecc:response[@value eq 'positive'])"/>
            <let name="M-calculated"
                value="  if ($peritoneum)          then '1b'
					else if ($positive-count gt 1) then '1b'
					else if ($positive-count gt 0) then '1a'
					else                                'unreported'"/>
            <report test="$M-reported ne $M-calculated">
                Reported M-stage (<value-of select="$M-reported"/>) does not match calculated (<value-of select="$M-calculated"/>).
            </report>
        </rule>
    </pattern>
    <!--=============================================================-->
    <pattern id="colon-grade">
        <rule context="//ecc:tumor//ecc:grade" role="warning">
            <assert test="@system eq '2-grade'">
                A 2-grade ("low-grade" vs. "high-grade") reporting system is recommended for colon carcinoma.
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <data:procedures>
        <!--sites that are **OBLIGATE MATCHES** to the procedure that precedes them-->
        <!--in other words, a procedure is first given; this is followed by a list of procedures that *must* be present if that procedure was performed-->
        <data:proc of="total colectomy">
            <data:site>sigmoid colon</data:site>
            <data:site>descending colon</data:site>
            <data:site>splenic flexure</data:site>
            <data:site>transverse colon</data:site>
            <data:site>hepatic flexure</data:site>
            <data:site>ascending colon</data:site>
            <data:site>cecum</data:site>
        </data:proc>
        <data:proc of="segmental colectomy"/>
        <data:proc of="proctocolectomy">
            <data:site>anus</data:site>
            <data:site>rectum</data:site>
        </data:proc>
        <data:proc of="abdominoperineal resection">
            <data:site>rectum</data:site>
        </data:proc>
        <data:proc of="low anterior resection">
            <data:site>rectum</data:site>
        </data:proc>
        <data:proc of="transanal disk excision">
            <data:site>rectum</data:site>
        </data:proc>
        <data:proc of="sigmoidectomy">
            <data:site>sigmoid colon</data:site>
        </data:proc>
        <data:proc of="left hemicolectomy">
            <data:site>descending colon</data:site>
        </data:proc>
        <data:proc of="transverse colectomy">
            <data:site>transverse colon</data:site>
        </data:proc>
        <data:proc of="right hemicolectomy">
            <data:site>ascending colon</data:site>
        </data:proc>
        <data:proc of="ascending colectomy">
            <data:site>ascending colon</data:site>
        </data:proc>
        <data:proc of="polypectomy"/>
    </data:procedures>
    <data:sites>
        <!--procedures that are **ALLOWABLE MATCHES** to the site that precedes them-->
        <!--in other words, a site is first given; this is followed by a list of procedures that *can* give rise to that site-->
        <data:site of="anus">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>proctocolectomy</data:proc>
            <data:proc>abdominoperineal resection</data:proc>
            <data:proc>low anterior resection</data:proc>
            <data:proc>transanal disk excision</data:proc>
        </data:site>
        <data:site of="rectum">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>proctocolectomy</data:proc>
            <data:proc>abdominoperineal resection</data:proc>
            <data:proc>low anterior resection</data:proc>
            <data:proc>transanal disk excision</data:proc>
            <data:proc>sigmoidectomy</data:proc>
            <data:proc>left hemicolectomy</data:proc>
        </data:site>
        <data:site of="rectomsigmoid junction">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>proctocolectomy</data:proc>
            <data:proc>abdominoperineal resection</data:proc>
            <data:proc>low anterior resection</data:proc>
            <data:proc>sigmoidectomy</data:proc>
            <data:proc>left hemicolectomy</data:proc>
        </data:site>
        <data:site of="sigmoid colon">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>abdominoperineal resection</data:proc>
            <data:proc>low anterior resection</data:proc>
            <data:proc>sigmoidectomy</data:proc>
            <data:proc>left hemicolectomy</data:proc>
        </data:site>
        <data:site of="left colon">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>abdominoperineal resection</data:proc>
            <data:proc>sigmoidectomy</data:proc>
            <data:proc>left hemicolectomy</data:proc>
        </data:site>
        <data:site of="splenic flexure">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>left hemicolectomy</data:proc>
            <data:proc>transverse colectomy</data:proc>
        </data:site>
        <data:site of="transverse colon">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>left hemicolectomy</data:proc>
            <data:proc>transverse colectomy</data:proc>
            <data:proc>right hemicolectomy</data:proc>
        </data:site>
        <data:site of="hepatic flexure">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>transverse colectomy</data:proc>
            <data:proc>right hemicolectomy</data:proc>
        </data:site>
        <data:site of="right colon">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>right hemicolectomy</data:proc>
            <data:proc>ascending colectomy</data:proc>
        </data:site>
        <data:site of="cecum">
            <data:proc>total colectomy</data:proc>
            <data:proc>segmental colectomy</data:proc>
            <data:proc>polypectomy</data:proc>
            <data:proc>right hemicolectomy</data:proc>
            <data:proc>ascending colectomy</data:proc>
        </data:site>
        <data:site of="terminal ileum">
            <data:proc>total colectomy</data:proc>
            <data:proc>right hemicolectomy</data:proc>
            <data:proc>ascending colectomy</data:proc>
        </data:site>
    </data:sites>
</schema>
