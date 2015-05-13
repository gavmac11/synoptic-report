So now you know how the classes fit together to create a site- and method-specific data model (=schema). But where _are_ all these Relax NG classes in the Source folder? Which file is which?

This diagram shows the package (i.e. folder) structure of the project. These are the folder names you will see if you click on the **Source** tab up above and browse the repository.

(For those new to Subversion, that the repository contains a main development  line in the **trunk** folder, various named, snapshotted versions of the entire project in the **tags** folder, and alternate development branches in the **branches** folder.)


![http://synoptic-report.googlecode.com/files/Packages.png](http://synoptic-report.googlecode.com/files/Packages.png)


Let's take these folders one at a time.

**report** is where you look to see the "completed" schema, that is to say, the full schema for, say, a "breast resection" or a "pelvic MRI" or the like. When you open this folder you will see that the contents are organized into subfolders, each one representing a particular report domain. Thus we have a **cap-cancer** folder that contains the schemas for CAP cancer report templates; a **cap-medicalKidney** folder that contains (as yet imaginary) templates for CAP medical kidney reports; and a **rsna-mri** folder that contains (again, as yet imaginary) RSNA MRI reports.

When you open **/report/cap-cancer** you will see a couple of additional "convenience" subfolders that help organize the contents: a **biopsy** subfolder and a **resection** subfolder. This means what it says: all the schemas for various biopsy templates are in the one, for various resection templates are in the other.

When you look inside, let's say, the **resection** subfolder, you will see a bunch of schemas for resections at various sites. There is a **resection@breast.rng** file that represents the complete schema for a breast resection, and so on.

All files with a suffix of **.rng** are Relax NG schemas, in case you didn't know. (There may also be some **.xsd** files in there; these are the cognate XML Schema translations of the Relax NG schemas.) Open one up and look at it if you like, but I'll explain how these schemas are structured internally [elsewhere](ReportSchemaStructure.md). On this page, I just want to help you become familiar with the various packages (= folders).

Okay, now back out of **report** and let's look at the other folders. Notice there is one called **method** and one called **site**? That should remind you of the project design principle I mentioned elsewhere, namely that we conceive of a report as consisting of a composition of a Method and a Site. And indeed, that's exactly why these two folders exist.

The **method** folder defines schema "bits" that are specific to various methods. Open it up, and just like the **report** folder, notice the subfolder named **cap-cancer**. Look inside and you will see three files: **common.rng**, **biopsy.rng** and **resection.rng**. Right at the moment, biopsy and resection are the two methods that we accommodate in the CAP cancer project. We might subsequently add more methods, like for example, fine needle biopsy, or exfoliative cytology, or whatever; but right now we support these two. The **common.rng** file contains bits relating to method definition that are common to biopsy and resection, and the other two files contain the schema bits unique to each method.

What exactly are these "bits"? Well, what about a report is constrained by the method (as opposed to the site)?  Answer: most importantly, the choice of relevant report sections and their optionality. For example, a resection report must have an staging section. By contrast, a biopsy report does not have a staging section (because you don't stage from a biopsy). Both biopsy and resection need to have a clinical history section. A resection has a required tumor extent section, whereas for a biopsy the extent sections is optional (it may not be possible to assess tumor extent from a biopsy). So...most of what's in these particular "bits" is the definition of the sectional structure of the report, particularized to the method.

What about the content of the sections?

...to be continued...