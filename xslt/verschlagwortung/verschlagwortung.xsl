<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">


    <xsl:output indent="yes" encoding="UTF-8"  method="xml"/>
    
    <!-- Stylesheet, um die Keywords von einzelnen Artikeln zu sammeln und in Registerform darzustellen -->

    <!-- XPath Ausdruck, um maximale Keyword-Tiefe zu berechnen: max(//keyword/count(ancestor-or-self::keyword)) -->
    
    <!-- XPath Ausdruck, um Keywords zu finden, die Blätter sind: //keyword[not(child::*)] -->
    
    <!-- XPath Ausdruck, um Knoten zu vergleichen. Vergleicht nur auf String Gleichheit //A[.= following-sibling::A]
        bzw. //A[some $sibling in following-sibling::A satisfies deep-equal(. ,$sibling)]
    -->

    <xsl:template match="/">
        <xsl:variable name="file-collection" select="collection('../../../../../tempCF/verschlagwortung/?recurse=yes;select=*.xml')"/>
        <Register>
            <xsl:apply-templates select="$file-collection/*/metadata/keywords/keyword">
                <xsl:sort/>
            </xsl:apply-templates>
        </Register>
    </xsl:template>
    
    <xsl:template match="keywords/keyword">
        <xsl:variable name="seitenzahl" select="./../../pub/pages/start_page"/>
        
        <xsl:choose>
            <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
                <reg-zeile>
                    <hauptebene><xsl:value-of select="replace(text(),'\n','')"/></hauptebene>
                    <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                    <xsl:comment><xsl:value-of select="$seitenzahl"/></xsl:comment>
                </reg-zeile>
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
                <reg-zeile>
                    <hauptebene><xsl:value-of select="$ersteEbene"/></hauptebene>
                    <zweite-ebene><xsl:value-of select="replace(text(),'\n','')"/></zweite-ebene>
                    <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                    <xsl:comment><xsl:value-of select="$seitenzahl"/></xsl:comment>
                </reg-zeile>
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
            <reg-zeile>
                <hauptebene><xsl:value-of select="$ersteEbene"/></hauptebene>
                <zweite-ebene><xsl:value-of select="$zweiteEbene"/></zweite-ebene>
                <dritte-ebene><xsl:value-of select="replace(text(),'\n','')"/></dritte-ebene>
                <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                <xsl:comment><xsl:value-of select="$seitenzahl"/></xsl:comment>
            </reg-zeile>
    </xsl:template>

</xsl:stylesheet>
