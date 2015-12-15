<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs saxon fn"
    version="2.0">
    
    <xsl:output indent="yes"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
    />
    
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
                <xsl:when test="$ru-attr='GASTKOMMENTAR' and $typ-attr='BEITRAG'">gk</xsl:when>
                <xsl:when test="$ru-attr='BEITRAG' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='DAS AKTUELLE STICHWORT' and $typ-attr='BEITRAG'">au</xsl:when>
                <xsl:when test="$ru-attr='RECHTSPRECHUNG' and $typ-attr='URTEILSBERICHT'">ent</xsl:when>
                <xsl:when test="$ru-attr='MELDUNGEN' and $typ-attr='NACHRICHT'">nr</xsl:when>
                <xsl:when test="$ru-attr='PERSONALIA' and $typ-attr='NACHRICHT'">nr</xsl:when>
                <xsl:when test="$ru-attr='BÜCHER' and $typ-attr='BUCHBESPRECHUNG'">rez</xsl:when>
                <xsl:when test="$ru-attr='AKTUELLE FACHBEITRÄGE' and $typ-attr='LITERATURHINWEIS'">nr</xsl:when>
                <xsl:when test="$ru-attr='BÜCHER' and $typ-attr='NACHRICHT'">rez</xsl:when>
                <xsl:when test="$ru-attr='GASTKOMMENTAR' and $typ-attr='KOMMENTAR'">gk</xsl:when>
                <xsl:when test="$ru-attr='GASTKOMMENTAR' and $typ-attr='EDITORIAL'">ed</xsl:when>
                <xsl:when test="$ru-attr='AKTUELLE FACHBEITRÄGE' and $typ-attr='NACHRICHT'">nr</xsl:when>
                <xsl:when test="$ru-attr='NACHRICHTEN' and $typ-attr='NACHRICHT'">nr</xsl:when>
                <xsl:when test="$ru-attr='INTERVIEW' and $typ-attr='BEITRAG'">iv</xsl:when>
                <xsl:when test="$ru-attr='INTERVIEW' and $typ-attr='INTERVIEW'">iv</xsl:when>
                <xsl:when test="$ru-attr='NEUES AUS DER DATENBANK'">nr</xsl:when>
                <xsl:otherwise>ELEMENT-ZUTEILUNG-FEHLGESCHLAGEN</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$dtyp}">
            <xsl:attribute name="rawid">
                <xsl:value-of select="@SIRIUS-ID"/>
            </xsl:attribute>
            <xsl:attribute name="docid">
                <xsl:value-of select="concat('AR', $sevenDigitID)"/>
            </xsl:attribute>
            <xsl:attribute name="altdocid">
                <xsl:value-of select="concat('AR', $sevenDigitID)"/>
            </xsl:attribute>

            <metadata>
                <title>
                    <xsl:value-of select="TITEL"/>
                </title>
                
                <xsl:if test="AUTOR">
                    <authors>
                        <xsl:for-each select="AUTOR/PERSON">
                            <author>
                                <prefix><xsl:value-of select="text()"/></prefix><!-- TODO: passt das?-->
                                <firstname><xsl:value-of select="VORNAME"/></firstname>
                                <surname><xsl:value-of select="NACHNAME"/></surname>
                                <suffix></suffix><!-- TODO -->
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

                <!-- In bestimmten Rubrik/Typ Kombinationen  kommt es zur Zuteilung von Ressorts-->                
                <xsl:choose>
                    <xsl:when test="$ru-attr='DAS AKTUELLE STICHWORT' and $typ-attr='BEITRAG'">
                        <ressort>Das aktuelle Stichwort</ressort>  
                    </xsl:when>
                    <xsl:when test="$ru-attr='PERSONALIA' and $typ-attr='NACHRICHT'">
                        <ressort>Personalie</ressort>
                    </xsl:when>
                    <xsl:when test="$ru-attr='AKTUELLE FACHBEITRÄGE' and $typ-attr='LITERATURHINWEIS'">
                        <ressort>Aktueller Fachbeitrag</ressort>
                    </xsl:when>
                    <xsl:when test="$ru-attr='AKTUELLE FACHBEITRÄGE' and $typ-attr='NACHRICHT'">
                        <ressort>Aktueller Fachbeitrag</ressort>
                    </xsl:when>
                </xsl:choose>
                
                <pub>
                    <pubtitle>Aufsichtsrat</pubtitle>
                    <pubabbr>AR</pubabbr>
                    <pubyear>
                        <xsl:value-of select="PUB/DATUM/JAHR"/>
                    </pubyear>

                    <!-- Bezieht den Inhalt vom pubedition Element aus dem ID Element des Zeitschrift Beitrags -->
                    <pubedition>
                        <xsl:value-of select="tokenize(@ID,'_')[3]"/>
                    </pubedition>
                    <date>
                        <xsl:value-of
                            select="concat(PUB/DATUM/JAHR,'-',PUB/DATUM/MONAT,'-',PUB/DATUM/TAG)"/>
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
                <all_doc_type level="1">zs</all_doc_type>
                <all_source level="1">zsa</all_source>
                <all_source level="2">ar</all_source>
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
</xsl:stylesheet>