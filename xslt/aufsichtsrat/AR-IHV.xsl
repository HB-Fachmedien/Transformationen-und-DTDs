<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempAR/?recurse=yes;select=*.xml')"/>
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
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von Der Aufsichtsrat? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der 
                        
                        <a href="https://aufsichtsrat.owlit.de/Browse.aspx?level=roex%3abron.Zeitschriften.166da8952f2d4dd69db07d45271dd3df&amp;title=Aufsichtsrat" target="_blank">Bibliothek der Recherche-Datenbank.</a>
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
                                        <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-adjacent="*[1]/name()" >
                                            <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number" order="ascending"/>
                                            <xsl:choose>
                                                <xsl:when test="current-grouping-key() = 'gk'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Gastkommentar</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'iv'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Interview</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'ent'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Rechtsprechung</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'rez'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Bücher</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'divso'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Neues aus der Datenbank</div>
                                                </xsl:when>
                                                <xsl:otherwise/>
                                            </xsl:choose>
                                            <xsl:for-each-group select="current-group()" group-by="/*/metadata/ressort">
                                                <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number" order="ascending"/>
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'Das aktuelle Stichwort'">
                                                        <div class="ihv_headline ressort" style="margin-bottom: 5px;">Das aktuelle Stichwort</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Beitrag'">
                                                        <div class="ihv_headline ressort" style="margin-bottom: 5px;">Beiträge</div>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:for-each-group>
                                            <xsl:choose>
                                                <xsl:when test="/nr/metadata/title/text()!='Aktuelle Fachbeiträge'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Nachrichten</div>
                                                </xsl:when>
                                                <xsl:when test="/*/metadata/title/text()='Aktuelle Fachbeiträge'">
                                                    <div class="ihv_headline ressort" style="margin-bottom: 5px;">Aktuelle Fachbeiträge</div>
                                                </xsl:when>
                                                <xsl:otherwise></xsl:otherwise>
                                            </xsl:choose>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:choose>
                                                        <xsl:when test="/divso">
                                                            <xsl:call-template name="listarticlesXQ"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:call-template name="listarticlesAR"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                            </div>
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
    <xsl:template name="listarticlesXQ">
        <xsl:for-each select="current-group()">
            <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
            <xsl:variable name="docum" select="document(document-uri(.))"/>
            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
            <a target="_blank" href="https://aufsichtsrat.owlit.de/document.aspx?docid=XQ{$siriusID}">
                <xsl:choose>
                    <xsl:when test="/*/metadata[title='Aktuelle Fachbeiträge']"/>
                    <xsl:otherwise><div class="ihv_headline titel"><xsl:value-of select="/*/metadata/title"/></div></xsl:otherwise>
                </xsl:choose>
                <div class="ihv_autor"  style="display: inline;">
                    <xsl:for-each select="/*/metadata/authors/author">
                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if><xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                    </xsl:for-each>
                </div>
                <xsl:if test="/*/metadata/summary">
                    <div class="ihv_abstract">
                        <xsl:value-of select="/*/metadata/summary"/>
                    </div>
                </xsl:if>
                <div class="ihv_seite" style="font-style: italic; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                    <xsl:choose>
                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>, <xsl:text>XQ</xsl:text><xsl:value-of select="$siriusID"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>, <xsl:text>XQ</xsl:text><xsl:value-of select="$siriusID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </a>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="listarticlesAR">
        <xsl:for-each select="current-group()">
            <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
            <xsl:variable name="docum" select="document(document-uri(.))"/>
            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
            <a target="_blank" href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                <xsl:choose>
                    <xsl:when test="/*/metadata[title='Aktuelle Fachbeiträge']"/>
                    <xsl:otherwise>
                        <div class="ihv_headline titel"><xsl:value-of select="/*/metadata/title"/></div>
                    </xsl:otherwise>
                </xsl:choose>
                <div class="ihv_autor"  style="display: inline;">
                    <xsl:for-each select="/*/metadata/authors/author">
                            <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if><xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>    
                    </xsl:for-each>
                </div>
                <xsl:if test="/*/metadata/summary">
                    <div class="ihv_abstract">
                        <xsl:value-of select="/*/metadata/summary"/>
                    </div>
                </xsl:if>
                <div class="ihv_seite" style="font-style: italic; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                    <xsl:choose>
                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]"><xsl:value-of select="/*/metadata/pub/pages/start_page"/>, <xsl:text>AR</xsl:text><xsl:value-of select="$siriusID"/></xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>, <xsl:text>AR</xsl:text><xsl:value-of select="$siriusID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </a>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>