<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0" xmlns:my="http://john.madden.name/xpath#"
	xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="*|node()">
		<result value="{my:lower-camel('these are the times')}"/>
	</xsl:template>
	<xsl:template match="//rng:include[@href eq 'item.rng']/rng:define[@name eq 'name']">
		<rng:element name="{my:lower-camel(value)}">
			<rng:ref name="content"/>
		</rng:element>
	</xsl:template>
	<xsl:function as="xs:string" name="my:upper-camel">
		<xsl:param name="input"/>
		<xsl:value-of select="string-join(for $a in tokenize($input, ' ') return concat(upper-case(substring($a,1,1)),substring($a,2)),'')"
		/>
	</xsl:function>
	<xsl:function as="xs:string" name="my:lower-camel">
		<xsl:param name="input"/>
		<xsl:variable name="a" select="my:upper-camel($input)"/>
		<xsl:value-of select="concat(lower-case(substring($a,1,1)),substring($a,2))"/>
	</xsl:function>
</xsl:stylesheet>
