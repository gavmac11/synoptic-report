<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="validate" version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:ca="http://purl.org/pathology/ecc/" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <p:input port="source">
        <p:empty/>
    </p:input>
    <p:output port="result">
        <p:pipe port="result" step="validate-with-rng"/>
    </p:output>
    <p:exec args="-jar /Applications/oxygen/lib/jing.jar noSite.rng example.xml" command="java"
        cwd="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework" name="validate-with-rng"
        result-is-xml="false" wrap-result-lines="true"/>
</p:declare-step>
