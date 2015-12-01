<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- Stylesheet, um die Keywords von einzelnen Artikeln zu sammeln und in Registerform darzustellen -->

    <!-- XPath Ausdruck, um maximale Keyword-Tiefe zu berechnen: max(//keyword/count(ancestor-or-self::keyword)) -->

    <xsl:template match="/">
        <html>
            <head>
                <title>Test Register</title>
            </head>
            <body>
                <h1>Schlagwörter für Corporate Finance - Ausgabe 3</h1>
                <xsl:for-each
                    select="collection('../../../../../tempCF/verschlagwortung/?recurse=yes;select=*.xml')">

                    <xsl:variable name="docum" select="document(document-uri(.))"/>
                    <xsl:variable name="root" select="$docum/*"/>
                    
                    <xsl:if test="$root/metadata/keywords">
                        <p><xsl:value-of select="$root/name()"/></p>
                    </xsl:if>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
