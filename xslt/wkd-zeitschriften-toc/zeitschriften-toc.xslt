<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0" xmlns:hbfm="http:www.fachmedien.de/hbfm">

    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="no" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE" doctype-system="hbfm.dtd"/>
    <!--<xsl:strip-space elements="p summary"/>-->
    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempDB/?recurse=yes;select=*.xml')"/>
    <xsl:variable name="erstes-dokument" select="$aktuelles-Heft[1]"/>
    <xsl:template match="/">
        <toc>
            <metadata>
                <title>Zeitschriften Inhalt Heft <xsl:value-of select="$erstes-dokument/*/metadata/pub/pubedition"/>/<xsl:value-of select="$erstes-dokument/*/metadata/pub/pubyear"/></title>
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
                </pub>
                <all_doc_type level="1">zs</all_doc_type>
                <all_source level="1">zsa</all_source>
                <all_source level="2">
                    <xsl:value-of select="$erstes-dokument/*/metadata/all_source[@level='2']"/>
                </all_source>
            </metadata>
            <body>
                <xsl:for-each select="$aktuelles-Heft/*[not(metadata/ressort)]">
                    <xsl:choose>
                        <xsl:when test="name() = 'ed'">
                            Editorial
                        </xsl:when>
                        <xsl:when test="name() = 'gk'">
                            Gastkommentar
                        </xsl:when>
                        <xsl:otherwise><!-- sollte eher unten stehen? -->
                            Weitere Inhalte
                        </xsl:otherwise>
                    </xsl:choose>
                    <hier-noch-ausfüllen>
                        <title>
                            <xsl:value-of select="current()/metadata/title"/>
                        </title>
                    </hier-noch-ausfüllen>
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
                    </section>
                    <xsl:for-each select="current-group()">
                        <table>
                            <tbody>
                                <xsl:for-each select="/*">
                                    <xsl:variable name="dokid" select="@docid"/>
                                    <xsl:variable name="pubabbr" select="lower-case(metadata/pub/pubabbr/text())"/>
                                    <xsl:variable name="pubyear" select="metadata/pub/pubyear/text()"/>
                                    <xsl:variable name="pubpage" select="metadata/pub/pages/start_page/text()"/>
                                    <tr>
                                        <td>
                                            <p class="ihv_title"><link meta_target="{$pubabbr}" meta_pubyear="{$pubyear}" meta_page="{$pubpage}" meta_context="{$pubabbr}"><xsl:value-of select="metadata/title"/></link></p>
                                            <xsl:if test="metadata/authors">
                                                <p class="ihv_author">
                                                    <xsl:for-each select="metadata/authors/author">
                                                        <xsl:if test="not(position()=1)"><xsl:text> / </xsl:text></xsl:if>
                                                        <xsl:value-of select="concat(prefix, ' ' , firstname, ' ', surname)"/>
                                                    </xsl:for-each>
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="metadata/summary"><p class="ihv_summary"><xsl:value-of select="normalize-space(metadata/summary)"/></p></xsl:if> 
                                        </td>
                                        <td>
                                            <p class="ihv_page">
                                                <xsl:choose>
                                                    <xsl:when test="metadata/pub/pages[start_page = last_page]">
                                                        <xsl:value-of select="metadata/pub/pages/start_page"/>,  <xsl:value-of select="$dokid"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="metadata/pub/pages/last_page"/>, <xsl:value-of select="$dokid"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </p>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </xsl:for-each>
                </xsl:for-each-group>
            </body>
        </toc>
    </xsl:template>
</xsl:stylesheet>
