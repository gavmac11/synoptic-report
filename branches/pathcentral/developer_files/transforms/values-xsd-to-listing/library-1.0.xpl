<p:library version="1.0" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
  xmlns:p="http://www.w3.org/ns/xproc" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <p:documentation xmlns="http://www.w3.org/1999/xhtml">
    <div>
      <h1>XML Calabash Extension Library</h1>
      <h2>Version 1.0</h2>
      <p>The steps defined in this library are implemented in <a href="http://xmlcalabash.com/">XML Calabash</a>. </p>
    </div>
  </p:documentation>
  <p:declare-step type="cx:metadata-extractor">
    <p:output port="result"/>
    <p:option name="href" required="true"/>
  </p:declare-step>
  <p:declare-step type="cx:unzip">
    <p:output port="result"/>
    <p:option cx:type="xsd:anyURI" name="href" required="true"/>
    <p:option name="file"/>
    <p:option name="content-type"/>
  </p:declare-step>
  <p:declare-step type="cx:zip">
    <p:input port="source" primary="true" sequence="true"/>
    <p:input port="manifest"/>
    <p:output port="result"/>
    <p:option cx:type="xsd:anyURI" name="href" required="true"/>
    <p:option cx:type="stored|deflated" name="compression-method"/>
    <p:option cx:type="smallest|fastest|default|huffman|none" name="compression-level"/>
    <p:option cx:type="update|freshen|create|delete" name="command" select="'update'"/>
    <p:option cx:type="xsd:boolean" name="byte-order-mark"/>
    <p:option cx:type="ListOfQNames" name="cdata-section-elements" select="''"/>
    <p:option cx:type="xsd:string" name="doctype-public"/>
    <p:option cx:type="xsd:anyURI" name="doctype-system"/>
    <p:option cx:type="xsd:string" name="encoding"/>
    <p:option cx:type="xsd:boolean" name="escape-uri-attributes" select="'false'"/>
    <p:option cx:type="xsd:boolean" name="include-content-type" select="'true'"/>
    <p:option cx:type="xsd:boolean" name="indent" select="'false'"/>
    <p:option cx:type="xsd:string" name="media-type"/>
    <p:option cx:type="xsd:QName" name="method" select="'xml'"/>
    <p:option cx:type="NormalizationForm" name="normalization-form" select="'none'"/>
    <p:option cx:type="xsd:boolean" name="omit-xml-declaration" select="'true'"/>
    <p:option cx:type="true|false|omit" name="standalone" select="'omit'"/>
    <p:option cx:type="xsd:boolean" name="undeclare-prefixes"/>
    <p:option cx:type="xsd:string" name="version" select="'1.0'"/>
  </p:declare-step>
  <p:declare-step type="cx:delta-xml">
    <p:input port="source"/>
    <p:input port="alternate"/>
    <p:input port="dxp"/>
    <p:output port="result"/>
  </p:declare-step>
  <p:declare-step type="cx:message">
    <p:input port="source"/>
    <p:output port="result"/>
    <p:option name="message" required="true"/>
  </p:declare-step>
  <p:declare-step type="cx:nvdl">
    <p:input port="source" primary="true"/>
    <p:input port="nvdl"/>
    <p:input port="schemas" sequence="true"/>
    <p:output port="result"/>
    <p:option name="assert-valid" select="'true'"/>
    <!-- boolean -->
  </p:declare-step>
  <p:declare-step type="cx:collection-manager">
    <p:input port="source" sequence="true"/>
    <p:output port="result" primary="false" sequence="true"/>
    <p:option cx:type="xsd:anyURI" name="href" required="true"/>
  </p:declare-step>
  <p:declare-step type="ml:adhoc-query">
    <p:input port="source" primary="true" sequence="true"/>
    <p:input kind="parameter" port="parameters"/>
    <p:output port="result" sequence="true"/>
    <p:option name="host"/>
    <p:option cx:type="xsd:integer" name="port"/>
    <p:option name="user"/>
    <p:option name="password"/>
    <p:option name="content-base"/>
    <p:option cx:type="xsd:QName" name="wrapper"/>
  </p:declare-step>
  <p:declare-step type="ml:invoke-module">
    <p:input kind="parameter" port="parameters"/>
    <p:output port="result" sequence="true"/>
    <p:option name="module" required="true"/>
    <p:option name="host"/>
    <p:option cx:type="xsd:integer" name="port"/>
    <p:option name="user"/>
    <p:option name="password"/>
    <p:option name="content-base"/>
    <p:option cx:type="xsd:QName" name="wrapper"/>
  </p:declare-step>
  <p:declare-step type="ml:insert-document">
    <p:input port="source"/>
    <p:output port="result" primary="false"/>
    <p:option name="host"/>
    <p:option cx:type="xsd:integer" name="port"/>
    <p:option name="user"/>
    <p:option name="password"/>
    <p:option name="content-base"/>
    <p:option name="uri" required="true"/>
    <p:option cx:type="xsd:integer" name="buffer-size"/>
    <p:option name="collections"/>
    <p:option cx:type="xml|text|binary" name="format"/>
    <p:option name="language"/>
    <p:option name="locale"/>
  </p:declare-step>
</p:library>
