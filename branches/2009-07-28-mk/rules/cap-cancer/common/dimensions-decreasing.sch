<pattern abstract="true" id="dimensions-decreasing" xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="$context">
        <let name="d1" value="if (@dimension-1 castable as xs:float) then xs:float(@dimension-1) else 0.0"/>
        <let name="d2" value="if (@dimension-2 castable as xs:float) then xs:float(@dimension-2) else 0.0"/>
        <let name="d3" value="if (@dimension-3 castable as xs:float) then xs:float(@dimension-3) else 0.0"/>
        <assert test="$d1 ge $d2 and $d2 ge $d3"> 
                In <name/>, size dimensions must be in decreasing order. 
            </assert>
    </rule>
</pattern>
