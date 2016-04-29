<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="aktuelles-Heft" select="collection(iri-to-uri('file:///c:/Users/rehberger/Desktop/ZOE_2016_02/?recurse=yes;select=*_[A-Z].xml'))"/>
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
                                                
                                                  <xsl:perform-sort select="*/metadata/pub/pages/start_page">
                                                      <xsl:sort select="start_page" data-type="number" order="ascending"/>
                                                </xsl:perform-sort>
                                                
                                                <xsl:choose>
                                                    <xsl:when test="current-grouping-key() = 'Reflexion'">
                                                        <div class="ihv_headline ressort">Reflexion</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Gespräch'">
                                                        <div class="ihv_headline ressort">Gespräch</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Erfahrung'">
                                                        <div class="ihv_headline ressort">Erfahrung</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Einblick'">
                                                        <div class="ihv_headline ressort">Einblick</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Fallklinik'">
                                                        <div class="ihv_headline ressort">Fallklinik</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Werkzeugkiste'">
                                                        <div class="ihv_headline ressort" >Werkzeugkiste</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Klassiker'">
                                                        <div class="ihv_headline ressort">Klassiker</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Recht'">
                                                        <div class="ihv_headline ressort">Recht</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Basiswissen'">
                                                        <div class="ihv_headline ressort" >Basiswissen</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Perspektiven'">
                                                        <div class="ihv_headline ressort" >Perspektiven</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Bücher'">
                                                        <div class="ihv_headline ressort">Bücher</div>
                                                    </xsl:when>
                                                    <xsl:when test="current-grouping-key() = 'Ortmanns Ordnung'">
                                                        <div class="ihv_headline ressort">Ortmanns
                                                            Ordnung</div>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <div class="ihv_headline ressort">[ 
                                                            
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
                                                            <a href="https://recherche.zoe-online.org/document.aspx?docid=ZOE{$siriusID}">
                                                                <div>
                                                                    <xsl:attribute name="class">
                                                                        <xsl:text>ihv_headline titel </xsl:text>
                                                                        <xsl:if test="*/metadata/rubriken/rubrik/text()='Schwerpunkt'">
                                                                            <xsl:text>schwerpunkt</xsl:text>
                                                                        </xsl:if>
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </div>
                                                                <div class="ihv_autor">
                                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                                        <xsl:choose>
                                                                            <xsl:when test="position()=1">
                                                                                <xsl:value-of select="prefix"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="firstname"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                                            </xsl:when>
                                                                            <xsl:when test="position()=last()">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="prefix"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="firstname"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="prefix"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="firstname"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:for-each>
                                                                </div>
                                                                <p>
                                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                                </p>
                                                                <p>S. 
                                                                    
                                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                                </p>
                                                                <p>
                                                                    <a href="https://recherche.zoe-online.org/document.aspx?docid=ZOE{$siriusID}" >ZOE
                                                                        
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </a>
                                                                </p>
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
        </output>
    </xsl:template>
</xsl:stylesheet>
