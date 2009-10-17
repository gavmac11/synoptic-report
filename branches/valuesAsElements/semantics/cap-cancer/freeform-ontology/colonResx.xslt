<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
  xmlns:xsl  ="http://www.w3.org/1999/XSL/Transform" 
  version    ="2.0"
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

  <xsl:output method="text" indent="yes"/>

  <!-- root template -->
  <xsl:template match="/">
    <!-- preamble -->
    <xsl:call-template name="prefixes" />
    
    <!-- individuals as stated -->
    <!-- JM.  Where are these coming from -->
    <xsl:call-template name="patient" />
    <xsl:call-template name="specimen" />
    <xsl:call-template name="pathologist" />
    <xsl:call-template name="source-of-specimen" />
    <xsl:call-template name="clinical-finding" />
    
    <!-- gleaned from synoptic -->
    <xsl:apply-templates />  <!-- apply default template -->    
  </xsl:template>  

  <xsl:template name="prefixes">
      @prefix cap:  &lt;http://www.cap.org/pert/2009/01/#&gt; .
      @prefix colon:  &lt;http://www.cap.org/pert/2009.01/colon/#&gt; .
      @prefix anat:  &lt;http://www.rsna.org/radlex/2009/01/anat/#&gt; .
  </xsl:template>

  <xsl:template name="patient">
    #patient = cmh:X875693 .
  </xsl:template>
  
  <xsl:template name="specimen">
    #specimen = cmhsp:SL-09-12345 .
  </xsl:template>
 
  <xsl:template name="pathologist">
    #dc:author #pathologist .
    #pathologist = cmhmd:9876-1 .
  </xsl:template>

  <xsl:template name="source-of-specimen">
    #patient cap:sourceOfSpecimen _:ThisSpecimen .
  </xsl:template>
 
  <xsl:template name="clinical-finding">
    #patient 
      cap:clinicalFinding 
        [a cap:Mass>], 
          [cap:diagnosedBy cap:Biopsy; a cap:Cancer ]
            .
  </xsl:template>

  <!-- specimen -->
  <xsl:template match="specimen">
    #specimen = 
      [
      a cap:Specimen;
        cap:derivedFromProcedure [a cap:segmentalColectomy];
          cap:includesAnatomicPart [a anat:Cecum, anat:leftColon];
            cap:involvedByDisease _:ThisTumor
              ]
              .      
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
    _:ThisTumor 
      a cap:Carcinoma; 
      cap:site [a anat:Cecum];
      cap:histologicType cap:Adenocarcinoma;
      cap:histologicGrade cap:highGrade;
      cap:hasTumorFinding _:microsatelliteInstabilityFindings;
      colon:intratumoralResponse cap:marked;
      colon:peritumoralResponse cap:mildToModerate;
      colon:tumorPerforation cap:negative;
      colon:discontinuousExtramuralExtenstion cap:negative;
      colon:preexistingPolyp [a cap:Concept; rdfs:label "villous adenoma"];
      cap:lymphovascularInvasion cap:inconclusive;
      cap:venousInvasion cap:negative;
      colon:deepestInvasion [a cap:Concept; rdfs:label "muscularis propria"];
      cap:size [cap:dimension 3.5; cap:unit [rdfs:label "cm"]]
      .      
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
      _:microsatelliteInstabilityFindings = 
        (
          [colon:highGrade cap:positive], 
          [colon:medullaryComponent cap:negative],
          [colon:mucinousComponent cap:negative]
        )
      .      
  </xsl:template>
  
  <!-- accessory -->
  <xsl:template name="accessory">
    <!-- pert:xml
      <accessory>
      <colon:discontinuousExtramuralExtension value="negative"/>
      <colon:preexistingPolyp value="villous adenoma"/>
      <lymphovascularInvasion value="inconclusive"/>
      <venousInvasion value="negative"/>
      </accessory>
    -->
    #specimen cap:accessory
  </xsl:template> 
  
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
    <!-- JM.  Where does individual get injected from -->
    #specimen cap:margin
      [
      cap:location cap:distalMargin>; 
        cap:marginStatus> cap:negative
          ],
          [
          cap:location cap:proximalMargin; 
            cap:marginStatus cap:negative
              ],
              [
              cap:location cap:circumferentiallMargin; 
                cap:marginStatus cap:negative; 
                  a cap:ClosestMargin
                    ]
                    )
                    .
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
    _:ThisTumor 
      cap:regionalLymphNodes 
        [
        cap:nodeGroup [rdfs:label "<xsl:value-of select="nodeGroup/@location"/>" ]; 
          cap:totalNodes <xsl:value-of select="nodeGroup/nodeStatus/@count"/>; 
            cap:positiveNodes <xsl:value-of select="nodeGroup/nodeStatus/@count"/>
              ]
              .
  </xsl:template>

  <!-- staging -->
  <xsl:template match="stage">
    _:ThisTumor 
      cap:T "<xsl:value-of select="T/@value"></xsl:value-of>"; 
        cap:N "<xsl:value-of select="N/@value"></xsl:value-of>"; 
          cap:M "<xsl:value-of select="M/@value"></xsl:value-of>"
          .
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
    <!-- JM.
      1.  does cap:additionalFinding need to be wrapped in a "findings collection"?
      2.  does cap:additionalFinding cap:polyp really represent "other polyp"
      -->
    _:ThisSpecimen 
      cap:additionalFinding cap:polyp
        .
  </xsl:template>
  
</xsl:stylesheet>