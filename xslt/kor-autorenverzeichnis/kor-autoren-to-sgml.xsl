<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes" encoding="UTF-8"  method="xml"/>
    
    <xsl:template match="/">
        <xsl:variable name="file-collection" select="collection('../../../../../tempKOR/verschlagwortung/?recurse=yes;select=*.xml')"/>
        <R_AUTOR><TITEL>Verzeichnis der Verfasser</TITEL>
            <xsl:for-each select="$file-collection/*">
                <xsl:if test="metadata/authors[child::node()]">
                    <xsl:for-each select="metadata/authors/author">
                        <R-AU-EINTR>
                            <xsl:attribute name="RU">
                                <xsl:choose>
                                    <xsl:when test="ancestor::metadata/ressort/text()='Fallstudie'">
                                        <xsl:text>FALLSTUDIE</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>KOR</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <NACHNAME><xsl:value-of select="surname"/></NACHNAME><VORNAME><xsl:value-of select="firstname"/></VORNAME>
                            <TITEL><xsl:value-of select="ancestor::metadata/title"/></TITEL>
                            <KORFUND>
                                <xsl:attribute name="ZIEL"><xsl:value-of select="replace(ancestor::metadata/sgml_root_element,'.*\sID=(.*?)\s.*','$1')"/></xsl:attribute>
                                <xsl:value-of select="ancestor::metadata/pub/pages/start_page"/>
                            </KORFUND>
                        </R-AU-EINTR>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each>
        </R_AUTOR>
    </xsl:template>
</xsl:stylesheet>