<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempCF/IHV/?recurse=yes;select=*.xml')"/>
    <xsl:template match="/">
        <!--  <xsl:result-document exclude-result-prefixes="#all" indent="no" href="file:///z:/Duesseldorf/Fachverlag/Fachbereiche/Pool/eShop_innochange/EasyProduct/Daten/1000/Export/Inhaltsverzeichnis/CF-IHV.html" method="xhtml" omit-xml-declaration="yes"> -->
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
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von Corporate Finance? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der 
                        <a href="https://recherche.cf-fachportal.de/Browse.aspx?level=roex%3abron.Zeitschriften.90774213900f4dc48b9e933031aa0f67&amp;title=Corporate%2bFinance" target="_blank">Bibliothek der Recherche-Datenbank.</a>
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
                                        <!-- Editorial oder Gastkommentar-->
                                        <xsl:variable name="editorial-oder-gastkommentar" select="$aktuelles-Heft/*[name()='ed' or name()='gk']"/>
                                        <xsl:choose>
                                            <xsl:when test="$editorial-oder-gastkommentar/name()='gk'">
                                                <div class="ihv_headline ressort" style="margin-bottom: 5px;">Gastkommentar</div>
                                            </xsl:when>
                                            <xsl:when test="$editorial-oder-gastkommentar/name()='ed'">
                                                <div class="ihv_headline ressort" style="margin-bottom: 5px;">Editorial</div>
                                            </xsl:when>
                                        </xsl:choose>
                                        <div class="ihv_level3">
                                            <div class="ihv_level4">
                                                <a href="https://recherche.cf-fachportal.de/document.aspx?docid={$editorial-oder-gastkommentar/@docid}" target="_blank">
                                                <div class="ihv_headline titel">
                                                        <xsl:value-of select="$editorial-oder-gastkommentar/metadata/title"/>
                                                </div>
                                                <div class="ihv_autor">
                                                    <xsl:for-each select="$editorial-oder-gastkommentar/metadata/authors/author">
                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                    </xsl:for-each>
                                                </div>
                                                    <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">M1,  <xsl:value-of select="$editorial-oder-gastkommentar/@docid"/></div>
                                               </a>
                                            </div>
                                        </div>
                                        
                                        <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH Ressort-->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-by="*/metadata/ressort" >
                                            
                                            <xsl:choose>
                                                <xsl:when test="current-grouping-key() = 'Finanzierung'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Finanzierung</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'Kapitalmarkt'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Kapitalmarkt</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'Bewertung'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Bewertung</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'Mergers &amp; Acquisitions'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Mergers &amp; Acquisitions</div>
                                                </xsl:when>
                                                <xsl:otherwise>UNBEKANNTES RESSORT</xsl:otherwise>
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
                                                        
                                                        <!-- verlinkter Artikel -->
                                                        <a href="https://recherche.cf-fachportal.de/document.aspx?docid={$dokid}" target="_blank">                                                        
                                                        <div class="ihv_headline titel"><xsl:value-of select="*/metadata/title"/></div>
                                                        
                                                        <!-- Autoren-->
                                                        <div class="ihv_autor">
                                                            <xsl:for-each select="*/metadata/authors/author">
                                                                <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                            </xsl:for-each>
                                                            <!--<xsl:choose>
                                                                <!-\- Bei Aufsätzen kommen die Autorennamen über den Titel -\->
                                                                <xsl:when test="/*/name() = 'au'">
                                                                    <xsl:for-each select="*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                    </xsl:for-each>
                                                                </xsl:when>
                                                                <!-\- Ansonsten die Gerichte/Behörden und Urteilsdaten -\->
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="concat(*/metadata/instdoc/inst, ', ', */metadata/instdoc/instdoctype, ' vom '
                                                                        , format-date(*/metadata/instdoc/instdocdate, '[D].[M].[Y]'), ' - ', */metadata/instdoc/instdocnrs/instdocnr[1])"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>-->
                                                        </div>
                                                        
                                                        <div class="ihv_abstract">
                                                            <xsl:value-of select="*/metadata/summary/*[not(@lang='en')]"/>
                                                        </div>
                                                        
                                                        <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;"><xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:value-of select="$dokid"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>, <xsl:value-of select="$dokid"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose></div>
                                                        </a>
                                                    </div>
                                                </div>
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
    </xsl:template>
</xsl:stylesheet>