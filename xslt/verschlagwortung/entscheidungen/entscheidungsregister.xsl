<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="alle-Hefte" select="collection('file:/c:/work/verschlagwortung/2015/?recurse=yes;select=*.xml')"/>
    <!--<xsl:variable name="alle-ent-dateien" select="$alle-Hefte/*[name()= ('ent', 'entk')]"/> -->
    
    <!-- HIER WEITER -->
    <!-- $alle-Hefte mal filtern, Kurz kommentiert kommt z.B. nicht rein! Welche doctypes noch? -->
    
    
    <!-- 
    
    ToDo:
    
    ********************************************************************************************************
    
    Gerichte, die kein Title bekommen, brauchen folgende Elemtentnamen:
    
    <zeile-gericht><datum-gericht>23. 04. 2015</datum-gericht><trennzeichen> - </trennzeichen><az-gericht>Rs. C-111/14</az-gericht><seite-gericht>	1263</seite-gericht></zeile-gericht>    
    
    
    ********************************************************************************************************
    
    -->

    <xsl:template match="/">
        <entscheidungsregister>

            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'EuGH'"/>
                <xsl:with-param name="ressort" select="'all'"/>
            </xsl:call-template>

        </entscheidungsregister>
    </xsl:template>
    
    <!-- Was ist mit den führenden Nullen in den Datumsangaben?? -->


    <xsl:template name="entscheidungsdaten">
        <xsl:param name="gerichtsBezeichnung"/>
        <xsl:param name="ressort"/>
        
        
        <h2>
            <xsl:value-of select="$gerichtsBezeichnung"/>
        </h2>
        <xsl:choose>
            <!--<xsl:when test="$ressort='all'">-->
            <xsl:when test="true()">
                <xsl:for-each select="$alle-Hefte/*[metadata/instdoc/inst/text()=$gerichtsBezeichnung and not(starts-with(metadata/pub/pages/start_page, 'M'))]">
                    <xsl:sort select="replace(metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                    <xsl:variable name="datum-tokenized" select="tokenize(metadata/instdoc/instdocdate/text(), '-')"/>
                    <zeile>
                        <datum><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                            <xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum>
                        <xsl:choose>
                            <xsl:when test="$ressort = 'sr'">
                                <xsl:comment>Tabulator</xsl:comment>    
                            </xsl:when>
                            <xsl:otherwise>
                                <trennzeichen><xsl:text> - </xsl:text></trennzeichen>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                        <az>
                            <xsl:for-each select="metadata/instdoc/instdocnrs/instdocnr">
                                <xsl:if test="not(position()=1)">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </az>
                        <xsl:if test="$ressort = 'sr'">
                            <xsl:variable name="rubik-gekuerzt">
                                <xsl:choose>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Abgabenordnung'">AO</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Bewertungsgesetz'">BewG</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Eigenheimzulage'">EigZul</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Einkommensteuer'">ESt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Erbschaft-Schenkungsteuer'">ErbSt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Finanzgerichtsordnung'">FGO</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Gewerbesteuer'">GewSt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Grunderwerbsteuer'">GrESt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Grundsteuer'">GrSt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Investitionszulage'">InvZul</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Investmentsteuergesetz'">InvStG</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Kapitalertragsteuer'">KapESt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Kirchensteuer'">KiSt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Koerperschaftsteuer'">KSt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Lohnsteuer'">LSt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Solidaritaetszuschlag'">SolZ</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Umsatzsteuer'">USt</xsl:when>
                                    <xsl:when test="metadata/rubriken/rubrik[1]='Umwandlungsteuerrecht'">UmwSt</xsl:when>
                                    <xsl:otherwise><xsl:value-of select="metadata/rubriken/rubrik[1]"/></xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <break>***</break>
                            <title><xsl:value-of select="$rubik-gekuerzt"/><xsl:text>, </xsl:text><xsl:value-of select="metadata/title"/></title>
                        </xsl:if>
                        <seite>
                            <xsl:comment>Tabulator</xsl:comment>
                            <xsl:value-of select="metadata/pub/pages/start_page"/>
                        </seite>
                    </zeile>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <!-- hier noch nach Ressorts filtern in der for-each Schleife --> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
