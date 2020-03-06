<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0" xmlns:hbfm="http:www.fachmedien.de/hbfm">

    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="no" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE" doctype-system="hbfm.dtd"/>
    <xsl:param name="src-documents-location" select="'file:/c:/toc/?recurse=yes;select=*.xml'"/>
    <xsl:variable name="aktuelles-Heft" select="collection($src-documents-location)"/>
    <xsl:variable name="erstes-dokument" select="$aktuelles-Heft[1]"/>

    <xsl:template match="/">
        <toc>
            <xsl:value-of select="$aktuelles-Heft/*/name()"/>
            <!-- Hier geht's weiter -->
        </toc>
    </xsl:template>
</xsl:stylesheet>