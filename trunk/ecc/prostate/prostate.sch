<?xml version="1.0" encoding="UTF-8"?>

<!--
    
    Schema for Synoptic Reports
    (c) Copyright 2010 Pathology Consulting Services
    ===========================================================================
    Component name:
    resection@prostate.sch
    
    Component type:
    schematron schema for rules-based validation
    
    Version date:
    2008.12.31
    
    Defines:
    
    
    Purpose:
    
    
    
    Dependencies:      
    
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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="ca" uri="http://purl.org/pathology/ecc/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <let name="rside" value="'right side'"/>
    <let name="lside" value="'left side'"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="seminal-vesicle-extent-only-if-positive">
        <rule context="//ca:extent/ca:seminalVesicleInvasion/ca:result/ca:response">
            <report test="@value ne 'positive' and @extent"> Negative seminal
                vesicles must not report extent. </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-overall-PTI">
        <rule context="//ca:tumorVolume" role="warning">
            <!-- I use the sum function to coerce NaN to 0. -->
            <let name="r"
                value="sum(ca:result[@for eq 'right']/ca:response/@value[. castable as xs:integer])"/>
            <let name="l"
                value="sum(ca:result[@for eq 'left']/ca:response/@value[. castable as xs:integer])"/>
            <let name="b"
                value="sum(ca:result[@for eq 'bilateral']/ca:response/@value[. castable as xs:integer])"/>
            <assert test="max (($r, $l)) ge $b and min (($r, $l)) le $b"> Bilateral cancer volume must be between the right and left
                unilateral volumes. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-T-stage">
        <rule context="//ca:pT/ca:response">
            <let name="reported-T" value="@value"/>
            <let name="adj"
                value="//ca:contiguousExtension/ca:status[of eq 'invades']/result/@for[../ca:response eq 'positive']"/>
            <let name="epe"
                value="//ca:extracapsularExtension/ca:result/ca:response/@value[. eq 'positive']"/>
            <let name="svi"
                value="//ca:seminalVesicleInvasion/ca:result/ca:response/@value[. eq 'positive']"/>
            <let name="rpti"
                value="sum(//ca:tumorVolume/ca:result[@for = 'right']/ca:response/@value[. castable as xs:integer])"/>
            <let name="lpti"
                value="sum(//ca:tumorVolume/ca:result[@for = 'left']/ca:response/@value[. castable as xs:integer])"/>
            <let name="calculated-T"
                value="                                       
                     if ($adj = 'bladder' or $adj = 'rectum') then '4'                   
                else if ($svi)                                then '3b'                  
                else if ($epe)                                then '3a'                 
                else if ($rpti > 0 and $lpti > 0)             then '2c'        
                else if ($rpti = 0 and $lpti > 50)            then '2b'
                else if ($lpti = 0 and $rpti > 50)            then '2b'             
                else if ($rpti = 0 and $lpti > 0)             then '2a'        
                else if ($lpti = 0 and $lpti > 0)             then '2a'                
                else if ($rpti = 0 and $lpti = 0)             then '0'                 
                else                                               'X'    "/>
            <assert test="$calculated-T eq $reported-T">
                Reported T-stage (<value-of select="$reported-T"/>) does not match calculated (<value-of select="$calculated-T"/>).
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="//ca:pN/ca:response">
            <let name="reported-N" value="xs:string(@value)"/>
            <let name="posNodes"
                value="//ca:nodeGroup/ca:status/ca:result[@for eq 'positive']/ca:response/@value[. castable as xs:integer]"/>
            <let name="calculated-N" value="if (sum($posNodes) gt 0) then '1' else '0'"/>
            <assert test="$calculated-N eq $reported-N">
                Reported N-stage (N<value-of select="$reported-N"/>) does not match calculated (N<value-of select="$calculated-N"/>). 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//ca:pM/ca:response">
            <let name="reported-M" value="@value"/>
            <let name="bone-met"
                value="//ca:distant/ca:site[@name eq 'bone']/ca:status/ca:result/ca:response[@value eq 'positive']"/>
            <let name="distant-nodeGroup"
                value="('aortic','common iliac','deep inguinal','superficial inguinal','supraclavicular','cervical','scalene','retroperitoneal NOS')"/>
            <let name="distant-node-met"
                value="sum(//ca:nodeGroup[@name = $distant-nodeGroup]/ca:status/ca:result[@for eq 'positive']/ca:response/@value[. castable as xs:integer])"/>
            <let name="other-met"
                value="//ca:distant/ca:site[@name ne 'bone']/ca:status/ca:result/ca:response[@value eq 'positive']"/>
            <let name="calculated-M"
                value="if ($other-met)                  then '1c'
                       else if (bone-met)               then '1b' 
                       else if ($distant-node-met gt 0) then '1a' 
                       else                                  '0'"/>
            <assert test="$reported-M eq $calculated-M">
               Reported M-stage (M<value-of select="$reported-M"/>) does not match calculated (M<value-of select="$calculated-M"/>).
            </assert>
        </rule>
    </pattern>
</schema>
