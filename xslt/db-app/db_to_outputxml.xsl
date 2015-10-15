<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
            <!-- VARIABLE ANPASSEN IMMER ODER PER KONSOLE EINGEBEN -->
            <xsl:variable name="ausgabennummer" select="40"/>  
            <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
            
            <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
            
            <xsl:for-each
                select="collection(concat('../../../../../webexport/export/DB_3/XML/',$ausgabennummer,'/?recurse=yes;select=*.xml'))">
                <!-- TODO - PFAD ANPASSEN-->

                <xsl:element name="DOKUMENT">
                    <xsl:attribute name="DATEINAME" select="tokenize(document-uri(.), '/')[last()]"/>
                    <xsl:attribute name="DATEIVERZ">c:\webexport\export\DB_3\XML\<xsl:value-of
                            select="$ausgabennummer"/>\</xsl:attribute>
                    <!-- TODO - PFAD ANPASSEN-->
                    <xsl:variable name="docum" select="document(document-uri(.))"/>
                    <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                    <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                    <SIRIUS-ID>
                        <xsl:value-of select="$siriusID"/>
                    </SIRIUS-ID>

                    <DOCUMENTCODE>
                        <xsl:value-of select="$dok-nr"/>
                    </DOCUMENTCODE>

                    <TEXT>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:apply-templates select="$docum/*/body"/>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </TEXT>

                    <KURZTEXT>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <DOKID ID="{$dok-nr}"/>
                        <H2>Gliederung</H2>
                        <TABLE>
                            <xsl:for-each select="$docum/*/body//section">
                                <TR>
                                    <xsl:choose>
                                        <xsl:when test="matches(substring(@number,1,1),'\D')">
                                            <TD CLASS="td_content">
                                                <xsl:value-of select="@number"/>
                                            </TD>
                                            <TD CLASS="td_content" colspan="2">
                                                <xsl:value-of select="title"/>
                                            </TD>
                                        </xsl:when>
                                        <xsl:when test="@number">
                                            <TD CLASS="td_content">&#160;</TD>
                                            <TD CLASS="td_content">
                                                <xsl:value-of select="@number"/>
                                            </TD>
                                            <TD CLASS="td_content">
                                                <xsl:value-of select="title"/>
                                            </TD>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <TD CLASS="td_content">&#160;</TD>
                                            <TD CLASS="td_content">&#160;</TD>
                                            <TD CLASS="td_content">
                                                <xsl:value-of select="title"/>
                                            </TD>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </TR>
                            </xsl:for-each>
                        </TABLE>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </KURZTEXT>

                    <xsl:variable name="autorenzeile">
                        <xsl:for-each select="$docum/*/metadata/authors/author">
                            <xsl:if test="not(position()=1)">
                                <xsl:text> / </xsl:text>
                            </xsl:if>
                            <xsl:value-of select="prefix"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="firstname"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="surname"/>
                            <xsl:if test="suffix">
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="suffix"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <TEASER>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:value-of select="$autorenzeile"/>
                        <BR/>
                        <xsl:choose>
                            <xsl:when test="$docum/*/metadata/summary/*[1]/name() = 'p'">
                                <xsl:value-of select="$docum/*/metadata/summary/p"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$docum/*/metadata/summary"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </TEASER>

                    <MIME-TYPE>text/html</MIME-TYPE>

                    <xsl:variable name="doctype" select="$docum/*/name()"/>
                    <xsl:variable name="dtgb">
                        <xsl:choose>
                            <xsl:when test="$doctype = 'au'">Aufsatz</xsl:when>
                            <xsl:when test="$doctype = 'kk'">Kurz Kommentiert</xsl:when>
                            <xsl:when test="$doctype = 'va'">Verwaltungsanweisung</xsl:when>
                            <xsl:when test="$doctype = 'ent'">Entscheidung</xsl:when>
                            <xsl:when test="$doctype = 'entk'">Entscheidung</xsl:when>
                            <xsl:when test="$doctype = 'nr'">Nachricht</xsl:when>
                            <xsl:when test="$doctype = 'ed'">Editorial</xsl:when>
                            <xsl:when test="$doctype = 'toc'">Inhaltsverzeichnis</xsl:when>
                            <xsl:when test="$doctype = 'gk'">Gastkommentar</xsl:when>
                            <xsl:when test="$doctype = 'sp'">Standpunkt</xsl:when>
                            <xsl:otherwise>DOCTYP NICHT ERKANNT</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <DOCTYPGROUPBEZ>
                        <xsl:value-of select="$dtgb"/>
                    </DOCTYPGROUPBEZ>
                    <DOCTYPBEZ>
                        <xsl:value-of select="$dtgb"/>
                    </DOCTYPBEZ>
                    <!-- Es gibt so Sachen wie "Steuerrechtliche Verwaltungsanweisung", das habe ich nicht genauer untergliedert -->
                    <!-- TODO -->
                    
                    <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                    <HAUPTRUBRIK>
                        <BEZ>
                            <xsl:choose>
                                <xsl:when test="$ressortbez = 'bw'">Betriebswirtschaft</xsl:when>
                                <xsl:when test="$ressortbez = 'sr'">Steuerrecht</xsl:when>
                                <xsl:when test="$ressortbez = 'wr'">Wirtschaftsrecht</xsl:when>
                                <xsl:when test="$ressortbez = 'ar'">Arbeitsrecht</xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                        </BEZ>
                        <UNTERRUBRIK>
                            <xsl:value-of select="$docum/*/metadata/rubriken/rubrik"/>
                        </UNTERRUBRIK>
                    </HAUPTRUBRIK>
                    
                    <SUCHDATUM><xsl:value-of select="$docum/*/metadata/pub/date"/>T00:00:00</SUCHDATUM>

                    <SELBST-ID>OBJ_DB_ID_<xsl:value-of select="$dok-nr"/></SELBST-ID>
                    <SELBST-ID>OBJ_DB_ID_DB<xsl:value-of select="$siriusID"/></SELBST-ID>
                    
                    <xsl:variable name="pagetemp" select="$docum/*/metadata/pub/pages/start_page"/>
                    
                    <xsl:variable name="page-praefix">
                        <xsl:choose>
                            <xsl:when test="matches(substring($pagetemp, 1, 1), '[M|S]')">
                                <xsl:value-of select="substring($pagetemp, 1, 1)"/>
                            </xsl:when>
                            <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:variable name="startpage"
                        select="xs:integer(replace($pagetemp, '[M|S]', ''))"
                        as="xs:integer"/>

                    <xsl:variable name="lastpage"
                        select="xs:integer(replace($docum/*/metadata/pub/pages/last_page, '[M|S]', ''))"
                        as="xs:integer"/>
                    
                    <xsl:variable name="year" select="$docum/*/metadata/pub/pubyear"/>

                    <xsl:variable name="s-id-anzahl" select="1 + ($startpage - $lastpage)"/>
                    
                    <!-- Für jede Seite ein Eintrag -->
                    <xsl:for-each select="$startpage to $lastpage">
                        <SELBST-ID>ZEI_KUR_DB_J_<xsl:value-of select="$year"/>_S_<xsl:value-of select="$page-praefix"/><xsl:value-of
                                select="position() + $startpage - 1"/></SELBST-ID>
                    </xsl:for-each>

                    <PUBDATUM><xsl:value-of select="$docum/*/metadata/pub/date"/>T00:00:00</PUBDATUM>

                    <HEFTNR>
                        <xsl:value-of select="$ausgabennummer"/>
                    </HEFTNR>
                    <SEITEVON>
                        <xsl:value-of select="$pagetemp"/>
                    </SEITEVON>
                    <SEITEBIS>
                        <xsl:value-of select="$pagetemp/../last_page"/>
                    </SEITEBIS>
                    <OBJEKTQUELLE>
                        <OBJEKTBEZ>DER BETRIEB</OBJEKTBEZ>
                        <OBJEKTKURZBEZ>DB</OBJEKTKURZBEZ>
                    </OBJEKTQUELLE>
                    <OBJEKTZIEL>
                        <OBJEKTBEZ>DER BETRIEB</OBJEKTBEZ>
                        <OBJEKTKURZBEZ>DB</OBJEKTKURZBEZ>
                    </OBJEKTZIEL>

                    <xsl:if test="starts-with($docum/*/metadata/pub/pages/start_page, 'S')">
                        <STITEL><!--<![CDATA[]]>--></STITEL>
                    </xsl:if>

                    <TITEL>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:value-of select="$docum/*/metadata/title"/>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </TITEL>
                    <UTITEL>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:value-of select="$docum/*/metadata/subtitle"/>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </UTITEL>
                    <!-- TODO: <URTDATEN> HABE ICH NOCH NICHT -->
                    
                    <!-- TODO: <VORSCHRIFT> HABE ICH NOCH NICHT -->
                    <VORSPANN>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:value-of select="$docum/*/metadata/summary"/>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </VORSPANN>
                    <AUTORENZEILE>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[&lt;A HREF="#autor"&gt;</xsl:text>
                        <xsl:value-of select="$autorenzeile"/>
                        <xsl:text disable-output-escaping="yes">&lt;/A&gt;]]&gt;</xsl:text>
                    </AUTORENZEILE>
                    <xsl:for-each select="$docum/*/metadata/authors/author">
                        <AUTOR>
                            <xsl:value-of select="firstname"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="surname"/>
                        </AUTOR>
                    </xsl:for-each>
                    <PRIO-HP>300</PRIO-HP>
                    <PRIO-NL>0</PRIO-NL>
                    <!-- Abbildungen lasse ich mal raus -->
                </xsl:element>
            </xsl:for-each>
        
    </xsl:template>
    <xsl:template match="body">
        <DOKID ID="{../@rawid}"/>
        <xsl:if test="../name() = 'au'">
            <H2>Gliederung</H2>
            <TABLE>
                <xsl:for-each select="section">
                    <xsl:variable name="s-nummer" select="@number"/>
                    <TR>
                        <TD CLASS="td_content">
                            <A HREF="#{$s-nummer}">
                                <xsl:value-of select="$s-nummer"/>
                            </A>
                        </TD>
                        <TD CLASS="td_content" colspan="2">
                            <A HREF="#{$s-nummer}">
                                <xsl:value-of select="title"/>
                            </A>
                        </TD>
                    </TR>
                    <xsl:for-each select="section">
                        <xsl:variable name="s2-nummer">
                            <xsl:choose>
                                <xsl:when test="string-length(@number)>0">
                                    <xsl:value-of select="@number"/>
                                </xsl:when>
                                <xsl:otherwise>XX<xsl:value-of select="position()"/></xsl:otherwise>
                                <!-- TODO: XX NUMMERIERUNG IST NOCH NICHT GANZ RICHTIG, IST DAS WICHTIG???? -->
                            </xsl:choose>
                        </xsl:variable>
                        <TR>
                            <TD CLASS="td_content">
                                <xsl:text disable-output-escaping="no">&#160;</xsl:text>
                            </TD>
                            <TD CLASS="td_content">
                                <A HREF="#{$s-nummer}-{$s2-nummer}">
                                    <xsl:choose>
                                        <xsl:when test="string-length(@number)>0">
                                            <xsl:value-of select="$s2-nummer"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text disable-output-escaping="no">&#160;</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </A>
                            </TD>
                            <TD CLASS="td_content" colspan="2">
                                <A HREF="#{$s-nummer}-{$s2-nummer}">
                                    <xsl:value-of select="title"/>
                                </A>
                            </TD>
                        </TR>
                    </xsl:for-each>
                </xsl:for-each>
            </TABLE>
        </xsl:if>
        <xsl:apply-templates select="p|section|footnote|list|listitem|note"/>
        <!-- Autoren Informationen: -->
        <H3>
            <A NAME="autor" CLASS="text">Informationen zu den Autoren</A>
        </H3>
        <!--<xsl:value-of select="../metadata/authors/biography"/>-->
        <xsl:apply-templates select="../metadata/authors/biography"/>
        <!-- Fußnoten-Inhalte: -->
        <H3>Fußnoten:</H3>
        <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
            <xsl:for-each select="descendant::footnote">
                <xsl:variable name="fn-nr" select="substring(@id,2)"/>
                <TR VALIGN="TOP">
                    <TD CLASS="footnote_nr" ALIGN="RIGHT">
                        <A NAME="fn{$fn-nr}" HREF="#fn_back{$fn-nr}"><xsl:value-of select="$fn-nr"
                            />)</A>
                    </TD>
                    <TD CLASS="footnote">
                        <xsl:value-of select="descendant::*"/>
                    </TD>
                    <!-- TODO: VERLINKUNGEN FEHLEN NOCH -->
                </TR>
            </xsl:for-each>
        </TABLE>
    </xsl:template>
    <xsl:template match="list">
        <UL>
            <xsl:apply-templates/>
        </UL>
    </xsl:template>
    <xsl:template match="listitem">
        <LI>
            <xsl:apply-templates/>
        </LI>
    </xsl:template>
    <xsl:template match="p">
        <P>
            <xsl:apply-templates/>
        </P>
    </xsl:template>
    <xsl:template match="i">
        <I>
            <xsl:apply-templates/>
        </I>
    </xsl:template>
    <xsl:template match="b">
        <STRONG>
            <xsl:apply-templates/>
        </STRONG>
    </xsl:template>
    
    <xsl:template match="note">
        <P><STRONG><A NAME="REDHINW"><xsl:value-of select="title"/></A></STRONG></P>
        
        <xsl:apply-templates select="p|subhead|figure|table|list|rzblock|example|block|newpage|section|newpage"/>
    </xsl:template>
    
    <xsl:template match="newpage">
        <A CLASS="ns" NAME="{@pagenumber}">[DB&#160;<xsl:value-of
                select="ancestor::body/../metadata/pub/pubyear"/>&#160;S.&#160;<xsl:value-of
                select="@pagenumber"/>]</A>
    </xsl:template>
    <xsl:template match="section">
        <!-- SECTION <xsl:value-of select="count(ancestor::*)"/> -->
        <xsl:variable name="ebene" select="count(ancestor::*)"/>
        <xsl:variable name="s-nummer" select="@number"/>
        <xsl:element name="H{$ebene}">
            <DIV CLASS="artikel_indent">
                <A NAME="{$s-nummer}" CLASS="text">
                    <xsl:value-of select="$s-nummer"/>
                </A>
            </DIV>
            <xsl:value-of select="title"/>
        </xsl:element>
        <xsl:apply-templates
            select="block|example|figure|list|newpage|p|rzblock|section|subhead|table"/>
    </xsl:template>
    <xsl:template match="footnote">
        <xsl:variable name="fn-number" select="substring(@id,2)"/>
        <A HREF="#fn{$fn-number}" NAME="fn_back{$fn-number}" TITLE="Fussnote ansehen"
            CLASS="footnote_link">
            <SUP><xsl:value-of select="$fn-number"/>)</SUP>
        </A>
        <!-- Der Inhalt der Fußnoten wird dann später aufgelistet -->
    </xsl:template>
</xsl:stylesheet>
