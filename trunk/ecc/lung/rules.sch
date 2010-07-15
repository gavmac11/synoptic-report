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
    xmlns:data="http://purl.org/pathology/ecc/data" xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <ns prefix="ca" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="f" uri="http://purl.org/pathology/ecc/functions/"/>
    <ns prefix="data" uri="http://purl.org/pathology/ecc/data"/>
    <let name="skip" value="true()"/>
    <let name="positive" value="'positive'"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:function as="xs:decimal" name="f:mm">
        <xsl:param name="value"/>
        <xsl:param name="unit"/>
        <xsl:param name="relation"/>
        <xsl:variable name="lessThan" select="'less than'"/>
        <xsl:variable name="greaterThan" select="'greater than'"/>
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
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-T-stage">
        <rule context="ca:pT/ca:response">
            <let name="reported-T" value="@value"/>
            <let name="t3-sites"
                value="('parietal pleura', 'chest wall', 'diaphragm', 'phrenic nerve', 'mediastinal pleura', 'parietal pericardium')"/>
            <let name="t4-sites"
                value="('mediastinum', 'heart', 'great vessels', 'trachea', 'recurrent laryngeal nerve', 'esophagus', 'vertebral body', 'carina')"/>
            <let name="contiguous"
                value="//ca:contiguousExtension/ca:status[ca:result[@for eq 'invades']/ca:response/@value eq $positive]/@of"/>
            <let name="br-dist"
                value="//ca:contiguousExtension/ca:status[@of eq 'main bronchus']/ca:result[@for eq 'invades']/ca:distance[@from eq 'carina']/ca:response"/>
            <let name="t3-bronchus" value="f:mm($br-dist/@value,$br-dist/@unit,$br-dist/@relation) lt 20"/>
            <let name="t2-bronchus" value="f:mm($br-dist/@value,$br-dist/@unit,$br-dist/@relation) ge 20"/>
            <let name="foci" value="count(//ca:focus)"/>
            <let name="sep-nodules" value="$foci gt 1"/>
            <let name="sep-nodules-diff-lobes"
                value="true() = (for $x in 1 to ($foci - 1), $y in ($x + 1) to $foci return //ca:focus[$x]/ca:site/ca:response/@value != //ca:focus[$y]/ca:site/ca:response/@value)"/>
            <let name="pleura" value="//ca:pleuralInvasion/ca:response/@value"/>
            <let name="PL3" value="$pleura eq 'in parietal pleura'"/>
            <let name="PL1-2" value="$pleura = ('past visceral pleura elastica','to visceral pleura surface')"/>
            <let name="poc" value="//ca:extent/ca:postobstructiveChanges/ca:response/@value"/>
            <let name="atel-lung" value="$poc eq 'involving entire lung'"/>
            <let name="atel-hilum" value="$poc eq 'extending to hilum'"/>
            <let name="size"
                value="max(for $x in //ca:focus/ca:size/ca:response return f:mm($x/@value,$x/@unit,$x/@relation))"/>
            <let name="calculated-T"
                value="
                         if ($contiguous = $t4-sites) then '4'
                    else if ($sep-nodules-diff-lobes) then '4'
                    else if ($contiguous = $t3-sites) then '3'
                    else if ($size gt 70)             then '3'
                    else if ($t3-bronchus)            then '3'
                    else if ($PL3)                    then '3'
                    else if ($sep-nodules)            then '3'
                    else if ($atel-lung)              then '3'
                    else if ($size gt 50)             then '2b'
                    else if ($size gt 30)             then '2a'
                    else if ($PL1-2)                  then '2a'
                    else if ($t2-bronchus)            then '2a'
                    else if ($atel-hilum)             then '2a'
                    else if ($size gt 20)             then '1b'
                    else if ($size gt 0)              then '1a'
                    else                                   'X'  "/>
            <assert test="$calculated-T eq $reported-T">
                Reported T-stage (<value-of select="$reported-T"/>) does not match calculated (<value-of select="$calculated-T"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="//ca:pN/ca:response">
            <let name="reported-N" value="@value"/>
            <let name="N3"
                value="sum(//ca:nodes/ca:status[@laterality eq 'contralateral']/ca:result[@for eq 'positive']/ca:response/@value[. castable as xs:integer]) gt 0"/>
            <let name="N2"
                value="sum(//ca:nodes/ca:status[@of = ('mediastinal','subcarinal')]/ca:result[@for eq 'positive']/ca:response/@value[. castable as xs:integer]) gt 0"/>
            <let name="N1"
                value="sum(//ca:nodes/ca:status/ca:result[@for eq 'positive']/ca:response/@value[. castable as xs:integer]) gt 0"/>
            <let name="calculated-N"
                value="
                             if ($N3) then '3' 
                        else if ($N2) then '2' 
                        else if ($N1) then '1' 
                        else               '0'"/>
            <assert test="$calculated-N eq $reported-N">
                Reported N-stage (<value-of select="$reported-N"/>) does not match calculated (<value-of select="$calculated-N"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//ca:pM/ca:response">
            <let name="reported-M" value="@value"/>
            <let name="distant"
                value="//ca:distant/ca:status[matches(@of,'brain|bone|adrenal|liver|kidney|skin','ix')]/ca:result/ca:response[@value
                eq 'positive']"/>
            <let name="mpe" value="//ca:malignantEffusion[@of eq 'pleura']/ca:response/@value eq 'positive'"/>
            <let name="pleural-nodules" value="//ca:pleuralNodules/ca:response/@value eq 'positive'"/>
            <let name="contra-lobe"
                value="//ca:distant/ca:status[matches(@of,'lung|lobe|segment|lingula','ix')][@laterality eq
                'contralateral']/ca:result/ca:response/@value eq 'positive'"/>
            <let name="pce"
                value="//ca:malignantEffusion[@of eq 'pericardium']/ca:response/@value eq 'positive'"/>
            <let name="calculated-M"
                value="
                                    if ($distant)          then '1b'
                                    else if ($mpe)         then '1a'
                                    else if ($contra-lobe) then '1a'
                                    else if ($mpe)         then '1a'
                                    else if ($pce)         then '1a'
                                    else                        '0'"/>
            <assert test="$calculated-M eq $reported-M">
                Reported M-stage (<value-of select="$reported-M"/>) does not match calculated (<value-of select="$calculated-M"/>).
            </assert>
        </rule>
    </pattern>
    <!--=============================================================-->
    <include href="../framework/shared/abstractPatterns/site-proc-match.sch"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="lung-site-proc-match" is-a="site-proc-match">
        <param name="data-source" value="''"/>
    </pattern>
    <!--=============================================================-->
    <include href="../framework/shared/abstractPatterns/proc-site-match.sch"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="lung-proc-site-match" is-a="proc-site-match">
        <param name="data-source" value="''"/>
    </pattern>
    <!--=============================================================-->
    <include href="../framework/shared/abstractPatterns/subset-rule.sch"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="tumor-sites-subset-specimen-sites" is-a="subset-rule">
        <param name="data-source" value="''"/>
        <param name="context" value="//ca:tumor"/>
        <param name="subset" value="//ca:tumor/ca:focus/ca:site/ca:response/@value"/>
        <param name="superset" value="//ca:specimen/ca:site/ca:response/@value"/>
        <param name="rule-id" value="tssss"/>
        <param name="subName" value="'tumor sites'"/>
        <param name="superName" value="'specimen sites'"/>
    </pattern>
    <!--=============================================================-->
    <data:procedures>
        <!--sites that are **OBLIGATE MATCHES** to the procedure that precedes them-->
        <!--in other words, a procedure is first given; this is followed by a list of procedures that *must* be present if that procedure was performed-->
        <data:proc of="wedge biopsy"/>
        <data:proc of="transbronchial biopsy"/>
        <data:proc of="endobronchial biopsy"/>
        <data:proc of="pneumonectomy">
            <data:site>entire lung</data:site>
        </data:proc>
        <data:proc of="segmentectomy"/>
        <data:proc of="lobectomy"/>
        <data:proc of="bilobectomy"/>
        <data:proc of="major airway resection"/>
    </data:procedures>
    <data:sites>
        <!--procedures that are **ALLOWABLE MATCHES** to the site that precedes them-->
        <!--in other words, a site is first given; this is followed by a list of procedures that *can* give rise to that site-->
        <data:site of="main bronchus">
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
        </data:site>
        <data:site of="entire lung">
            <data:proc>pneumonectomy</data:proc>
        </data:site>
        <data:site of="upper lobe">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="middle lobe">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="lower lobe">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="lingula">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="apical right upper segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="posterior right upper segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="anterior right upper segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="lateral right middle segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="medial right middle segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="superior right lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of=" medial-basal right lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="anterior-basal right lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="lateral-basal right lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="apical-posterior left upper segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="anterior left upper segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="inferior lingular segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="superior left lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="anteromedial-basal left lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="posterior-basal left lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="lateral-basal left lower segment">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="upper lobe bronchus">
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="bronchus intermedius">
            <data:proc>bilobectomy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="right middle lobe bronchus">
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="lower lobe bronchus">
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="carina">
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
        </data:site>
        <data:site of="main bronchus">
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>endobronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>major airway resection</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
        <data:site of="visceral pleura">
            <data:proc>wedge biopsy</data:proc>
            <data:proc>transbronchial biopsy</data:proc>
            <data:proc>pneumonectomy</data:proc>
            <data:proc>segmentectomy</data:proc>
            <data:proc>lobectomy</data:proc>
            <data:proc>bilobectomy</data:proc>
        </data:site>
    </data:sites>
    <data:expansions for="tssss">
        <data:expansion of="entire lung">
            <data:value>entire lung</data:value>
            <data:value>upper lobe</data:value>
            <data:value>middle lobe</data:value>
            <data:value>lower lobe</data:value>
            <data:value>lingula</data:value>
            <data:value>upper lobe bronchus</data:value>
            <data:value>middle lobe bronchus</data:value>
            <data:value>lower lobe bronchus</data:value>
            <data:value>bronchus intermedius</data:value>
            <data:value>main bronchus</data:value>
            <data:value>apical right upper segment</data:value>
            <data:value>posterior right upper segment</data:value>
            <data:value>anterior right upper segment</data:value>
            <data:value>lateral right middle segment</data:value>
            <data:value>medial right middle segment</data:value>
            <data:value>superior right lower segment</data:value>
            <data:value>medial-basal right lower segment</data:value>
            <data:value>anterior-basal right lower segment</data:value>
            <data:value>lateral-basal right lower segment</data:value>
            <data:value>apical-posterior left upper segment</data:value>
            <data:value>anterior left upper segment</data:value>
            <data:value>inferior lingular segment</data:value>
            <data:value>superior left lower segment</data:value>
            <data:value>anteromedial-basal left lower segment</data:value>
            <data:value>posterior-basal left lower segment</data:value>
            <data:value>lateral-basal left lower segment</data:value>
            <data:value>visceral pleura</data:value>
        </data:expansion>
        <data:expansion of="upper lobe">
            <data:value>upper lobe</data:value>
            <data:value>apical right upper segment</data:value>
            <data:value>posterior right upper segment</data:value>
            <data:value>anterior right upper segment</data:value>
            <data:value>apical-posterior left upper segment</data:value>
            <data:value>anterior left upper segment</data:value>
            <data:value>upper lobe bronchus</data:value>
            <data:value>visceral pleura</data:value>
        </data:expansion>
        <data:expansion of="middle lobe">
            <data:value>middle lobe</data:value>
            <data:value>apical right upper segment</data:value>
            <data:value>lateral right middle segment</data:value>
            <data:value>medial right middle segment</data:value>
            <data:value>right middle lobe bronchus</data:value>
            <data:value>visceral pleura</data:value>
        </data:expansion>
        <data:expansion of="lower lobe">
            <data:value>lower lobe</data:value>
            <data:value>superior right lower segment</data:value>
            <data:value>medial-basal right lower segment</data:value>
            <data:value>anterior-basal right lower segment</data:value>
            <data:value>lateral-basal right lower segment</data:value>
            <data:value>superior left lower segment</data:value>
            <data:value>anteromedial-basal left lower segment</data:value>
            <data:value>posterior-basal left lower segment</data:value>
            <data:value>lateral-basal left lower segment</data:value>
            <data:value>lower lobe bronchus</data:value>
            <data:value>visceral pleura</data:value>
        </data:expansion>
        <data:expansion of="lingula">
            <data:value>lingula</data:value>
            <data:value>inferior lingular segment</data:value>
            <data:value>visceral pleura</data:value>
        </data:expansion>
    </data:expansions>
</schema>
