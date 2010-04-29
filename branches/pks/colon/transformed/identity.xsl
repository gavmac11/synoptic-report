<?xml version="1.0" encoding="UTF-8"?>
<xs:transform version="2.0" xmlns:ecc="http://cap#" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
    <xs:template match="*">
        <xs:copy>
            <xs:apply-templates/>
        </xs:copy>
    </xs:template>
    <xs:template match="ecc:section|ecc:item">
        <xs:variable name="newName">
            <xs:value-of
                select="lower-case(substring(string-join(for $x in tokenize(@name,' ') return upper-case(substring($x,1,1)),''),1,1))"
            />
        </xs:variable>
        <xs:element name="{$newName}">
            <xs:apply-templates select="@*"/>
            <xs:apply-templates/>
        </xs:element>
    </xs:template>
    <xs:template match="@*[(name(.) ne 'name')]">
        <xs:copy/>
    </xs:template>
</xs:transform>
