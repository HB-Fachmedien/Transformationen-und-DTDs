<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">


    <xsl:output indent="yes" encoding="UTF-8"  method="html" omit-xml-declaration="yes"/>
    
    <!-- Stylesheet, um die Keywords von einzelnen Artikeln zu sammeln und in Registerform darzustellen -->

    <!-- XPath Ausdruck, um maximale Keyword-Tiefe zu berechnen: max(//keyword/count(ancestor-or-self::keyword)) -->
    
    <!-- XPath Ausdruck, um Keywords zu finden, die Blätter sind: //keyword[not(child::*)] -->

    <xsl:template match="/">
        
        <html>
            <head>
                <title>Test Register</title>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous"></link>
            </head>
            <body>
                <h1>Schlagwörter für Corporate Finance - Ausgabe 3</h1>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>1. Ebene</th>
                            <th>2. Ebene</th>
                            <th>3. Ebene</th>
                            <th>Fundstelle</th>
                        </tr>
                    </thead>
                    <xsl:variable name="file-collection" select="collection('../../../../../tempCF/verschlagwortung/?recurse=yes;select=*.xml')"/>
                    <tbody>
                        <xsl:apply-templates select="$file-collection/*/metadata/keywords/keyword">
                            <xsl:sort/>
                        </xsl:apply-templates>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
<xsl:template match="keywords/keyword">
    <xsl:variable name="seitenzahl" select="./../../pub/pages/start_page"/>
    
    <xsl:choose>
        <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
            <tr>
                <td><xsl:value-of select="replace(text(),'\n','')"/></td>
                <td></td>
                <td></td>
                <td><xsl:value-of select="$seitenzahl"/></td>
            </tr>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="keyword">
                <xsl:sort/>
                <xsl:with-param name="ersteEbene" select="replace(text()[1],'\n','')"/>
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<xsl:template match="keywords/keyword/keyword">
    <xsl:param name="ersteEbene"/>
    <xsl:variable name="seitenzahl" select="./../../../pub/pages/start_page"/>
    <xsl:choose>
        <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
            <tr>
                <td><xsl:value-of select="$ersteEbene"/></td>
                <td><xsl:value-of select="replace(text(),'\n','')"/></td>
                <td></td>
                <td><xsl:value-of select="$seitenzahl"/></td>
            </tr>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="keyword">
                <xsl:sort/>
                <xsl:with-param name="ersteEbene" select="$ersteEbene"/>
                <xsl:with-param name="zweiteEbene" select="replace(text()[1],'\n','')"/>
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
    
<xsl:template match="keywords/keyword/keyword/keyword">
    <xsl:param name="ersteEbene"/>
    <xsl:param name="zweiteEbene"/>
    <xsl:variable name="seitenzahl" select="./../../../../pub/pages/start_page"/>
        <tr>
            <td><xsl:value-of select="$ersteEbene"/></td>
            <td><xsl:value-of select="$zweiteEbene"/></td>
            <td><xsl:value-of select="replace(text(),'\n','')"/></td>
            <td><xsl:value-of select="$seitenzahl"/></td>
        </tr>
</xsl:template>

</xsl:stylesheet>
