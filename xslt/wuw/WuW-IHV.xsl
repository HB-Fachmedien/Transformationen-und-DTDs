<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/Users/rehberger/Desktop/WuW_03/?recurse=yes;select=*.xml')"/>

    <xsl:template match="/">
        <output>
            <html>
                <head>
                    <meta charset="UTF-8"/>
                </head>


                <body>
                    <div class="content-wrapper">
                        <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                        <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von WIRTSCHAFT UND WETTBEWERB? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der <a href="https://recherche.wuw-online.de/Browse.aspx?level=roex%3abron.Zeitschriften.d4d652b1019840bfac5d28ebd0ec6c9f&amp;title=Wirtschaft%2bund%2bWettbewerb" target="_blank">Bibliothek der Recherche-Datenbank.</a></div>
                        <!-- Linke Spalte -->
                        <section class="left" id="content" style="width:630px">
                            <div class="content-list inhaltsverzeichnis">
                                <div class="content-text">
                                    <div class="ihv_level1">
                                        <div class="ihv_headline">Inhaltsverzeichnis</div>
                                        <div class="ihv_datum">Heft 
                                            <xsl:for-each
                                                select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="/*/metadata/pub/pubedition"/><xsl:text> vom </xsl:text>
                                            <xsl:value-of select="/*/metadata/pub/date"/></xsl:for-each>
                                        </div>

                                        <xsl:if test="$aktuelles-Heft//gk">
                                            <h3>KOMMENTAR</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <div class="ihv_heftnr">
                                                <xsl:value-of select="/metadata/pub/pubedition"/>
                                            </div>
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- KOMMENTAR -->
                                            
                                            <xsl:if test="gk">
                                                <h4>
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
                                                </h4>
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"
                                                />-<xsl:value-of
                                                    select="/*/metadata/pub/pages/last_page"/></p>
                                                <p>
                                                    <xsl:value-of select="/*/gk[@docid]"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>

                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Abhandlung']">
                                            <h3>ABHANDLUNGEN</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <div class="ihv_heftnr">
                                                <xsl:value-of select="/metadata/pub/pubedition"/>
                                            </div>
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                           
                                            <!-- ABHANDLUNGEN -->
                                            
                                            <xsl:if test="$ressortbez='Abhandlung'">
                                                <h4>
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
                                                </h4>
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>
                                                        <xsl:value-of select="/*/metadata/summary/p[not(@lang='en')]"/>
                                                </p>
                                                <p>S. <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"
                                                />-<xsl:value-of
                                                    select="/*/metadata/pub/pages/last_page"/></p>
                                                <p>
                                                    <xsl:value-of select="/*/au[@docid]"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Tagungsbericht']">
                                            <h3>TAGUNGSBERICHT</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                           
                                            <div class="ihv_heftnr">
                                                <xsl:value-of select="/metadata/pub/pubedition"/>
                                            </div>
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            <!-- TAGUNGSBERICHT -->
                                            
                                            <xsl:if test="$ressortbez='Tagungsbericht'">
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"
                                                />-<xsl:value-of
                                                    select="/*/metadata/pub/pages/last_page"/></p>
                                                <p>
                                                    <xsl:value-of select="/*/nr[@docid]"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='International Developments']">
                                            <h3>INTERNATIONAL DEVELOPMENTS</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <div class="ihv_heftnr">
                                                <xsl:value-of select="/metadata/pub/pubedition"/>
                                            </div>
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- INTERNATIONAL DEVELOPMENTS -->
                                            
                                            <xsl:if test="$ressortbez='International Developments'">
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"
                                                />-<xsl:value-of
                                                    select="/*/metadata/pub/pages/last_page"/></p>
                                                <p>
                                                    <xsl:value-of select="/*/nr[@docid]"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//ent">
                                            <h3>ENTSCHEIDUNGEN</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <div class="ihv_heftnr">
                                                <xsl:value-of select="/metadata/pub/pubedition"/>
                                            </div>
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- ENTSCHEIDUNGEN -->
                                            
                                            <xsl:if test="ent">
                                                <h5>
                                                    <i><xsl:value-of select="/*/metadata/instdoc/inst"/><xsl:text>: </xsl:text></i>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"
                                                />-<xsl:value-of
                                                    select="/*/metadata/pub/pages/last_page"/></p>
                                                <p>
                                                    <xsl:value-of select="/*/ent[@docid]"/>
                                                </p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        
                                        <xsl:if test="$aktuelles-Heft//iv">
                                            <h3>INTERVIEW</h3>
                                        </xsl:if>
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <div class="ihv_heftnr">
                                                <xsl:value-of select="/metadata/pub/pubedition"/>
                                            </div>
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- INTERVIEW -->
                                            
                                            <xsl:if test="iv">
                                                <h5>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </h5>
                                                <p>S. <xsl:value-of
                                                    select="/*/metadata/pub/pages/start_page"
                                                />-<xsl:value-of
                                                    select="/*/metadata/pub/pages/last_page"/></p>
                                                <p>
                                                    <xsl:value-of select="/*/iv[@docid]"/>
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
