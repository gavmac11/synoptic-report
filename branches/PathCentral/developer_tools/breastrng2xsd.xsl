<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:ecc="http://purl.org/pathology/ecc/" xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="rng:ref[@name eq 'resection']">
        <xs:schemaresection xmlns="http://purl.org/pathology/ecc/">
            <xsl:apply-templates/>
        </xs:schemaresection>
    </xsl:template>
</xsl:stylesheet>
