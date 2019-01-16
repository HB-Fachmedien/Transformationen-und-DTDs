<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
    />
    
    
    <!-- 
    offene Fragen:
    
    was ist bei hbfm.dtd mit den Elementen:
    
    sollten komplett uninteressant sein für diese Umwandlung:
    ROOTELEMENT/@sid
    ROOTELEMENT/@sidword
    
    
    was ist bei hbfmcc.dtd mit den Elementen:
    
    maindate
    subtitle_rest
    toc_title
    author_info
    
    -->
    
    <!-- identity transform: -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="/rodoc">
        <xsl:variable name="doctype" select="metadata/all_doc_type[@level='2']"/>
        <xsl:element name="{$doctype}">
            <xsl:attribute name="docid"><xsl:value-of select="metadata/docid"/></xsl:attribute>
            <xsl:if test="metadata/altdocid">
                <xsl:attribute name="altdocid"><xsl:call-template name="build_altdocid_string"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="metadata/rawid">
                <xsl:attribute name="rawid"><xsl:value-of select="metadata/rawid/text()"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="metadata/extid">
                <xsl:attribute name="extid"><xsl:value-of select="metadata/extid/text()"/></xsl:attribute>
            </xsl:if>
            <!--<xsl:apply-templates select="*"/>-->
            <metadata>
                <!--<title><xsl:apply-templates select="metadata/title/*"/></title>-->
                <xsl:copy-of select="metadata/title | metadata/subtitle | metadata/coll_title"></xsl:copy-of>
                <authors><xsl:apply-templates select="metadata/author_info/*"/></authors>
                <xsl:copy-of select="metadata/summary | metadata/leitsaetze | metadata/keywords | metadata/ressort"></xsl:copy-of>
            </metadata>
            <body>
               <xsl:apply-templates select="xml_body/*"/>
            </body>
        </xsl:element>
    </xsl:template>
    
    <!--<!-\- Elemente, die nicht oder an schon an anderer Stelle verarbeitet werden: -\->
    <xsl:template match="docid | altdocid | rawid | extid">
    </xsl:template>-->
    
    <!--<xsl:template match="maindate">
        <TO-DO>TBD</TO-DO>
    </xsl:template>-->
    
    <!-- Generiert einen Kommata getrennten String aus allen altdocids: -->
    <xsl:template name="build_altdocid_string">
        <xsl:for-each select="metadata/altdocid">
            <xsl:value-of select="text()"/><xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>