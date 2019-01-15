<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:output encoding="UTF-8"  method="xml"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="seite"/>
    
    <xsl:template match="/">
        <xsl:variable name="file-collection" select="collection('file:/c:/tempDB/?recurse=yes;select=*.xml')"/>
        <entscheidungsregister><xsl:text>&#xa;</xsl:text>
            <h2>Beilagen</h2>
            <zeile><!-- Hier muss noch nach Beilagen sortiert werden und die Ausgabe dementsprechend verändert werden. Das hier war nur ein Quickfix. Standpunkte funktionieren. -->
                <xsl:for-each select="$file-collection/*[metadata/pub/pub_suppl]">
                    <!-- noch sortieren -->
                    <xsl:for-each select="metadata/authors/author">
                        <xsl:if test="true()"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                    </xsl:for-each>
                </xsl:for-each>
            </zeile>
            <!--<h2>Standpunkte</h2><xsl:text>&#xa;</xsl:text>
            <xsl:for-each select="$file-collection/sp">
                <!-\-<xsl:sort select=""/>-\->
                <zeile>
                    <datum>Nr. <xsl:value-of select="position()"/>/<xsl:value-of select="metadata/pub/pubyear"/></datum>
                    <az><xsl:value-of select="metadata/title"/><xsl:if test="metadata/subtitle"> - <xsl:value-of select="metadata/subtitle"/></xsl:if></az>
                    <break>***</break>
                    <title>(<xsl:for-each select="metadata/authors/author">
                            <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                        </xsl:for-each>)</title>
                    <seite><xsl:text>&#x9;</xsl:text>Heft <xsl:value-of select="metadata/pub/pubedition"/></seite>
                </zeile><xsl:text>&#xa;</xsl:text>
            </xsl:for-each>-->
        </entscheidungsregister>
    </xsl:template>

</xsl:stylesheet>
