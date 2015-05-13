|_An XML framework for creation and distribution of structured (sometimes referred to as "synoptic") medical diagnostic reports, in particular pathology and radiology reports._|![http://synoptic-report.googlecode.com/files/framework.png](http://synoptic-report.googlecode.com/files/framework.png) |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------|

The framework consists of the following components:

  1. a modular and extensible set of base document schemas (implemented as Relax NG) that allow description of the section structure and the recurring information items pertaining to a medical domain;
  1. a mechanism for extending the base schemas to accommodate more specialized information content pertaining to various combinations of diagnostic method and body site;
  1. a pattern for adding rules-based constraints on the report schemas generated from (1) and (2), using Schematron as the implementation language;
  1. a method for converting (1) + (2) into XML Schema or (1) + (2) + (3) into exemplary instances, either of which may be used in XForms, PDF Forms, etc. environments as the binding target for visual forms;
  1. a set of semantic extraction transforms implemented in XSLT and linked to the schemas by means of GRDDL, suitable for mapping compliant documents into any standard terminology or (especially) RDF/OWL ontology.