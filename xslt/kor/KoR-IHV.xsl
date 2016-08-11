<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="yes" exclude-result-prefixes="#all"/>
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempKoR/?recurse=yes;select=*.xml')"/>
    <xsl:template match="/">
        <!--<xsl:result-document href="file:///z:/Duesseldorf/Fachverlag/Fachbereiche/Pool/eShop_innochange/EasyProduct/Daten/1000/Export/Inhaltsverzeichnis/KoR-IHV.html" method="xhtml" omit-xml-declaration="yes">-->
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
                                        <div class="ihv_datum">
                                            <xsl:value-of select="format-date($aktuelles-Heft[1]/*/metadata/pub/date, '[D].[M].[Y]')"/>
                                        </div>
                                    </div>
                                    <div class="ihv_level2">
                                        <div class="ihv_headline ressort">Aufsätze</div>
                                        <xsl:for-each select="$aktuelles-Heft/*[name()='au' and metadata[not(ressort)]]" >
                                            <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number"/>
                                            <xsl:call-template name="ihv-eintrag">
                                                <xsl:with-param name="dokumentknoten" select="."/>
                                            </xsl:call-template>
                                        </xsl:for-each>
                                        <xsl:for-each select="$aktuelles-Heft/*[name()='au' and metadata[ressort]]" >
                                            <xsl:variable name="ressort" select="/*/metadata/ressort"/>
                                            <xsl:choose>
                                                <xsl:when test="$ressort = 'Fallstudie'">
                                                    <div class="ihv_headline doktyp">Fallstudie</div>
                                                    <xsl:call-template name="ihv-eintrag">
                                                        <xsl:with-param name="dokumentknoten" select="."/>
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:when test="$ressort = 'Tagungsbericht'">
                                                    <div class="ihv_headline doktyp">Tagungsbericht</div>
                                                    <xsl:call-template name="ihv-eintrag">
                                                        <xsl:with-param name="dokumentknoten" select="."/>
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:when test="$ressort = 'Rechnungslegung und Investor Relations'">
                                                    <div class="ihv_headline doktyp">Rechnungslegung &amp; Investor Relations</div>
                                                    <xsl:call-template name="ihv-eintrag">
                                                        <xsl:with-param name="dokumentknoten" select="."/>
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <div class="ihv_headline doktyp">unbekannt</div>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                        <div class="ihv_headline ressort">Reports</div>
                                        <xsl:for-each-group select="$aktuelles-Heft/*[name()='nr']" group-by="/nr/metadata/ressort">
                                            <xsl:sort select="/nr/metadata/ressort"></xsl:sort>
                                            <xsl:variable name="ressort" select="/*/metadata/ressort"/>
                                            <xsl:choose>
                                                <xsl:when test="$ressort = 'Report international'">
                                                    <div class="ihv_headline doktyp">Reports international</div>
                                                </xsl:when>
                                                <xsl:when test="$ressort = 'Report national'">
                                                    <div class="ihv_headline doktyp">Reports national</div>
                                                </xsl:when>
                                            </xsl:choose>
                                            <xsl:for-each select="current-group()">
                                                <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number"/>
                                                <xsl:call-template name="ihv-eintrag">
                                                    <xsl:with-param name="dokumentknoten" select="."/>
                                                </xsl:call-template>
                                            </xsl:for-each>
                                        </xsl:for-each-group>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </body>
        </html>
        <!--</xsl:result-document>-->
    </xsl:template>
    <xsl:template name="ihv-eintrag">
        <xsl:param name="dokumentknoten"/>
        <xsl:variable name="dokid" select="$dokumentknoten/@docid"/>
        <div class="ihv_level3">
            <div class="ihv_level4">
                <!-- Rubriken: -->
                <div class="ihv_rubriken">
                    <xsl:for-each select="$dokumentknoten//metadata/keywords/keyword">
                        <xsl:if test="not(position()=1)">
                            <xsl:text> / </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </div>
                <!-- verlinkter Artikel -->
                <a href="https://recherche.kor-ifrs.de/document.aspx?docid={$dokid}">
                <div class="ihv_headline titel">
                        <xsl:value-of select="$dokumentknoten/metadata/title"/>
                <!-- Autoren- bzw. Behördenauszeichnung -->
                <div class="ihv_autor">
                        <xsl:choose>
                            <!-- Bei Aufsätzen kommen die Autorennamen über den Titel -->
                            <xsl:when test="$dokumentknoten/name() = 'au'">
                                <xsl:for-each select="$dokumentknoten/metadata/authors/author">
                                    <xsl:if test="not(position()=1)">
                                        <xsl:text> / </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                </xsl:for-each>
                            </xsl:when>
                            <!-- Ansonsten die Gerichte/Behörden und Urteilsdaten, falls vorhanden -->
                            <xsl:when test="$dokumentknoten/metadata[instdoc]">
                                <xsl:value-of select="concat($dokumentknoten/metadata/instdoc/inst, ', ', $dokumentknoten/metadata/instdoc/instdoctype, ' vom ' , format-date($dokumentknoten/metadata/instdoc/instdocdate, '[D].[M].[Y]'), ' - ', $dokumentknoten/metadata/instdoc/instdocnrs/instdocnr[1])"/>
                            </xsl:when>
                        </xsl:choose>
                    
                </div>
                <!-- Bei Aufsätzen wird der Summary Inhalt dargestellt -->
                <xsl:if test="$dokumentknoten/name() = 'au'">
                    <div class="ihv_abstract">
                            <xsl:value-of select="$dokumentknoten/metadata/summary/*"/>
                    </div>
                </xsl:if>
                    <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;"><xsl:choose>
                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:value-of select="$dokid"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:value-of select="$dokid"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
                </div>
                </a>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>


