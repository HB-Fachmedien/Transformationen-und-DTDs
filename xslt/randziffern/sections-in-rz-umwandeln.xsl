<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="no"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
        method="xml"
    />
    
    <!-- Identity Template -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="rzblock/section[title]">
        <xsl:variable name="prefix">
            <xsl:choose>
                <xsl:when test="@number">
                    <xsl:value-of select="@number"/><xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <subhead><xsl:value-of select="concat($prefix, title)"/></subhead>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="rzblock/section/title"></xsl:template>
    
    <xsl:template match="rzblock/section[not(title)]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="rzblock/section[@class='anmerkung']" priority="10">
        <block class="anmerkung">
            <xsl:apply-templates/>
        </block>
    </xsl:template>
</xsl:stylesheet>