<?xml version="1.0" encoding="UTF-8"?>
<p:library version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:ex="http://john.madden.name/exproc/"
    xmlns:p="http://www.w3.org/ns/xproc" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-version="2.0">
    <p:declare-step name="validate-with-jing" type="ex:validate-with-jing">
        <p:option name="document"/>
        <p:option name="schema"/>
        <p:input port="source"/>
        <p:output port="result" primary="true">
            <p:pipe port="result" step="do-validate"/>
        </p:output>
        <p:variable name="jing" select="'/Applications/oxygen/lib/jing.jar'"/>
        <p:exec command="java" name="do-validate" result-is-xml="false" wrap-result-lines="true">
            <p:input port="source">
                <p:empty/>
            </p:input>
            <p:with-option name="args" select="concat('-jar ', $jing, ' ', $schema, ' ', $document)"/>
        </p:exec>
    </p:declare-step>
</p:library>
