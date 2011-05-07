<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0">
    <!-- Declare the input and bind it on the document to be split. -->
    <p:input port="source">
        <p:document href="../personal.xml"/>
    </p:input>
    <!-- Select the 'person' elements... -->
    <p:filter select="//person"/>
    <!-- ... and store them in separate files. -->
    <p:for-each>
        <p:store>
            <p:with-option name="href" select="concat('persons/', /person/@id, '.xml')"/>
        </p:store>
    </p:for-each>
</p:declare-step>
