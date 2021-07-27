<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:maileon="http://rssext.maileon.com/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs hbfm" version="2.0" xmlns:hbfm="http:www.fachmedien.de/hbfm">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="" />
    
    <xsl:param name="input_path" select="'c:/tempInput'"/>
    <xsl:param name="output_path" select="'c:/tempOutput/'"/>
    
    <xsl:variable name="src-documents-location" select="concat('file:///', $input_path, '/?recurse=yes;select=*.xml')"/>
    <xsl:variable name="aktuelles-Heft" select="collection($src-documents-location)"/>
    
    <xsl:variable name="erstes-dokument" select="$aktuelles-Heft[1]"/>
    <xsl:variable name="publisher" select="$erstes-dokument/*/metadata/all_source[@level='2']/text()"/>
    <xsl:variable name="pubEdition" select="$erstes-dokument/*/metadata/pub/pubedition"/>
    <xsl:variable name="publisherLink">
        <xsl:choose>
            <xsl:when test="$publisher='wuw'"><xsl:text>https://www.wuw-online.de</xsl:text></xsl:when>
            <xsl:when test="$publisher='kor'"><xsl:text>https://www.kor-ifrs.de</xsl:text></xsl:when>
            <xsl:when test="$publisher='db'"><xsl:text>https://www.der-betrieb.de</xsl:text></xsl:when>
            <xsl:otherwise><xsl:text>Not Yet Programmed</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="publisherTitle">
        <xsl:choose>
            <xsl:when test="$publisher='wuw'"><xsl:text>WIRTSCHAFT und WETTBEWERB</xsl:text></xsl:when>
            <xsl:when test="$publisher='kor'"><xsl:text>KoR IFRSB</xsl:text></xsl:when>
            <xsl:when test="$publisher='db'"><xsl:text>DER BETRIEB</xsl:text></xsl:when>
            <xsl:otherwise><xsl:text>Not Yet Programmed</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="publisherDescription">
        <xsl:choose>
            <xsl:when test="$publisher='wuw'"><xsl:text>Mit WIRTSCHAFT und WETTBEWERB ist führende deutsche Medium zu den Themen, Kartellverbot, Fusionskontrolle, Kartellschadensersatz, Marktbeherrschung, Missbrauchsaufsicht, Bußgeldverfahren u.v.m. Hochrangige Experten stellen die unterschiedlichen Sichtweisen dar.</xsl:text></xsl:when>
            <xsl:when test="$publisher='kor'"><xsl:text>KoR IFRS - Ihr Magazin zum Thema internationale und kapitalmarktorientierte Rechnungslegung versorgt Sie stets mit aktuellen Entwicklungen für Ihr Accounting-Business. Egal ob Rechnungslegung nach IFRS oder dem deutschen Standard DRS - mit uns bleiben Sie immer aktuell.</xsl:text></xsl:when>
            <xsl:when test="$publisher='db'"><xsl:text>DER BETRIEB ist die optimale Verbindung aus Steuerrecht, Wirtschaftsrecht, Arbeitsrecht und Betriebswirtschaft und liefert Ihnen das notwendige Know-how für weitsichtige Entscheidungen.</xsl:text></xsl:when>
            <xsl:otherwise><xsl:text>Not Yet Programmed</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="feeds">
        <xsl:choose>
            <xsl:when test="$publisher=('wuw','kor')">  <feed1>general</feed1>  </xsl:when>
            <xsl:when test="$publisher='db' and not($pubEdition='00')">   <feed1>general</feed1>   <feed2>bw</feed2>  <feed3>sr</feed3>   <feed4>wr</feed4>   <feed5>ar</feed5>   <feed6>kr</feed6>   <feed7>br</feed7>  </xsl:when>
            <xsl:when test="$publisher='db' and $pubEdition='00'">   <feed1>sr</feed1>  </xsl:when>
            <xsl:otherwise>  Not Yet Programmed   </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:template name="main" match="/">
        <xsl:for-each select="$feeds/*">
            <xsl:variable name="feed" select="text()"/>
            <!-- Acticles in reverse order as requested by steffi -->
            <xsl:variable name="generalArticles" select="reverse($aktuelles-Heft/*)[not(name()=('toc','rss'))][not(metadata/ressort) or not(metadata/ressort/text()=$feeds/*/text())]"/>
            <xsl:variable name="currentRessortArticles" select="reverse($aktuelles-Heft)/*[not(name()=('toc','rss'))][metadata/ressort/text()=$feed]"/>
            <!-- create rss feeds only if the equivalent ressort articles or general articles are available in the heft-->
            <xsl:if test="($feed='general' and $generalArticles) or ($currentRessortArticles)">
                <xsl:result-document method="xml" href="file:///{$output_path}RSS_Feed_{upper-case($publisher)}-{$feed}.xml">    <!-- for debugging only: {format-dateTime(current-dateTime(),'[M01]-[D01]-[Y0001]-[h1].[m01].[s01]')}-->
                    <rss version="2.0" xmlns:maileon="http://rssext.maileon.com/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" xmlns:slash="http://purl.org/rss/1.0/modules/slash/">
                        <channel>
                            <!-- obligatory -->
                            <title><xsl:value-of select="$publisherTitle"></xsl:value-of></title>
                            <link><xsl:value-of select="$publisherLink"></xsl:value-of></link>
                            <description><xsl:value-of select="$publisherDescription"></xsl:value-of></description>
                            <!-- optional -->
                            <copyright>Fachmedien Otto Schmidt <xsl:value-of select="year-from-date(current-date())"></xsl:value-of></copyright>
                            
                            <!-- items -->
                            <xsl:choose>
                                <xsl:when test="$feed='general'">
                                    <xsl:for-each select="$generalArticles">
                                        <xsl:call-template name="fill_item"/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>                                      
                                    <xsl:for-each select="$currentRessortArticles">
                                        <xsl:call-template name="fill_item"/>
                                    </xsl:for-each>  
                                </xsl:otherwise>
                            </xsl:choose>
                        </channel>
                    </rss>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="fill_item">
        <xsl:variable name="firstphoto" select="(//figure)[1]"/>
        <item> 
            <title>
                <xsl:if test="metadata/title">
                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text>
                    <xsl:value-of select="metadata/title"/>
                    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                </xsl:if>
            </title>
            
            <category>
                <xsl:choose>
                    <xsl:when test="./name()='gk'">Gastkommentar</xsl:when>
                    <xsl:when test="./name()='au'">Aufsatz</xsl:when>
                    <xsl:when test="./name()='kk'">Kompakt</xsl:when>
                    <xsl:when test="./name()='va'">Verwaltungsanweisung</xsl:when>
                    <xsl:when test="./name()='ent'">Entscheidung</xsl:when>
                    <xsl:when test="./name()='entk'">Entscheidung</xsl:when>
                    <xsl:when test="./name()='nr'">Nachricht</xsl:when>
                    <xsl:when test="./name()='kb'">Kurzbeitrag</xsl:when>
                    <xsl:when test="./name()='sp'">Standpunkt</xsl:when>
                    <xsl:when test="./name()='ed'">Editorial</xsl:when>
                    <xsl:when test="./name()='iv'">Interview</xsl:when>
                    <xsl:otherwise>Not Yet Programmed</xsl:otherwise>
                </xsl:choose>
            </category>
            
            <dc:creator><!--<author>-->
                <xsl:if test="metadata/authors/author">
                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text>
                    <xsl:for-each select="metadata/authors/author">
                        <xsl:if test="not(position()=1)">
                            <xsl:text> / </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="normalize-space(concat(prefix, ' ' , firstname, ' ', surname))"/>
                    </xsl:for-each>
                    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                </xsl:if>
            </dc:creator>
            
            <maileon:DB-number>
                <xsl:value-of select="./@docid"/>
            </maileon:DB-number>
            
            <maileon:Urteilszeile>
                <xsl:if test="metadata/instdoc">
                    <xsl:variable name="instdoc" select="metadata/instdoc"/>
                    <xsl:variable name="aktenzeichen-string" select="string-join($instdoc/instdocnrs/instdocnr, ', ')"/>
                    <xsl:variable name="urteilszeile">
                        <xsl:choose>
                            <xsl:when test="$instdoc/instdocaddnr and contains($aktenzeichen-string, ',')">
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
                    <xsl:value-of select="concat($instdoc/inst/text(), ', ', $instdoc/instdoctype/text(), ' vom ', format-date($instdoc/instdocdate, '[D,2].[M,2].[Y]'), ' ', codepoints-to-string(8211), ' ', $urteilszeile)"/>    
                </xsl:if>
            </maileon:Urteilszeile>
            
            <link>
                <xsl:value-of select="normalize-space(concat('https://research.owlit.de/lx-document/' , ./@docid))"/>
            </link>
            
            <dc:identifier><xsl:value-of select="position()"/></dc:identifier>
            
            <dc:date>
                <xsl:value-of select="metadata/pub/date"/>
            </dc:date>
            
            <xsl:if test="$firstphoto/file/@src">
                <enclosure length="20000000" type="image/png" url="{normalize-space(concat('https://resources-eu-prd.wk-onega.com/docmedia/attach/WKDE-LTR-DOCS-PHC/hbfm_' , lower-case($firstphoto/file/@src)))}"/>
            </xsl:if>
            
            <maileon:Ressort> 
                <xsl:if test="metadata/ressort">  
                    <xsl:value-of select="metadata/ressort"/>   
                </xsl:if>
            </maileon:Ressort>
            
            <maileon:Subtitle>
                <xsl:if test="metadata/subtitle">   
                    <xsl:value-of select="metadata/subtitle"/>   
                </xsl:if>
            </maileon:Subtitle>
            
            <xsl:if test="$publisher='db' and $pubEdition='00'">
                <maileon:rubrik>
                    <xsl:if test="metadata/authors/author">
                        <xsl:for-each select="metadata/rubriken/rubrik">
                            <xsl:if test="not(position()=1)">
                                <xsl:text> / </xsl:text>
                            </xsl:if>
                            <xsl:value-of select="normalize-space(./text())"/>
                        </xsl:for-each>
                    </xsl:if>
                </maileon:rubrik>
            </xsl:if>
            
            <description>
                <xsl:if test="metadata/summary">
                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text>
                    <xsl:for-each select="metadata/summary/*[name() !='figure']">
                        <xsl:if test="not(position()=1)">   <br/>   </xsl:if>
                        <xsl:copy-of select="."/>
                    </xsl:for-each>
                    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                </xsl:if>
            </description>
            
            <content:encoded>
                <xsl:choose>
                    <xsl:when test="./name()=('ed') and (body/*)"> <!--or not(metadata/summary/*)-->
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text>
                        <xsl:for-each select="body/*[not(name()=('figure','note'))]">
                            <xsl:if test="not(position()=1)">   <br/>   </xsl:if>
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </xsl:when> 
                    <xsl:otherwise>
                        <xsl:if test="not(metadata/summary) and (body/*)">
                            <xsl:choose>
                                <xsl:when test="$publisher=('wuw','kor')">
                                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text>
                                    <!-- convert to string and take only the first 350 characters -->
                                    <xsl:copy-of select="concat(substring(string-join(body/*[not(name()=('figure','note'))], ' '),1,347),'...')"/>
                                    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    Not yet programmed
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </content:encoded>
        </item>
    </xsl:template>
</xsl:stylesheet>