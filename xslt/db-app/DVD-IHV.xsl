<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0"
    xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
    
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
                                 
                                 <!-- BW -->   
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
                                        
                                        <xsl:if test="output/DOKUMENT/ihv-prio-number[text()='170']/../SEITEVON[not(starts-with(text(),'M'))]">
                                            <xsl:call-template name="listArticles">
                                                <xsl:with-param name="self" select="./node()"/>
                                                <xsl:with-param name="ueberschrift" select="'Betriebswirtschaftliche Hinweise'"/>
                                                <xsl:with-param name="art-nr" select="170"/>
                                            </xsl:call-template>
                                        </xsl:if>
                                        
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
                                            <xsl:with-param name="ueberschrift" select="'Entscheidungen'"/>
                                            <xsl:with-param name="art-nr" select="360"/>
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
                                            <xsl:with-param name="ueberschrift" select="'Entscheidungen'"/>
                                            <xsl:with-param name="art-nr" select="460"/>
                                        </xsl:call-template>
                                        
                                    </div><xsl:comment>Ende Level 2</xsl:comment>
                                    
                                </div><xsl:comment>Ende Level 1</xsl:comment>
                                
                            </div>
                        </div>
                        
                    </section>
                </div>
            </body>
        </html>
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
                    
                    <xsl:choose>
                        <xsl:when test="$art-nr=170 and starts-with(SEITEVON/text(),'M')"/>
                        <xsl:otherwise>
                         
                    <xsl:variable name="temp-sid">
                        <xsl:call-template name="calculateDocId">
                            <xsl:with-param name="id" select="SIRIUS-ID"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <div class="ihv_level4">
                        <div class="ihv_rubriken">
                            <xsl:value-of select="HAUPTRUBRIK/UNTERRUBRIK"/>
                        </div>
                        
                        
                        <a href="https://recherche.der-betrieb.de/document.aspx?docid=DB{$temp-sid}">
                        <div class="ihv_headline titel">
                                <xsl:value-of disable-output-escaping="yes" select="TITEL"/>
                        </div>
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
                        <div class="ihv_abstract"><xsl:value-of select="VORSPANN"/></div>
                        <div class="ihv_seite" style="font-style: italic; padding-bottom: 5px; padding-right: 5px; color: #666666; margin-bottom: 30px; text-align: left;">
                            <xsl:choose>
                                <xsl:when test="SEITEVON = SEITEBIS">
                                    <xsl:value-of select="SEITEVON"/>, DB<xsl:value-of select="$temp-sid"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="SEITEVON"/> - <xsl:value-of select="SEITEBIS"/>, DB<xsl:value-of select="$temp-sid"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                        </a>
                    </div><xsl:comment>Ende Level 4</xsl:comment>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </div><xsl:comment>Ende Level 3</xsl:comment>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
    
   
</xsl:stylesheet>
