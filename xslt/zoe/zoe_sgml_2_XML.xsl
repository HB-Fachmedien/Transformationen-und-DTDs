<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs saxon fn hbfm"
    version="2.0">
    
    <xsl:output indent="yes"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
    />
    
    <!-- Gerichtsddatei liegt im Verwaltungsanweisungen Ordner -->
    <xsl:variable name="gerichteDatei" select="document('../verwaltungsanweisungen/gerichte.xml')"/>
    
    <xsl:template match="ZEITSCHRIFT-BEITRAG">
        <xsl:variable name="sevenDigitID">
            <xsl:call-template name="calculateDocId">
                <xsl:with-param name="id" select="@SIRIUS-ID"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="ru-attr" select="upper-case(fn:normalize-space(saxon:parse-html(@RU)))"/>
        <xsl:variable name="typ-attr" select="upper-case(fn:normalize-space(saxon:parse-html(@TYP)))"/>
        <xsl:variable name="dtyp">
            
            <xsl:choose>
                <xsl:when test="$ru-attr='BEITRAG' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='SERVICE' and $typ-attr='BUCHBESPRECHUNG'">rez</xsl:when>
                <xsl:when test="$ru-attr='INHALT' and $typ-attr='INHALT'">nachbearbeitung</xsl:when>
                <xsl:when test="$ru-attr='EDITORIAL' and $typ-attr='EDITORIAL'">ed</xsl:when>
                <xsl:when test="$ru-attr='SERVICE' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='SCHWERPUNKT' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='EDITORIAL' and $typ-attr='BEITRAG'">ed</xsl:when>
                <xsl:when test="$ru-attr='BEITRAG' and $typ-attr='BUCHBESPRECHUNG'">rez</xsl:when>
                <xsl:when test="$ru-attr='' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='' and $typ-attr='INHALT'">nachbearbeitung</xsl:when>
                <xsl:when test="$ru-attr='BEITRAG' and $typ-attr='INTERVIEW'">iv</xsl:when>
                <xsl:when test="$ru-attr='SERVICE' and $typ-attr='INHALT'">nachbearbeitung</xsl:when>
                <xsl:when test="$ru-attr='SCHWERPUNKT' and $typ-attr='INTERVIEW'">iv</xsl:when>
                <xsl:when test="$ru-attr='SERVICE' and $typ-attr='SERVICE'">au</xsl:when>
                <xsl:when test="$ru-attr='INHALT' and $typ-attr='SERVICE'">nachbearbeitung</xsl:when>
                <xsl:when test="$ru-attr='DOSSIER' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='SERVICE' and $typ-attr='BUCHBESPRECHUNG'">rez</xsl:when>
                <xsl:when test="$ru-attr='BEITRAG' and $typ-attr='SERVICE'">au</xsl:when>
                
                <xsl:otherwise>ELEMENT-ZUTEILUNG-FEHLGESCHLAGEN</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$dtyp}">
            <xsl:attribute name="rawid">
                <xsl:value-of select="@SIRIUS-ID"/>
            </xsl:attribute>
            <xsl:attribute name="docid">
                <xsl:value-of select="concat('ZOE', $sevenDigitID)"/>
            </xsl:attribute>
            <xsl:attribute name="altdocid">
                <xsl:value-of select="concat('ZOE', $sevenDigitID)"/>
            </xsl:attribute>

            <metadata>
                <title>
                    <xsl:value-of select="TITEL"/>
                </title>
                
                <xsl:if test="STITEL and not(string(STITEL/text())='')">
                    <subtitle><xsl:value-of select="STITEL"/><xsl:if test="UTITEL and not(string(UTITEL/text())='')"> - <xsl:value-of select="UTITEL"/></xsl:if></subtitle>
                </xsl:if>
                
                <xsl:if test="AUTOR">
                    <authors>
                        <xsl:for-each select="AUTOR/PERSON">
                            <author>
                                <prefix><xsl:value-of select="text()"/></prefix>
                                <firstname><xsl:value-of select="VORNAME"/></firstname>
                                <surname><xsl:value-of select="NACHNAME"/></surname>
                                <!--<xsl:if test="BIOGR/descendant-or-self::*[not(text()='')]">
                                    <suffix><xsl:value-of select="concat(BIOGR/text(), ' ', BIOGR/ABS/text())"/></suffix>
                                </xsl:if>-->
                            </author>
                        </xsl:for-each>
                        <xsl:if test="AUTOR/PERSON/BIOGR">
                            <biography>
                                <xsl:for-each select="AUTOR/PERSON/BIOGR">
                                    <p><xsl:value-of select="replace(replace(ABS,'\n',' '),'\s{2,}',' ')"/></p>
                                </xsl:for-each>
                            </biography>
                        </xsl:if>
                    </authors>
                </xsl:if>
                
                <xsl:if test="ABSTRACT">
                    <summary>
                        <p>
                            <xsl:value-of select="replace(replace(ABSTRACT,'\n',' '),'\s{2,}',' ')"/>
                        </p>
                    </summary>
                </xsl:if>
                
                <xsl:if test="TOPIC">
                    <keywords>
                        <xsl:for-each select="TOPIC/BASENAME/BASENAMESTRING">
                            <keyword><xsl:value-of select="text()"/></keyword>
                        </xsl:for-each>
                    </keywords>
                </xsl:if>
                
                <xsl:if test="RUBRIK">
                    <xsl:choose>
                        <xsl:when test="RUBRIK/text()='Editorial'"></xsl:when>
                        <xsl:otherwise>
                            <ressort><xsl:value-of select="RUBRIK/text()"/></ressort>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="$ru-attr='SCHWERPUNKT' and $typ-attr='BEITRAG'"><rubriken><rubrik>Schwerpunkt</rubrik></rubriken></xsl:when>
                    <xsl:when test="$ru-attr='SCHWERPUNKT' and $typ-attr='INTERVIEW'"><rubriken><rubrik>Schwerpunkt</rubrik></rubriken></xsl:when>
                </xsl:choose>
                
                <pub>
                    <pubtitle>OrganisationsEntwicklung</pubtitle>
                    <pubabbr>ZOE</pubabbr>
                    <pubyear>
                        <xsl:value-of select="PUB/DATUM/JAHR"/>
                    </pubyear>

                    <!-- Bezieht den Inhalt vom pubedition Element aus dem ID Element des Zeitschrift Beitrags -->
                    <pubedition>
                        <xsl:value-of select="PUB/HEFTNR"/>
                    </pubedition>
                    <date>
                        <xsl:value-of
                            select="concat(PUB/DATUM/JAHR,'-',format-number(PUB/DATUM/MONAT,'00'),'-',format-number(PUB/DATUM/TAG,'00'))"/>
                    </date>
                    <pages>
                        <start_page>
                            <xsl:value-of select="PUB/SEITEVON"/>
                        </start_page>
                        <last_page>
                            <xsl:value-of select="PUB/SEITEBIS"/>
                        </last_page>
                        <xsl:variable name="s-length" select="string-length(tokenize(base-uri(),'\.')[1])"/>
                        <xsl:variable name="article-order-character" select="substring(tokenize(base-uri(),'\.')[1],$s-length,1)"/>
                        <!--<xsl:variable name="alphabet" select="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>-->
                        <article_order>
                            <xsl:choose>
                                <xsl:when test="$article-order-character='A'">1</xsl:when>
                                <xsl:when test="$article-order-character='B'">2</xsl:when>
                                <xsl:when test="$article-order-character='C'">3</xsl:when>
                                <xsl:when test="$article-order-character='D'">4</xsl:when>
                                <xsl:when test="$article-order-character='E'">5</xsl:when>
                                <xsl:when test="$article-order-character='F'">6</xsl:when>
                                <xsl:when test="$article-order-character='G'">7</xsl:when>
                                <xsl:when test="$article-order-character='H'">8</xsl:when>
                                <xsl:when test="$article-order-character='I'">9</xsl:when>
                                <xsl:when test="$article-order-character='J'">10</xsl:when>
                                <xsl:when test="$article-order-character='K'">11</xsl:when>
                                <xsl:when test="$article-order-character='L'">12</xsl:when>
                                <xsl:when test="$article-order-character='M'">13</xsl:when>
                                <xsl:when test="$article-order-character='N'">14</xsl:when>
                                <xsl:otherwise>1</xsl:otherwise>
                            </xsl:choose>
                            <!--<xsl:value-of select="index-of($alphabet,$article-order-character)"/>-->
                        </article_order>
                    </pages>
                </pub>
                <xsl:if test="DATEI-REF/DATEI/@NAME">
                    <extfile display="true" type="pdf">
                        <xsl:value-of select="DATEI-REF/DATEI/@NAME"/>
                    </extfile>
                </xsl:if>
                
                <xsl:if test="URTZEILE/BEHOERDE and not(string(URTZEILE/BEHOERDE/text())='')">
                    <instdoc>
                        <inst>
                            <xsl:variable name="gerichtsabfrage" select="hbfm:getGericht(URTZEILE/BEHOERDE)"/>
                            <xsl:attribute name="type">
                                <xsl:choose>
                                    <xsl:when test="$gerichtsabfrage[3]='authority'">authority</xsl:when>
                                    <xsl:otherwise>court</xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:attribute name="code">
                                <xsl:value-of select="$gerichtsabfrage[1]"/>
                            </xsl:attribute>
                            <xsl:value-of select="$gerichtsabfrage[2]"/>
                        </inst>
                        <instdoctype>Schreiben</instdoctype>
                        <instdocdate><xsl:value-of select="concat(URTZEILE/DATUM/JAHR,'-',URTZEILE/DATUM/MONAT,'-',URTZEILE/DATUM/TAG)"/></instdocdate>
                        <instdocnrs><instdocnr><xsl:value-of select="URTZEILE/AZ"/></instdocnr></instdocnrs>
                    </instdoc>
                </xsl:if>
                
                <all_doc_type level="1">zs</all_doc_type>
                <all_source level="1">zsa</all_source>
                <all_source level="2">zoe</all_source>
                <sgml_root_element doctype="{name()}">
                    <xsl:value-of
                        select="concat(name(), ' SIRIUS-ID=', @SIRIUS-ID, ' TYP=', @TYP, ' ID=', @ID, ' RU=', @RU)"
                    />
                </sgml_root_element>
            </metadata>
            <body>
                <p>
                    <xsl:apply-templates select="VOLLTEXT"/>
                </p>
            </body>
        </xsl:element>
    </xsl:template>
    

    <xsl:template match="VOLLTEXT">
        <xsl:value-of select="saxon:parse-html(text())"/>
    </xsl:template>
    
    <!-- Unsere IDs müssen 7-stellig sein, dieses Template füllt kürzere IDs vorne mit Nullen auf-->
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <!--xsl:value-of select="$id"/-->
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
    
    <xsl:function name="hbfm:getGericht">
        <xsl:param name="gerichtsBezeichnung"/>    
        <xsl:variable name="option" select="$gerichteDatei/*/option[*[text() = $gerichtsBezeichnung/text()]]"/>
        <xsl:sequence select="($option/main, $option/*[@diction='true'],$option/@type)"></xsl:sequence>
    </xsl:function>
</xsl:stylesheet>