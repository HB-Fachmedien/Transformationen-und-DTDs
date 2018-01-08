<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- TO-DO: Autorennamen aus Standpunkten sollen ebenfalls ins Autorenverzeichnis-->

    <xsl:output indent="yes" encoding="UTF-8"  method="xml"/>
    
    <!-- Stylesheet, um die Keywords von einzelnen Artikeln zu sammeln und in Registerform darzustellen -->

    <!-- XPath Ausdruck, um maximale Keyword-Tiefe zu berechnen: max(//keyword/count(ancestor-or-self::keyword)) -->
    
    <!-- XPath Ausdruck, um Keywords zu finden, die Blätter sind: //keyword[not(child::*)] -->
    
    <!-- XPath Ausdruck, um Knoten zu vergleichen. Vergleicht nur auf String Gleichheit //A[.= following-sibling::A]
        bzw. //A[some $sibling in following-sibling::A satisfies deep-equal(. ,$sibling)]
    -->

    <xsl:template match="/">
        <xsl:variable name="file-collection" select="collection('file:/c:/work/verschlagwortung/2017/?recurse=yes;select=*.xml')"/>
        <Register>
            <xsl:apply-templates select="$file-collection/*/metadata/keywords/keyword">
                <xsl:sort/>
            </xsl:apply-templates>
            <xsl:apply-templates select="$file-collection/*/metadata/authors/author"><!-- Autorenverzeichnis -->
                <xsl:sort/>
            </xsl:apply-templates>
        </Register>
    </xsl:template>
    
    <xsl:template match="author">
        <!--<xsl:if test="ancestor::metadata/keywords/keyword">--> <!-- hier weiter: habe das auskommentiert... weil DB keine keywords hat  -->
        <!-- Keine Mantelseiten -->
        <xsl:if test="not(string(number(normalize-space(ancestor::metadata/pub/pages/start_page))) = 'NaN')">
            <autoren-zeile>
                <autor><xsl:value-of select="surname"/><xsl:text>, </xsl:text><xsl:value-of select="firstname"/></autor>
                <title><xsl:value-of select="../../title"/></title>
                <xsl:comment><xsl:if test="ancestor::metadata/pub/pub_suppl"><xsl:text>Beilage </xsl:text><xsl:value-of select="ancestor::metadata/pub/pub_suppl"/><!--<xsl:text>|</xsl:text>--></xsl:if><xsl:if test="not(ancestor::metadata/pub/pub_suppl)"><xsl:value-of select="../../pub/pages/start_page"/></xsl:if></xsl:comment>
            </autoren-zeile>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="keywords/keyword">
        <xsl:variable name="isDB" select="ancestor::metadata/pub/pubtitle = 'Der Betrieb'"/>
        <xsl:choose>
            <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
                <xsl:variable name="isMantelseite" select="starts-with(./ancestor::metadata/pub/pages/start_page/text(), 'M')"/>
                <xsl:variable name="kuerzel">
                    <xsl:choose>
                        <xsl:when test="$isMantelseite"><xsl:text> MANTELSEITE!</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'au'"><xsl:text> (A)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'kk'"><xsl:text> (K)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'va'"><xsl:text> (V)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = ('ent', 'entk')"><xsl:text> (E)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'nr' and ancestor::metadata/ressort/text() = 'bw'"><xsl:text> (R)</xsl:text></xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:variable name="seitenzahl" select="./../../pub/pages/start_page"/>
                
                <reg-zeile>
                    <hauptebene><xsl:value-of select="replace(text(),'\n','')"/></hauptebene>
                    <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                    <xsl:comment><xsl:value-of select="concat($seitenzahl, $kuerzel)"/></xsl:comment>
                </reg-zeile>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="keyword">
                    <xsl:sort/>
                    <xsl:with-param name="ersteEbene" select="replace(text()[1],'\n','')"/>
                    <xsl:with-param name="isDB" select="$isDB"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    
    </xsl:template>

    <xsl:template match="keywords/keyword/keyword">
        <xsl:param name="ersteEbene"/>
        <xsl:param name="isDB"/>
        <xsl:variable name="seitenzahl" select="./../../../pub/pages/start_page/text()"/>
        <xsl:choose>
            <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
                <xsl:variable name="isMantelseite" select="starts-with(./ancestor::metadata/pub/pages/start_page/text(), 'M')"/>
                <xsl:variable name="kuerzel">
                    <xsl:choose>
                        <xsl:when test="$isMantelseite"><xsl:text> MANTELSEITE!</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'au'"><xsl:text> (A)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'kk'"><xsl:text> (K)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'va'"><xsl:text> (V)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = ('ent', 'entk')"><xsl:text> (E)</xsl:text></xsl:when>
                        <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'nr' and ancestor::metadata/ressort/text() = 'bw'"><xsl:text> (R)</xsl:text></xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:variable name="seitenzahl" select="./../../../pub/pages/start_page/text()"/>
                
                <reg-zeile>
                    <hauptebene><xsl:value-of select="$ersteEbene"/></hauptebene>
                    <zweite-ebene><xsl:value-of select="replace(text(),'\n','')"/></zweite-ebene>
                    <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                    <xsl:comment><xsl:value-of select="concat($seitenzahl, $kuerzel)"/></xsl:comment>
                </reg-zeile>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="keyword">
                    <xsl:sort/>
                    <xsl:with-param name="ersteEbene" select="$ersteEbene"/>
                    <xsl:with-param name="zweiteEbene" select="replace(text()[1],'\n','')"/>
                    <xsl:with-param name="isDB" select="$isDB"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <xsl:template match="keywords/keyword/keyword/keyword">
        <xsl:param name="ersteEbene"/>
        <xsl:param name="zweiteEbene"/>
        <xsl:param name="isDB"/>
        <xsl:variable name="seitenzahl" select="./../../../../pub/pages/start_page/text()"/>
        <xsl:variable name="isMantelseite" select="starts-with(./ancestor::metadata/pub/pages/start_page/text(), 'M')"/>
        <xsl:variable name="kuerzel">
            <xsl:choose>
                <xsl:when test="$isMantelseite"><xsl:text> MANTELSEITE!</xsl:text></xsl:when>
                <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'au'"><xsl:text> (A)</xsl:text></xsl:when>
                <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'kk'"><xsl:text> (K)</xsl:text></xsl:when>
                <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'va'"><xsl:text> (V)</xsl:text></xsl:when>
                <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = ('ent', 'entk')"><xsl:text> (E)</xsl:text></xsl:when>
                <xsl:when test="$isDB and ./ancestor::metadata/parent::*/name() = 'nr' and ancestor::metadata/ressort/text() = 'bw'"><xsl:text> (R)</xsl:text></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
            <reg-zeile>
                <hauptebene><xsl:value-of select="$ersteEbene"/></hauptebene>
                <zweite-ebene><xsl:value-of select="$zweiteEbene"/></zweite-ebene>
                <dritte-ebene><xsl:value-of select="replace(text(),'\n','')"/></dritte-ebene>
                <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                <xsl:comment><xsl:value-of select="concat($seitenzahl, $kuerzel)"/></xsl:comment>
            </reg-zeile>
    </xsl:template>

</xsl:stylesheet>
