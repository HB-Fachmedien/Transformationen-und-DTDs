<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" doctype-public="-//Handelsblatt Fachmedien CContent//DTD V1.0//DE"
        doctype-system="hbfmcc.dtd" encoding="UTF-8"/>
    
    <!-- Stylesheet zur Änderung des vorhandenen Dateformats in das hbfm Date Format -->

    <xsl:template match="rodoc/metadata/maindate">
        <maindate>
            <xsl:variable name="year" select="tokenize(text(),'-')[1]"/>
            <xsl:variable name="month" select="number(tokenize(text(),'-')[2])"/>
            <xsl:variable name="day" select="number(tokenize(text(),'-')[3])"/>
            <!--<xsl:value-of select="format-number(text(), '0000-00-00')"/>-->
            <xsl:value-of select="concat($year, '-', format-number($month, '00'), '-', format-number($day, '00'))"/>
        </maindate>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>