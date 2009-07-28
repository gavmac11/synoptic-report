<?xml version="1.0" encoding="UTF-8"?>
<pattern abstract="true" id="a-subsets-b" xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="$context">
        <assert test="$a = $b or $escape">
                Every <value-of select="$a-name"/> must be <value-of select="$b-name"/>
            </assert>
    </rule>
</pattern>
