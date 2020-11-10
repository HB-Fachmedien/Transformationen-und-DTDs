<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="alle-Hefte" select="collection('file:/c:/verschlagwortung/?recurse=yes;select=*.xml')"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <!-- Dieses Skript dient zur Kontrolle, ob alle Entscheidungen mit dem aktuellen Stand des entscheidungsregister.xsl Skripts
        verarbeitet werden können. Zum Abgleich verwendet dieses Skript alle Dokumente eines DB/Dk Jahrgangs und die erste Version des
        zugehörigen Entscheidungsregisters.
        Es listet alle Dokumente auf, welche bisher nicht verarbeitet wurden.
    -->
    
    <xsl:template match="/">
        <xsl:variable name="alle-aktenzeichen-des-registers" select="//*[name() =('az', 'az-gericht')]/text()"/>
        
        <nicht-gefundene-dokumente>
            <xsl:for-each select="$alle-Hefte/*[not(name()=('kk','entk'))]/metadata/instdoc/inst[not(starts-with(ancestor::metadata/pub/pages/start_page/text(),'M') or starts-with(ancestor::metadata/pub/pages/start_page/text(),'S'))]">
                    <xsl:variable name="aggr-az">
                        <xsl:choose>
                            <xsl:when test="ancestor::instdoc/instdocnrs/instdocnr">
                                <xsl:for-each select="ancestor::metadata/instdoc/instdocnrs/instdocnr">
                                    <xsl:if test="not(position()=1)">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="."/>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="ancestor::instdoc/instdoctype"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                
                <xsl:if test="empty(index-of($alle-aktenzeichen-des-registers, $aggr-az))">
                    <document>
                        <uri><xsl:value-of select="base-uri()"/></uri>
                        <xsl:copy-of select="./.."/>
                        <doctype><xsl:value-of select="/*/name()"/></doctype>
                        <ressort><xsl:value-of select="ancestor::metadata/ressort"/></ressort>
                    </document>
                </xsl:if>
                    
            </xsl:for-each>
        </nicht-gefundene-dokumente>
    </xsl:template>
</xsl:stylesheet>
