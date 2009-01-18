<pattern abstract="true" id="x-iff-y" xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="$context">
        <assert test="if (exists($x)) then exists($y) else not(exists($y))">
                In <name/>, <value-of select="$x-name"/> must have <value-of select="$y-name"/>, and vice-versa.
            </assert>
    </rule>
</pattern>
