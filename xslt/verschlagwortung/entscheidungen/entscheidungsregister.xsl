<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="alle-Hefte" select="collection('file:/c:/work/verschlagwortung/2016/?recurse=yes;select=*.xml')"/>
    <!--<xsl:variable name="alle-ent-dateien" select="$alle-Hefte/*[name()= ('ent', 'entk')]"/> -->
    
    
    <!-- hilfreiche XPATH Ausdrücke
    
    /*[not(name()=('kk','entk'))]/metadata/instdoc/inst[not(starts-with(ancestor::metadata/pub/pages/start_page/text(),'M') or starts-with(ancestor::metadata/pub/pages/start_page/text(),'S'))]
    
    
    
    -->
    
    <!-- 
    
    ToDo:
    
    ********************************************************************************************************
    
    
    Entscheidungen vom selben Tag nach Römischen Zahlen sortieren! -->
    
    
    <!-- ALLE ENTSCHEIDUNGEN AUßER KOMMENTIERTE UND AUS DEM MANTELTEIL
    
        
    
    ********************************************************************************************************
    
    -->

    <xsl:template match="/">
        <entscheidungsregister>
            
            <!-- SR -->
            <!--<xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'EuGH'"/>
                <xsl:with-param name="ressort" select="'all'"/>
            </xsl:call-template>
            
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BVerfG'"/>
                <xsl:with-param name="ressort" select="'all'"/>
            </xsl:call-template>-->
            
            <!-- FG gibt es bisher nicht -->
            
            <!--<xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BMF'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Sachsen-Anhalt'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Schleswig-Holstein'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'SenFin. Berlin'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD Frankfurt/M.'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD Karlsruhe'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD NRW'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'Oberste Finanzbehörden der Länder'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BayLfSt'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
            </xsl:call-template>-->
            
            <!-- WR -->
            <!--<xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BGH'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'EuGH'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'KG Berlin'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Düsseldorf'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Frankfurt/M.'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Hamm'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Thüringen'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
            </xsl:call-template>-->
            
            <!-- AR -->
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BAG'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BVerwG'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Düsseldorf'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Hamm'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Hessen'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Köln'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Mecklenburg-Vorpommern'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG München'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Nürnberg'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Rheinland-Pfalz'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LSG Hessen'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
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
            <xsl:when test="$ressort=('ar','wr')">
                <xsl:for-each select="$alle-Hefte/*[not(name()=('kk','entk'))][metadata/ressort/text()= $ressort][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))]">
                    <xsl:sort select="replace(metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                    <xsl:variable name="datum-tokenized" select="tokenize(metadata/instdoc/instdocdate/text(), '-')"/>
                    <zeile-gericht>
                        <datum-gericht><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                            <xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum-gericht>
                        <xsl:choose>
                            <xsl:when test="$ressort = 'sr'">
                                <xsl:comment>Tabulator</xsl:comment>    
                            </xsl:when>
                            <xsl:otherwise>
                                <trennzeichen><xsl:text> - </xsl:text></trennzeichen>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                        <az-gericht>
                            <xsl:for-each select="metadata/instdoc/instdocnrs/instdocnr">
                                <xsl:if test="not(position()=1)">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </az-gericht>
                        <!--<xsl:if test="$ressort = 'sr'">
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
                        </xsl:if>-->
                        <seite-gericht>
                            <xsl:comment>Tabulator</xsl:comment>
                            <xsl:value-of select="metadata/pub/pages/start_page"/>
                        </seite-gericht>
                    </zeile-gericht>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="$ressort='sr'">
                <xsl:for-each select="$alle-Hefte/*[not(name()=('kk','entk'))][metadata/ressort/text()= $ressort][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))]">
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
                        
                        <seite>
                            <xsl:comment>Tabulator</xsl:comment>
                            <xsl:value-of select="metadata/pub/pages/start_page"/>
                        </seite>
                    </zeile>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <!-- Ressort = ALL -->
                <xsl:for-each select="$alle-Hefte/*[not(name()=('kk','entk'))][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))]">
                    <xsl:sort select="replace(metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                    <xsl:variable name="datum-tokenized" select="tokenize(metadata/instdoc/instdocdate/text(), '-')"/>
                    <zeile>
                        <datum><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                            <xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum>
                        
                        <trennzeichen><xsl:text> - </xsl:text></trennzeichen>
                        
                        <az>
                            <xsl:for-each select="metadata/instdoc/instdocnrs/instdocnr">
                                <xsl:if test="not(position()=1)">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </az>
                        <seite>
                            <xsl:comment>Tabulator</xsl:comment>
                            <xsl:value-of select="metadata/pub/pages/start_page"/>
                        </seite>
                    </zeile>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
