<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="validate-noSite.example" xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc" version="1.0" xmlns:ca="http://purl.org/pathology/ecc/">
    <p:input port="source">
        <p:document href="example.xml"/>
    </p:input>
    <p:output port="result">
        <p:pipe port="result" step="validation"/>
    </p:output>
    <p:validate-with-relax-ng name="validation">
        <p:input port="source"></p:input>
        <p:input port="schema" select="noSite.rng"></p:input>
    </p:validate-with-relax-ng>
</p:declare-step>
