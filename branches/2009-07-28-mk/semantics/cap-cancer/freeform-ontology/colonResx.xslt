<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE rdf:RDF [

    <!ENTITY owl "http://www.w3.org/2002/07/owl#" >
    <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#" >
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#" >
    <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#" >
    <!ENTITY dc "http://purl.org/dc/elements/1.1/#" >
    
    <!ENTITY cap "http://www.cap.org/pert/2009/01/#" >
    <!ENTITY colon "http://www.cap.org/pert/2009/01/colon/#" >
    <!ENTITY anat "http://www.rsna.org/radlex/2009/01/anat/#" >
    <!ENTITY cmh "http://www.cap.org/pert/2009/01/colon/#" >
    <!ENTITY cmhsp "http://www.centerville-memorial-hospital.org/pid#" >
    <!ENTITY cmhsp "http://www.centerville-memorial-hospital.org/pathology/sid#" >
    <!ENTITY cmhmd "http://www.centerville-memorial-hospital.org/md-id#" >

]>

<xsl:stylesheet 
  xmlns:xsl  ="http://www.w3.org/1999/XSL/Transform" 
  version    ="1.0"
  xmlns:cap   ="http://www.cap.org/pert/2009/01/#/"
  xmlns:colon ="http://www.cap.org/pert/2009.01/colon/#"
  xmlns:anat = "http://www.rsna.org/radlex/2009/01/anat/#"
  xmlns:cmh = "http://www.centerville-memorial-hospital.org/pid#"
  xmlns:cmhsp = "http://www.centerville-memorial-hospital.org/pathology/sid#"
  xmlns:cmhmd = "http://www.centerville-memorial-hospital.org/md-id#"
  xmlns:dc   ="http://purl.org/dc/elements/1.1/"
  xmlns:rdfs ="http://www.w3.org/2000/01/rdf-schema#" 
  xmlns:rdf  ="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 >

  <xsl:output method="xml"/>

  <!-- root template -->
  <xsl:template match="/">
    <rdf:RDF>
      <rdfs:Description rdf:about="Colon resection example semantic extract">
        <rdfs:isDefinedBy rdf:resource="http://www.cap.org/pert/2009/01/colon"/>
      </rdfs:Description>

      <!-- JM.  where do individuals go? (E.g., Patient, Specimen, Physician).  where does it come from?   -->
      <!-- JM.  implicit semantics that domain expert needs to state (I.e., NOT in source pert xml)  -->
      
      <!-- pathologist stated -->
      <xsl:call-template name="patient" />
      <xsl:call-template name="specimen" />
      <xsl:call-template name="pathologist" />
      <xsl:call-template name="source-of-specimen" />"
      <xsl:call-template name="clinical-finding" />"

      <!-- gleaned from synoptic -->
      <xsl:apply-templates select="//synopsis/specimen"/>                  
      <xsl:apply-templates select="//synopsis/tumor" />      
      <xsl:apply-templates select="//synopsis/accessory" />
      <xsl:apply-templates select="//synopsis/extent" />      
      <xsl:apply-templates select="//synopsis/margins" />
      <xsl:apply-templates select="//synopsis/nodes" />
      <xsl:apply-templates select="//synopsis/stage" />      
      <xsl:apply-templates select="//synopsis/additional/findings/finding" />
    </rdf:RDF>    
  </xsl:template>  

  <!-- patient (as individual) -->
  <!-- n3:
    <#patient> = <cmh:X875693> .
  -->  
  <xsl:template name="patient">
    <rdf:Description rdf:about="#patient">
      <rdf:type rdf:resource="cmh:X875693" />
    </rdf:Description>
    <!-- JM.  Or owl:sameAs ??? -->
    <!-- rdf:Description rdf:about="#patient">
      <sameAs xmlns="http://www.w3.org/2002/07/owl#"
        rdf:resource="cmh:X875693"/ >
    </rdf:Description -->
  </xsl:template>
  
  <!-- specimen (as individual) -->
  <!-- n3:
    <#specimen> = <cmhsp:SL-09-12345> .
  -->
  <xsl:template name="specimen">
    <rdf:Description rdf:about="#specimen">
      <sameAs xmlns="http://www.w3.org/2002/07/owl#"
        rdf:resource="cmhsp:SL-09-12345"/>
    </rdf:Description>
  </xsl:template>
 
  <!-- pathologist (as individual) -->
  <!--
    <#> dc:author <#pathologist>.
    <#pathologist> = <cmhmd:9876-1> .
  -->
  <xsl:template name="pathologist">
    <rdf:Description rdf:about="#">
      <dc:creator rdf:resource="#pathologist" />
    </rdf:Description>
    <rdf:Description rdf:about="#pathologist">
      <rdf:type rdf:resource="cmhmd:9876-1" />
      <!-- JM.  owl:sameAs??? -->
    </rdf:Description>
  </xsl:template>

  <!-- source of specimen -->
  <!-- n3:
    <#patient> <cap:sourceOfSpecimen> <_:ThisSpecimen>.
  -->  
  <xsl:template name="source-of-specimen">
    <rdf:Description rdf:about="#specimen">
      <cap:sourceOfSpecimen
        rdf:resource="cmhsp:SL-09-12345" />
    </rdf:Description>
  </xsl:template>
 
  <!-- clinical-finding -->
  <!-- n3:
    <#patient> 
    <cap:clinicalFinding> 
    [a <cap:Mass>], 
    [<cap:diagnosedBy> <cap:Biopsy>; a <cap:Cancer>]
    .
  -->
  <xsl:template name="clinical-finding">
    <rdf:Description rdf:about="#patient">
      <cap:clinicalFinding>
        <rdf:Description>
          <rdf:type rdf:resource="cap:Mass" />
        </rdf:Description>
        <rdf:Description>
          <cap:diagnosedBy rdf:resource="cap:Biopsy" />
          <rdf:type rdf:resource="cap:Cancer" />
        </rdf:Description>
      </cap:clinicalFinding>
    </rdf:Description>
  </xsl:template>

  <!-- specimen -->
  <xsl:template match="specimen">
    <!-- pert:xml
      <specimen>
      <procedures>
      <procedure value="segmental colectomy"/>
      </procedures>
      <sites>
      <site value="cecum"/>
      <site value="left colon"/>
      </sites>
      <tumorLocations>
      <tumorLocation value="cecum"/>
      </tumorLocations>
      </specimen>
    -->    
    <!-- n3:
      <#specimen> = 
      [
      a <cap:Specimen>;
      <cap:derivedFromProcedure> [a <cap:segmentalColectomy>];
      <cap:includesAnatomicPart> [a <anat:Cecum>, <anat:leftColon>];
      <cap:involvedByDisease> <_:ThisTumor>
      ]
      .      
    -->
    <rdf:Description rdf:about="cmhsp:SL-09-12345">
      <rdf:type rdf:resource="cap:Specimen" />
      <cap:derivedFromProcedure>
        <rdf:Description>
          <rdf:type rdf:resource="cap:segmentalColectomy" />
        </rdf:Description>
      </cap:derivedFromProcedure>
      <cap:includesAnatomicPart>
        <rdf:Description>
          <rdf:type rdf:resource="anat:Cecum" />
          <rdf:type rdf:resource="anat:leftColon" />
        </rdf:Description>
      </cap:includesAnatomicPart>
      <cap:involvedByDisease rdf:resource=":ThisTumor" />
    </rdf:Description>
  </xsl:template>
  
  <!-- tumor -->
  <xsl:template match="tumor">
    <!-- pert:xml
      <tumor>
      <histologicTypes>
      <histologicType value="adenocarcinoma"/>
      </histologicTypes>
      <grade value="high"/>
      <colon:suggestMicrosatelliteInstability>
      <colon:highGrade value="positive"/>
      <colon:medullaryComponent value="negative"/>
      <colon:mucinousComponent value="negative"/>
      </colon:suggestMicrosatelliteInstability>
      <colon:immuneResponse>
      <colon:intratumoralResponse value="marked"/>
      <colon:peritumoralResponse value="mild to moderate"/>
      </colon:immuneResponse>
      <colon:tumorPerforation value="negative"/>
      </tumor>
      -->
    <!-- n3:
      <_:ThisTumor> 
      a <cap:Carcinoma>; 
      <cap:site [a <anat:Cecum>];
      <cap:histologicType> <cap:Adenocarcinoma>;
      <cap:histologicGrade> <cap:highGrade>;
      <cap:hasTumorFinding> <_:microsatelliteInstabilityFindings>;
      <colon:intratumoralResponse> <cap:marked>;
      <colon:peritumoralResponse> <cap:mildToModerate>;
      <colon:tumorPerforation> <cap:negative>;
      <colon:discontinuousExtramuralExtenstion> <cap:negative>;
      <colon:preexistingPolyp> [a cap:Concept; rdfs:label "villous adenoma"];
      <cap:lymphovascularInvasion> <cap:inconclusive>;
      <cap:venousInvasion> <cap:negative>;
      <colon:deepestInvasion> [a cap:Concept; rdfs:label "muscularis propria"];
      <cap:size> [<cap:dimension> 3.5; <cap:unit> [<rdfs:label> "cm"]]
      .      
    -->
    <rdf:Description rdf:about=":ThisTumor">
      <rdf:type rdf:resource="cap:Carcinoma" />
      <cap:site>
        <rdf:Description>
          <rdf:type rdf:resource="cap:" />
        </rdf:Description>
      </cap:site>
      <cap:histologyType rdf:resource="cap:Adenocarcinoma" />
      <cap:histologicGrade rdf:resource="cap:highGrade" />
      <cap:hasTumorFinding rdf:resource=":_microsatelliteInstabilityFindings" />
      <cap:intratumoralResponse rdf:resource="cap:marked"/>
      <cap:peritumoralResponse rdf:resource="cap:mildToModerate" />
      <cap:tumorPerforation rdf:resource="cap:negative" />
      <colon:discontinuousExtramuralExtenstion rdf:resource="cap:negative" />
      <colon:preexistingPolyp /> 
      <cap:lymphovascularInvasion /> 
      <cap:venousInvasion /> 
       <colon:deepestInvasion />
      <cap:size>
        <rdf:Description>
          <cap:dimension rdf:resource="xsd:integer">
            3.5
          </cap:dimension>
          <rdfs:label>cm</rdfs:label>
        </rdf:Description>
      </cap:size>
             
    </rdf:Description>
   </xsl:template>
  
  <!-- microsatellite -->
  <xsl:template match="tumorFindings">
    <!-- pert xml:
      <tumor>
...
      <colon:suggestMicrosatelliteInstability>
      <colon:highGrade value="positive"/>
      <colon:medullaryComponent value="negative"/>
      <colon:mucinousComponent value="negative"/>
      </colon:suggestMicrosatelliteInstability>
...      
      </tumor>
    -->
    <!-- n3:
      <_:microsatelliteInstabilityFindings> = 
      (
      [<colon:highGrade> <cap:positive>], 
      [<colon:medullaryComponent> <cap:negative>],
      [<colon:mucinousComponent> <cap:negative>]
      )
      .      
    -->
    <!-- JM.  Review this? -->
    <xsl:variable name="high-grade-value" select="colon:highGrade/@value"/>
    <xsl:variable name="medullary-component-value" select="colon:medullaryComponent/@value"/>
    <xsl:variable name="mucinous-component-value" select="colon:mucinousComponent/@value"/>
    <rdf:Description rdf:about="#microsatelliteInstabilityFindings">
        <!-- JM.  Should we move this to code look ups? -->
        <xsl:choose>
          <xsl:when test="$high-grade-value='positive'">
          <colon:highGrade rdf:resource="cap:positive" />
          </xsl:when>
          <xsl:when test="$high-grade-value='negative'">
            <colon:highGrade rdf:resource="cap:negative" />
          </xsl:when>
        </xsl:choose>

      <xsl:choose>
        <xsl:when test="$high-grade-value='positive'">
          <colon:medullaryComponent rdf:resource="cap:positive" />
        </xsl:when>
        <xsl:when test="$high-grade-value='negative'">
          <colon:medullaryComponent rdf:resource="cap:negative" />
        </xsl:when>
      </xsl:choose>
      
      <xsl:choose>
        <xsl:when test="$high-grade-value='positive'">
          <colon:mucinousComponent rdf:resource="cap:positive" />
        </xsl:when>
        <xsl:when test="$high-grade-value='negative'">
          <colon:mucinousComponent rdf:resource="cap:negative" />
        </xsl:when>
      </xsl:choose>
      
    </rdf:Description>    
  </xsl:template>
  
  <!-- accessory -->
  <!-- pert:xml
  <accessory>
    <colon:discontinuousExtramuralExtension value="negative"/>
    <colon:preexistingPolyp value="villous adenoma"/>
    <lymphovascularInvasion value="inconclusive"/>
    <venousInvasion value="negative"/>
  </accessory>
  -->
  <!-- n3:
  -->
  
  <!-- margins -->
  <xsl:template match="margins">
    <!-- pert xml:
      <margins>
      <margin location="distal" status="negative"> </margin>
      <margin location="proximal" status="negative"/>
      <margin closest="true" location="circumferential" status="negative">
      <distance unit="cm" value="0.8"/>
      </margin>
      </margins>
    -->
    <!-- n3:
    <#specimen> <cap:margin>
      (
      [
      <cap:location> <cap:distalMargin>; 
        <cap:marginStatus> <cap:negative>
          ],
          [
          <cap:location> <cap:proximalMargin>; 
            <cap:marginStatus> <cap:negative>
              ],
              [
              <cap:location> <cap:circumferentiallMargin>; 
                <cap:marginStatus> <cap:negative>; 
                  a <cap:ClosestMargin>
                    ]
                    )
                    .
    -->
    <rdf:Description rdf:about="#specimen">
      <cap:margin>
        <rdf:Description>
          <cap:location rdf:resource="cap:distalMargin" />
          <cap:marginStatus rdf:resource="cap:negative" />
          <rdf:type rdf:resource="cap:ClosestMargin" />
        </rdf:Description>
       </cap:margin>
    </rdf:Description>      
  </xsl:template>
  
  <!-- lymph nodes -->
  <xsl:template match="nodes">
    <!-- pert xml
      <nodes>
      <nodeGroup location="posterior cecal">
      <nodeStatus count="7" value="total"/>
      <nodeStatus count="0" value="positive"/>
      </nodeGroup>
      </nodes>
    -->
    <!-- n3:
    <_:ThisTumor> 
      <cap:regionalLymphNodes> 
        [
        <cap:nodeGroup> [<rdfs:label> "posterior cecal"]; 
          <cap:totalNodes> 7; 
            <cap:positiveNodes> 0
              ]
              .
    -->
    <rdf:Description rdf:about=":ThisTumor">
      <cap:regionalLymphNodes>
        <rdf:Description>
          <cap:nodeGroup>
            <rdfs:label>
              <xsl:value-of select="nodeGroup/@location"/>
            </rdfs:label>
          </cap:nodeGroup>
          <cap:totalNodes>
            <xsl:if test="value='total' ">
              <xsl:value-of select="nodeGroup/nodeStatus/@count"/>
            </xsl:if>        
          </cap:totalNodes>
          <cap:positiveNodes>
            <xsl:if test="value='positive' ">
              <xsl:value-of select="nodeGroup/nodeStatus/@count"/>
            </xsl:if>        
          </cap:positiveNodes>
        </rdf:Description>
      </cap:regionalLymphNodes>
    </rdf:Description>    
  </xsl:template>

  <!-- staging -->
  <xsl:template match="stage">
    <!--
      <stage>
      <T value="2"/>
      <N value="0"/>
      <M value="X"/>
      </stage>
    -->
     <!--
    <_:ThisTumor> 
      <cap:T> "2"; 
        <cap:N> "0"; 
          <cap:M> "X"
          .
     -->
    <rdf:Description rdf:about=":ThisTumor">
      <cap:T rdf:datatype="xsd:integer">
        <xsl:value-of select="T/@value"/>      
      </cap:T>
      <cap:N rdf:datatype="xsd:integer">
        <xsl:value-of select="N/@value"/>
      </cap:N>
      <cap:M rdf:datatype="xsd:integer">
        <xsl:value-of select="M/@value"/>
      </cap:M>      
    </rdf:Description>
  </xsl:template>
          
   <!-- additional finding -->       
  <xsl:template match="finding">
    <!-- pert xml:
      <additional>
      <findings>
      <finding value="other polyp"/>
      </findings>
      </additional>
    -->
    <!-- n3
    <_:ThisSpecimen> 
    <cap:additionalFinding> <cap:polyp>
    .
    -->
    <rdf:Description rdf:about="#specimen">
      <cap:additionalFinding rdf:resource="cap:polyp">
        <xsl:value-of select="@value"/>
      </cap:additionalFinding>
    </rdf:Description>
  </xsl:template>
  
</xsl:stylesheet>