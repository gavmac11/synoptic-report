Each report schema is conceived of as being determined by the composition of:

  * a "method" (i.e. for pathology, a biopsy or a resection; or for radiology, a CT or an MRI)
  * a "site" (i.e. for pathology, thyroid or lung or prostate; or for radiology, pelvis or thorax or head)

These two "ingredients" seem to be the primary determinants of the data content of a pathology report in the sense that once these two items are known, almost everything about the data structure of the report is fixed. This is shown diagrammatically here:


![http://synoptic-report.googlecode.com/files/meth-site.png](http://synoptic-report.googlecode.com/files/meth-site.png)


For example, a lung biopsy schema is a composition of a component that defines the biopsy method, and a component that defines the lung site content:


![http://synoptic-report.googlecode.com/files/bx-lung.png](http://synoptic-report.googlecode.com/files/bx-lung.png)


We believe that this model framework will extend fairly easily to the radiology domain:


![http://synoptic-report.googlecode.com/files/mri-pelv.png](http://synoptic-report.googlecode.com/files/mri-pelv.png)


but we also can imagine that this bipartite framework might be insufficient for many kinds of reports. Thus we have built the framework to accomodate additional componentry:


![http://synoptic-report.googlecode.com/files/extend.png](http://synoptic-report.googlecode.com/files/extend.png)


So, for example, if in some domain an additional primary determinant of the data content of a report happens to be, say, the indication for which the method was performed, the framework can accomodate such an additional determinant:

![http://synoptic-report.googlecode.com/files/extend-example.png](http://synoptic-report.googlecode.com/files/extend-example.png)


So far all this is at a very high level! But how is this all implemented? The answer is as a series of Relax NG schemas that reference each other. This is presented on the [next page](ReportUML.md).