# Concept #
This project is a framework for expressing pathology/radiology reports in a structured fashion. The cornerstone design concept is to maintain a modular, loosely-coupled relationship among:

  1. the user interface (a.k.a. user input/output form/format)
  1. the underlying data model (a.k.a. report document schema, data persistence model), and model extensions       expressed in rules formalism for expressing complex constraints
  1. the sharable semantics (a.k.a. ontology binding)
  1. the transport format

This layered design mirrors an extended version of the classic model-view-controller paradigm, with the addition of a data integration layer below the model layer.

Component #1 corresponds to the View layer. (UI's today typically incorporate some controller functions too, in the form of data integrity checks.)

Component #2 corresponds to the Model layer, plus (in the form of rules) some aspects of controller.

Component #3 is an added data integration layer that sits below the Model (#2) layer and allows for semantic integration.

Component #4 is a traditional (non-semantic) data integration layer like any classic XML data integration layer.

![http://synoptic-report.googlecode.com/files/Classes-2.png](http://synoptic-report.googlecode.com/files/Classes-2.png)

We've noted that some users of existing software (like some HL7 users) find that this design novel in some ways. A discussion of why we chose this design is [here](WhyThisDesign.md).

In this Google project, the focus is on #2 and #3. Here's a high-level overview in UML.

The data mode (blue background) has as its central artifact the red "Report Schema" class. In this project, this class is instantiated as a set of Relax NG schemas (which can be translated into XSD as required).

The "Business Rule" class (purple background) represents the definitive artifact of Component #3. In this project, this class is instantiated as a set of Schematron schemas. It is in a sense an extended part of the data model, so it lives also inside the blue background.

The red-background "User form" class is Component #1. This particular project will contain at most examples of implementations of the user layer, but the instantiation of this class is intended to be a form in any of the common, widely-used user frameworks that use XML artifacts (XML schema, XML exemplar documents, etc.) as the data binding targets for their form controls. This would include all the widely-used form frameworks currently available, including XForms, PDF Forms, InfoPath forms and WPF forms.

The branch containing the green "Mapping transform" class represents Component #4. As in the W3C GRDDL architecture, ontological representations of the data are viewed as resulting from an extraction process that begins with the domain-specific data, proceeds through an extraction/mapping event that is driven by a standardized mapping transform (instantiated in this project as GRDDL/XSLT) and results in a separate document that is the ontolgical "image" of the document content.

This project currently focuses on the data model and business rules portion of this plan. We will next look at how the schemas themselves are [conceptualized](Concept2.md).