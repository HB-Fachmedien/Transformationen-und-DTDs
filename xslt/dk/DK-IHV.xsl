<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="no"/>
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempDerKonzern/?recurse=yes;select=*.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <link media="screen" type="text/css"
                    href="http://beta.der-betrieb.de/wp-content/themes/Der-Betrieb/style.css"
                    rel="stylesheet"/>
                <style>
                    @charset "UTF-8";
                    @font-face{
                    font-family:"Unit Slab Pro Bold";
                    font-weight:bold;
                    src:url("fonts/unitslabpro-bold.woff") format("woff");
                    }
                    @font-face{
                    font-family:"Unit Slab Pro Medium";
                    src:url("fonts/unitslabpro-medium.woff") format("woff");
                    }
                    @font-face{
                    font-family:"Unit Slab Pro";
                    src:url("fonts/unitslabpro.woff") format("woff");
                    }
                    @font-face{
                    font-family:"Unit Pro Medium";
                    src:url("fonts/unitpro-medium.woff") format("woff");
                    }
                    @font-face{
                    font-family:"Unit Pro";
                    src:url("fonts/unitpro.woff") format("woff");
                    }
                    .ihv_seite,
                    .ihv_dbnummer{
                    text-align:right;
                    padding:0px;
                    }</style>
            </head>
            <body>
                <div class="content-wrapper">
                    <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von Der Konzern? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der 
                        
                        <a href="https://recherche.der-konzern.de/Browse.aspx?level=roex%3abron.Zeitschriften.5812b0ada8c9454182ed43bf03f938ef&amp;title=Der+Konzern&amp;trailpos=2" target="_blank">Bibliothek der Recherche-Datenbank.</a>
                    </div>
                    <section class="left" id="content" style="width:630px">
                        <div class="content-list inhaltsverzeichnis">
                            <div class="content-text">
                                <div class="ihv_level1">
                                    <div class="ihv_headline">Inhaltsverzeichnis</div>
                                    <div class="ihv_heftnr">
                                        <xsl:value-of select="$aktuelles-Heft[1]/*/metadata/pub/pubedition"/>
                                        <div class="ihv_datum"><xsl:value-of select="format-date($aktuelles-Heft[1]/*/metadata/pub/date, '[D].[M].[Y]')"/></div>
                                    </div>
                                    <div class="ihv_level2">
                                        <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-by="*[1]/name()" >
                                            
                                            <xsl:choose>
                                                <xsl:when test="current-grouping-key() = 'au'">
                                                    <div class="ihv_headline ressort">Aufsätze</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'ent'">
                                                    <div class="ihv_headline ressort">Entscheidungen</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'entk'">
                                                    <div class="ihv_headline ressort">Entscheidungen</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'va'">
                                                    <div class="ihv_headline ressort">Verwaltungsanweisungen</div>
                                                </xsl:when>
                                                <xsl:otherwise></xsl:otherwise>
                                            </xsl:choose>
                                            
                                            <!-- For-each-group, die alle Doctypen in die drei Ressorts gruppiert: kr, br und sr: -->
                                            <xsl:for-each-group select="current-group()" group-by="/*/metadata/ressort">
                                                <xsl:sort select="/*/metadata/pub/pages/start_page"/>
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'kr'">
                                                        <div class="ihv_headline doktyp">Konzernrecht</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'br'">
                                                        <div class="ihv_headline doktyp">Bilanzrecht/Rechnungslegung</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'sr'">
                                                        <div class="ihv_headline doktyp">Steuerrecht</div>
                                                    </xsl:when>
                                                </xsl:choose>
                                                
                                                <!-- Schleife durch die einzelnen Ressorts: -->
                                                <xsl:for-each select="current-group()">
                                                    <xsl:variable name="dokid" select="/*/@docid"/>
                                                    <div class="ihv_level3">
                                                        <div class="ihv_level4">
                                                            
                                                            <!-- Rubriken: -->
                                                            <div class="ihv_rubriken">
                                                                <xsl:for-each select="*/metadata/rubriken/rubrik">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                    <xsl:value-of select="."/>
                                                                </xsl:for-each>
                                                            </div>
                                                            
                                                            <!-- verlinkter Titel -->                                                        
                                                            <div class="ihv_headline titel"><a href="https://recherche.der-konzern.de/document.aspx?docid={$dokid}"><xsl:value-of select="*/metadata/title"/></a></div>
                                                            
                                                            <!-- Autoren- bzw. Behördenauszeichnung -->
                                                            <div class="ihv_autor">
                                                                <xsl:choose>
                                                                    <!-- Bei Aufsätzen kommen die Autorennamen über den Titel -->
                                                                    <xsl:when test="/*/name() = 'au'">
                                                                        <xsl:for-each select="*/metadata/authors/author">
                                                                            <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                            <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                        </xsl:for-each>
                                                                    </xsl:when>
                                                                    <!-- Ansonsten die Gerichte/Behörden und Urteilsdaten -->
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="concat(*/metadata/instdoc/inst, ', ', */metadata/instdoc/instdoctype, ' vom '
                                                                            , format-date(*/metadata/instdoc/instdocdate, '[D].[M].[Y]'), ' - ', */metadata/instdoc/instdocnrs/instdocnr[1])"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </div>
                                                            
                                                            <!-- Bei Aufsätzen wird der Summary Inhalt dargestellt -->
                                                            <xsl:if test="/*/name() = 'au'">
                                                                <div class="ihv_abstract">
                                                                    <xsl:value-of select="*/metadata/summary/*"/>
                                                                </div>
                                                            </xsl:if>
                                                            <div class="ihv_seite"><xsl:value-of select="*/metadata/pub/pages/start_page"/></div>
                                                            <p><a href="https://recherche.der-konzern.de/document.aspx?docid={$dokid}"><xsl:value-of select="$dokid"/></a></p>
                                                        </div>
                                                    </div>
                                                </xsl:for-each>
                                            </xsl:for-each-group>
                                        </xsl:for-each-group> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>