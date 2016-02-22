<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs hbfm"
    version="2.0">
    <xsl:output method="xml" indent="no"/>
    
    <xsl:template match="raw-reg">
        <register>
            <xsl:for-each-group select="reg-zeile" group-by="autor">
                <ebene1><xsl:value-of select="current-grouping-key()"/></ebene1>
                <xsl:for-each select="current-group()">
                    <xsl:sort select="fundstellen/text()" data-type="number"/>
                    <ebene2><xsl:value-of select="title"/><fundstelle><xsl:value-of select="fundstellen"/></fundstelle></ebene2>
                    <!--<xsl:for-each select="current-group()">
                        <xsl:if test="dritte-ebene"><ebene3><xsl:value-of select="dritte-ebene"/><fundstelle><xsl:value-of select="replace(fundstellen/text(),',',', ')"/></fundstelle></ebene3></xsl:if>
                    </xsl:for-each>-->
                </xsl:for-each> 
            </xsl:for-each-group>
        </register>
    </xsl:template>
    
</xsl:stylesheet>