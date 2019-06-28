<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="aktuelles-Heft" select="collection(iri-to-uri('file:/c:/tempREL/?recurse=yes;select=*_[A-Z].xml'))"/>
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
					
					.ihv_abstract{
					line-height:17.5px !important;
					}
					#content{
					width: 100% !important;
					}
					#content_innen{
					display: inline !important;
					}
					.ihv_datum{
					font-weight: bold;
					}
					.ihv_heftnr{
					font-weight: bold;
					}
					.ihv_headline ressort{
					margin-bottom: 5px;
					font-weight: bold; 
					}
					.ihv_seite{
					font-style: italic;
					padding-right: 5px;
					color: #666666;
					margin-bottom: 30px;
					text-align: left;
					}
					.pagehead.small{
					line-height: 0.8;
					}
					
                    .ihv_datum{
                    border-bottom: 2px solid #00abd6 !important;
                    }
                    .ihv_headline{
                    font-weight:bold !important;
                    }
                    .ihv_seite,
                    .ihv_dbnummer{
                    text-align:right;
                    padding:0px;
                    }</style>
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
                                <p><xsl:value-of select="substring($temp, 1, 400)"/>...<a target="_blank" style="text-decoration: none; color: #4db36c;" href="https://rethinking-law.owlit.de/document.aspx?docid=REL{$siriusID}"><xsl:text>[Weiterlesen]</xsl:text> </a></p>
							</div>
                            <xsl:if test="matches('/*/body/p/text()','Seite\s\d{1,3}')">
                                <a target="_blank" href="https://rethinking-law.owlit.de/document.aspx?docid=REL{$siriusID}">Seite X </a> <!-- hier noch seite ersetzen -->
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
                                                        <a target="_blank" style="text-decoration: none;" href="https://rethinking-law.owlit.de/document.aspx?docid=REL{$siriusID}">
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
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>REL</xsl:text>
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
