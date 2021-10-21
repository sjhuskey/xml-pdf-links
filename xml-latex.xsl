<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:s="http://www.ascc.net/xml/schematron"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="s xs tei"
    version="2.0">

    <!-- Set the output method to text, since LaTeX is a text format. -->
    <xsl:output method="text"/>

    <!-- Match everything and insert the LaTeX preamble. The for-each statement is where all of the 
        documents linked in index.xml are opened. -->
    <xsl:template match="/">
        <xsl:text>
\documentclass{book}
\usepackage{blindtext}
\usepackage{hyperref} %This enables the hyperlinks
\title{Example of Processing Multiple XML Documents with One XSLT}
\author{Samuel J. Huskey}
\begin{document}
        </xsl:text>
        <xsl:for-each select="document(//tei:ref/@target)//tei:text">
            <xsl:apply-templates/>
        </xsl:for-each>
       <xsl:text>&#10;
\end{document}</xsl:text> 
    </xsl:template>

<!-- Process the head element to set up a label for links to point to. -->
    <xsl:template match="tei:div/tei:head">
        <xsl:text>
\section{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}\label{</xsl:text>
        <xsl:value-of select="parent::tei:div/@xml:id"/>
        <xsl:text>}</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

<!-- Use \hyperref to link to different parts of the document. --> 
    <xsl:template match="tei:ref">
        <xsl:text>\hyperref[</xsl:text>
        <xsl:value-of select="@target"/>
        <xsl:text>]{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="tei:teiHeader"/>
</xsl:stylesheet>
