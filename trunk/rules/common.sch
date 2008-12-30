<pattern abstract="true" id="x-iff-y">
    <rule context="$context">
        <assert test="if ($x) then $y else $skip">
            <value-of select="$x-not-y-msg"/>
        </assert>
        <assert test="if ($y) then $x else $skip">
            <value-of select="$y-not-x-msg"/>
        </assert>
    </rule>
</pattern>