<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:param name="input_path" select="'c:/tempInputIHV'"/>
    <xsl:param name="output_path" select="'c:/tempOutputIHV/'"/>
    
    <xsl:variable name="src-documents-location" select="iri-to-uri(concat('file:///', $input_path, '/?recurse=yes;select=*.xml'))"/>
    <xsl:variable name="aktuelles-Heft" select="collection($src-documents-location)"/>

    <xsl:variable name="erstes-dokument" select="$aktuelles-Heft[1]"/>
    <xsl:variable name="publisher" select="$erstes-dokument/*/metadata/all_source[@level='2']/text()"/>

    <xsl:template name="main" match="/">
        <xsl:result-document method="xml" href="file:///{$output_path}{upper-case($publisher)}-IHV.html">
            <xsl:choose>
                <xsl:when test="$publisher='wuw'"><xsl:call-template name="fill_wuw"/></xsl:when>
                <!--<xsl:when test="$publisher='db'"><xsl:call-template name="fill_db"/></xsl:when>-->
                <xsl:when test="$publisher='rel'"><xsl:call-template name="fill_rel"/></xsl:when>
                <xsl:when test="$publisher='cf'"><xsl:call-template name="fill_cf"/></xsl:when>
                <xsl:when test="$publisher='ar'"><xsl:call-template name="fill_ar"/></xsl:when>
                <xsl:when test="$publisher='dk'"><xsl:call-template name="fill_dk"/></xsl:when>
                <xsl:when test="$publisher='kor'"><xsl:call-template name="fill_kor"/></xsl:when>
                <xsl:when test="$publisher='ref'"><xsl:call-template name="fill_ref"/></xsl:when>
                <xsl:when test="$publisher='zuj'"><xsl:call-template name="fill_zuj"/></xsl:when>
                <!-- NEW PUBLISHER? Quickly add it just here!-->
                <xsl:when test="$publisher=('db','ret','bwp','paw','zau','esgz','econic')"><xsl:call-template name="fill_ihv"/></xsl:when>
                <xsl:otherwise><xsl:text>Ungültige Zeitschrift</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="fill_zuj">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <link media="screen" type="text/css" href="http://beta.der-betrieb.de/wp-content/themes/Der-Betrieb/style.css" rel="stylesheet"/>
            </head>
            <body>
                <div class="content-wrapper">
                    <!--                    <div>
                        <h2>Editorial</h2>
                        <xsl:for-each select="$aktuelles-Heft[position()=1]">
                            <xsl:value-of select="/*/body/p"/>
                        </xsl:for-each>  
                    </div>-->
                    <!-- Linke Spalte -->
                    <section id="content_innen">
                        <h2>Editorial</h2>
                        <xsl:for-each select="$aktuelles-Heft[position()=1]">
                            <xsl:variable name="siriusID" select="document(document-uri(.))/*/@rawid"/>
                            <div class="ihv_abstract"><p>
                                <xsl:value-of select="/*/body/p"/>
                            </p></div>
                            <xsl:if test="matches('/*/body/p/text()','Seite\s\d{1,3}')">
                                <a target="_blank" href="https://research.owlit.de/lx-document/ZUJ{$siriusID}">Seite X </a> <!-- hier noch seite ersetzen -->
                            </xsl:if>
                        </xsl:for-each>       
                        <div class="content-list inhaltsverzeichnis">
                            <div class="content-text">
                                <div class="ihv_level1">
                                    
                                    <!-- style="border-bottom:#ee7000" -->
                                    <div class="ihv_level2">
                                        <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-by="/*/metadata/ressort">
                                            
                                            <!-- <xsl:sort select="*/metadata/pub/pages/start_page[1]" data-type="number" order="ascending"/> -->
                                            
                                            <!--<xsl:perform-sort select="*/metadata/pub/pages/start_page">-->
                                            <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                            <!--</xsl:perform-sort>-->
                                            
                                            <hr></hr>
                                            <div class="ihv_headline ressort">
                                                
                                                <!--<xsl:value-of select="/*/metadata/ressort/text()"/>--> 
                                                <xsl:value-of select="concat(substring(translate(/*/metadata/ressort/text(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1),substring(/*/metadata/ressort/text(),2))"/> 
                                                
                                            </div>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:for-each select="current-group()">
                                                        <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        <xsl:variable name="ti" select="/*/metadata/title"/>
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/ZUJ{$siriusID}" title="{$ti}">                  
                                                            <div>
                                                                <xsl:attribute name="class">
                                                                    <xsl:text>ihv_headline titel </xsl:text >
                                                                    <xsl:text></xsl:text>
                                                                    <!--<xsl:if test="*/metadata/rubriken/rubrik/text()='Schwerpunkt'">
                                                                        <xsl:text>schwerpunkt</xsl:text>
                                                                    </xsl:if>-->
                                                                </xsl:attribute>
                                                                <xsl:value-of select="/*/metadata/title"/>
                                                                <!-- <xsl:if test="/*/metadata/ressort/text()=('Ortmanns Ordnung' , 'Klassiker' , 'Werkzeugkiste')">
                                                                    <xsl:text>: </xsl:text><xsl:value-of select="/*/metadata/subtitle"/>
                                                                </xsl:if>-->
                                                                
                                                            </div>
                                                            
                                                            <xsl:if test="/*/metadata/authors">
                                                                <div class="ihv_autor">
                                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                                    </xsl:for-each>
                                                                    
                                                                </div>
                                                            </xsl:if>
                                                            <div class="ihv_abstract"><p><xsl:value-of select="/*/metadata/summary"/></p></div>
                                                            <div class="ihv_seite">
                                                                <xsl:choose>
                                                                    <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                        <xsl:text>ZUJ vom </xsl:text> 
                                                                        <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" /><xsl:text>, Heft </xsl:text> 
                                                                        <xsl:value-of select="/*/metadata/pub/pubedition"/><xsl:text>, Seite </xsl:text> 
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/><xsl:text>, ZUJ</xsl:text><xsl:value-of select="$siriusID"/> 
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text>ZUJ vom </xsl:text>
                                                                        <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" /><xsl:text>, Heft </xsl:text> 
                                                                        <xsl:value-of select="/*/metadata/pub/pubedition"/><xsl:text>, Seite </xsl:text> 
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/><xsl:text>, ZUJ</xsl:text><xsl:value-of select="$siriusID"/> 
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </div>
                                                        </a>
                                                    </xsl:for-each>
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
    
    <xsl:template name="fill_ref">
        <html>
            <head>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <div class="content-wrapper">
                    <!--                    <div>
                        <h2>Editorial</h2>
                        <xsl:for-each select="$aktuelles-Heft[position()=1]">
                            <xsl:value-of select="/*/body/p"/>
                        </xsl:for-each>  
                    </div>-->
                    <!-- Linke Spalte -->
                    <section id="content_innen">
                        <h2 class="ihv">Editorial</h2>
                        <xsl:for-each select="$aktuelles-Heft[position()=1]">
                            <xsl:variable name="siriusID" select="document(document-uri(.))/*/@rawid"/>
                            <div class="ihv_abstract">
                                <p><xsl:value-of select="/*/body/p"/></p>
                            </div>
                            <xsl:if test="matches('/*/body/p/text()','Seite\s\d{1,3}')">
                                <a target="_blank" href="https://research.owlit.de/lx-document/REF{$siriusID}">Seite X </a> <!-- hier noch seite ersetzen -->
                            </xsl:if>
                        </xsl:for-each>       
                        <div class="content-list inhaltsverzeichnis">
                            <div class="content-text">
                                <div class="ihv_level1">
                                    
                                    <!-- style="border-bottom:#ee7000" -->
                                    <div class="ihv_level2">
                                        <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-by="/*/metadata/ressort">
                                            
                                            <!-- <xsl:sort select="*/metadata/pub/pages/start_page[1]" data-type="number" order="ascending"/> -->
                                            
                                            <!--<xsl:perform-sort select="*/metadata/pub/pages/start_page">-->
                                            <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                            <!--</xsl:perform-sort>-->
                                            
                                            <div class="ihv_headline ressort">
                                                
                                                <!--<xsl:value-of select="/*/metadata/ressort/text()"/>--> 
                                                <xsl:value-of select="concat(substring(translate(/*/metadata/ressort/text(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1),substring(/*/metadata/ressort/text(),2))"/> 
                                                
                                            </div>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:for-each select="current-group()">
                                                        <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        <xsl:variable name="ti" select="/*/metadata/title"/>
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/REF{$siriusID}" title="{$ti}">                  
                                                            <h2>
                                                                <xsl:attribute name="class">
                                                                    <xsl:text>ihv_headline titel </xsl:text >
                                                                    <xsl:text></xsl:text>
                                                                    <!--<xsl:if test="*/metadata/rubriken/rubrik/text()='Schwerpunkt'">
                                                                        <xsl:text>schwerpunkt</xsl:text>
                                                                    </xsl:if>-->
                                                                </xsl:attribute>
                                                                <xsl:value-of select="/*/metadata/title"/>
                                                                <!-- <xsl:if test="/*/metadata/ressort/text()=('Ortmanns Ordnung' , 'Klassiker' , 'Werkzeugkiste')">
                                                                    <xsl:text>: </xsl:text><xsl:value-of select="/*/metadata/subtitle"/>
                                                                </xsl:if>--> 
                                                            </h2>
                                                            
                                                            <xsl:if test="/*/metadata/authors">
                                                                <div class="ihv_autor">
                                                                    <p>
                                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                                    </xsl:for-each>
                                                                    </p>
                                                                </div>
                                                            </xsl:if>
                                                            <div class="ihv_abstract"><p><xsl:value-of select="/*/metadata/summary"/></p></div>
                                                            <div class="ihv_seite">
                                                                <xsl:choose>
                                                                    <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>REF</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text>REF vom </xsl:text> 
                                                                        <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" /><xsl:text>, Heft </xsl:text> 
                                                                        <xsl:value-of select="/*/metadata/pub/pubedition"/><xsl:text>, Seite </xsl:text>
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/><xsl:text>, REF</xsl:text><xsl:value-of select="$siriusID"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </div>
                                                        </a>
                                                    </xsl:for-each>
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

    <xsl:template name="fill_kor">
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
                        
                        <a href="https://kor-ifrs.owlit.de/Browse.aspx?level=roex%3abron.Zeitschriften.0c0f5d6e415044179263a16c0d68e83e&amp;title=KoR" target="_blank">Bibliothek der Recherche-Datenbank.</a>
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
                                        <div class="ihv_headline ressort">Editorial</div>
                                        <xsl:for-each select="$aktuelles-Heft/*[name()='ed']" >
                                            <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number"/>
                                            <xsl:call-template name="ihv-eintrag">
                                                <xsl:with-param name="dokumentknoten" select="."/>
                                            </xsl:call-template>
                                        </xsl:for-each>
                                        <div id="au" class="ihv_headline ressort">Aufsätze</div>
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
                                        <div id="rep" class="ihv_headline ressort">Reports</div>
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
    </xsl:template>
    <xsl:template name="ihv-eintrag">
        <xsl:param name="dokumentknoten"/>
        <xsl:variable name="dokid" select="$dokumentknoten/@docid"/>
        <div class="ihv_level3">
            <div class="ihv_level4">
                <!-- Rubriken: -->
                <!--<div class="ihv_rubriken">
                    <xsl:for-each select="$dokumentknoten//metadata/keywords/keyword">
                        <xsl:if test="not(position()=1)">
                            <xsl:text> / </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </div>-->
                <!-- verlinkter Artikel -->
                <a href="https://research.owlit.de/lx-document/{$dokid}" target="_blank">
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
                                <p><xsl:value-of select="$dokumentknoten/metadata/summary/*"/></p>
                            </div>
                        </xsl:if>
                    </div>
                    <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                        <xsl:choose>
                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:value-of select="$dokid"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:value-of select="$dokid"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </a>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="fill_dk">
        <html>
            <head>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <div class="content-wrapper">
                    <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von Der Konzern? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der <a href="https://der-konzern.owlit.de/Browse.aspx?level=roex%3abron.Zeitschriften.5812b0ada8c9454182ed43bf03f938ef&amp;title=Der+Konzern&amp;trailpos=2" target="_blank">Bibliothek der Recherche-Datenbank.</a>
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
                                            <xsl:sort select="*[1]/metadata/pub/pages/start_page/text()" data-type="number"/>
                                            <xsl:choose>
                                                <xsl:when test="current-grouping-key() = 'au'">
                                                    <div id="au" class="ihv_headline ressort" style="margin-bottom: 5px;">Aufsätze</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'ent'">
                                                    <div id="ent" class="ihv_headline ressort" style="margin-bottom: 5px;">Entscheidungen</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'entk'">
                                                    <div id="entk" class="ihv_headline ressort" style="margin-bottom: 5px;">Entscheidungen</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'kk'">
                                                    <div id="va" class="ihv_headline ressort" style="margin-bottom: 5px;">Kompakt</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'va'">
                                                    <div id="va" class="ihv_headline ressort" style="margin-bottom: 5px;">Verwaltungsanweisungen</div>
                                                </xsl:when>
                                                <xsl:otherwise></xsl:otherwise>
                                            </xsl:choose>
                                            
                                            <!-- For-each-group, die alle Doctypen in die drei Ressorts gruppiert: kr, br und sr: -->
                                            <xsl:for-each-group select="current-group()" group-by="/*/metadata/ressort">
                                                <xsl:sort select="*[1]/metadata/pub/pages/start_page/text()" data-type="number"/>
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'kr'">
                                                        <div class="ihv_headline doktyp">Konzernrecht</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'br'">
                                                        <div class="ihv_headline doktyp">Rechnungslegung/Corporate Governance</div>
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
                                                            <a href="https://research.owlit.de/lx-document/{$dokid}" target="_blank">
                                                                <!-- Rubriken: -->
                                                                <div class="ihv_rubriken">
                                                                    <xsl:for-each select="*/metadata/rubriken/rubrik">
                                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                        <xsl:value-of select="."/>
                                                                    </xsl:for-each>
                                                                </div>
                                                                
                                                                <!-- verlinkter Titel -->                                                        
                                                                <div class="ihv_headline titel"><xsl:value-of select="*/metadata/title"/></div>
                                                                
                                                                <!-- Autoren- bzw. Behördenauszeichnung -->
                                                                <div class="ihv_autor">
                                                                    <xsl:choose>
                                                                        <!-- Bei Aufsätzen kommen die Autorennamen über den Titel -->
                                                                        <xsl:when test="/*/name() = ('au', 'kk')">
                                                                            <xsl:for-each select="*/metadata/authors/author">
                                                                                <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                                <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                            </xsl:for-each>
                                                                        </xsl:when>
                                                                        <!-- Ansonsten die Gerichte/Behörden und Urteilsdaten -->
                                                                        <xsl:otherwise>
                                                                            <xsl:if test="*/metadata/instdoc">
                                                                                <xsl:value-of select="concat(*/metadata/instdoc/inst, ', ', */metadata/instdoc/instdoctype, ' vom '
                                                                                    , format-date(*/metadata/instdoc/instdocdate, '[D].[M].[Y]'), ' - ', */metadata/instdoc/instdocnrs/instdocnr[1])"/>
                                                                            </xsl:if>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                                
                                                                <!-- Bei Aufsätzen wird der Summary Inhalt dargestellt -->
                                                                <xsl:if test="/*/name() = 'au'">
                                                                    <div class="ihv_abstract">
                                                                        <xsl:value-of select="*/metadata/summary/*"/>
                                                                    </div>
                                                                </xsl:if>
                                                                <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                                                    <xsl:choose>
                                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:value-of select="$dokid"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:value-of select="$dokid"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </a>
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
    
    <xsl:template name="fill_ar">
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
                    <section class="left" id="content">
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
                                                    <div class="ihv_headline ressort">Gastkommentar</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'iv'">
                                                    <div id="interv" class="ihv_headline ressort">Interview</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'ent'">
                                                    <div id="resp" class="ihv_headline ressort">Rechtsprechung</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'rez'">
                                                    <div id="rez" class="ihv_headline ressort">Bücher</div>
                                                </xsl:when>
                                                <xsl:when test="current-grouping-key() = 'divso'">
                                                    <div class="ihv_headline ressort">Neues aus der Datenbank</div>
                                                </xsl:when>
                                                <xsl:otherwise/>
                                            </xsl:choose>
                                            <xsl:for-each-group select="current-group()" group-by="/*/metadata/ressort">
                                                <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number" order="ascending"/>
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'Das aktuelle Stichwort'">
                                                        <div id="aktstich" class="ihv_headline ressort">Das aktuelle Stichwort</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Beitrag'">
                                                        <div id="beit" class="ihv_headline ressort">Beiträge</div>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:for-each-group>
                                            
                                            
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
            <a target="_blank" href="https://research.owlit.de/lx-document/XQ{$siriusID}">
                <xsl:choose>
                    <xsl:when test="/*/metadata[title='Aktuelle Fachbeiträge']"/>
                    <xsl:otherwise><div class="ihv_headline titel"><xsl:value-of select="/*/metadata/title"/></div></xsl:otherwise>
                </xsl:choose>
                <div class="ihv_autor">
                    <xsl:for-each select="/*/metadata/authors/author">
                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if><xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                    </xsl:for-each>
                </div>
                <xsl:if test="/*/metadata/summary">
                    <div class="ihv_abstract">
                        <xsl:value-of select="/*/metadata/summary"/>
                    </div>
                </xsl:if>
                <div class="ihv_seite">
                    <xsl:choose>
                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>, <xsl:text>XQ</xsl:text><xsl:value-of select="$siriusID"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>, <xsl:text>XQ</xsl:text><xsl:value-of select="$siriusID"/>
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
            <a target="_blank" href="https://research.owlit.de/lx-document/AR{$siriusID}">
                <div class="ihv_headline titel">
                    <xsl:value-of select="/*/metadata/title">
                    </xsl:value-of>
                </div>        
                <div class="ihv_autor">
                    <xsl:for-each select="/*/metadata/authors/author">
                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if><xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>    
                    </xsl:for-each>
                </div>
                <xsl:if test="/*/metadata/summary">
                    <div class="ihv_abstract">
                        <p><xsl:value-of select="/*/metadata/summary"/></p>
                    </div>
                </xsl:if>
                <div class="ihv_seite">
                    <xsl:choose>
                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]"><xsl:value-of select="/*/metadata/pub/pages/start_page"/>, <xsl:text>AR</xsl:text><xsl:value-of select="$siriusID"/></xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>, <xsl:text>AR</xsl:text><xsl:value-of select="$siriusID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </a>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="fill_cf">
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
                        <a href="https://cf-fachportal.owlit.de/Browse.aspx?level=roex%3abron.Zeitschriften.90774213900f4dc48b9e933031aa0f67&amp;title=Corporate%2bFinance" target="_blank">Bibliothek der Recherche-Datenbank.</a>
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
                                                <a href="https://research.owlit.de/lx-document/{$editorial-oder-gastkommentar/@docid}" target="_blank">
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
                                                        <a href="https://research.owlit.de/lx-document/{$dokid}" target="_blank">                                                        
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
                                                                <p><xsl:value-of select="*/metadata/summary/*[not(@lang='en')]"/></p>
                                                            </div>
                                                            
                                                            <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;"><xsl:choose>
                                                                <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:value-of select="$dokid"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>, <xsl:value-of select="$dokid"/>
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
    
    <xsl:template name="fill_rel">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <link media="screen" type="text/css" href="http://beta.der-betrieb.de/wp-content/themes/Der-Betrieb/style.css" rel="stylesheet"/>
            </head>
            <body>
                <div class="content-wrapper">
                    <h1 class="pagehead">Inhaltsverzeichnis</h1>
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von
                        REthinking-Law? 
                        
                        <a href="https://rethinking-law.com/zeitschrift/archiv/" target="_blank">
                            <u>Hier finden Sie eine Übersicht aller früheren
                                Ausgaben.</u>
                        </a>
                    </div>
                    <!--                    <div>
                        <h2>Editorial</h2>
                        <xsl:for-each select="$aktuelles-Heft[position()=1]">
                            <xsl:value-of select="/*/body/p"/>
                        </xsl:for-each>  
                    </div>-->
                    <!-- Linke Spalte -->
                    <section id="content_innen">
                        
                        <h2>Editorial</h2>
                        <xsl:for-each select="$aktuelles-Heft[position()=1]">
                            <xsl:variable name="siriusID" select="document(document-uri(.))/*/@rawid"/>
                            <div class="ihv_abstract">
                                <xsl:variable name="temp" select="string-join(//body//text()[normalize-space()], ' ')"/>
                                <p><xsl:value-of select="substring($temp, 1, 400)"/>...<a target="_blank" style="text-decoration: none; color: #4db36c;" href="https://research.owlit.de/lx-document/REL{$siriusID}"><xsl:text>[Weiterlesen]</xsl:text> </a></p>
                            </div>
                            <xsl:if test="matches('/*/body/p/text()','Seite\s\d{1,3}')">
                                <a target="_blank" href="https://research.owlit.de/lx-document/REL{$siriusID}">Seite X </a> <!-- hier noch seite ersetzen -->
                            </xsl:if>
                        </xsl:for-each>
                        
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
                                    <!-- style="border-bottom:#ee7000" -->
                                    <div class="ihv_level2">
                                        <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-by="/*/metadata/ressort">
                                            
                                            <!-- <xsl:sort select="*/metadata/pub/pages/start_page[1]" data-type="number" order="ascending"/> -->
                                            
                                            <!--<xsl:perform-sort select="*/metadata/pub/pages/start_page">-->
                                            <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                            <!--</xsl:perform-sort>-->
                                            
                                            <xsl:variable name="ressort" select='/*/metadata/ressort/text()'> </xsl:variable>
                                            
                                            <xsl:variable name="inhalt" select='replace($ressort,"\s","")'> </xsl:variable>
                                            
                                            <xsl:variable name="text" select='replace($inhalt,"&amp;","")'> </xsl:variable>
                                            
                                            <div id="{$text}" class="ihv_headline ressort" style="margin-bottom: 5px; font-weight: bold;" >
                                                
                                                <!--<xsl:value-of select="/*/metadata/ressort/text()"/>--> 
                                                <xsl:value-of select="concat(substring(translate(/*/metadata/ressort/text(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1),substring(/*/metadata/ressort/text(),2))"/> 
                                                
                                            </div>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:for-each select="current-group()">
                                                        <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        <a target="_blank" style="text-decoration: none;" href="https://research.owlit.de/lx-document/REL{$siriusID}">
                                                            <div>
                                                                <xsl:attribute name="class">
                                                                    <xsl:text>ihv_headline titel </xsl:text>
                                                                    <xsl:text></xsl:text>
                                                                    <!--<xsl:if test="*/metadata/rubriken/rubrik/text()='Schwerpunkt'">
                                                                        <xsl:text>schwerpunkt</xsl:text>
                                                                    </xsl:if>-->
                                                                </xsl:attribute>
                                                                <xsl:value-of select="/*/metadata/title"/>
                                                                <!-- <xsl:if test="/*/metadata/ressort/text()=('Ortmanns Ordnung' , 'Klassiker' , 'Werkzeugkiste')">
                                                                    <xsl:text>: </xsl:text><xsl:value-of select="/*/metadata/subtitle"/>
                                                                </xsl:if>-->
                                                                
                                                                
                                                            </div>
                                                            
                                                            <xsl:if test="/*/metadata/authors">
                                                                <div class="ihv_autor">
                                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                                    </xsl:for-each>
                                                                </div>
                                                            </xsl:if>
                                                            <div class="ihv_abstract" style="line-height:17.5px !important; font-size:13px !important;">
                                                                
                                                                <xsl:if test="/*/metadata/summary">
                                                                    <p><xsl:value-of select="/*/metadata/summary"/></p>
                                                                </xsl:if>
                                                                <xsl:if test="/*/metadata/subtitle">
                                                                    <p><xsl:value-of select="/*/metadata/subtitle"/></p>
                                                                </xsl:if > 
                                                            </div>
                                                            <div class="ihv_seite" style="font-style: italic; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                                                <xsl:choose>
                                                                    <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>REL</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>REL</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </div>
                                                        </a>
                                                    </xsl:for-each>
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
    
    
    <xsl:template name="fill_ihv">
        <html>
            <head>
                <meta charset="UTF-8"/> 
            </head>
            <body>
                <div class="content-wrapper">
                    <!-- Linke Spalte -->
                    <section id="content_innen">     
                        <div class="content-list inhaltsverzeichnis">
                            <div class="content-text">
                                <div class="ihv_level1">
                                    <div class="ihv_level2">
                                        <!-- Editorials dann Gastkommentare-->
                                        <xsl:if test="$aktuelles-Heft/*[name()='ed']">
                                            <div class="ihv_headline ressort">Editorial</div>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:for-each select="$aktuelles-Heft/*[name()='ed']">
                                                        <xsl:sort select="/*/metadata/pub/pages/start_page" data-type="number"/>
                                                        
                                                        <a href="https://research.owlit.de/lx-document/{./@docid}" target="_blank">
                                                            <div class="ihv_headline titel"><xsl:value-of select="./metadata/title"/></div>
                                                            <div class="ihv_autor">
                                                                <xsl:for-each select="./metadata/authors/author">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                </xsl:for-each>
                                                            </div>
                                                            <div class="ihv_seite">  
                                                                <xsl:text>Seite </xsl:text><xsl:value-of select="./metadata/pub/pages/start_page"/> 
                                                                <xsl:if test="not(./metadata/pub/pages[start_page = last_page or last_page =''])">
                                                                    <xsl:text> &#45; </xsl:text><xsl:value-of select="./metadata/pub/pages/last_page"/>
                                                                </xsl:if>
                                                                <xsl:text>, </xsl:text><xsl:value-of select="./@docid"/>
                                                            </div>
                                                        </a>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </xsl:if>
                                        <xsl:if test="$aktuelles-Heft/*[name()='gk']">
                                            <div class="ihv_headline ressort">Gastkommentar</div>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:for-each select="$aktuelles-Heft/*[name()='gk']">
                                                        <a href="https://research.owlit.de/lx-document/{./@docid}" target="_blank">
                                                            <div class="ihv_headline titel"><xsl:value-of select="./metadata/title"/></div>
                                                            <div class="ihv_autor">
                                                                <xsl:for-each select="./metadata/authors/author">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                                </xsl:for-each>
                                                            </div>
                                                            <div class="ihv_seite">
                                                                <xsl:text>Seite </xsl:text><xsl:value-of select="./metadata/pub/pages/start_page"/> 
                                                                <xsl:if test="not(./metadata/pub/pages[start_page = last_page or last_page =''])">
                                                                    <xsl:text> &#45; </xsl:text><xsl:value-of select="./metadata/pub/pages/last_page"/>
                                                                </xsl:if>
                                                                <xsl:text>, </xsl:text><xsl:value-of select="./@docid"/>
                                                            </div>
                                                        </a>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </xsl:if>
                                        
                                        <!-- Documets are grouped according to ressorts. And an additional group for articles with no ressort (excluding TOC and Editorial) -->
                                        <xsl:for-each-group select="$aktuelles-Heft" group-by="if (/*/metadata/ressort) then /*/metadata/ressort else if (/*[not(name()=('toc','ed','gk'))]) then 'Weitere Inhalte' else ()">
                                            
                                            <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                            <xsl:sort select="current-grouping-key()" data-type="text" order="ascending"/>
                                            
                                            <div class="ihv_headline ressort">
                                                <!--just converting the first letter into an upper case--> 
                                                <xsl:value-of select="concat(substring(translate(current-grouping-key(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,1),substring(current-grouping-key(),2))"/> 
                                            </div>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <xsl:for-each select="current-group()">
                                                        <xsl:sort select="*/metadata/pub/pages/start_page" data-type="number"/>
                                                        <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/{upper-case($publisher)}{$siriusID}" title="{/*/metadata/title}">
                                                            <div>
                                                                <xsl:attribute name="class">
                                                                    <xsl:text>ihv_headline titel </xsl:text>
                                                                    <xsl:text></xsl:text>
                                                                </xsl:attribute>
                                                                <xsl:value-of select="/*/metadata/title"/>
                                                            </div>
                                                            <xsl:if test="/*/metadata/authors">
                                                                <div class="ihv_autor">
                                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                                    </xsl:for-each>
                                                                </div>
                                                            </xsl:if>
                                                            <div class="ihv_abstract"><p><xsl:value-of select="/*/metadata/summary"/></p></div>
                                                            <div class="ihv_seite">
                                                                <xsl:value-of select="upper-case($publisher)"/><xsl:text> vom </xsl:text>
                                                                <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" /><xsl:text>, Heft </xsl:text> 
                                                                <xsl:value-of select="/*/metadata/pub/pubedition"/><xsl:text>, Seite </xsl:text>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                <xsl:if test="not(/*/metadata/pub/pages[start_page = last_page or last_page =''])">
                                                                    <xsl:text> &#45; </xsl:text><xsl:value-of select="/*/metadata/pub/pages/last_page"/>
                                                                </xsl:if>                                                            
                                                                <xsl:text>, </xsl:text><xsl:value-of select="upper-case($publisher)"/><xsl:value-of select="$siriusID"/> 
                                                            </div>
                                                        </a>
                                                    </xsl:for-each>
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
    
    
    <xsl:template name="fill_wuw">
        <html>
            <head>
                <meta charset="UTF-8"/>
            </head>
    
            <body>
                <div class="content-wrapper">
                    <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                    <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von WIRTSCHAFT UND WETTBEWERB? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der <a href="https://wuw-online.owlit.de/Browse.aspx?level=roex%3abron.Zeitschriften.d4d652b1019840bfac5d28ebd0ec6c9f&amp;title=Wirtschaft%2bund%2bWettbewerb" target="_blank">Bibliothek der Recherche-Datenbank.</a></div>
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
                                    <!--  style="border-bottom:#ee7000" -->
                                            
                                    <div class="ihv_level2"> 
                                    <xsl:if test="$aktuelles-Heft//gk">
                                        <div id="gk" class="ihv_headline ressort">Gastkommentar</div>
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
                                        
                                        
                                        <!-- KOMMENTAR -->
                                        
                                        <xsl:if test="gk">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                            <div class="ihv_headline titel">
                                                <xsl:value-of select="/*/metadata/title"/>
                                            </div>
                                            <div class="ihv_autor">
                                                <xsl:for-each select="/*/metadata/authors/author">
                                                    <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                </xsl:for-each>
                                            </div>
                                          <div class="ihv_seite">
                                              <xsl:choose>
                                                  <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                      <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                      <xsl:value-of select="$siriusID"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                      <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                      <xsl:value-of select="$siriusID"/>
                                                  </xsl:otherwise>
                                              </xsl:choose>
                                          </div>
                                          </a>
                                        </xsl:if>
                                    </xsl:for-each>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="ihv_level2">                                            
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Abhandlung']">
                                                <div id="abh" class="ihv_headline ressort">Abhandlungen</div>
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
                                       
                                        <!-- ABHANDLUNGEN -->
                                        
                                 <!--       <xsl:if test="$ressortbez='Abhandlung'">   -->
                                        <xsl:if test="($ressortbez='Abhandlung')">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                            <div class="ihv_headline titel">
                                                <xsl:value-of select="/*/metadata/title"/>
                                            </div>
                                                <div class="ihv_autor">
                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                        <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                    </xsl:for-each>
                                                </div>
                                                <div class="ihv_abstract">
                                                    <p><xsl:value-of select="/*/metadata/summary/p[not(@lang='en')]"/></p>
                                                </div>
                                                <div class="ihv_seite" >
                                                    <xsl:choose>
                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                           </a>
                                        </xsl:if>
                                         </xsl:for-each>
                                             
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- LElXIKON -->                                        
                                    
                                    <div class="ihv_level2">                                            
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Ökonomisches Lexikon']">
                                            <div class="ihv_headline ressort">Ökonomisches Lexikon</div>
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
                                                    
                                                    <!-- Ökonomisches Lexikon -->
                                                    
                                                    <xsl:if test="($ressortbez='Ökonomisches Lexikon')">
                                                        <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                            <div class="ihv_headline titel">
                                                                <xsl:value-of select="/*/metadata/title"/>
                                                            </div>
                                                            <div class="ihv_autor">
                                                                <xsl:for-each select="/*/metadata/authors/author">
                                                                    <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
                                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>        
                                                                </xsl:for-each>
                                                            </div>
                                                            <div class="ihv_abstract">
                                                                <p><xsl:value-of select="/*/metadata/summary/p[not(@lang='en')]"/></p>
                                                            </div>
                                                            <div class="ihv_seite" >
                                                                <xsl:choose>
                                                                    <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </div>
                                                        </a>
                                                    </xsl:if>
                                                </xsl:for-each>
                                               
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- LITERATUR -->
                                    
                                    <div class="ihv_level2">
                                        <xsl:if test="$aktuelles-Heft//rez">
                                            <div class="ihv_headline ressort">Literatur</div>
                                        </xsl:if>
                                        
                                        <div class="ihv_level3">
                                            <div class="ihv_level4">
                                                
                                                <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                <xsl:for-each select="$aktuelles-Heft">
                                                    
                                                    <xsl:variable name="docum"
                                                        select="document(document-uri(.))"/>
                                                    <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                    <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                    <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                    
                                                    <xsl:if test="rez">
                                                        <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                            <div class="ihv_headline titel">
                                                                <xsl:value-of select="/*/metadata/title"/>
                                                            </div>
                                                            <div class="ihv_seite"> 
                                                                <xsl:choose>
                                                                    <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </div>
                                                        </a>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                    <div class="ihv_level2">
                                    <xsl:if test="$aktuelles-Heft//ressort[text()='Tagungsbericht']">
                                        <div class="ihv_headline ressort">Tagungsbericht</div>
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
                                        
                                        <!-- TAGUNGSBERICHT -->
                                        
                                        <xsl:if test="$ressortbez='Tagungsbericht'">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                            <div class="ihv_headline titel">
                                                <xsl:value-of select="/*/metadata/title"/>
                                            </div>
                                                <div class="ihv_seite" >
                                                    <xsl:choose>
                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                            </a>
                                        </xsl:if>
                                    </xsl:for-each>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="ihv_level2">
                                       
                                        <xsl:choose>
                                            <xsl:when test="$aktuelles-Heft//ressort[text()='International Developments']">
                                                <div class="ihv_headline ressort">International Developments</div>
                                            </xsl:when>
                                            <xsl:otherwise>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        
                                        
                                        
                              <!--   
                                    <xsl:if test="$aktuelles-Heft//ressort[text()='International Developments']">
                                        <div class="ihv_headline ressort">International Developments</div>
                                    </xsl:if>
                                        
                                    <xsl:if test="$aktuelles-Heft//ressort[text()='Fusionskontrolle']">
                                        <div class="ihv_headline ressort">Fusionskontrolle</div>
                                    </xsl:if>
                                     -->   
    
                                        
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
                                        
                                        
                                        <!-- INTERNATIONAL DEVELOPMENTS -->
                                        
                                        <xsl:if test="$ressortbez='International Developments'">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                            <div class="ihv_headline titel">
                                                <xsl:value-of select="/*/metadata/title"/>
                                            </div>
                                                <div class="ihv_seite" >
                                                    <xsl:choose>
                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                            </a>
                                        </xsl:if>
                                        
                                     
                                    </xsl:for-each>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="ihv_level2">
                                        <xsl:if test="$aktuelles-Heft//ent or $aktuelles-Heft//nr">
                                        <div id="entsch" class="ihv_headline ressort">Entscheidungen</div>
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
                                        
                                        
                                        <!-- ENTSCHEIDUNGEN -->
                                        
                                        <xsl:if test="ent">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                            <div class="ihv_headline titel">
                                                <i><xsl:value-of select="/*/metadata/instdoc/inst"/><xsl:text>: </xsl:text></i>
                                                <xsl:value-of select="/*/metadata/title"/>
                                            </div>
                                                <div class="ihv_seite" >
                                                    <xsl:choose>
                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                            </a>
                                        </xsl:if>
                                        
                                        <!-- FUSIONSKONTROLLE -->
                                        
                                        <xsl:if test="$ressortbez='Fusionskontrolle'">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                <div class="ihv_seite" >
                                                    <xsl:choose>
                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                            </a>
                                        </xsl:if>
                                    </xsl:for-each>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="ihv_level2">
                                    <xsl:if test="$aktuelles-Heft//iv">
                                        <div id="interv" class="ihv_headline ressort">Interview</div>
                                    </xsl:if>
                                        
                                        <div class="ihv_level3">
                                            <div class="ihv_level4">
                                    
                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                    <xsl:for-each select="$aktuelles-Heft">
                                        
                                        <xsl:variable name="docum"
                                            select="document(document-uri(.))"/>
                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                        
                                        
                                        <!-- INTERVIEW -->
                                        
                                        <xsl:if test="iv">
                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                            <div class="ihv_headline titel">
                                                <xsl:value-of select="/*/metadata/title"/>
                                            </div>
                                                <div class="ihv_seite"> 
                                                    <xsl:choose>
                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#45; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                            <xsl:value-of select="$siriusID"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </div>
                                            </a>
                                        </xsl:if>
                                    </xsl:for-each>
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
    
    <!--<xsl:template name="fill_db">
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
                        }
                    </style>
            </head>
    
            <body>
                <div class="content-wrapper">
                    <h2 class="pagehead small">Inhaltsverzeichnis</h2>
                    <!-\- Linke Spalte -\->
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
                                    <!-\- Editorial -\->
                                    <div class="ihv_level2">
                                        <xsl:if test="$aktuelles-Heft//ed">
                                            <div class="ihv_headline ressort">Editorial</div>
                                        </xsl:if>
                                        
                                        <div class="ihv_level3">
                                            <div class="ihv_level4">
                                                
                                                <!-\- SCHLEIFE ÜBER JEDES XML DOKUMENT -\->
                                                <xsl:for-each select="$aktuelles-Heft">
                                                    <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                    <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                    <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                    <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                    <xsl:if test="ed">
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/DB{$siriusID}">
                                                        <div class="ihv_headline titel"><xsl:value-of select="/*/metadata/title"/></div>
                                                        <div class="ihv_autor">
                                                            <xsl:for-each select="/*/metadata/authors/author">
                                                                <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
                                                                <xsl:value-of select="concat(firstname, ' ', surname)"/>        
                                                            </xsl:for-each>
                                                        </div>
                                                        <xsl:for-each select="/*/metadata/authors/author">
                                                            <div class="ihv_autornormiert">
                                                                <div class="ihv_autor">
                                                                    <xsl:value-of select="hbfm:autorenkuerzel(concat(firstname, ' ', surname))"/>
                                                                </div>
                                                            </div>
                                                        </xsl:for-each>      
                                                        <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">M1, DB<xsl:value-of select="$siriusID"/></div>
                                                        </a>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </div>
                                            <!-\- Ende Level4 -\->
                                        </div>
                                        <!-\- Ende Level3 -\->
                                    </div>
                                    <!-\- Ende Level2 - Editorial -\->
                                    <!-\- Ende: Editorial -\->
                                    
                                    <!-\- Gastkommentar -\->
                                    <div class="ihv_level2">
                                        <div class="ihv_headline ressort">Gastkommentar</div>
                                        <!-\- GK KANN WOMÖGLICH AUCH VON MEHREREN AUTOREN GESCHRIEBEN WERDEN -\->
                                        <div class="ihv_level3">
                                            <div class="ihv_level4">
                                                <!-\- SCHLEIFE ÜBER JEDES XML DOKUMENT -\->
                                                <xsl:for-each select="$aktuelles-Heft">
                                                    <xsl:variable name="docum" select="document(document-uri(.))"/>
                                                    <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                    <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                    <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                    <xsl:if test="gk">
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/DB{$siriusID}">
                                                            <div class="ihv_headline titel"><xsl:value-of select="/*/metadata/title"/></div>
                                                            <div class="ihv_autor">
                                                                <xsl:for-each select="/*/metadata/authors/author">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname, suffix)"/>
                                                                    <!-\-<xsl:if test="$docum/*/metadata/authors/author/suffix"><xsl:value-of select="suffix"/></xsl:if>-\->
                                                                </xsl:for-each>
                                                            </div>
                                                            <xsl:for-each select="/*/metadata/authors/author">
                                                                <div class="ihv_autornormiert">
                                                                    <div class="ihv_autor">
                                                                        <xsl:value-of select="hbfm:autorenkuerzel(concat(firstname, ' ', surname))"/>
                                                                    </div>
                                                                </div>
                                                            </xsl:for-each>
                                                            <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                                                M5, DB<xsl:value-of select="$siriusID"/>
                                                            </div>
                                                        </a>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </div>
                                            <!-\- Ende Level4 -\->
                                        </div>
                                        <!-\- Ende Level3 -\->
                                    </div>
                                    <!-\- Ende Level2 - Gastkommentar -\->
                                    
                                    
                                    <div class="ihv_level2">
                                        <div class="ihv_headline ressort">Betriebswirtschaft</div>
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Aufsätze'"/>
                                            <xsl:with-param name="art-nr" select="130"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kompakt'"/>
                                            <xsl:with-param name="art-nr" select="140"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Verwaltungsanweisungen'"/>
                                            <xsl:with-param name="art-nr" select="150"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Entscheidungen'"/>
                                            <xsl:with-param name="art-nr" select="160"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Nachrichten'"/>
                                            <xsl:with-param name="art-nr" select="170"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kurzbeiträge'"/>
                                            <xsl:with-param name="art-nr" select="165"/>
                                        </xsl:call-template>
                                    </div><xsl:comment>Ende Level 2</xsl:comment>
                                    
                                    <div class="ihv_level2">
                                        <div class="ihv_headline ressort">Steuerrecht</div>
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Aufsätze'"/>
                                            <xsl:with-param name="art-nr" select="230"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kompakt'"/>
                                            <xsl:with-param name="art-nr" select="240"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Verwaltungsanweisungen'"/>
                                            <xsl:with-param name="art-nr" select="250"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Entscheidungen'"/>
                                            <xsl:with-param name="art-nr" select="260"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kurzbeiträge'"/>
                                            <xsl:with-param name="art-nr" select="265"/>
                                        </xsl:call-template>
                                    </div><xsl:comment>Ende Level 2</xsl:comment>
                                    
                                    <div class="ihv_level2">
                                        <div class="ihv_headline ressort">Wirtschaftsrecht</div>
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Aufsätze'"/>
                                            <xsl:with-param name="art-nr" select="330"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kompakt'"/>
                                            <xsl:with-param name="art-nr" select="340"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Verwaltungsanweisungen'"/>
                                            <xsl:with-param name="art-nr" select="350"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Entscheidungen'"/>
                                            <xsl:with-param name="art-nr" select="360"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kurzbeiträge'"/>
                                            <xsl:with-param name="art-nr" select="365"/>
                                        </xsl:call-template>
                                    </div><xsl:comment>Ende Level 2</xsl:comment>
                                    
                                    <div class="ihv_level2">
                                        <div class="ihv_headline ressort">Arbeitsrecht</div>
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Aufsätze'"/>
                                            <xsl:with-param name="art-nr" select="430"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kompakt'"/>
                                            <xsl:with-param name="art-nr" select="440"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Verwaltungsanweisungen'"/>
                                            <xsl:with-param name="art-nr" select="450"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Entscheidungen'"/>
                                            <xsl:with-param name="art-nr" select="460"/>
                                        </xsl:call-template>
                                        
                                        <xsl:call-template name="listArticles">
                                            <xsl:with-param name="self" select="./node()"/>
                                            <xsl:with-param name="ueberschrift" select="'Kurzbeiträge'"/>
                                            <xsl:with-param name="art-nr" select="465"/>
                                        </xsl:call-template>
                                    </div><xsl:comment>Ende Level 2</xsl:comment>
                                    
                                    <!-\- Standpunkte -\->
                                    <xsl:variable name="standpunkte">
                                        <xsl:for-each select="$aktuelles-Heft">
                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                            <xsl:variable name="doctype" select="$docum/*/name()"/>
                                            <xsl:if test="$doctype='sp'">
                                                <sp>
                                                    <xsl:copy-of select="$docum/*"/>
                                                </sp>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    
                                    <xsl:variable name="anzahl-standpunkte" select="count($standpunkte/sp)"/>
                                    <xsl:if test="$anzahl-standpunkte&gt;0">
                                        <div class="ihv_level2">
                                            <!-\- Rubrik existiert nicht im ihv-\->  
                                            <div class="ihv_headline ressort">Standpunkt<xsl:if test="$anzahl-standpunkte&gt;1">e</xsl:if></div>
                                            <xsl:for-each select="$standpunkte/sp">
                                                <xsl:variable name="sp-dokument" select="."/>
                                                <xsl:variable name="sp-dbnummer" select="./*/@rawid"/>
                                                
                                                <!-\- SP KANN WOMÖGLICH AUCH VON MEHREREN AUTOREN GESCHRIEBEN WERDEN -\->
                                                <div class="ihv_level3">
                                                    <div class="ihv_level4">
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/DB{$sp-dbnummer}">
                                                            <div class="ihv_headline titel">
                                                                <xsl:value-of disable-output-escaping="yes" select="$sp-dokument/*/metadata/title"/>
                                                            </div>
                                                            
                                                            <div class="ihv_autor">
                                                                <xsl:for-each select="$sp-dokument/*/metadata/authors/author">
                                                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>

                                                                    <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname, suffix)"/>
                                                                    
                                                                </xsl:for-each>
                                                            </div>
                                                            <xsl:for-each select="$sp-dokument/*/metadata/authors/author">
                                                                <div class="ihv_autornormiert">
                                                                    <div class="ihv_autor">
                                                                        <xsl:value-of select="hbfm:autorenkuerzel(concat(firstname, ' ', surname))"/>
                                                                    </div>
                                                                </div>
                                                            </xsl:for-each>
                                                            <div class="ihv_dbnummer" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 5px; text-align: left;">
                                                                <xsl:value-of select="$sp-dbnummer"/>
                                                            </div>
                                                        </a>
                                                    </div>
                                                    <!-\- Ende Level4 -\->
                                                </div>
                                                <!-\- Ende Level3 -\->
                                                <br/>
                                            </xsl:for-each>
                                        </div>
                                    </xsl:if>
                                    <!-\- Ende: Standpunkte -\->
                                </div><xsl:comment>Ende Level 1</xsl:comment>
                            </div>
                        </div>
                    </section>
                </div>
            </body>
        </html>
    </xsl:template>-->
    
    <!--<xsl:template name="listArticles">
        <xsl:param name="self"/>
        <xsl:param name="ueberschrift" as="xs:string"/>
        <xsl:param name="art-nr" as="xs:integer"/>
        
        <xsl:variable name="available-ihv-prio-numbers">
            <xsl:for-each select="$aktuelles-Heft">
                <xsl:variable name="docum" select="document(document-uri(.))"/>
                <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                <xsl:variable name="doctype" select="$docum/*/name()"/>
                <xsl:variable name="ihv-prio-number">
                    <xsl:choose>
                        <xsl:when test="$ressortbez = 'bw'">1</xsl:when>
                        <xsl:when test="$ressortbez = 'sr'">2</xsl:when>
                        <xsl:when test="$ressortbez = 'wr'">3</xsl:when>
                        <xsl:when test="$ressortbez = 'ar'">4</xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$doctype = 'au'">30</xsl:when>
                        <xsl:when test="$doctype = 'kk'">40</xsl:when>
                        <xsl:when test="$doctype = 'va'">50</xsl:when>
                        <xsl:when test="$doctype = 'ent'">60</xsl:when>
                        <xsl:when test="$doctype = 'entk'">60</xsl:when>
                        <xsl:when test="$doctype = 'kb'">65</xsl:when> 
                        <xsl:when test="$doctype = 'nr'">70</xsl:when>
                        <xsl:when test="$doctype = 'ed'">10</xsl:when>
                        <!-\-<xsl:when test="$doctype = 'toc'">0</xsl:when>-\->
                        <xsl:when test="$doctype = 'gk'">20</xsl:when>
                        <!-\-<xsl:when test="$doctype = 'sp'">Standpunkt</xsl:when>-\->
                        <xsl:otherwise>1000</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="$ihv-prio-number"/>
                <xsl:text> / </xsl:text>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:if test="contains($available-ihv-prio-numbers, string($art-nr))">
            
            <div class="ihv_level3">
                <div class="ihv_headline doktyp"><xsl:value-of select="$ueberschrift"/></div>
            
                <!-\- SCHLEIFE ÜBER JEDES XML DOKUMENT -\->
                <xsl:for-each select="$aktuelles-Heft">
                    <xsl:variable name="docum" select="document(document-uri(.))"/>
                    <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                    <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                    <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                    <xsl:variable name="doctype" select="$docum/*/name()"/>
                    <xsl:variable name="ihv-prio-number">
                        <xsl:choose>
                            <xsl:when test="$ressortbez = 'bw'">1</xsl:when>
                            <xsl:when test="$ressortbez = 'sr'">2</xsl:when>
                            <xsl:when test="$ressortbez = 'wr'">3</xsl:when>
                            <xsl:when test="$ressortbez = 'ar'">4</xsl:when>
                            <xsl:otherwise>0</xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="$doctype = 'au'">30</xsl:when>
                            <xsl:when test="$doctype = 'kk'">40</xsl:when>
                            <xsl:when test="$doctype = 'va'">50</xsl:when>
                            <xsl:when test="$doctype = 'ent'">60</xsl:when>
                            <xsl:when test="$doctype = 'entk'">60</xsl:when>
                            <xsl:when test="$doctype = 'kb'">65</xsl:when> 
                            <xsl:when test="$doctype = 'nr'">70</xsl:when>
                            <xsl:when test="$doctype = 'ed'">10</xsl:when>
                            <!-\-<xsl:when test="$doctype = 'toc'">0</xsl:when>-\->
                            <xsl:when test="$doctype = 'gk'">20</xsl:when>
                            <!-\-<xsl:when test="$doctype = 'sp'">Standpunkt</xsl:when>-\->
                            <xsl:otherwise>1000</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:if test="$ihv-prio-number=$art-nr">
                        <xsl:variable name="temp-sid">
                            <xsl:choose>
                                <xsl:when test="ends-with(string($art-nr), '65')">DBL</xsl:when>
                                <xsl:otherwise>DB</xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="$siriusID"/>
                        </xsl:variable>
                        <div class="ihv_level4">
                            <div class="ihv_rubriken">
                                <xsl:for-each select="$docum/*/metadata/rubriken/rubrik">
                                    <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if><xsl:value-of select="."/>
                                </xsl:for-each>
                            </div>
                            <a target="_blank" href="https://research.owlit.de/lx-document/{$temp-sid}">
                                <div class="ihv_headline titel"><xsl:value-of select="/*/metadata/title"/></div>
                                <xsl:choose>
                                    <xsl:when test="/*/metadata/authors/author">
                                        <div class="ihv_autor">
                                            <xsl:for-each select="/*/metadata/authors/author">
                                                <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname, suffix)"/>        
                                            </xsl:for-each>
                                        </div>
                                        <div class="ihv_autornormiert">
                                            <xsl:for-each select="/*/metadata/authors/author">
                                                <div class="ihv_autor">
                                                    <xsl:value-of select="hbfm:autorenkuerzel(concat(firstname, ' ', surname))"/>
                                                </div>
                                            </xsl:for-each>
                                        </div>  
                                    </xsl:when>
                                    <xsl:otherwise/>
                                </xsl:choose>
                                        <div class="ihv_abstract">
                                            <p>
                                                <xsl:if test="$docum/*/metadata/summary">
                                                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                                                    <xsl:value-of select="$docum/*/metadata/summary"/>
                                                    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                                                </xsl:if>
                                            </p>
                                        </div>
                                <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                    <xsl:variable name="startpage" select="$docum/*/metadata/pub/pages/start_page"/>
                                    <xsl:variable name="lastpage" select="$docum/*/metadata/pub/pages/last_page"/>
                                    <xsl:choose>
                                        <xsl:when test="$startpage = $lastpage">
                                            <xsl:value-of select="$startpage"/>, <xsl:value-of select="$temp-sid"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$startpage"/> &#45; <xsl:value-of select="$lastpage"/>, <xsl:value-of select="$temp-sid"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </a>
                        </div><xsl:comment>Ende Level 4</xsl:comment>
                        
                    </xsl:if>
                </xsl:for-each>
            </div><xsl:comment>Ende Level 3</xsl:comment>
        </xsl:if>
    </xsl:template>-->
    
<!--    <xsl:function name="hbfm:autorenkuerzel">
        <xsl:param name="aut-name" as="xs:string"/>
        <xsl:value-of select="lower-case(replace(replace(tokenize($aut-name, ',')[1],'[\.|-]','_'),' ','_'))"/>
    </xsl:function>-->
    
</xsl:stylesheet>