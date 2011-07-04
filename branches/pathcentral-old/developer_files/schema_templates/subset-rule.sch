<pattern abstract="true" id="subset-rule" xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="$where" role="warning">
        <!-- COPY THIS ABSTRACT RULE INTO SITE-SPECIFIC SCHEMAS AND INSTANTIATE IT THERE   -->
        <!-- ===== Parameters =====                                                        -->
        <!-- data-source:  name of document containing data, as single-quoted string       -->
        <!--               (if same as doc containing concrete rule, then '')              -->
        <!-- context:      context node for invoking the rule                              -->
        <!-- subset:       candidate subset                                                -->
        <!-- superset:     allowed superset                                                -->
        <!-- explode:      @of tag value of <data:explosions> element (as string)         -->
        <!-- subName:      description of the subset as plural noun (for error message, as string)    -->
        <!-- superName:    description of the superset as plural noun (for error message, as string)  -->
        <let name="explosions" value="document($data-source)//data:explosions[@of eq $explode]/data:explosion"/>
        <let name="r" value="for $x in $explosions return if ($x/@of = $superset) then $x/data:value else ()"/>
        <assert test="empty(for $x in distinct-values($subset) return if ($x = ($superset, $r, $noReport, $specify)) then () else $x)">
                One or more <value-of select="$subName"/> are not included among the <value-of select="$superName"/>. (This may be due to different laterality.)
            </assert>
    </rule>
</pattern>
