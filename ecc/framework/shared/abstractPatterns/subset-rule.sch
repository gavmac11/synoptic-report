<?xml version="1.0" encoding="UTF-8"?>
<pattern abstract="true" id="subset-rule">
    <rule context="$where" role="warning">
        <!-- ===== Parameters =====                                                        -->
        <!-- context:      context node for invoking the rule                              -->
        <!-- subset:       candidate subset                                                -->
        <!-- superset:     allowed superset                                                -->
        <!-- subName:      description of the subset as plural noun (for error message)    -->
        <!-- superName:    description of the superset as plural noun (for error message)  -->
        <let name="explosions"
            value="document('')//data:explosions[@for eq 'tumorSite-subsets-specimenSite-2']/data:explosion"/>
        <let name="r"
            value="for $x in $explosions return if ($x/@of = $superset) then $x/data:value else ()"/>
        <assert test="empty(for $x in distinct-values($subset) return if ($x = ($superset, $r, $noReport, $specify)) then () else $x)">
                One or more <value-of select="$subName"/> are not included among the <value-of select="$superName"/>. (This may be due to different laterality.)
            </assert>
    </rule>
</pattern>
