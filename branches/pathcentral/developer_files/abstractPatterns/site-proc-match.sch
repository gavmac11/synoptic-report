<pattern abstract="true" id="site-proc-match" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:ecc="http://purl.org/pathology/ecc/">
    <rule context="ecc:specimen" role="warning">
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!-- Required parameter $data-source is a string that gives the name of the document that contains the data -->
        <let name="the-procs" value="//ecc:specimen/ecc:procedure/ecc:response/@value"/>
        <let name="the-sites" value="//ecc:specimen/ecc:site/ecc:response/@value"/>
        <let name="sites" value="document($data-source)//data:sites/data:site"/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <let name="rslt"
            value="for $site in $sites return (($site/@of = $the-sites) and not($the-procs = $site/data:proc))"/>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <report test="true() = $rslt">
                For the site(s) "<value-of select="string-join(for $x in index-of($rslt,true()) return $sites[$x]/@of,', ')"/>" no matching procedure is reported.
        </report>
    </rule>
</pattern>
