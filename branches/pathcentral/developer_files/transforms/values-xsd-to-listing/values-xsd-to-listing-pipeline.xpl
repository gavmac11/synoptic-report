<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="start" version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:cx="http://xmlcalabash.com/ns/extensions"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" xmlns:obbr="http://www.obbr.org/"
    xmlns:p="http://www.w3.org/ns/xproc" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- This template does a two-phase transform. -->
    <p:input port="source" primary="true"/>
    <p:input port="stylesheet-1"/>
    <p:input port="stylesheet-2"/>
    <p:output port="result" primary="true">
        <p:pipe port="result" step="phase-2"/>
    </p:output>
    <!--  -->
    <p:import href="/Applications/oXygen/frameworks/xproc/library-1.0.xpl"/>
    <!--  -->
    <p:xslt name="phase-1">
        <p:documentation>Do the first transformation</p:documentation>
        <p:input port="source">
            <p:pipe port="source" step="start"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet-1" step="start"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    <p:xslt name="phase-2">
        <p:documentation>Do the second transformation</p:documentation>
        <p:input port="source">
            <p:pipe port="result" step="phase-1"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet-2" step="start"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
</p:declare-step>
