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
    xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <ns prefix="ecc" uri="http://purl.org/pathology/ecc/"/>
    <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
    <ns prefix="f" uri="http://purl.org/pathology/ecc/functions/"/>
    <let name="skip" value="true()"/>
    <let name="cval" value="doc('values.rng')"/>
    <let name="val" value="doc('../framework/values.rng')"/>
    <let name="positive" value="'positive'"/>
    <xsl:function as="xs:decimal" name="f:mm">
        <xsl:param name="value"/>
        <xsl:param name="unit"/>
        <xsl:param name="relation"/>
        <xsl:variable name="lessThan" select="'less than'"/>
        <xsl:variable name="greaterThan" select="'greaterThan'"/>
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
    <!--=============================================================-->
    <pattern id="calculate-T-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pT assignment is correct, given the invasion reported in the
            "extent" section. This is the AJCC 7th edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:extent">
            <let name="T-reported" value="//ecc:stage/ecc:pT/ecc:response/@value"/>
            <let name="bbmucosa"
                value="ecc:contiguousExtension/ecc:status[@of eq 'invades']/ecc:result[@for = ('bladder mucosa','bowel mucosa')]/ecc:response[@value eq $positive]"/>
            <let name="vagpara"
                value="ecc:contiguousExtension/ecc:status[@of eq 'invades']/ecc:result[@for = ('vagina','parametrium')]/ecc:response[@value eq $positive]"/>
            <let name="serad"
                value="ecc:contiguousExtension/ecc:status[@of eq 'invades']/ecc:result[@for = ('omentum','ovary','fallopian tube')]/ecc:response[@value eq $positive]"/>
            <let name="cervix" value="ecc:cervicalStromalInvasion/ecc:response[@value eq $positive]"/>
            <let name="gehalf"
                value="ecc:myometrialInvasion/ecc:response[@value eq 'equal or greater than 50%']"/>
            <let name="depth" value="ecc:myometrialInvasion/ecc:depth/ecc:response"/>
            <let name="thickness" value="ecc:myometrialInvasion/ecc:thickness/ecc:response"/>
            <let name="mym"
                value="f:mm($depth/@value,$depth/@unit,$depth/@relation) div f:mm($thickness/@value,$thickness/@unit,$thickness/@relation) "/>
            <let name="T-calculated"
                value="  if ($bbmucosa)    then '4'
					else if ($vagpara)     then '3b'
					else if ($serad)       then '3a'
					else if ($cervix)      then '2'
					else if ($gehalf)      then '1b'
					else if ($mym ge 0.5)  then '1b'
					else if ($mym gt 0.0)  then '1a'
					else if ($mym eq 0.0)  then 'is'
					else                        'X'"/>
            <report test="$T-reported ne $T-calculated">
                Reported T-stage (<value-of select="$T-reported"/>) does not match calculated (<value-of select="$T-calculated"/>).
            </report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <pattern id="calculate-N-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pN assignment is correct, given the node statuses reported
            in the "nodes" section of the patient's report. This is the AJCC 7th edition
            algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:nodes">
            <let name="N-reported" value="//ecc:pN/ecc:response/@value"/>
            <let name="pos"
                value="sum(ecc:nodeGroup[@name ne 'inguinal']/ecc:status/ecc:tally[@type eq $positive]/ecc:response/@value)"/>
            <let name="posPara"
                value="sum(ecc:nodeGroup[@name eq 'para-aortic']/ecc:status/ecc:tally[@type eq $positive]/ecc:response/@value)"/>
            <let name="N-calculated"
                value="if ($posPara gt 0) then '2' else if ($pos gt 0) then '1' else '0'"/>
            <report test="$N-reported ne $N-calculated">
                Reported N-stage (<value-of select="$N-reported"/>) does not match calculated (<value-of select="$N-calculated"/>).
            </report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
    <pattern id="calculate-M-stage">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <p>This pattern checks that the pM assignment is correct, given the metastasis statuses
            reported in the "metastases" section of the patient's report. This is the AJCC 7th
            edition algorithm.</p>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <rule context="//ecc:distant">
            <let name="M-reported" value="//ecc:pM/ecc:response/@value"/>
            <let name="pos"
                value="exists(ecc:site/ecc:status/ecc:result/ecc:response[@value eq $positive])"/>
            <let name="posInguinal"
                value="exists(//ecc:nodes/ecc:nodeGroup[@name eq 'inguinal']/ecc:status/ecc:result[@for eq $positive]/ecc:response[@value castable as xs:integer][xs:integer(@value) gt 0])"/>
            <let name="M-calculated"
                value="  if ($pos or $posInguinal)                     then '1'
					else if (exists(ecc:site/ecc:status/ecc:response)) then '0'
					else                                                    'unreported'"/>
            <report test="$M-reported ne $M-calculated">
               Reported M-stage (<value-of select="$M-reported"/>) does not match calculated (<value-of select="$M-calculated"/>).
            </report>
        </rule>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    </pattern>
</schema>
