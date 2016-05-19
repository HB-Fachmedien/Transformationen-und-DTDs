<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="alle-Hefte" select="collection('file:/c:/work/verschlagwortung/2015/?recurse=yes;select=*.xml')"/>
    <xsl:variable name="alle-Entscheidungen" select="$alle-Hefte/*[name()= ('ent', 'entk')]"/> <!-- HIER WEITER -->
    
    <xsl:template match="/">
        <entscheidungsregister>
            
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'EuGH'"/>
                <xsl:with-param name="ressort" select="'all'" />
            </xsl:call-template>
               
        </entscheidungsregister>
    </xsl:template>
    
    
    <xsl:template name="entscheidungsdaten">
        <xsl:param name="gerichtsBezeichnung"/>
        <xsl:param name="ressort"/>
        
        <h2><xsl:value-of select="$gerichtsBezeichnung"/></h2>
        <xsl:choose>
            <xsl:when test="$ressort='all'">
                <xsl:for-each select="$alle-Entscheidungen[metadata/instdoc/inst/text()=$gerichtsBezeichnung]">
                    <zeile><xsl:value-of select="metadata/pub/pages/start_page"/></zeile>
                </xsl:for-each>        
            </xsl:when>
            <xsl:otherwise>
                <!-- hier noch nach Ressorts filtern in der for-each Schleife -->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>