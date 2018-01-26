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
                <ebene1><xsl:value-of select="current-grouping-key()"/><xsl:call-template name="isLeaf"><xsl:with-param name="cgk" select="current-grouping-key()"/><xsl:with-param name="contxt" select="."/><xsl:with-param name="el" select="2"/></xsl:call-template></ebene1><xsl:text>&#xa;</xsl:text>
                <xsl:for-each-group select="current-group()" group-by="zweite-ebene">
                    <ebene2><xsl:value-of select="current-grouping-key()"/><xsl:call-template name="isLeaf"><xsl:with-param name="cgk" select="current-grouping-key()"/><xsl:with-param name="contxt" select="."/><xsl:with-param name="el" select="3"/></xsl:call-template></ebene2><xsl:text>&#xa;</xsl:text>
                    <xsl:for-each select="current-group()">
                        <xsl:if test="dritte-ebene"><ebene3><xsl:value-of select="dritte-ebene"/><fundstelle><xsl:text>&#x9;</xsl:text><xsl:value-of select="replace(fundstellen/text(),',',', ')"/></fundstelle></ebene3><xsl:text>&#xa;</xsl:text></xsl:if>
                    </xsl:for-each>
                </xsl:for-each-group> 
            </xsl:for-each-group>
        </register>
    </xsl:template>
    
    
    <xsl:template name="isLeaf">
        <xsl:param name="cgk"/><xsl:param name="contxt"/><xsl:param name="el"/>
        <xsl:if test="//*[text()=$cgk]/..[count(child::* ) = $el]"><fundstelle><xsl:text>&#x9;</xsl:text><xsl:value-of select="replace($contxt/fundstellen/text(),',',', ')"/></fundstelle></xsl:if>
    </xsl:template>
    
</xsl:stylesheet>