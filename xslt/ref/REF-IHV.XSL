<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="aktuelles-Heft" select="collection(iri-to-uri('file:/c:/tempREF/?recurse=yes;select=*_[A-Z].xml'))"/>
    <xsl:output method="xhtml" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <!--  <xsl:result-document exclude-result-prefixes="#all" indent="no" href="file:///z:/Duesseldorf/Fachverlag/Fachbereiche/Pool/eShop_innochange/EasyProduct/Daten/1000/Export/Inhaltsverzeichnis/REF-IHV.html" method="xhtml" omit-xml-declaration="yes"> -->
        <html>
            <head>
                <meta charset="UTF-8"/>
                <link media="screen" type="text/css" href="http://beta.der-betrieb.de/wp-content/themes/Der-Betrieb/style.css" rel="stylesheet"/>
                <style> 
                    </style>
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
                                                        <a target="_blank" href="https://research.owlit.de/lx-document/REF{$siriusID}" title="{$ti}">                  
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
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>REF</xsl:text>
                                                                        <xsl:value-of select="$siriusID"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
																		<xsl:text>REF vom </xsl:text> 
																	<xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" />,
																	<xsl:text>Heft </xsl:text> 
																	<xsl:value-of select="/*/metadata/pub/pubedition"/>,  
																	<xsl:text> Seite </xsl:text> 
                                                                        <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; 
																		<xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>REF</xsl:text><xsl:value-of select="$siriusID"/> 
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
