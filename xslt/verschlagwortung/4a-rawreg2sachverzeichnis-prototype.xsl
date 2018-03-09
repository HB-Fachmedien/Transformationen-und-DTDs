<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs hbfm"
    version="2.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="fundstelle"/>
    
    <xsl:template match="raw-reg"><xsl:text>&#xa;</xsl:text>
        <register><xsl:text>&#xa;</xsl:text>
            <xsl:for-each-group select="reg-zeile" group-by="hauptebene">
                <ebene1>
                    <xsl:value-of select="current-grouping-key()"/>
                    <xsl:if test="not(current-group()/zweite-ebene)">
                        <fundstelle><xsl:text>&#x9;</xsl:text><xsl:value-of select="replace(fundstellen/text(),',',', ')"/></fundstelle>
                    </xsl:if>
                    
                </ebene1><xsl:text>&#xa;</xsl:text>
                
                <xsl:for-each-group select="current-group()" group-by="zweite-ebene">
                    <ebene2>
                        <xsl:value-of select="current-grouping-key()"/>
                        <xsl:if test="not(current-group()/dritte-ebene)">
                            <fundstelle><xsl:text>&#x9;</xsl:text><xsl:value-of select="replace(fundstellen/text(),',',', ')"/></fundstelle>
                        </xsl:if>
                    </ebene2><xsl:text>&#xa;</xsl:text>
                    
                    <xsl:for-each select="current-group()">
                        <xsl:if test="dritte-ebene">
                            <ebene3>
                                <xsl:value-of select="dritte-ebene"/><fundstelle><xsl:text>&#x9;</xsl:text><xsl:value-of select="replace(fundstellen/text(),',',', ')"/></fundstelle>
                            </ebene3><xsl:text>&#xa;</xsl:text>
                        </xsl:if>
                        
                    </xsl:for-each>
                </xsl:for-each-group> 
            </xsl:for-each-group>
        </register>
    </xsl:template>
    
</xsl:stylesheet>