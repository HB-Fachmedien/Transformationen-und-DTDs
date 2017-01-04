<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output encoding="UTF-8" indent="no" method="xhtml" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <!--<xsl:result-document exclude-result-prefixes="#all" indent="no" href="file:///z:/Duesseldorf/Fachverlag/Fachbereiche/Pool/eShop_innochange/EasyProduct/Daten/1000/Export/Inhaltsverzeichnis/DB-IHV.html" method="xhtml" omit-xml-declaration="yes">-->
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
                        }
                    </style>
                </head>
                <body>
                    <div class="content-wrapper">
                        <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                        <!-- Linke Spalte -->
                        <section class="left" id="content" style="width:630px">
                            <div class="content-list inhaltsverzeichnis">
                                <div class="content-text">
                                    <div class="ihv_level1">
                                        <div class="ihv_headline">Inhaltsverzeichnis</div>
                                        <div class="ihv_heftnr">
                                            <xsl:value-of select="/output/@nr"/>
                                        </div>
                                        <div class="ihv_datum">
                                            <xsl:value-of
                                                select="format-date(output/@pubdatum, '[D].[M].[Y]')"/>
                                        </div>
                                        <!--<div class="ihv_datum"> <xsl:value-of select="format-dateTime(current-dateTime(), '[D]. [M]. [Y]')"/></div>-->
                                        
                                        <!-- Editorial -->
                                        <xsl:variable name="editorial-dokument"
                                            select="output/DOKUMENT[DOCTYPGROUPBEZ='Editorial']"/>
                                        <xsl:variable name="editorial-dbnummer">
                                            <xsl:call-template name="calculateDocId">
                                                <xsl:with-param name="id" select="$editorial-dokument/SIRIUS-ID"/>
                                            </xsl:call-template>
                                        </xsl:variable>
                                        
                                        <div class="ihv_level2">
                                            <div class="ihv_headline ressort" style="margin-bottom: 5px;">Editorial</div>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <a target="_blank"  href="https://recherche.der-betrieb.de/document.aspx?docid=DB{$editorial-dbnummer}">
                                                    <div class="ihv_headline titel">
                                                            <xsl:value-of disable-output-escaping="yes" select="$editorial-dokument/TITEL"/>
                                                    </div>
                                                    <div class="ihv_autor">
                                                        <xsl:value-of select="$editorial-dokument/AUTOR"/>
                                                    </div>
                                                    <xsl:for-each select="$editorial-dokument/AUTOR">
                                                        <div class="ihv_autornormiert">
                                                            <div class="ihv_autor">
                                                                <xsl:value-of select="hbfm:autorenkuerzel(.)"/>
                                                            </div>
                                                            <!-- Überprüfen, ob das so passt -->
                                                        </div>
                                                    </xsl:for-each>
                                                    <!-- TODO: Aus Autoren Feld ziehen -->
                                                        <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">M1, DB<xsl:value-of select="$editorial-dbnummer"/>
                                                    </div>
                                                    </a>
                                                </div>
                                                <!-- Ende Level4 -->
                                            </div>
                                            <!-- Ende Level3 -->
                                        </div>
                                        <!-- Ende Level2 - Editorial -->
                                        <!-- Ende: Editorial -->
                                        
                                        <!-- Gastkommentar -->
                                        <xsl:variable name="gk-dokument"
                                            select="output/DOKUMENT[DOCTYPGROUPBEZ='Gastkommentar' and starts-with(SEITEVON/text(), 'M')]"/>
                                        <xsl:variable name="gk-dbnummer">
                                            <xsl:call-template name="calculateDocId">
                                                <xsl:with-param name="id" select="$gk-dokument/SIRIUS-ID"/>
                                            </xsl:call-template>
                                        </xsl:variable>
                                        
                                        <div class="ihv_level2">
                                            <div class="ihv_headline ressort" style="margin-bottom: 5px;">Gastkommentar</div>
                                            <!-- GK KANN WOMÖGLICH AUCH VON MEHREREN AUTOREN GESCHRIEBEN WERDEN -->
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    <a target="_blank" href="https://recherche.der-betrieb.de/document.aspx?docid=DB{$gk-dbnummer}">
                                                    <div class="ihv_headline titel">
                                                        <xsl:value-of disable-output-escaping="yes" select="$gk-dokument/TITEL"/>
                                                    </div>
                                                    <div class="ihv_autor">
                                                        <!--<xsl:value-of select="$gk-dokument/AUTOR"/>-->
                                                        <xsl:value-of select="replace(replace($gk-dokument/AUTORENZEILE,'&lt;A.*?&gt;',''),'&lt;/A&gt;','')" disable-output-escaping="yes"/>
                                                    </div>
                                                    <xsl:for-each select="$gk-dokument/AUTOR">
                                                        <div class="ihv_autornormiert">
                                                            <div class="ihv_autor">
                                                                <xsl:value-of select="hbfm:autorenkuerzel(.)"/>
                                                            </div>
                                                            <!-- Überprüfen, ob das so passt -->
                                                        </div>
                                                    </xsl:for-each>
                                                        <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                                            M5, DB<xsl:value-of select="$gk-dbnummer"/>
                                                    </div>
                                                    </a>
                                                </div>
                                                <!-- Ende Level4 -->
                                                
                                            </div>
                                            <!-- Ende Level3 -->
                                            
                                        </div>
                                        <!-- Ende Level2 - Gastkommentar -->
                                        
                                        <div class="ihv_level2">
                                            <div class="ihv_headline ressort" style="margin-bottom: 5px;">Betriebswirtschaft</div>
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
                                        </div><xsl:comment>Ende Level 2</xsl:comment>
                                        
                                        <div class="ihv_level2">
                                            <div class="ihv_headline ressort" style="margin-bottom: 5px;">Steuerrecht</div>
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
                                        </div><xsl:comment>Ende Level 2</xsl:comment>
                                        
                                        <div class="ihv_level2">
                                            <div class="ihv_headline ressort" style="margin-bottom: 5px;">Wirtschaftsrecht</div>
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
                                        </div><xsl:comment>Ende Level 2</xsl:comment>
                                        
                                        <div class="ihv_level2">
                                            <div class="ihv_headline ressort" style="margin-bottom: 5px;">Arbeitsrecht</div>
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
                                        </div><xsl:comment>Ende Level 2</xsl:comment>
                                        
                                        <!-- Standpunkte -->
                                        <xsl:variable name="anzahl-standpunkte" select="count(output/DOKUMENT[DOCTYPGROUPBEZ='Standpunkt'])"/>
                                        <xsl:if test="$anzahl-standpunkte&gt;0">
                                                                                  
                                            <div class="ihv_level2">
                                                <div class="ihv_headline ressort" style="margin-bottom: 5px;">Standpunkt<xsl:if test="$anzahl-standpunkte&gt;1">e</xsl:if></div>
                                                
                                                <xsl:for-each select="output/DOKUMENT[DOCTYPGROUPBEZ='Standpunkt']">
                                                    
                                                    
                                                    <xsl:variable name="sp-dokument"
                                                        select="."/>
                                                    <xsl:variable name="sp-dbnummer">
                                                        <xsl:call-template name="calculateDocId">
                                                            <xsl:with-param name="id" select="$sp-dokument/SIRIUS-ID"/>
                                                        </xsl:call-template>
                                                    </xsl:variable>
                                                                                                  
                                                    <!-- SP KANN WOMÖGLICH AUCH VON MEHREREN AUTOREN GESCHRIEBEN WERDEN -->
                                                    <div class="ihv_level3">
                                                        <div class="ihv_level4">
                                                            <a target="_blank" href="https://recherche.der-betrieb.de/document.aspx?docid=DB{$sp-dbnummer}">
                                                            <div class="ihv_headline titel">
                                                                <xsl:value-of disable-output-escaping="yes" select="$sp-dokument/TITEL"/>
                                                            </div>
                                                                                                                 
                                                            <div class="ihv_autor">
                                                                <!--<xsl:value-of select="$gk-dokument/AUTOR"/>-->
                                                                <xsl:value-of select="replace(replace(AUTORENZEILE,'&lt;A.*?&gt;',''),'&lt;/A&gt;','')" disable-output-escaping="yes"/>
                                                            </div>
                                                            <xsl:for-each select="AUTOR">
                                                                <div class="ihv_autornormiert">
                                                                    <div class="ihv_autor">
                                                                        <xsl:value-of select="hbfm:autorenkuerzel(.)"/>
                                                                    </div>
                                                                    <!-- Überprüfen, ob das so passt -->
                                                                </div>
                                                            </xsl:for-each>
                                                                <div class="ihv_dbnummer" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 5px; text-align: left;">
                                                                    <xsl:value-of select="$sp-dbnummer"/>
                                                            </div>
                                                            </a>
                                                        </div>
                                                        <!-- Ende Level4 -->
                                                        
                                                    </div>
                                                    <!-- Ende Level3 -->
                                                    
                                                    <br/>
                                                </xsl:for-each>
                                                
                                            </div>
                                        </xsl:if>
                                        <!-- Ende: Standpunkte -->
                                        
                                    </div><xsl:comment>Ende Level 1</xsl:comment>
                                    
                                </div>
                            </div>
                            
                        </section>
                    </div>
                </body>
            </html>
        <!--</xsl:result-document>-->
    </xsl:template>
    
    <xsl:function name="hbfm:autorenkuerzel">
        <xsl:param name="aut-name" as="xs:string"/>
        <xsl:value-of select="lower-case(replace(replace(tokenize($aut-name, ',')[1],'[\.|-]','_'),' ','_'))"/>
    </xsl:function>
    
    <xsl:template name="listArticles">
        <xsl:param name="self"/>
        <xsl:param name="ueberschrift" as="xs:string"/>
        <xsl:param name="art-nr" as="xs:integer"/>
        
        <xsl:variable name="dokumente" select="$self/DOKUMENT[ihv-prio-number=$art-nr]"/>
        <xsl:if test="not(empty($dokumente))">
            <div class="ihv_level3">
                <div class="ihv_headline doktyp"><xsl:value-of select="$ueberschrift"/></div>
                <xsl:for-each select="$dokumente"> 
                    <xsl:variable name="temp-sid">
                        <xsl:call-template name="calculateDocId">
                            <xsl:with-param name="id" select="SIRIUS-ID"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <div class="ihv_level4">
                        <div class="ihv_rubriken">
                            <xsl:value-of select="HAUPTRUBRIK/UNTERRUBRIK"/>
                        </div>
                        
                        <a target="_blank" href="https://recherche.der-betrieb.de/document.aspx?docid=DB{$temp-sid}">
                        <div class="ihv_headline titel">
                            <xsl:value-of disable-output-escaping="yes" select="TITEL"/>
                        </div>
                            <xsl:choose>
                                <xsl:when test="AUTOR">
                                    <div class="ihv_autor">
                                        <xsl:value-of select="replace(replace(AUTORENZEILE,'&lt;A.*?&gt;',''),'&lt;/A&gt;','')" disable-output-escaping="yes"/>
                                    </div>
                                    <div class="ihv_autornormiert">
                                        <xsl:for-each select="AUTOR">
                                            <div class="ihv_autor">
                                                <xsl:value-of select="hbfm:autorenkuerzel(.)"/>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                            <!-- <div class="ihv_autor">
                            <xsl:value-of select="replace(replace(AUTORENZEILE,'&lt;A.*?&gt;',''),'&lt;/A&gt;','')" disable-output-escaping="yes"/>
                        </div> -->
                        
                        <xsl:choose>
                            <xsl:when test="VORSPANN">
                                <div class="ihv_abstract"><xsl:value-of select="VORSPANN" disable-output-escaping="yes"/></div>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                            <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                                <xsl:choose>
                                    <xsl:when test="SEITEVON = SEITEBIS">
                                        <xsl:value-of select="SEITEVON"/>, DB<xsl:value-of select="$temp-sid"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="SEITEVON"/> &#x2011; <xsl:value-of select="SEITEBIS"/>, DB<xsl:value-of select="$temp-sid"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                        </div>
                        </a>
                    </div><xsl:comment>Ende Level 4</xsl:comment>
                </xsl:for-each>
            </div><xsl:comment>Ende Level 3</xsl:comment>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
    
    
</xsl:stylesheet>