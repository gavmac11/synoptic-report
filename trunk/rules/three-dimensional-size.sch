<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xi="http://www.w3.org/2001/XInclude">
    <ns prefix="pert" uri="http://www.cap.org/pert/2009/01/"/>
    <ns prefix="colon" uri="http://www.cap.org/pert/2009/01/colon/"/>
    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <ns prefix="lung" uri="http://www.cap.org/pert/2009/01/lung/"/>
    <ns prefix="breast" uri="http://www.cap.org/pert/2009/01/breast/"/>
    <let name="skip" value="true()"/>
    <let name="no-report" value="false()"/>
    <pattern abstract="true" id="three-dimensional-size">
        <rule context="$size">
            <let name="d1" value="if (@dimension-1 castable as xs:float) then xs:float(@dimension-1) else 0.0"/>
            <let name="d2" value="if (@dimension-2 castable as xs:float) then xs:float(@dimension-2) else 0.0"/>
            <let name="d3" value="if (@dimension-3 castable as xs:float) then xs:float(@dimension-3) else 0.0"/>
            <assert test="$d1 ge $d2 and $d2 ge $d3">
                The dimensions of <name/> must be in decreasing order.
            </assert>
        </rule>
    </pattern>
</schema>
