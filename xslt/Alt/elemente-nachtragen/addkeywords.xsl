<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE" doctype-system="hbfm.dtd" encoding="UTF-8"/>
    <xsl:variable name="keywordDatei" select="document('schlagwoerter.xml')"/>


    <xsl:template match="/*">
        <xsl:variable name="sid" select="@rawid"/>

        <xsl:variable name="kwds">
            <xsl:choose>
                <xsl:when test="$keywordDatei/kwds/keywords/siriusId[text() = $sid]">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <metadata>
                <xsl:apply-templates select="metadata/title | metadata/subtitle | metadata/coll_title | metadata/authors | metadata/summary 
                    | metadata/leitsaetze"/>
                <xsl:if test="not($kwds = 'false')">
                    <xsl:apply-templates select="$keywordDatei/kwds/keywords/siriusId[text() = $sid]/.."/>                    
                </xsl:if>
                <xsl:apply-templates select="metadata/*[name()=('keywords','ressort', 'rubriken', 'pub', 'extfile','law','instdoc',' preinstdocs','law_refs','all_doc_type','all_source','all_source','exportblocker','sgml_root_element')]"/>
            </metadata>
            <body>
                <xsl:apply-templates select="body/*"/>
            </body>
        </xsl:copy>

    </xsl:template>
    
    <xsl:template match="siriusId"></xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
