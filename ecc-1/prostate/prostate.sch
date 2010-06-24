<?xml version="1.0" encoding="UTF-8"?>

<!--
    
    CAP Schema for Synoptic Reports
    (c) Copyright 2008 College of American Pathologists
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
    This file is part of the "CAP Schema for Synoptic Reports".
    
    The "CAP Schema for Synoptic Reports" is free software: 
    you can redistribute it and/or modify it under the terms of the 
    GNU General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or (at your option) any later version.
    
    The "CAP Schema for Synoptic Reports" is distributed 
    in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
    without even the implied warranty of MERCHANTABILITY or 
    FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
    for more details.
    
    You should have received a copy of the GNU General Public License
    along with the "CAP Schema for Synoptic Reports".  
    If not, see <http://www.gnu.org/licenses/>. 
    ===========================================================================
    
-->
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="therapy-description-not-allowed">
        <rule context="//hasPriorTherapy">
            <assert test="@value &gt;= count(@description)"> Description is
                not allowed unless value is true. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="extraprostatic-specified-both-sides">
        <rule context="//prostate:extension">
            <let name="loc" value="prostate:extraprostatic/@location"/>
            <assert test="$loc = 'right side' and $loc = 'left side'">
                Extraprostatic extension must be reported for both right and
                left sides (at least). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="seminal-vesicle-specified-both-sides">
        <rule context="//prostate:extension">
            <let name="lat" value="prostate:seminalVesicle/@laterality"/>
            <assert test="$lat = 'right' and $lat = 'left'"> Seminal vesicle
                extension must be reported for both right and left sides.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="seminal-vesicle-extent-only-if-positive">
        <rule context="//prostate:extension/prostate:seminalVesicle">
            <report test="@value ne 'positive' and @extent"> Negative seminal
                vesicles must not report extent. </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-overall-PTI">
        <rule context="//prostate:percentTumorInvolvement[@laterality eq 'both sides']">
            <let name="r" value="parent::*/*[@laterality eq 'right']/@value"/>
            <let name="l" value="parent::*/*[@laterality eq 'left']/@value"/>
            <let name="b" value="xs:double(./@value)"/>
            <assert test="if ($r and $l and $b) then max (($r, $l)) ge $b and min (($r, $l)) le $b else $skip"> Bilateral cancer volume must be between the right and left
                unilateral volumes. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-T-stage">
        <rule context="//pert:T">
            <let name="T" value="@value cast as xs:string"/>
            <let name="adj" value="//prostate:adjacentStructure/@value"/>
            <let name="epe" value="//prostate:extraprostatic/@value"/>
            <let name="svi" value="//prostate:seminalVesicle/@value"/>
            <let name="rpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'right']/@value cast as xs:integer"/>
            <let name="lpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'left']/@value cast as xs:integer"/>
            <assert test="                                       
                     if ($adj = 'bladder' or $adj = 'rectum') then $T = '4'                   
                else if ($svi = 'positive')                   then $T = '3b'                  
                else if ($epe = 'positive')                   then $T = '3a'                 
                else if ($rpti > 0 and $lpti > 0)             then $T = '2c'        
                else if ($rpti = 0 and $lpti > 50)            then $T = '2b'
                else if ($lpti = 0 and $rpti > 50)            then $T = '2b'             
                else if ($rpti = 0 and $lpti > 0)             then $T = '2a'        
                else if ($lpti = 0 and $lpti > 0)             then $T = '2a'                
                else if ($rpti = 0 and $lpti = 0)             then $T = '0'                 
                else                                               $T = 'X'    "> Reported T-stage (T<value-of select="$T"/>) does not match
                calculated (T<value-of select="
                     if ($adj = 'bladder' or $adj = 'rectum') then '4'                   
                else if ($svi = 'positive')                   then '3b'                  
                else if ($epe = 'positive')                   then '3a'                 
                else if ($rpti > 0 and $lpti > 0)             then '2c'        
                else if ($rpti = 0 and $lpti > 50)            then '2b'
                else if ($lpti = 0 and $rpti > 50)            then '2b'             
                else if ($rpti = 0 and $lpti > 0)             then '2a'        
                else if ($lpti = 0 and $lpti > 0)             then '2a'                
                else if ($rpti = 0 and $lpti = 0)             then '0'                 
                else                                               'X'    "/>). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="//pert:N">
            <let name="posNodes" value="sum(//pert:nodeGroup/@positiveNodes)"/>
            <let name="N" value="@value cast as xs:integer"/>
            <assert test="if ($posNodes eq 0) then $N eq 0 else $N eq 1">
                Reported N-stage (N<value-of select="$N"/>) does not match
                calculated (N<value-of select="if ($posNodes eq 0) then '0' else '1'"/>). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:M">
            <let name="M" value="@value"/>
            <let name="met" value="exists(//pert:metastasis)"/>
            <let name="report" value="exists(//pert:metastases)"/>
            <assert test="
                if ($report) then 
                if ($met) then $M = '1' 
                else $M = '0' 
                else $M = 'X'"> Reported M-stage (M<value-of select="$M"/>) does not match
                calculated (M<value-of select=" 
                    if ($report) then 
                        if ($met) then '1' 
                        else '0' 
                    else 'X'"/>). </assert>
        </rule>
    </pattern>
</schema>
