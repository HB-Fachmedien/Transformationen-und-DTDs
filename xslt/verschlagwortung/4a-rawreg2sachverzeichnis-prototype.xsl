<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs hbfm"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="raw-reg">
        <register>
            <xsl:for-each-group select="reg-zeile" group-by="hauptebene">
                <zeile><ebene1><xsl:value-of select="current-grouping-key()"/></ebene1><xsl:call-template name="isLeaf"><xsl:with-param name="cgk" select="current-grouping-key()"/><xsl:with-param name="contxt" select="."/><xsl:with-param name="el" select="2"/></xsl:call-template></zeile>
                <xsl:for-each-group select="current-group()" group-by="zweite-ebene">
                    <zeile><ebene2><xsl:value-of select="current-grouping-key()"/></ebene2><xsl:call-template name="isLeaf"><xsl:with-param name="cgk" select="current-grouping-key()"/><xsl:with-param name="contxt" select="."/><xsl:with-param name="el" select="3"/></xsl:call-template></zeile>
                    <xsl:for-each select="current-group()">
                        <xsl:if test="dritte-ebene"><zeile><ebene3><xsl:value-of select="dritte-ebene"/></ebene3><fundstelle><xsl:value-of select="replace(fundstellen/text(),',',' ,')"/></fundstelle></zeile></xsl:if>
                    </xsl:for-each>
                </xsl:for-each-group> 
            </xsl:for-each-group>
        </register>
    </xsl:template>
    
    
    <xsl:template name="isLeaf">
        <xsl:param name="cgk"/>
        <xsl:param name="contxt"/>
        <xsl:param name="el"/>

        <xsl:if test="//*[text()=$cgk]/..[count(child::* ) = $el]">
            <fundstelle><xsl:value-of select="replace($contxt/fundstellen/text(),',',', ')"/></fundstelle>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>