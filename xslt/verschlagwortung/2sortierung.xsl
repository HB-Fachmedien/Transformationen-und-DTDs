<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:key name="item-by-value" match="reg-zeile" use="."/>

    <xsl:template match="/Register">
        <sortiertes-register>
            <xsl:apply-templates select="reg-zeile">
                <xsl:sort lang="de" select="concat(hauptebene/text(), zweite-ebene/text(), dritte-ebene/text())"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="autoren-zeile">
                <xsl:sort lang="de" select="concat(lower-case(autor/text()),comment())"/>
            </xsl:apply-templates>
        </sortiertes-register>
    </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
