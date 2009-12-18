<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<ns prefix="ecc" uri="http://cap#"/>
	<let name="skip" value="true()"/>
	<pattern id="mesorectum-iff-rectum-specimen">
		<rule context="//ecc:item[@name eq 'mesorectum intactness']/ecc:response[@value ne
			'unreported']">
			<assert role="error" test="//ecc:item[@name eq 'specimen sites']/ecc:response[@value eq
				'rectum']">You may not report on mesorectum intactness unless the specimen includes
				rectum.</assert>
		</rule>
		<rule context="//ecc:item[@name eq 'specimen sites']/ecc:response[@value = 'rectum']">
			<assert role="warning" test="//ecc:item[@name eq 'mesorectum
				intactness']/ecc:response[@value ne                 'unreported']">Since the
				specimen includes rectum, you should report on mesorectum intactness.</assert>
		</rule>
	</pattern>
</schema>
