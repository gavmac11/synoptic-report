    <ns prefix="prostate" uri="http://www.cap.org/pert/2009/01/prostate/"/>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->   
    <pattern is-a="x-iff-y">
        <param name="context" value="//prostate:extension/prostate:seminalVesicle"/>
        <param name="x" value="@value='positive'"/>
        <param name="y" value="@extent"/>
        <param name="x-name" value="positive seminal vesicle invasion"/>
        <param name="y" value="specification of extent"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="bilaterality">
        <param name="context" value="//prostate:extension"/>
        <param name="finding" value="prostate:extraprostatic"/>
        <param name="finding-name" value="'extraprostatic extension status'"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="bilaterality">
        <param name="context" value="//prostate:extension"/>
        <param name="finding" value="prostate:seminalVesicle"/>
        <param name="finding-name" value="'seminal vesicle extension status'"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="node-numbers-add-up">
        <rule context="//pert:nodeGroup">
            <let name="regressed"
                value="
                if (pert:nodeStatus[@value = 'regressed']/@count castable as xs:integer)
                then xs:integer(pert:nodeStatus[@value = 'regressed']/@count)
                else 0
                "/>
            <let name="pos"
                value="
                if (pert:nodeStatus[@value = 'positive']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'positive']/@count) 
                else 0
                "/>
            <let name="total"
                value="
                if (pert:nodeStatus[@value = 'total']/@count castable as xs:integer) 
                then xs:integer(pert:nodeStatus[@value = 'total']/@count) 
                else -1
                "/>
            <assert test="$regressed le $total">
                Nodes positive for regressed tumor (<value-of select="$regressed"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$pos le $total">
                Nodes positive (<value-of select="$pos"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group. 
            </assert>
            <assert test="$regressed + $pos le $total"> 
                Sum (<value-of select="$regressed + $pos"/>) of nodes with regressed tumor (<value-of select="$regressed"/>)  and positive (<value-of select="$pos"/>) must not exceed total nodes (<value-of select="$total"/>) in the "<value-of select="@location"/>" lymph node group.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern is-a="x-iff-y">
        <param name="context" value="//prostate:extension/prostate:seminalVesicle"/>
        <param name="x" value="@value = 'positive'"/>
        <param name="y" value="exists(@extent)"/>
        <param name="x-name" value="a positive seminal vesicle"/>
        <param name="y-name" value="a specification of extent"/>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-overall-PTI">
        <rule context="//prostate:percentTumorInvolvement[@laterality eq 'both sides']">
            <let name="r" value="parent::*/*[@laterality eq 'right']/@value"/>
            <let name="l" value="parent::*/*[@laterality eq 'left']/@value"/>
            <let name="b" value="xs:double(./@value)"/>
            <assert test="if ($r and $l and $b) then max (($r, $l)) ge $b and min (($r, $l)) le $b else $skip"> 
                Bilateral cancer volume must be between the right and left unilateral volumes.
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="treatment-effect-implies-prior-therapy">
        <rule context="//pert:treatmentEffect">
            <let name="RxEffect" value="exists(.) and @value ne 'inapplicable'"/>
            <report test="$RxEffect and not(//pert:priorTherapy)"> 
                If reporting tumor treatment effect, you must also specify prior therapy in the clinical section. 
            </report>
            <report test="$RxEffect and not(contains(//pert:stage/pert:prefix/@value, 'y'))">
                Treatment effect must be noted in the stage descriptor using the 'y' prefix.
            </report>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="report-closest-if-all-margins-negative">
        <rule context="//pert:margins">
            <let name="status" value="pert:margin/@status"/>
            <let name="closest" value="pert:margin/@closest"/>
            <let name="closestLocation" value="pert:margin[@closest = 'true()']/@location"/>
            <assert test="if ($status = 'positive') then not(exists($closest)) else $skip"> 
                "Closest margin" is not reportable if any margin is frankly positive. 
            </assert>
            <assert test="if (not($status = 'positive')) then exists($closest) else $skip"> 
                "Closest margin" must be reported if all margins are negative. 
            </assert>
            <assert test="if (exists($closestLocation)) then $closestLocation = pert:margin[@status = 'negative']/@location else $skip"> 
                Closest margin location must correspond to a reported negative margin location."/>
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-T-stage">
        <rule context="//pert:T">
            <let name="T" value="@value cast as xs:string"/>
            <let name="adj" value="//prostate:adjacentStructure/@value"/>
            <let name="epe" value="//prostate:extraprostatic/@value"/>
            <let name="svi" value="//prostate:seminalVesicle/@value"/>
            <let name="rpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'right']/@value cast as xs:integer"/>
            <let name="lpti"
                value="//prostate:percentTumorInvolvement[@laterality =
                'left']/@value cast as xs:integer"/>
            <assert test="                                       
                     if ($adj = 'bladder' or $adj = 'rectum') then $T = '4'                   
                else if ($svi = 'positive')                   then $T = '3b'                  
                else if ($epe = 'positive')                   then $T = '3a'                 
                else if ($rpti > 0 and $lpti > 0)             then $T = '2c'        
                else if ($rpti = 0 and $lpti > 50)            then $T = '2b'
                else if ($lpti = 0 and $rpti > 50)            then $T = '2b'             
                else if ($rpti = 0 and $lpti > 0)             then $T = '2a'        
                else if ($lpti = 0 and $lpti > 0)             then $T = '2a'                
                else if ($rpti = 0 and $lpti = 0)             then $T = '0'                 
                else                                               $T = 'X'    "> 
                Reported T-stage (T<value-of select="$T"/>) does not match calculated (T<value-of select="
                     if ($adj = 'bladder' or $adj = 'rectum') then '4'                   
                else if ($svi = 'positive')                   then '3b'                  
                else if ($epe = 'positive')                   then '3a'                 
                else if ($rpti > 0 and $lpti > 0)             then '2c'        
                else if ($rpti = 0 and $lpti > 50)            then '2b'
                else if ($lpti = 0 and $rpti > 50)            then '2b'             
                else if ($rpti = 0 and $lpti > 0)             then '2a'        
                else if ($lpti = 0 and $lpti > 0)             then '2a'                
                else if ($rpti = 0 and $lpti = 0)             then '0'                 
                else                                               'X'    "/>). 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern id="calculate-N-stage">
        <rule context="//pert:N">
            <let name="posNodes" value="sum(//pert:nodeGroup/@positiveNodes)"/>
            <let name="N" value="@value cast as xs:integer"/>
            <assert test="if ($posNodes eq 0) then $N eq 0 else $N eq 1"> 
                Reported N-stage (N<value-of select="$N"/>) does not match calculated (N<value-of select="if ($posNodes eq 0) then '0' else '1'"/>). 
            </assert>
        </rule>
    </pattern>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <pattern>
        <rule context="//pert:M">
            <let name="M" value="@value"/>
            <let name="met" value="exists(//pert:metastasis)"/>
            <let name="report" value="exists(//pert:metastases)"/>
            <assert test="
                if ($report) then 
                if ($met) then $M = '1' 
                else $M = '0' 
                else $M = 'X'">
                Reported M-stage (M<value-of select="$M"/>) does not match calculated (M<value-of select=" 
                    if ($report) then 
                        if ($met) then '1' 
                        else '0' 
                    else 'X'"/>).
            </assert>
        </rule>
    </pattern>