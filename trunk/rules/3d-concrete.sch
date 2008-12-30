<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron">
    <pattern is-a="three-dimensional-size">
        <param name="size" value="//size"/>
        <param name="dimension-1" value="@d1"/>
        <param name="dimension-2" value="@d2"/>
        <param name="dimension-3" value="@d3"/>
    </pattern>
    <include href="3d-abstract.sch"/>
</schema>
