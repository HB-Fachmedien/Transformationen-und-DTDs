<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempDSB/?recurse=yes;select=*.xml')"/>
    <xsl:template match="/">
        <output>
            <html>
    <head>
        <meta charset="UTF-8"/>
        <link media="screen" type="text/css" href="http://beta.der-betrieb.de/wp-content/themes/Der-Betrieb/style.css" rel="stylesheet"/>
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
                        <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe des
                            Datenschutz-Berater? Die Übersicht aller in der Datenbank verfügbaren
                            Ausgaben finden Sie in der 
                            <a href="https://recherche.datenschutz-berater.de/Browse.aspx?level=roex%3abron.Zeitschriften.d4d739c3943348e7b3da8a2bc3907319&amp;title=Datenschutz-Berater" target="_blank">Bibliothek der Recherche-Datenbank.</a>
                        </div>
                        <!-- Linke Spalte -->
                        <section class="left" id="content" style="width:630px">
                            <div class="content-list inhaltsverzeichnis">
                                <div class="content-text">
                                    <div class="ihv_level1">
                                        <div class="ihv_headline">Inhaltsverzeichnis</div>
                                        <div class="ihv_heftnr">
                                            <xsl:for-each select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="/*/metadata/pub/pubedition"/>
                                            </xsl:for-each>
                                        </div>
                                        <div class="ihv_datum">
                                            <xsl:for-each select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" />
                                            </xsl:for-each>
                                        </div>
                                        
                                        <div class="ihv_level2">
                                            <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                            <xsl:for-each-group select="$aktuelles-Heft" group-by="/*/metadata/ressort">
                                                
                                                <!-- <xsl:sort select="*/metadata/pub/pages/start_page[1]" data-type="number" order="ascending"/> 
                                                
                                                <xsl:perform-sort select="*/metadata/pub/pages/start_page">
                                                    <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                                </xsl:perform-sort>-->
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'Datenschutz im Fokus'">
                                                        <div class="ihv_headline ressort">Datenschutz im Fokus</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Aktuelles aus den Aufsichtsbehörden'">
                                                        <div class="ihv_headline ressort">Aktuelles aus den Aufsichtsbehörden</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Stichwort des Monats'">
                                                        <div class="ihv_headline ressort">Stichwort des Monats</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Service'">
                                                        <div class="ihv_headline ressort">Service</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Rechtsprechung'">
                                                        <div class="ihv_headline ressort">Rechtsprechung</div>
                                                    </xsl:when>
                                                     <xsl:otherwise>
                                                         [<div class="ihv_headline ressort">UNBEKANNTES RESSORT</div>]
                                                     </xsl:otherwise>
                                                        
                                                </xsl:choose>
                                                
                                                <div class="ihv_level3">
                                                    <div class="ihv_level4">
                                                        <xsl:for-each select="current-group()">
                                                            <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
                                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                            <a href="https://recherche.datenschutz-berater.de/document.aspx?docid=DSB{$siriusID}">
                                                                <div class="ihv_headline titel">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </div>
                                                                
                                                                <xsl:for-each select="*/metadata/authors/author">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                </xsl:for-each>
                                                                
                                                                <p>
                                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                                </p>
                                                                <p>
                                                                    <div class="ihv_seite"><xsl:value-of select="/*/metadata/pub/pages/start_page"/></div>
                                                                    <xsl:text>DSB</xsl:text><xsl:value-of select="$siriusID"/>
                                                                </p>
                                                            </a>
                                                        </xsl:for-each>
                                                    </div>
                                                </div>
                                                
                                            </xsl:for-each-group>
                                            
                                            <div class="ihv_headline ressort">Nachrichten</div>
                                                <div class="ihv_seite"><xsl:value-of select="min($aktuelles-Heft/nr/metadata/pub/pages/start_page)"/></div>
                                        </div>
                                </div>
                            </div>
                            </div>
                        </section>
                    </div>
                </body>
            </html>
        </output>
    </xsl:template>
</xsl:stylesheet>