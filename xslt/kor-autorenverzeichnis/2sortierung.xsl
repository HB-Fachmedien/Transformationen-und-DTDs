<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:key name="item-by-value" match="reg-zeile" use="."/>
    
    <xsl:template match="/R-AUTOR">
        <R-AUTOR>
            <TITEL>Verzeichnis der Verfasser</TITEL>
            <xsl:apply-templates select="R-AU-EINTR">
                <xsl:sort lang="de" select="concat(NACHNAME/text(), VORNAME/text(), KORFUND/text())"/>
            </xsl:apply-templates>
        </R-AUTOR>
    </xsl:template>
    
    <!--<xsl:template match="R-AU-EINTR">
        <R-AUTOR1>
            <!-\-<xsl:apply-templates select="R-AU-EINTR">
                <xsl:sort select="concat(NACHNAME/text(), VORNAME/text(), KORFUND/text())"/>
                <!-\\-<xsl:sort select="NACHNAME/text()"/>-\\->
            </xsl:apply-templates>-\->
        </R-AUTOR1>
    </xsl:template>-->
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
