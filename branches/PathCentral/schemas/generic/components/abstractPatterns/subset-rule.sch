<?xml version="1.0" encoding="UTF-8"?>
<pattern abstract="true" id="subset-rule" xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:data="http://purl.org/pathology/ecc/data">
    <rule context="$context" role="warning">
        <!-- ===== Parameters =====                                                        -->
        <!-- data-source   document containing data                                        -->
        <!-- context:      context node for invoking the rule                              -->
        <!-- subset:       candidate subset                                                -->
        <!-- rule-id:      id of concrete rule                                             -->
        <!-- superset:     allowed superset                                                -->
        <!-- subName:      description of the subset as plural noun (for error message)    -->
        <!-- superName:    description of the superset as plural noun (for error message)  -->
        <let name="expansions" value="document('')//data:expansions[@for eq $rule-id]/data:expansion"/>
        <let name="r" value="for $x in $expansions return if ($x/@of = $superset) then $x/data:value else ()"/>
        <assert test="empty(for $x in distinct-values($subset) return if ($x = ($superset, $r,
            'inapplicable', 'unreported', 'specify')) then () else $x)">
                One or more <value-of select="$subName"/> do not appear among the <value-of select="$superName"/>. (This may be due to different laterality.)
        </assert>
    </rule>
</pattern>
