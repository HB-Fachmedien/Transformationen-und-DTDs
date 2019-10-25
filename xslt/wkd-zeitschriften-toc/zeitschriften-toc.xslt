<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0" xmlns:hbfm="http:www.fachmedien.de/hbfm">

    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="no" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE" doctype-system="hbfm.dtd"/>
    <!--<xsl:strip-space elements="p summary"/>-->
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempDB/?recurse=yes;select=*.xml')"/>
    <xsl:variable name="erstes-dokument" select="$aktuelles-Heft[1]"/>
    
    <xsl:template name="create_shortened_summary">
        <!-- Kürzt die Beschreibung auf ungefähr mind 40 Wörter bis zum nächsten Satzende. 
         Die Wortgrenze liegt bei 49, wegen den Whitespaces zwischen den XML Elementen. Zumindest bei CF ist das so.
        -->
        <xsl:param name="knoten"/>
        <xsl:variable name="WORTGRENZE" select="49" as="xs:integer"/>
        
        <xsl:variable name="beschreibung">
            <xsl:variable name="summary-word-list" select="tokenize($knoten/metadata/summary/p[not(@lang='en')], ' ')"/>
            <xsl:choose>
                <xsl:when test="count($summary-word-list) &lt;= $WORTGRENZE">
                    <xsl:value-of select="normalize-space($knoten/metadata/summary/p[not(@lang='en')])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="text_vor_wortgrenze">
                        <xsl:for-each select="1 to $WORTGRENZE">
                            <xsl:value-of select="$summary-word-list[current()]"/><xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="text_nach_wortgrenze">
                        <!--<xsl:value-of select="tokenize($knoten/metadata/summary, '[.!?]')"/>-->
                        <xsl:for-each select="$WORTGRENZE+1 to count($summary-word-list)">
                            <xsl:value-of select="$summary-word-list[current()]"/><xsl:text> </xsl:text>
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
    
    <xsl:template match="/">
        <toc>
            <metadata>
                <title>Inhaltsverzeichnis - <xsl:value-of select="upper-case($erstes-dokument/*/metadata/pub/pubtitle)"/><xsl:text> </xsl:text><xsl:value-of select="$erstes-dokument/*/metadata/pub/pubedition"/>/<xsl:value-of select="$erstes-dokument/*/metadata/pub/pubyear"/></title>
                <pub>
                    <pubtitle>
                        <xsl:value-of select="$erstes-dokument/*/metadata/pub/pubtitle"/>
                    </pubtitle>
                    <pubabbr>
                        <xsl:value-of select="$erstes-dokument/*/metadata/pub/pubabbr"/>
                    </pubabbr>
                    <pubyear>
                        <xsl:value-of select="$erstes-dokument/*/metadata/pub/pubyear"/>
                    </pubyear>
                    <pubedition>
                        <xsl:value-of select="$erstes-dokument/*/metadata/pub/pubedition"/>
                    </pubedition>
                    <date>
                        <xsl:value-of select="$erstes-dokument/*/metadata/pub/date"/>
                    </date>
                    <pages>
                        <start_page>M2</start_page>
                        <!-- Hier immer die Heftseite aus dem Print nehmen -->
                        <!-- dafür hier eine Mappingtabelle? -->
                        <last_page>M2</last_page>
                        <article_order>1</article_order>
                    </pages>
                    <public value='true'/>
                </pub>
                <all_doc_type level="1">zs</all_doc_type>
                <all_source level="1">zsa</all_source>
                <all_source level="2">
                    <xsl:value-of select="$erstes-dokument/*/metadata/all_source[@level='2']"/>
                </all_source>
            </metadata>
            <body>
                <xsl:for-each select="$aktuelles-Heft/*[not(metadata/ressort)]">
                    <section>
                        <xsl:choose>
                            <xsl:when test="name() = 'ed'">
                                <title>Editorial</title>
                            </xsl:when>
                            <xsl:when test="name() = 'gk'">
                                <title>Gastkommentar</title>
                            </xsl:when>
                        </xsl:choose>
                        <table frame="void" rules="none">
                            <tbody>
                                <xsl:call-template name="print-entry">
                                    <xsl:with-param name="knoten" select="."/>
                                </xsl:call-template>
                            </tbody>
                        </table>
                    </section>
                </xsl:for-each>
                <xsl:for-each-group select="$aktuelles-Heft" group-by="*/metadata/ressort">
                    <xsl:variable name="ressort-ueberschrift">
                        <xsl:choose>
                            <xsl:when test="current-grouping-key() = 'sr'">Steuerrecht</xsl:when>
                            <xsl:when test="current-grouping-key() = 'wr'">Wirtschaftsrecht</xsl:when>
                            <xsl:when test="current-grouping-key() = 'ar'">Arbeitsrecht</xsl:when>
                            <xsl:when test="current-grouping-key() = 'bw'">Betriebswirtschaft</xsl:when>
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
                <xsl:for-each select="$aktuelles-Heft/*[not(metadata/ressort)][not(name()=('ed', 'gk'))]">
                    <section>
                        <title>Weiter Inhalte</title>
                        <table frame="void" rules="none">
                            <tbody>
                                <xsl:call-template name="print-entry">
                                    <xsl:with-param name="knoten" select="."/>
                                </xsl:call-template>
                            </tbody>
                        </table>
                    </section>
                </xsl:for-each>
            </body>
        </toc>
    </xsl:template>

    <xsl:template name="print-entry">
        <xsl:param name="knoten"/>
        <xsl:variable name="dokid" select="@docid"/>
        <xsl:variable name="pubabbr" select="lower-case($knoten/metadata/pub/pubabbr/text())"/>
        <xsl:variable name="pubyear" select="$knoten/metadata/pub/pubyear/text()"/>
        <xsl:variable name="pubpage" select="$knoten/metadata/pub/pages/start_page/text()"/>
        <tr>
            <td align="left" colspan="78%" rowspan="1" valign="top">
                <p class="ihv_title">
                    <url src="/lx-document/{$dokid}">
                        <b><xsl:value-of select="$knoten/metadata/title"/></b>
                    </url>
                </p>
                <xsl:if test="$knoten/metadata/authors">
                    <p class="ihv_author"><i>
                        <xsl:for-each select="$knoten/metadata/authors/author">
                            <xsl:if test="not(position()=1)">
                                <xsl:text> / </xsl:text>
                            </xsl:if>
                            <xsl:value-of select="normalize-space(concat(prefix, ' ' , firstname, ' ', surname))"/>
                        </xsl:for-each>
                    </i></p>
                </xsl:if>
                
                <!-- Entweder Summary oder Urteilsdaten: -->
                <xsl:choose>
                    <xsl:when test="$knoten/metadata/summary">
                        <xsl:call-template name="create_shortened_summary">
                            <xsl:with-param name="knoten" select="$knoten"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$knoten/metadata/instdoc">
                        <xsl:variable name="instdoc" select="$knoten/metadata/instdoc"/>
                        <p class="ihv_summary">
                            <xsl:value-of select="concat($instdoc/inst/text(), ', ', $instdoc/instdoctype/text(), ' vom ', format-date($instdoc/instdocdate, '[D,2].[M,2].[Y]'))"/>
                        </p>
                    </xsl:when>
                </xsl:choose>
            </td>
            <td align="right" colspan="22%" rowspan="1" valign="top">
                <p class="ihv_page">
                    <xsl:choose>
                        <xsl:when test="$knoten/metadata/pub/pages[start_page = last_page]">
                            <xsl:text>S.</xsl:text><xsl:value-of select="codepoints-to-string(160)"/><xsl:value-of select="$knoten/metadata/pub/pages/start_page"/><br/><xsl:value-of select="$dokid"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>S.</xsl:text><xsl:value-of select="codepoints-to-string(160)"/><xsl:value-of select="$knoten/metadata/pub/pages/start_page"/><xsl:value-of select="codepoints-to-string(8209)"/><xsl:value-of select="$knoten/metadata/pub/pages/last_page"/><br/><xsl:value-of select="$dokid"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>
