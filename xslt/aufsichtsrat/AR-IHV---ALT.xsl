<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xhtml" omit-xml-declaration="yes" encoding="UTF-8" indent="no"/>
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
                    <!-- Linke Spalte -->
                    <section class="left" id="content" style="width:630px">
                        <div class="content-list inhaltsverzeichnis">
                            <div class="content-text">
                                <div class="ihv_level1">
                                    <div class="ihv_headline">Inhaltsverzeichnis</div>
                                    <div class="ihv_heftnr">
                                        <xsl:for-each
                                            select="$aktuelles-Heft[position()=1]">
                                            <xsl:value-of select="/*/metadata/pub/pubedition"/>
                                        </xsl:for-each>
                                        <div class="ihv_datum">
                                            <xsl:for-each
                                            select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')"/>
                                            </xsl:for-each>
                                        </div>
                                        <!--  style="border-bottom:#ee7000" -->
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//gk">
                                                <div class="ihv_headline ressort">Gastkommentar</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                                        <!-- GASTKOMMENTAR -->
                                                        <xsl:if test="gk">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_autor">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:for-each select="*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)">
                                                                            <xsl:text> / </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                    </xsl:for-each>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                                </a>
                                                            </p>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//au[not(/*/metadata/ressort='Das aktuelle Stichwort')]">
                                                <div class="ihv_headline ressort">Beiträge</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum"
                                            select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez"
                                            select="$docum/*/metadata/ressort"/>
                                                        <!-- BEITRÄGE -->
                                                        <xsl:if test="au[not(/*/metadata/ressort='Das aktuelle Stichwort')]">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_autor">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:for-each select="*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)">
                                                                            <xsl:text> / </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                    </xsl:for-each>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                                </a>
                                                            </p>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//iv">
                                                <div class="ihv_headline ressort">Interview</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum"
                                            select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez"
                                            select="$docum/*/metadata/ressort"/>
                                                        <!-- INTERVIEW -->
                                                        <xsl:if test="iv">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_autor">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                Interview mit 
                                                                    <xsl:value-of select="/*/metadata/authors/author/prefix"/>
                                                                    <xsl:text></xsl:text>
                                                                    <xsl:value-of select="/*/metadata/authors/author/firstname"/>
                                                                    <xsl:text></xsl:text>
                                                                    <xsl:value-of select="/*/metadata/authors/author/surname"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                                </a>
                                                            </p>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//ressort[text()='Das aktuelle Stichwort']">
                                                <div class="ihv_headline ressort">Das aktuelle Stichwort</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum"
                                            select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez"
                                            select="$docum/*/metadata/ressort"/>
                                                        <!-- DAS AKTUELLE STICHWORT -->
                                                        <xsl:if test="$ressortbez='Das aktuelle Stichwort'">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//ent">
                                                <div class="ihv_headline ressort">Rechtsprechung</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        <!-- RECHTSPRECHUNG -->
                                                        <xsl:if test="ent">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//rez">
                                                <div class="ihv_headline ressort">Bücher</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        <!-- RECHTSPRECHUNG -->
                                                        <xsl:if test="rez[not(metadata/title/text() = 'Aktuelle Fachbeiträge')]">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//rez">
                                                <div class="ihv_headline ressort">Aktuelle Fachbeiträge</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        <!-- RECHTSPRECHUNG -->
                                                        <xsl:if test="rez[metadata/title/text() = 'Aktuelle Fachbeiträge']">
                                                            <div class="ihv_headline titel">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </a>
                                                            </div>
                                                            <div class="ihv_seite">
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </a>
                                                            </div>
                                                            <p>
                                                                <a href="https://aufsichtsrat.owlit.de/document.aspx?docid=AR{$siriusID}">AR<xsl:value-of select="$siriusID"/></a>
                                                            </p>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
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
