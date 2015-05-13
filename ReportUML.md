The Report Schema class in this project is implemented as Relax NG. Note that this is not necessary: the content-identical class could also be implemented as XML schema, or as Java classes, or as C# classes, or as SQL tables, or (indeed) as pure UML. In fact, since most of the user interface frameworks that we aim at want to see XML Schema, one of the artifacts we will provide is an XML Schema translation of the Relax NG. We could also provide Java classes, if someone required it.

(But we chose to develop in Relax NG because the "impedance match" between our particular data modeling tasks and the Relax NG environment hit a nice "sweet spot". Relax NG makes a very good modelling language for XML documents that mix structured and unstructured content, as evidenced, for example, by its adoption by the [DocBook](http://www.docbook.org/) project, the [OpenDocument](http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=office) ISO standard, the [XHTML2](http://www.w3.org/TR/xhtml2/) spec, and so on.)

The below UML shows the compositional design of the Report Schema.


![http://synoptic-report.googlecode.com/files/ReportUML-2.png](http://synoptic-report.googlecode.com/files/ReportUML-2.png)


![http://synoptic-report.googlecode.com/files/methodUML.png](http://synoptic-report.googlecode.com/files/methodUML.png)