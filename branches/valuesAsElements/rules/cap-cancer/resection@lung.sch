<?xml version="1.0" encoding="UTF-8"?>

<!--
    
    CAP Schema for Synoptic Reports
    (c) Copyright 2008 College of American Pathologists
    ===========================================================================
    Component name:
    resection@lung.sch
    
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
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="colon" uri="http://www.cap.org/pert/2009/01/colon/"/>
    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <ns prefix="lung" uri="http://www.cap.org/pert/2009/01/lung/"/>
    <ns prefix="breast" uri="http://www.cap.org/pert/2009/01/breast/"/>
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="therapy-description-not-allowed">
        <rule context="//hasPriorTherapy">
            <assert test="@value &gt;= count(@description)"> Description is not allowed unless value is true. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="size-dimensions-in-decreasing-order">
        <rule context="//pert:tumorSize">
            <let name="d1" value="if (@dimension-1 castable as xs:float) then xs:float(@dimension-1)
                else 0.0"/>
            <let name="d2" value="if (@dimension-2 castable as xs:float) then xs:float(@dimension-2)
                else 0.0"/>
            <let name="d3" value="if (@dimension-3 castable as xs:float) then xs:float(@dimension-3)
                else 0.0"/>
            <assert test="$d1 ge $d2 and $d2 ge $d3"> Tumor size dimensions must be in decreasing order. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="node-numbers-add-up">
        <rule context="//pert:nodeGroup">
            <let name="positiveNodes"
                value="if (pert:nodeStatus[@value = 'positive']/@count
                castable as xs:integer) then xs:integer(pert:nodeStatus[@value = 'positive']/@count)
                else 0"/>
            <let name="regressedNodes"
                value="if (pert:nodeStatus[@value = 'regressed']/@count
                castable as xs:integer) then xs:integer(pert:nodeStatus[@value =
                'regressed']/@count) else 0"/>
            <let name="totalNodes"
                value="if (pert:nodeStatus[@value = 'total']/@count castable as
                xs:integer) then xs:integer(pert:nodeStatus[@value = 'total']/@count) else -1"/>
            <assert test="$positiveNodes le $totalNodes"> Positive nodes (<value-of select="$positiveNodes"
                    />) must not exceed
                total nodes (<value-of select="$totalNodes"/>) in the "<value-of
                    select="@location"/>" lymph node group. </assert>
            <assert test="$regressedNodes le $totalNodes"> Regressed nodes (<value-of select="$regressedNodes"
                    />) must not exceed
                total nodes (<value-of select="$totalNodes"/>) in the "<value-of
                    select="@location"/>" lymph node group. </assert>
            <assert test="$regressedNodes + $positiveNodes le $totalNodes"> Positive (<value-of select="$positiveNodes"
                    />) plus
                regressed (<value-of select="$regressedNodes"
                    />) nodes must not exceed total nodes (<value-of select="$totalNodes"/>) in the "<value-of select="@location"
                />" lymph node group. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="site-matches-procedure">
        <rule context="//pert:site">
            <let name="proc" value="//pert:procedure/@value"/>
            <assert
                test="                                       if ($proc = 'major airway
                resection') then @value = ('main bronchus')                 else if ($proc = 'wedge
                resection')        then @value = ('right upper lobe', 'right middle lobe', 'right
                lower lobe', 'left upper lobe', 'lingula', 'left lower lobe')                 else
                if ($proc = 'segmentectomy')          then @value = ('right upper lobe', 'right
                middle lobe', 'right lower lobe', 'left upper lobe', 'lingula', 'left lower lobe')
                else if ($proc = 'lobectomy')              then @value = ('right upper lobe', 'right
                middle lobe', 'right lower lobe', 'left upper lobe', 'lingula', 'left lower lobe')
                else if ($proc = 'bilobectomy')            then @value = ('right upper lobe', 'right
                middle lobe', 'right lower lobe', 'left upper lobe', 'lingula', 'left lower lobe')
                else if ($proc = 'pneumonectomy')          then @value = ('right lung', 'left lung')
                else $skip"
                    > Specimen site "<value-of select="@value"/>" must match a corresponding procedure. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="other-histologic-type">
        <rule context="//pert:histologicType">
            <assert test="if (@value eq 'other') then exists(@other-value) else
                not(exists(@other-value))"
                > If the
                histologic type is "other", then a value must be given in an "other-value" attribute which may otherwise not be
                present. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="tumor-site-subsets-specimen-site">
        <rule context="//pert:tumorLocation">
            <assert test="@value = //pert:site/@value"> The tumor site "<value-of select="@value"
                />" must be among the sites
                comprising specimen. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="//pert:N">
            <let name="posNodes"
                value="sum(//pert:nodeGroup/pert:nodeStatus[@value='positive']/@count) cast as
                xs:integer"/>
            <let name="N" value="@value cast as xs:integer"/>
            <assert
                test="
                     if ($posNodes eq 0) then $N eq 0 
                else if ($posNodes lt 4) then $N eq 1 
                else                          $N eq 2"
                    > Reported N-stage (N<value-of select="$N"/>) does not match calculated (N<value-of
                    select="     
                         if ($posNodes eq 0) then '0' 
                    else if ($posNodes lt 4) then '1' 
                    else                          '2'"
                />). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-T-stage">
        <rule context="//pert:T">
            <let name="size" value="//lung:tumorSize/@value"/>
            <let name="unit" value="//lung:tumorSize/@unit"/>
            <let name="focality" value="//lung:focality/@value"/>
            <let name="adjacent" value="//lung:adjacentStructureInvasion/lung:structure/@value"/>
            <let name="mainstem" value="//lung:mainstemBronchusInvolvement/@value"/>
            <let name="carina" value="//lung:carinaInvolvement/@value"/>
            <let name="pneumonitis" value="//lung:obstructivePneumonitis/@value"/>
            <let name="pleura" value="//lung:visceralPleuraInvasion/@value"/>
            <let name="T" value="@value cast as xs:string"/>
            <assert
                test="                               
                     if ($focality = 'multifocal different lobes') 
                                                     then $T = '4'                   
                else if ($adjacent = ('mediastinum', 'heart', 'great vessels', 'trachea', 'recurrent laryngeal nerve', 'esophagus', 'vertebral body', 'carina'))
                                                     then $T = '4' 
                else if ($focality = 'multifocal same lobe')  
                                                     then $T = '3'                 
                else if ($pneumonitis = 'entire lung') 
                                                     then $T = '3'                   
                else if (carina = 'positive')        then $T = '3'                  
                else if ($adjacent = ('chest wall', 'diaphragm', 'phrenic nerve', 'mediastinal pleura', 'parietal pericardium'))
                                                     then $T = '3'              
                else if ($size > 7 and $unit = 'cm') then $T = '3'                  
                else if ($size > 5 and $unit = 'cm') then $T = '2b'                 
                else if ($size > 3 and $unit = 'cm') then $T = '2a'               
                else if ($mainstem = 'positive')     then $T = '2a'                
                else if ($pleura = 'positive')       then $T = '2a'                 
                else if ($pneumonitis = 'extending to hilum') 
                                                     then $T = '2a'                 
                else if (size > 2 and $unit = 'cm')  then $T = '1b'                 
                else if (size > 0)                   then $T = '1a'                
                else                                      $T = 'X'    "
                    > Reported T-stage (T<value-of select="$T"/>) does not match calculated (T<value-of
                    select="
                     if ($focality = 'multifocal different lobes') 
                                                     then '4'                   
                else if ($adjacent = ('mediastinum', 'heart', 'great vessels', 'trachea', 'recurrent laryngeal nerve', 'esophagus', 'vertebral body', 'carina'))
                                                     then '4' 
                else if ($focality = 'multifocal same lobe')  
                                                     then '3'                 
                else if ($pneumonitis = 'entire lung') 
                                                     then '3'                   
                else if (carina = 'positive')        then '3'                  
                else if ($adjacent = ('chest wall', 'diaphragm', 'phrenic nerve', 'mediastinal pleura', 'parietal pericardium'))
                                                     then '3'              
                else if ($size > 7 and $unit = 'cm') then '3'                  
                else if ($size > 5 and $unit = 'cm') then '2b'                 
                else if ($size > 3 and $unit = 'cm') then '2a'               
                else if ($mainstem = 'positive')     then '2a'                
                else if ($pleura = 'positive')       then '2a'                 
                else if ($pneumonitis = 'extending to hilum') 
                                                     then '2a'                 
                else if (size > 2 and $unit = 'cm')  then '1b'                 
                else if (size > 0)                   then '1a'                
                else                                      'X'    "
                />). </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"
                > If reporting tumor treatment effect, you must also specify
                prior therapy in the clinical section. </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))"
                > Treatment effect must be noted in
                the stage descriptor using the 'y' prefix. </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin[@closest='true']"/>
            <assert
                test="if (exists($status) and $status = 'positive for carcinoma') then not(exists($closest))
                else $skip"
                > "Closest margin" is not reportable if any margin is positive. </assert>
            <assert
                test="if (exists($status) and not($status = 'positive for carcinoma')) then exists($closest)
                else $skip"
                > Closest margin must be reported if no margins are positive for invasive carcinoma. </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:M">
            <let name="M" value="@value"/>
            <let name="met" value="exists(//pert:metastasis)"/>
            <let name="report" value="exists(//pert:metastases)"/>
            <assert
                test="
                if ($report) then 
                if ($met) then $M = '1' 
                else $M = '0' 
                else $M = 'X'"
                    > Reported M-stage (M<value-of select="$M"/>) does not match calculated (M<value-of
                    select=" 
                    if ($report) then 
                        if ($met) then '1' 
                        else '0' 
                    else 'X'"
                />). </assert>
        </rule>
    </pattern>
</schema>
