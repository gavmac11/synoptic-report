<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="validate-noSite.example" version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:ca="http://purl.org/pathology/ecc/" xmlns:p="http://www.w3.org/ns/xproc">
    <p:input port="source">
        <p:empty/>
    </p:input>
    <p:output port="result" primary="true" sequence="true"/>
    <p:exec args="-jar /Applications/oxygen-11.2/lib/jing.jar noSite.rng example.xml" command="java"
        cwd="/Users/me/Dropbox/Projects/Synoptic-report/ecc/framework" name="validate" result-is-xml="false"
        wrap-result-lines="true"/>
    <p:
</p:declare-step>
