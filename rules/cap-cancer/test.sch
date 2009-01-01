<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    <include href="common.sch"/>
    <pattern abstract="true" id="other-value">
        <rule context="$context">
            <assert test="if @value = 'other' then exists(@otherValue) else not exists(@otherValue)">
                <name/> has the value 'other'; therefore otherValue attribute must be specified.
            </assert>
        </rule>
    </pattern>
    <pattern is-a="other-value">
        <param name="$context" value="//pert:histologicType"/>
    </pattern>
</schema>