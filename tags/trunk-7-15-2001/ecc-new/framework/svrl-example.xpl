<p:pipeline name="schematron" xmlns:p="http://www.w3.org/ns/xproc" version="1.0">
    <p:input port="instance" primary="true">
        <p:document href="/Users/me/Dropbox/Projects/Synoptic-report/ecc/breast/example.xml"/>
    </p:input>
    <p:input port="schema" primary="false">
        <p:document href="/Users/me/Dropbox/Projects/Synoptic-report/ecc/breast/breast.sch"/>
    </p:input>
    <p:output port="svrl" primary="true">
        <p:pipe port="result" step="validate"/>
    </p:output>
    <p:xslt name="include" version="2.0">
        <p:input port="source">
            <p:pipe port="schema" step="schematron"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="/Applications/oxygen-11.2/frameworks/schematron/iso-schematron-xslt2/iso_dsdl_include.xsl"/>
        </p:input>
    </p:xslt>
    <p:xslt name="expand" version="2.0">
        <p:input port="source">
            <p:pipe port="result" step="include"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="/Applications/oxygen-11.2/frameworks/schematron/iso-schematron-xslt2/iso_abstract_expand.xsl"/>
        </p:input>
    </p:xslt>
    <p:xslt name="compile" version="2.0">
        <p:input port="source">
            <p:pipe port="result" step="expand"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="/Applications/oxygen-11.2/frameworks/schematron/iso-schematron-xslt2/iso_svrl_for_xslt2.xsl"/>
        </p:input>
    </p:xslt>
    <p:xslt name="validate" version="2.0">
        <p:input port="source">
            <p:pipe port="instance" step="schematron"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="result" step="compile"/>
        </p:input>
    </p:xslt>
</p:pipeline>
