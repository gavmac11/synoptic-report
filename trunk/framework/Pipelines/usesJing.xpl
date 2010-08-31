<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:my="http://john.madden.name/pipeline/"
    xmlns:p="http://www.w3.org/ns/xproc" xpath-version="1.0">
    <p:input port="source"/>
    <p:output port="result">
        <p:pipe port="result" step="validate-with-jing"/>
    </p:output>
    <p:import href="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/Pipelines/newval.xpl"/>
    <my:validate-with-jing name="validate-with-jing">
        <p:with-option name="jing" select="/Applications/oxygen-11.2/lib/jing.jar"/>
        <p:with-option name="schema" select="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/noSite.rng"/>
        <p:with-option name="document" select="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/example.xml"/>
    </my:validate-with-jing>
</p:declare-step>
