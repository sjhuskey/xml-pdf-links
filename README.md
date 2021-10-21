---
author: "Samuel J. Huskey"
title: "How to process multiple XML files with one XSLT."
...

I created this repository to show one method for combining multiple XML files (section1.xml, section2.xml, section3.xml) into one PDF that preserves the links in the original XML files.

The transformation goes from XML to LaTeX to PDF.

The key to processing multiple XML files is in these lines:

```
<xsl:for-each select="document(//tei:ref/@target)//tei:text">
    <xsl:apply-templates/>
 </xsl:for-each>
```

The XSL file is meant to process the file called index.xml, which includes a list of sections. The `xsl:for-each` statement iterates over the documents referenced in index.html by selecting the value of `@target`, which is a file name, on `<ref>` then appending `//tei:text` to the resulting path. That effectively opens the document and selects the `<text>` element, which contains all of the parts that we want to be transformed into a PDF.

The rest of the XSL file contains specific instructions for transforming the elements into LaTeX.
