<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs hbfm"
    version="2.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="fundstelle"/>
    
    <xsl:template match="raw-reg">
        <xsl:text>&#xa;</xsl:text>
        <register><xsl:text>&#xa;</xsl:text>
            <xsl:for-each-group select="reg-zeile" group-by="autor">
                <ebene1-autoren><xsl:value-of select="current-grouping-key()"/></ebene1-autoren><xsl:text>&#xa;</xsl:text>
                <xsl:for-each select="current-group()">
                    <xsl:sort select="fundstellen/replace(text(),'\D','')" data-type="number"/>
                    <ebene2-autoren><xsl:value-of select="title"/><fundstelle><xsl:text>&#x9;</xsl:text><xsl:value-of select="fundstellen"/></fundstelle></ebene2-autoren><xsl:text>&#xa;</xsl:text>
                    <!--<xsl:for-each select="current-group()">
                        <xsl:if test="dritte-ebene"><ebene3><xsl:value-of select="dritte-ebene"/><fundstelle><xsl:value-of select="replace(fundstellen/text(),',',', ')"/></fundstelle></ebene3></xsl:if>
                    </xsl:for-each>-->
                </xsl:for-each> 
            </xsl:for-each-group>
        </register>
    </xsl:template>
    
</xsl:stylesheet>