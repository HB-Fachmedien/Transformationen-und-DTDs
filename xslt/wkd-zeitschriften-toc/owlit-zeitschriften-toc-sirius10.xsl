<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0" xmlns:hbfm="http:www.fachmedien.de/hbfm">

    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="no" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE" doctype-system="hbfm.dtd"/>
    
    <xsl:param name="input_path" select="'c:/tempInputTOC'"/>
    <xsl:param name="output_path" select="'c:/tempOutputTOC/'"/>
    
    <xsl:template name="create_shortened_summary">
        <!-- Kürzt die Beschreibung auf ungefähr mind 40 Wörter bis zum nächsten Satzende. 
         Die Wortgrenze liegt bei 49, wegen den Whitespaces zwischen den XML Elementen. Zumindest bei CF ist das so.
        -->
        <xsl:param name="knoten"/>
        <xsl:variable name="WORTGRENZE" select="49" as="xs:integer"/>

        <xsl:variable name="beschreibung">
            <xsl:variable name="summary-word-list" select="tokenize($knoten/metadata/summary/p[not(@lang='en')][1], ' ')"/>
            <xsl:choose>
                <xsl:when test="count($summary-word-list) &lt;= $WORTGRENZE">
                    <xsl:value-of select="normalize-space($knoten/metadata/summary/p[not(@lang='en')][1])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="text_vor_wortgrenze">
                        <xsl:for-each select="1 to $WORTGRENZE">
                            <xsl:value-of select="$summary-word-list[current()]"/>
                            <xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="text_nach_wortgrenze">
                        <!--<xsl:value-of select="tokenize($knoten/metadata/summary, '[.!?]')"/>-->
                        <xsl:for-each select="$WORTGRENZE+1 to count($summary-word-list)">
                            <xsl:value-of select="$summary-word-list[current()]"/>
                            <xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="concat(normalize-space($text_vor_wortgrenze), ' ', normalize-space(substring-before($text_nach_wortgrenze, '.')), '.', codepoints-to-string(160),'[', codepoints-to-string(8230), ']')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <p class="ihv_summary">
            <xsl:value-of select="$beschreibung"/>
        </p>
    </xsl:template>

    <xsl:template name="main" match="/">      
        <xsl:variable name="src-documents-location" select="iri-to-uri(concat('file:///', $input_path, '/?recurse=yes;select=*.xml'))"/>
        <xsl:variable name="alle_xmls" select="collection($src-documents-location)"/>
        <xsl:for-each-group select="$alle_xmls/*" group-by="metadata/all_source[@level='2']/text()">
            <xsl:variable name="pubabbr" select="current-grouping-key()"/>
            <xsl:for-each-group select="current-group()" group-by="metadata/pub/pubyear">
                <xsl:variable name="pubyr" select="current-grouping-key()"/>
                <xsl:for-each-group select="current-group()" group-by="metadata/pub/pubedition">
                    <xsl:variable name="pubed" select="current-grouping-key()"/>

                    <xsl:variable name="aktuelles-Heft" select="current-group()"/>
                    <xsl:variable name="erstes-dokument" select="$aktuelles-Heft[1]"/>
                    <xsl:variable name="pubtitle" select="$erstes-dokument/metadata/pub/pubtitle"/>
                    <xsl:variable name="pubdate" select="$erstes-dokument/metadata/pub/date"/>
                    
                    <xsl:result-document method="xml" href="file:///{$output_path}{upper-case($pubabbr)}_{$pubyr}_{$pubed}_TOC.xml">
                        <toc docid="{$pubabbr}_{$pubyr}_{$pubed}_toc">
                            <metadata>
                                <title>
                                    <xsl:text>Inhaltsverzeichnis</xsl:text>
                                </title>
                                <subtitle><b>
                                    <xsl:value-of select="$pubtitle"/>
                                    <xsl:text>&#x20;</xsl:text>
                                    <xsl:value-of select="$pubed"/>
                                    <xsl:text>/</xsl:text>
                                    <xsl:value-of select="$pubyr"/>
                                </b></subtitle>
                                <pub>
                                    <pubtitle>
                                        <xsl:value-of select="$pubtitle"/>
                                    </pubtitle>
                                    <pubabbr>
                                        <xsl:value-of select="upper-case($pubabbr)"/>
                                    </pubabbr>
                                    <pubyear>
                                        <xsl:value-of select="$pubyr"/>
                                    </pubyear>
                                    <pubedition>
                                        <xsl:value-of select="$pubed"/>
                                    </pubedition>
                                    <date>
                                        <xsl:value-of select="$pubdate"/>
                                    </date>
                                    <pages>
                                        <start_page/>
                                        <!-- Hier immer die Heftseite aus dem Print nehmen -->
                                        <!-- dafür hier eine Mappingtabelle? -->
                                        <article_order>1</article_order>
                                    </pages>
                                    <public value="true"/>
                                </pub>
                                <all_doc_type level="1">zs</all_doc_type>
                                <all_source level="1">zsa</all_source>
                                <all_source level="2">
                                    <xsl:value-of select="$pubabbr"/>
                                </all_source>
                            
                            </metadata>
                            <body>
                                <!-- 1. Zunächst obene alle Editorials und Gastkommentare darstellen: -->
                                <xsl:for-each select="$aktuelles-Heft[name()=('ed', 'gk')]">
                                    <xsl:choose>
                                        <xsl:when test="name() = 'ed'">
                                            <section>
                                                <title>Editorial</title>
                                                <table frame="void" rules="none">
                                                    <tbody>
                                                        <xsl:call-template name="print-entry">
                                                            <xsl:with-param name="knoten" select="."/>
                                                        </xsl:call-template>
                                                    </tbody>
                                                </table>
                                            </section>
                                        </xsl:when>
                                        <xsl:when test="name() = 'gk' and not(./metadata/all_source[@level='2']/text()='zau')">
                                            <section>
                                                <title>Gastkommentar</title>
                                                <table frame="void" rules="none">
                                                    <tbody>
                                                        <xsl:call-template name="print-entry">
                                                            <xsl:with-param name="knoten" select="."/>
                                                        </xsl:call-template>
                                                    </tbody>
                                                </table>
                                            </section>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                                
                                <!-- 1.b)Aufsätze für KoR haben kein Ressort: -->
                                <xsl:if test="$aktuelles-Heft[metadata/all_source[@level='2']/text()='kor']">
                                    <section>
                                        <title>Aufsätze</title>
                                        <xsl:for-each select="$aktuelles-Heft/au[not(name()=('toc','ed', 'gk'))][not(metadata/coll_title)][not(metadata/ressort)]">
                                            <!--<xsl:sort select="number(replace(metadata/pub/pages/start_page/text(), 'M', ''))"/>-->
                                            <table frame="void" rules="none">
                                                <tbody>
                                                    <xsl:for-each select="/*">
                                                        <xsl:call-template name="print-entry">
                                                            <xsl:with-param name="knoten" select="."/>
                                                        </xsl:call-template>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                            
                                        </xsl:for-each>
                                    </section>
                                </xsl:if>
                                
                                <!-- 2. Danach alle Ressort gruppierten Beiträge: -->
                                <xsl:for-each-group select="$aktuelles-Heft[not(name()=('toc','ed','gk'))][metadata/ressort][not(metadata/all_source[@level='2']/text()='zau') and not(starts-with(metadata/pub/pages/start_page/text(), 'M'))][not(metadata/coll_title)]" group-by="descendant::metadata/ressort">
                                    <xsl:variable name="ressort-ueberschrift">
                                        <xsl:choose>
                                            <xsl:when test="current-grouping-key() = ''">Aufsätze</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'sr'">Steuerrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'wr'">Wirtschaftsrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'ar'">Arbeitsrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'bw'">Betriebswirtschaft</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'kr'">Konzernrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'br'">Rechnungslegung/Corporate Governance</xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="current-grouping-key()"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <section>
                                        <title>
                                            <xsl:value-of select="$ressort-ueberschrift"/>
                                        </title>
                                        <xsl:for-each select="current-group()">
                                            <table frame="void" rules="none">
                                                <tbody>
                                                    <xsl:for-each select="/*">
                                                        <xsl:call-template name="print-entry">
                                                            <xsl:with-param name="knoten" select="."/>
                                                        </xsl:call-template>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                        </xsl:for-each>
                                    </section>
                                </xsl:for-each-group>
                                    
                                <!-- bei ZAU die Gastkommentare mit in das Ressort nehmen, nicht außerhalb -->
                                <xsl:for-each-group select="$aktuelles-Heft[not(name()=('toc','ed'))][metadata/ressort][metadata/all_source[@level='2']/text()='zau' and not(starts-with(metadata/pub/pages/start_page/text(), 'M'))][not(metadata/coll_title)]" group-by="descendant::metadata/ressort">
                                    <xsl:variable name="ressort-ueberschrift">
                                        <xsl:choose>
                                            <xsl:when test="current-grouping-key() = ''">Aufsätze</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'sr'">Steuerrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'wr'">Wirtschaftsrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'ar'">Arbeitsrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'bw'">Betriebswirtschaft</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'kr'">Konzernrecht</xsl:when>
                                            <xsl:when test="current-grouping-key() = 'br'">Rechnungslegung/Corporate Governance</xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="current-grouping-key()"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <section>
                                        <title>
                                            <xsl:value-of select="$ressort-ueberschrift"/>
                                        </title>
                                        <xsl:for-each select="current-group()">
                                            <table frame="void" rules="none">
                                                <tbody>
                                                    <xsl:for-each select="/*">
                                                        <xsl:call-template name="print-entry">
                                                            <xsl:with-param name="knoten" select="."/>
                                                        </xsl:call-template>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                        </xsl:for-each>
                                    </section>
                                </xsl:for-each-group>
                                
                                <!-- 2.b) Magazinteil für DB -->
                                <xsl:if test="$aktuelles-Heft[metadata/all_source[@level='2']/text()='db']">
                                    <section>
                                        <title>Weitere Magazin-Inhalte</title>
                                        <xsl:for-each select="$aktuelles-Heft[not(name()=('toc','ed', 'gk'))][metadata/all_source[@level='2']/text()='db' and starts-with(metadata/pub/pages/start_page/text(), 'M')][not(metadata/coll_title)]">
                                            <xsl:sort select="number(replace(metadata/pub/pages/start_page/text(), 'M', ''))"/>
                                            <table frame="void" rules="none">
                                                <tbody>
                                                    <xsl:for-each select="/*">
                                                        <xsl:call-template name="print-entry">
                                                            <xsl:with-param name="knoten" select="."/>
                                                            <xsl:with-param name="mantelteil" select="'yes'"/>
                                                        </xsl:call-template>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                            
                                        </xsl:for-each>
                                    </section>
                                </xsl:if>
                                
                                
                                <!-- 3. Letztendlich der Rest, der keine Ressorts hat: -->
                                <xsl:if test="$aktuelles-Heft[not(metadata/ressort)][not(name()=('ed', 'gk', 'toc'))][not(metadata/all_source[@level='2']/text()='kor')][not(metadata/coll_title)]">
                                    
                                    <!-- TODO DAS HIER IST BISHER NUR FÜR WUW GETESTET, KOR UND ANDERE DOCTYP-OHNE-RESSORT Magazine müssen noch getestet werden: -->
                                    <xsl:for-each-group select="$aktuelles-Heft[not(metadata/ressort)][not(name()=('ed', 'gk', 'toc'))]" group-by="./name()">
                                        
                                        <xsl:variable name="ressort-ueberschrift">
                                            <xsl:choose>
                                                <xsl:when test="current-grouping-key() = 'ent'">Entscheidungen</xsl:when>
                                                <xsl:when test="current-grouping-key() = 'iv'">Interview</xsl:when>
                                                <xsl:when test="current-grouping-key() = 'rez'">Literatur</xsl:when>
                                                <!--<xsl:when test="current-grouping-key() = 'wr'">Wirtschaftsrecht</xsl:when>
                                    
                                    <xsl:when test="current-grouping-key() = 'bw'">Betriebswirtschaft</xsl:when>
                                    <xsl:when test="current-grouping-key() = 'kr'">Konzernrecht</xsl:when>
                                    <xsl:when test="current-grouping-key() = 'br'">Rechnungslegung/Corporate Governance</xsl:when>-->
                                                <xsl:otherwise>
                                                    <xsl:value-of select="'Weitere Inhalte'"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <section>
                                            <title>
                                                <xsl:value-of select="$ressort-ueberschrift"/>
                                            </title>
                                            <xsl:for-each select="current-group()">
                                                <table frame="void" rules="none">
                                                    <tbody>
                                                        <xsl:for-each select="/*">
                                                            <xsl:call-template name="print-entry">
                                                                <xsl:with-param name="knoten" select="."/>
                                                            </xsl:call-template>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                        </section>
                                    </xsl:for-each-group>
                                    
                                </xsl:if>
                            </body>
                        </toc>
                    </xsl:result-document>
                </xsl:for-each-group>
            </xsl:for-each-group>
        </xsl:for-each-group>
        
    </xsl:template>

    <xsl:template name="print-entry">
        <xsl:param name="knoten" required="yes"/>
        <xsl:param name="mantelteil" required="no" select="'no'"/>
        <xsl:variable name="dokid" select="@docid"/>
        <xsl:variable name="pubabbr" select="lower-case($knoten/metadata/pub/pubabbr/text())"/>
        <xsl:variable name="pubyear" select="$knoten/metadata/pub/pubyear/text()"/>
        <xsl:variable name="pubpage" select="$knoten/metadata/pub/pages/start_page/text()"/>
        <tr>
            <td align="left" colspan="78%" rowspan="1" valign="top">
                <p class="ihv_title">
                    <xsl:if test="$mantelteil = 'yes'">
                        <xsl:variable name="ressort-ueberschrift">
                            <xsl:choose>
                                <xsl:when test="$knoten/metadata/ressort/text() = 'sr'">Steuerrecht</xsl:when>
                                <xsl:when test="$knoten/metadata/ressort/text() = 'wr'">Wirtschaftsrecht</xsl:when>
                                <xsl:when test="$knoten/metadata/ressort/text() = 'ar'">Arbeitsrecht</xsl:when>
                                <xsl:when test="$knoten/metadata/ressort/text() = 'bw'">Betriebswirtschaft</xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="doctype">
                            <xsl:choose>
                                <xsl:when test="$knoten/name()='gk'">Gastkommentar</xsl:when>
                                <xsl:when test="$knoten/name()='au'">Aufsatz</xsl:when>
                                <xsl:when test="$knoten/name()='kk'">Kompakt</xsl:when>
                                <xsl:when test="$knoten/name()='va'">Verwaltungsanweisung</xsl:when>
                                <xsl:when test="$knoten/name()='ent'">Entscheidung</xsl:when>
                                <xsl:when test="$knoten/name()='entk'">Entscheidung</xsl:when>
                                <xsl:when test="$knoten/name()='nr'">Nachricht</xsl:when>
                                <xsl:when test="$knoten/name()='kb'">Kurzbeitrag</xsl:when>
                                <xsl:when test="$knoten/name()='sp'">Standpunkt</xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        <b><xsl:value-of select="concat($ressort-ueberschrift, ' / ', $doctype)"/></b>: </xsl:if>
                    <link meta_docid="{$dokid}">
                        <b>
                            <xsl:value-of select="$knoten/metadata/title"/>
                        </b>
                    </link>
                </p>
                <xsl:choose>
                    <xsl:when test="$knoten/metadata/authors/author">
                        <p class="ihv_author">
                            <i>
                                <xsl:for-each select="$knoten/metadata/authors/author">
                                    <xsl:if test="not(position()=1)">
                                        <xsl:text> / </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="normalize-space(concat(prefix, ' ' , firstname, ' ', surname))"/>
                                </xsl:for-each>
                            </i>
                        </p>
                    </xsl:when>
                    <xsl:when test="$knoten/metadata/authors/organisation">
                        <p class="ihv_author">
                            <i>
                                <xsl:for-each select="$knoten/metadata/authors/organisation">
                                    <xsl:if test="not(position()=1)">
                                        <xsl:text> / </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="text()"/>
                                </xsl:for-each>
                            </i>
                        </p>
                    </xsl:when>
                </xsl:choose>
                
                <!-- Entweder Summary oder Urteilsdaten: -->
                <xsl:choose>
                    <xsl:when test="$knoten/metadata/summary">
                        <xsl:call-template name="create_shortened_summary">
                            <xsl:with-param name="knoten" select="$knoten"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$knoten/metadata/instdoc">
                        <!-- Siehe Email von Andreas: Di 29.10.2019 13:07 -->
                        <xsl:variable name="instdoc" select="$knoten/metadata/instdoc"/>
                        <xsl:variable name="aktenzeichen-string" select="string-join($instdoc/instdocnrs/instdocnr, ', ')"/>
                        <xsl:variable name="urteilszeile">
                            <xsl:choose>
                                <xsl:when test="$instdoc/instdocaddnr and contains($aktenzeichen-string, ',')">
                                    <!--<xsl:value-of select="insert-before($aktenzeichen-string, index-of($aktenzeichen-string, ','), concat(' ',$instdoc/instdocaddnr, ','))"/>-->
                                    <xsl:value-of select="concat(substring-before($aktenzeichen-string, ','), ' ',$instdoc/instdocaddnr, ',', substring-after($aktenzeichen-string, ','))"/>
                                </xsl:when>
                                <xsl:when test="$instdoc/instdocaddnr">
                                    <xsl:value-of select="concat($aktenzeichen-string, ' ', $instdoc/instdocaddnr)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$aktenzeichen-string"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of select="$instdoc/instdocnote"/>
                        </xsl:variable>
                        <p class="ihv_summary">
                            <xsl:value-of select="concat($instdoc/inst/text(), ', ', $instdoc/instdoctype/text(), ' vom ', format-date($instdoc/instdocdate, '[D,2].[M,2].[Y]'), ' ', codepoints-to-string(8211), ' ', $urteilszeile)"/>
                        </p>
                    </xsl:when>
                </xsl:choose>
            </td>
            <td align="right" colspan="22%" rowspan="1" valign="top">
                <p class="ihv_page">
                    <xsl:choose>
                        <xsl:when test="$knoten/metadata/pub/pages[start_page = last_page]">
                            <xsl:text>S.</xsl:text>
                            <xsl:value-of select="codepoints-to-string(160)"/>
                            <xsl:value-of select="$knoten/metadata/pub/pages/start_page"/>
                            <br/>
                            <xsl:value-of select="$dokid"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>S.</xsl:text>
                            <xsl:value-of select="codepoints-to-string(160)"/>
                            <xsl:value-of select="$knoten/metadata/pub/pages/start_page"/>
                            <xsl:value-of select="codepoints-to-string(45)"/>
                            <xsl:value-of select="$knoten/metadata/pub/pages/last_page"/>
                            <br/>
                            <xsl:value-of select="$dokid"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
