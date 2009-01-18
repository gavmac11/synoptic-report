<pattern abstract="true" id="bilaterality" xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="$context">
        <assert test="$finding/@location = 'right' and $finding/@location = 'left'">
                The <value-of select="'finding-name'"/> must be reported for both right and left sides, at least.
            </assert>
    </rule>
</pattern>
