<pattern abstract="true" id="proc-site-match" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:ecc="http://purl.org/pathology/ecc/">
    <!-- Required parameter $data-source is a string that gives the name of the document that contains the data -->
    <rule context="ecc:specimen" role="warning">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <let name="the-procs" value="//ecc:specimen/ecc:procedure/ecc:response/@value"/>
        <let name="the-sites" value="//ecc:specimen/ecc:site/ecc:response/@value"/>
        <let name="procs" value="document($data-source)//data:procedures/data:proc"/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <let name="rslt"
            value="for $proc in $procs return (($proc/@of = $the-procs) and not(every $site in $proc/data:site satisfies $site = $the-sites))"/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <report test="true() = $rslt">
                For the procedure(s) "<value-of select="string-join(for $x in index-of($rslt,true()) return $procs[$x]/@of,', ')"/>" no matching site is reported.
            </report>
    </rule>
</pattern>
