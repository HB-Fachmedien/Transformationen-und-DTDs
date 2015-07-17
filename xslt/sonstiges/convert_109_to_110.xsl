<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd" encoding="utf-8"/>

    <xsl:template match="instdoc">
        <instdoc>
            <xsl:choose>
                <xsl:when test="instcode|insttype">
                    <inst>
                        <xsl:if test="instcode">
                            <xsl:attribute name="code">
                                <xsl:value-of select="instcode/@court"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="insttype">
                            <xsl:attribute name="type">
                                <xsl:value-of select="insttype/@value"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:copy-of select="inst/node()"/>
                    </inst>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="inst"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="instdoctype|instdocdate|instdocnrs|instdocaddnr|instdocnote|judges|citations"/>
        </instdoc>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>