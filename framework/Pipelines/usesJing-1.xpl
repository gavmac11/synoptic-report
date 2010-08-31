<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="root" version="1.0" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:cco="http://www.cancercare.on.ca/"
    xmlns:ex="http://john.madden.name/exproc/" xmlns:p="http://www.w3.org/ns/xproc" xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <p:input port="source"/>
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="cleanup"/>
    </p:output>
    <p:import href="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/Pipelines/newval.xpl"/>
    <ex:validate-with-jing name="validate-with-jing">
        <p:with-option name="schema" select="'/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/noSite.rng'"/>
        <p:with-option name="document" select="'/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/example.xml'"/>
    </ex:validate-with-jing>
    <p:rename match="c:result" name="errors" new-name="cco:structural-errors"/>
    <p:rename match="c:line" name="errors-2" new-name="cco:structural-error"/>
    <p:xslt name="split">
        <p:input port="source">
            <p:pipe port="result" step="errors-2"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="2.0">
                    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
                    <xsl:template match="element()">
                        <xsl:copy>
                            <xsl:apply-templates select="@*,node()"/>
                        </xsl:copy>
                    </xsl:template>
                    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
                        <xsl:copy/>
                    </xsl:template>
                    <xsl:template match="cco:structural-error">
                        <xsl:variable name="msg" select="tokenize(.,':')"/>
                        <cco:structural-error>
                            <cco:message>
                                <xsl:value-of
                                    select="concat(upper-case(substring(normalize-space($msg[5]),1,1)),substring(normalize-space($msg[5]),2),'.')"
                                />
                            </cco:message>
                            <cco:line>
                                <xsl:value-of select="normalize-space($msg[2])"/>
                            </cco:line>
                            <cco:column>
                                <xsl:value-of select="normalize-space($msg[3])"/>
                            </cco:column>
                            <cco:kind>
                                <xsl:value-of select="normalize-space($msg[4])"/>
                            </cco:kind>
                        </cco:structural-error>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>
    <p:validate-with-schematron assert-valid="false" name="sch-val">
        <p:input port="source">
            <p:document href="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/example.xml"/>
        </p:input>
        <p:input port="schema">
            <p:document href="/Users/me/Dropbox/Projects/Synoptic-report/Working/framework/rules.sch"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:validate-with-schematron>
    <p:sink>
        <p:input port="source">
            <p:pipe port="result" step="sch-val"/>
        </p:input>
    </p:sink>
    <p:filter name="filt-sch" select="(descendant-or-self::svrl:failed-assert|descendant-or-self::successful-report)">
        <p:input port="source">
            <p:pipe port="report" step="sch-val"/>
        </p:input>
    </p:filter>
    <!--  -->
    <p:wrap-sequence name="wrap-sch" wrapper="cco:cross-element-errors">
        <p:input port="source">
            <p:pipe port="result" step="filt-sch"/>
        </p:input>
    </p:wrap-sequence>
    <p:rename match="svrl:failed-assert|svrl:successful-report" name="fix-sch" new-name="cco:cross-element-error">
        <p:input port="source">
            <p:pipe port="result" step="wrap-sch"/>
        </p:input>
    </p:rename>
    <p:pack name="packup" wrapper="errors" wrapper-namespace="http://www.cancercare.on.ca/" wrapper-prefix="cco">
        <p:input port="source" sequence="true">
            <p:pipe port="result" step="split"/>
        </p:input>
        <p:input port="alternate">
            <p:pipe port="result" step="fix-sch"/>
        </p:input>
    </p:pack>
    <p:xslt name="cleanup">
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="source">
            <p:pipe port="result" step="packup"/>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="2.0">
                    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
                    <xsl:template match="element()">
                        <xsl:copy copy-namespaces="no">
                            <xsl:apply-templates select="@*,node()"/>
                        </xsl:copy>
                    </xsl:template>
                    <xsl:template match="cco:cross-element-error">
                        <xsl:copy copy-namespaces="no">
                            <xsl:element inherit-namespaces="no" name="cco:message">
                                <xsl:value-of select="svrl:text"/>
                            </xsl:element>
                            <xsl:element inherit-namespaces="no" name="cco:location">
                                <xsl:value-of
                                    select="replace(@location,
                                    '\[namespace-uri.*?\]|\*:', '')"/>
                            </xsl:element>
                            <xsl:element inherit-namespaces="no" name="cco:test">
                                <xsl:value-of select="@test"/>
                            </xsl:element>
                        </xsl:copy>
                    </xsl:template>
                    <xsl:template match="@location">
                        <cco:location>
                            <xsl:value-of select="."/>
                        </cco:location>
                    </xsl:template>
                    <xsl:template match="@test">
                        <cco:test>
                            <xsl:value-of select="."/>
                        </cco:test>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>
    <p:store href="validation-result.xml" name="final">
        <p:input port="source">
            <p:pipe port="result" step="cleanup"/>
        </p:input>
    </p:store>
    <p:sink>
        <p:input port="source">
            <p:pipe port="result" step="final"/>
        </p:input>
    </p:sink>
</p:declare-step>
