<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="aktuelles-Heft" select="collection(iri-to-uri('file:/c:/tempZOE/?recurse=yes;select=*_[A-Z].xml'))"/>
    <xsl:output method="xhtml" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <!--  <xsl:result-document exclude-result-prefixes="#all" indent="no" href="file:///z:/Duesseldorf/Fachverlag/Fachbereiche/Pool/eShop_innochange/EasyProduct/Daten/1000/Export/Inhaltsverzeichnis/ZOE-IHV.html" method="xhtml" omit-xml-declaration="yes"> -->
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
                        <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von
                            OrganisationsEntwicklung? 
                            
                            <a href="https://www.zoe-online.org/zeitschrift/fruehere-ausgaben/" target="_blank">
                                <u>Hier finden Sie eine Übersicht aller früheren
                                    Ausgaben.</u>
                            </a>
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
                                        <!-- style="border-bottom:#ee7000" -->
                                        <div class="ihv_level2">
                                            <!-- FOR EACH GROUP ÜBER ALLE DOKUMENTE, GRUPPIERT NACH DOCTYPE-->
                                            <xsl:for-each-group select="$aktuelles-Heft" group-by="/*/metadata/ressort">
                                                
                                                <!-- <xsl:sort select="*/metadata/pub/pages/start_page[1]" data-type="number" order="ascending"/> -->
                                                
                                                  <!--<xsl:perform-sort select="*/metadata/pub/pages/start_page">-->
                                                      <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                                <!--</xsl:perform-sort>-->
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'Reflexion'">
                                                        <div id="reflx" class="ihv_headline ressort" style="margin-bottom: 5px;">Reflexion</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Gespräch'">
                                                        <div id="gesp" class="ihv_headline ressort" style="margin-bottom: 5px;">Gespräch</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Erfahrung'">
                                                        <div id="erf" class="ihv_headline ressort" style="margin-bottom: 5px;">Erfahrung</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Einblick'">
                                                        <div id="einbck" class="ihv_headline ressort" style="margin-bottom: 5px;">Einblick</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Fallklinik'">
                                                        <div id="fallk" class="ihv_headline ressort" style="margin-bottom: 5px;">Fallklinik</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Werkzeugkiste'">
                                                        <div id="wek" class="ihv_headline ressort" style="margin-bottom: 5px;">Werkzeugkiste</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Klassiker'">
                                                        <div id="kls" class="ihv_headline ressort" style="margin-bottom: 5px;">Klassiker</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Recht'">
                                                        <div id="recht" class="ihv_headline ressort" style="margin-bottom: 5px;">Recht</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Basiswissen'">
                                                        <div id="bawis" class="ihv_headline ressort" style="margin-bottom: 5px;">Basiswissen</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Perspektiven'">
                                                        <div id="persp" class="ihv_headline ressort" style="margin-bottom: 5px;">Perspektiven</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Bücher'">
                                                        <div id="book" class="ihv_headline ressort" style="margin-bottom: 5px;">Bücher</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Ortmanns Ordnung'">
                                                        <div id="ortord" class="ihv_headline ressort" style="margin-bottom: 5px;">Ortmanns Ordnung</div>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <div class="ihv_headline ressort" style="margin-bottom: 5px;">[ 
                                                            
                                                            <xsl:value-of select="/*/metadata/ressort/text()"/> ]
                                                            
                                                        </div>
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
                                                            <a target="_blank" href="https://zoe-online.owlit.de/document.aspx?docid=ZOE{$siriusID}">
                                                                <div>
                                                                    <xsl:attribute name="class">
                                                                        <xsl:text>ihv_headline titel </xsl:text>
                                                                        <xsl:if test="*/metadata/rubriken/rubrik/text()='Schwerpunkt'">
                                                                            <xsl:text>schwerpunkt</xsl:text>
                                                                        </xsl:if>
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                        <xsl:if test="/*/metadata/ressort/text()=('Ortmanns Ordnung' , 'Klassiker' , 'Werkzeugkiste')">
                                                                            <xsl:text>: </xsl:text><xsl:value-of select="/*/metadata/subtitle"/>
                                                                        </xsl:if>
                                                                       
                                                                    
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
                                                                <div class="ihv_seite" style="font-style: italic; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                                                    <xsl:choose>
                                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>ZOE</xsl:text>
                                                                            <xsl:value-of select="$siriusID"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>ZOE</xsl:text>
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
        
            <!--   </xsl:result-document> -->
    </xsl:template>
</xsl:stylesheet>
