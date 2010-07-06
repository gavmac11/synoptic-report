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
    <let name="skip" value="true()"/>
    <let name="positive" value="'positive'"/>
    <let name="test"
        value="document('values.rng')/rng:grammar/rng:define[@name eq 'extent.adjacentSite.valueset']/rng:choice/rng:value"
    />
</schema>
