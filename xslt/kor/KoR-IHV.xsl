<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="no"/>
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempKoR/?recurse=yes;select=*.xml')"/>
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
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von KoR? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der 
                        
                        <a href="https://recherche.kor-ifrs.de/Browse.aspx?level=roex%3abron.Zeitschriften.0c0f5d6e415044179263a16c0d68e83e&amp;title=KoR" target="_blank">Bibliothek der Recherche-Datenbank.</a>
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
                                                <xsl:when test="current-grouping-key() = 'nr'">
                                                    <a href="https://www.kor-ifrs.de/rubriken/reports/" target="_blank"><div class="ihv_headline ressort">Reports</div></a>
                                                </xsl:when>
                                                <xsl:otherwise></xsl:otherwise>
                                            </xsl:choose>
                                            
                                            <!-- For-each-group, die alle Doctypen in die drei Ressorts gruppiert: Fallstudie, Tagungsbericht, Rechnungslegung & Investor Relations: -->
                                            <xsl:for-each-group select="current-group()" group-by="/*/metadata/ressort">
                                                <xsl:sort select="/*/metadata/pub/pages/start_page"/>
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'Fallstudie'">
                                                        <div class="ihv_headline doktyp">Fallstudie</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Tagungsbericht'">
                                                        <div class="ihv_headline doktyp">Tagungsbericht</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Rechnungslegung und Investor Relations'">
                                                        <div class="ihv_headline doktyp">Rechnungslegung &amp; Investor Relations</div>
                                                    </xsl:when>
                                                </xsl:choose>
                                                
                                                <!-- Schleife durch die einzelnen Ressorts: -->
                                                <xsl:for-each select="current-group()">
                                                    <xsl:variable name="dokid" select="/*/@docid"/>
                                                    <div class="ihv_level3">
                                                        <div class="ihv_level4">
                                                            
                                                            <!-- Rubriken: -->
                                                            <div class="ihv_rubriken">
                                                                <xsl:for-each select="*/metadata/keywords/keyword">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                    <xsl:value-of select="."/>
                                                                </xsl:for-each>
                                                            </div>
                                                            
                                                            <!-- verlinkter Titel -->                                                        
                                                            <div class="ihv_headline titel"><a href="https://recherche.kor-ifrs.de/document.aspx?docid={$dokid}"><xsl:value-of select="*/metadata/title"/></a></div>
                                                            
                                                            <!-- Autoren- bzw. Behördenauszeichnung -->
                                                            <div class="ihv_autor">
                                                                <a href="https://recherche.kor-ifrs.de/document.aspx?docid={$dokid}">
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
                                                                </a>
                                                            </div>
                                                            
                                                            <!-- Bei Aufsätzen wird der Summary Inhalt dargestellt -->
                                                            <xsl:if test="/*/name() = 'au'">
                                                                <div class="ihv_abstract">
                                                                    <a href="https://recherche.kor-ifrs.de/document.aspx?docid={$dokid}"><xsl:value-of select="*/metadata/summary/*"/></a>
                                                                </div>
                                                            </xsl:if>
                                                            <div class="ihv_seite"><a href="https://recherche.kor-ifrs.de/document.aspx?docid={$dokid}"><xsl:value-of select="*/metadata/pub/pages/start_page"/></a></div>
                                                            <p><a href="https://recherche.kor-ifrs.de/document.aspx?docid={$dokid}"><xsl:value-of select="$dokid"/></a></p>
                                                        </div>
                                                    </div>
                                                </xsl:for-each>
                                            </xsl:for-each-group>
                                            
                                            <xsl:for-each-group select="current-group()" group-by="/nr/metadata/rubriken/rubrik">
                                                <xsl:sort select="/*/metadata/pub/pages/start_page"/>
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'IASB'">
                                                        <!-- gibt aber auch noch IAASB, EU, DRSC -->
                                                        <a href="https://www.kor-ifrs.de/rubriken/reports/" target="_blank"><div class="ihv_headline doktyp">International</div>
                                                        <div class="ihv_seite"><xsl:value-of select="*/metadata/pub/pages/start_page"/></div></a>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Sonstige Meldung'">
                                                        <!-- gibt aber auch noch Rechtsprechung, Gesetzgebung -->
                                                        <a href="https://www.kor-ifrs.de/rubriken/reports/" target="_blank"><div class="ihv_headline doktyp">National</div>
                                                        <div class="ihv_seite"><xsl:value-of select="*/metadata/pub/pages/start_page"/></div></a>
                                                    </xsl:when>
                                                </xsl:choose>
                                                
                                                <!--   <xsl:for-each select="current-group()">
                                                       <xsl:choose><xsl:when test="position()=1">
                                                           <div class="ihv_seite"><xsl:value-of select="*/metadata/pub/pages/start_page"/></div>
                                                       </xsl:when>
                                                       <xsl:otherwise/>
                                               </xsl:choose>
                                                   </xsl:for-each> -->
                                                
                                                
                                                
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