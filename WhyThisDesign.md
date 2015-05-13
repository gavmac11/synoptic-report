**1. Why aren't there any "codes" in the document instances? I want codes!**

Ah, but there are! There are no obscure numeric codes, but all the elements in this design reside in an XML namespace (`http://www.cap.org/pert/2009/01/` or namespaces whose names are derived from this). This means that the full name (or to use the official XML term, the namespace-qualified name) of (for example) the element that wraps information about the tumor histologic type in this project is:

> `http://www.cap.org/pert/2009/01/histologicType`

Is that sufficiently "code-like" to suit you?

For those unfamiliar with XML, you just have to realize that because namespace-qualified names can be long and human-unfriendly (like any "codes"), the XML standard allows them to be "abbreviated" in schemas by declaring a default namespace in the document. This is what we do.

(One sidelight for XML connoisseurs: notice that while all our element names are in specific namespaces, the associated attributes are in no-namespace (i.e. the "" namespace). We could have put our attributes in a namespace (and it's a discussable point), but at the moment we believe that since these attributes only exist in association with a "carrying' element, namespace restriction is unnecessary for them.)

**2. Why doesn't the document use SNOMED-CT (or LOINC, or UMLS, or RadLex) codes instead of your own XML element names? After all those coding systems are more widely used, whereas your system is novel!**

Unlike question #1, which is purely about technical implementation, this gets to the heart of the design philosophy.

We recognize (at least) two approaches to making documents machine-interoperable. One is to compose them directly in some existing, standardized, "ontology" that is administered by someone else. The other is to compose them in a public, unambiguous, but use-case specific vocabulary and then (in a separate step) map to one or more shared "ontologies".

The (perceived) advantage of the first approach is that (if you're lucky) you'll find some "ready-made" vocabulary items that you can "bake-in" to your design, thus possibly saving yourself some work downstream. The real-world disadvantages, however, are that:

  1. typically you _don't_ find all the vocabulary items you need to cover a specialized use case. You need to go to the "owners" of the vocabulary and request that your items be added. This takes time, and may involve a balloting process. The ontology owners may disagree with your semantics, and give you some terms that are similar to what you requested, but not exactly the same.
  1. the vocabulary items you requested may be highly specific to your use case and of no interest to the general users of big ontologies. When thousands of such requests are made, the central ontology suffers "bloat". The mere accretion of more terms does not add quality to the central ontology unless the new terms are accurately "hooked up" with existing terms. But the central ontology administrators, who are not experts in every use case, may not be able to do this. Or they may simply be overwhelmed by the number of term requests and enter them into the ontology perforce with very little "modeling", i.e. very few connections to existing terms. The central ontology begins to look like a flat term list with hundreds of thousands of terms that no one can possibly curate.
  1. central ontologies typically make some claim of "global semantics"; but this project is an example of a highly specialized, use-case specific standard (although it's an important use-case!)

> _When I say "global semantics" I mean that by virtue of being central and serving every possible use case, a central
> ontology needs to define terms in ways that "reconcile" differences in understanding among different user
> communities. If such reconciliation is not enforced, then the central ontology will come to contain logically
> incompatible assertions, and will ultimately become "unclassifiable" (i.e. it will no longer "compute")._

> But in the real world, subtle and not-so-subtle differences in understanding of vocabulary among user
> communities are a fact of life--in fact, it's these subtle, use-case specific meanings that may well be precisely
> the thing that your software project is trying to capture!

> Ongoing negotiation of such differences is the very essence of genuine human language. Such differences arise
> and recede constantly as knowledge and practice evolve. Large global ontologies always provide, therefore, at best
> a temporal "snapshot" and a conceptual "average" of how vocabulary is used and how concepts are understood by
> users. (In the semantic web world, this dynamic character of language has been recognized, and a variety of
> techniques have been proposed to accommodate it. For example, you might want to google "Named Graphs".)

> The more specialized the use case, the more violence the reconciliation process may do to conceptualizations of
> specialized users. For example, pathologists have a particular way of looking at tumors, particular understandings
> of terms like "size", "extent", "differentiation" and so on, that are overlapping, but also subtly or not-so-subtly
> different from the understanding of, say, radiologists or oncologists or molecular biology researchers. In fact, a lot
> of what a surgical pathologist spends her day doing, is talking to other medical specialists and explicating precisely
> these matters so her meaning is appropriately understood by other specialists.

> So for specialized use cases, a global ontology isn't at all where you want to start! Instead, you want to proceed
> from the "bottom-up", modeling your use case with as few external constraints as possible, until you have the
> formalization as close as possible to the community's intent. Only then do you want to begin to worry about
> matching your vocabulary up with some "global" standard.

> 4. the more expressive ontologies are first-order logic constructs; human thoughts are not (whence Wittgenstein repudiated the _Tractatus_)! In terms of logical "expressivity" some ontology languages exceed everyday thought, which means that if we attempt too quickly to translate everyday "knowledge" into an ontology, we may "pickle" the meaning, i.e. force overspecification of concepts that were not (by intent) so tightly specified in their everyday usage. (Philosophically, this goes back to the notion that everyday language is a degenerate dialect of FOL, that ideally could be cleaned up by paying closer attention to logic and rigor of expression. This concept was discarded now going on a century ago by most people (including the philosophers who originally proposed it; except, evidently, for an occasional ontologist).

The second approach takes a completely different tack, inspired by innovations like [microformats](http://microformats.org/), federative semantics, and the like. The idea here is that communities of practice (pathologists, radiologists, etc.) should formalize their own meaning, according to their own practice, in maximally light-weight and agile fashion; and then secondarily provide mappings to one or many ontologies that make global claims, controlling the mappings themselves.

In our project, we make no high-falutin' claims that we have created an "ontology". We intentionally did not choose to develop our project in, say, OWL as an implementation language. Our claim is simply that we know what a pathology report for cancer is supposed to "look like". We know what sections it's supposed to contain, we know what data items should be included in each section, and we know what "fill-in-the-blanks" responses should be allowed (or disallowed) for each item. In short, rather than an "ontology", we have chosen to publish a description of a particular document structure, but in a way that makes it "ripe" for subsequently extracting ontological (semantic) information to any arbitrary global ontology that might be required. (And also, in a way that does not unduly fore-ordain the visual representation of the underlying document data!)

By avoiding ontologic claims in our base artifacts, we have made our task _much simpler_ than it might otherwise have been. We don't need to reconcile the first-order logic of our vocabulary with the 1.2 million terms of SNOMED CT in order for it to be useful. We can change our document schema whenever we like, without having to "reclassify" multiple million-term ontologies to check whether we have "broken" something in the ontology. Those of you who have actually had the experience (as I have) of creating OWL ontologies know that it is a very demanding and often counter-intuitive kind of task, whereas describing what counts as an acceptable example of a particular document type is much simpler and "closer-to-user".