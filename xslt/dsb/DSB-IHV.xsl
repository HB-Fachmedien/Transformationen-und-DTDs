<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/Users/rehberger/Desktop/DSB_2016_03/?recurse=yes;select=*.xml')"/>
    <xsl:template match="/">
        <output>
            <html>
                <head>
                    <meta charset="UTF-8"/>
                </head>
                <body>
                    <div class="content-wrapper">
                        <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                        <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe des
                            Datenschutz-Berater? Die Übersicht aller in der Datenbank verfügbaren
                            Ausgaben finden Sie in der 
                            <a href="https://recherche.datenschutz-berater.de/Browse.aspx?level=roex%3abron.Zeitschriften.d4d739c3943348e7b3da8a2bc3907319&amp;title=Datenschutz-Berater" target="_blank">Bibliothek der Recherche-Datenbank.</a>
                        </div>
                        <!-- Linke Spalte -->
                        <section class="left" id="content" style="width:630px">
                            <div class="content-list inhaltsverzeichnis">
                                <div class="content-text">
                                    <div class="ihv_level1">
                                        <div class="ihv_headline">Inhaltsverzeichnis</div>
                                        <div class="ihv_datum">Heft 
                                            <xsl:for-each select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="/*/metadata/pub/pubedition"/>
                                                <xsl:text> vom </xsl:text>
                                                <xsl:value-of select="/*/metadata/pub/date" />
                                            </xsl:for-each>
                                        </div>
                                        
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Datenschutz im Fokus']">
                                            <h3>DATENSCHUTZ IM FOKUS</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                            
                                            <!-- DATENSCHUTZ IM FOKUS -->
                                            
                                            <xsl:if test="$ressortbez='Datenschutz im Fokus'">
                                                <h4>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h4>
                                                <h5>
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
                                                </h5>
                                                <p>
                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                </p>
                                                <p>S. 
                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Gesetzgebung aktuell']">
                                            <h3>GESETZGEBUNG AKTUELL</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                            
                                            <!-- GESETZGEBUNG AKTUELL -->
                                            
                                            <xsl:if test="$ressortbez='Gesetzgebung aktuell'">
                                                <h4>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h4>
                                                <h5>
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
                                                </h5>
                                                <p>
                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                </p>
                                                <p>S. 
                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Aktuelles aus den Aufsichtsbehörden']">
                                            <h3>AKTUELLES AUS DEN AUFSICHTSBEHÖRDEN</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        
                                        <xsl:for-each select="$aktuelles-Heft">
                                  
                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                            
                                            <!-- AKTUELLES AUS DEN AUFSICHTSBEHÖRDEN -->
                                            
                                            <xsl:if test="$ressortbez='Aktuelles aus den Aufsichtsbehörden'">
                                                <h4>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h4>
                                                <h5>
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
                                                </h5>
                                                <p>
                                                    <xsl:value-of select="/*/metadata/summary"/>
                                                </p>
                                                <p>S. 
                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//au/metadata/ressort='Rechtsprechung'">
                                            <h3>RECHTSPRECHUNG</h3>
                                        </xsl:if>
                                        
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                            <!-- RECHTSPRECHUNG -->
                                            <xsl:if test="au and $ressortbez='Rechtsprechung'">
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. 
                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        
                                        <xsl:for-each select="$aktuelles-Heft">
                                           
                                            <xsl:variable name="docum" select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                            <!-- RECHTSPRECHUNG -->
                                            <xsl:if test="ent">
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. 
                                                    <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
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
