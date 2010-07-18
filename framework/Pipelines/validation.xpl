<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="validate" version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:ca="http://purl.org/pathology/ecc/"
    xmlns:p="http://www.w3.org/ns/xproc" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <p:input kind="parameter" port="rng"/>
    <p:input kind="parameter" port="doc"/>
    <p:variable name="jing" select="'-jar /Applications/oxygen-11.2/lib/jing.jar'"/>
   <p:exec args="$jing" command="java" cwd="/Users/me/Dropbox/Projects/Synoptic-report/ecc/framework" name="validate-with-rng"
        result-is-xml="false" wrap-result-lines="true"> </p:exec>
</p:declare-step>
