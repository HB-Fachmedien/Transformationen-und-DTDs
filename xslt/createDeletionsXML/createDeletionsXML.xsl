<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes" encoding="UTF-8"  method="xml"/>
    
    <!-- Erstellt eine deletions.xml Datei, die muss dann als [all_source/level2]___[datum].zip auf dem FTP Server mit Signaldatei abgelegt werden. ] -->    
    <xsl:template match="/">
        <xsl:variable name="file-collection" select="collection('file:/c:/beispiel-xml-dateien/create-deletions-xml/?recurse=yes;select=*.xml')"/>
        <deletions>
            <xsl:for-each select="$file-collection/*">
                <deletion>
                    <docid>
                        <xsl:choose>
                            <xsl:when test="@docid"><xsl:value-of select="@docid"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="//docid"/></xsl:otherwise>
                        </xsl:choose>
                    </docid>
                    <all_source level="1"><xsl:value-of select="metadata/all_source[@level='1']"/></all_source>
                    <all_source level="2"><xsl:value-of select="metadata/all_source[@level='2']"/></all_source>
                </deletion>
            </xsl:for-each>
        </deletions>
    </xsl:template>
</xsl:stylesheet>