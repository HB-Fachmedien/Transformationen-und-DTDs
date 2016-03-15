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
    
    <!-- Girichtsddatei liegt im Verwaltungsanweisungen Ordner -->
    <xsl:variable name="gerichteDatei" select="document('../verwaltungsanweisungen/gerichte.xml')"/>
    <xsl:variable name="idMappingDatei" select="document('id-mapping.xml')"/>
    
    <xsl:template match="ZEITSCHRIFT-BEITRAG">
        <xsl:variable name="sevenDigitID">
            <xsl:call-template name="calculateDocId">
                <xsl:with-param name="id" select="@SIRIUS-ID"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="ru-attr" select="upper-case(fn:normalize-space(saxon:parse-html(@RU)))"/>
        <xsl:variable name="neues_aus_der_datenbank" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="$ru-attr='NEUES AUS DER DATENBANK'">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
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
                <xsl:when test="$ru-attr='NACHRICHTEN' and $typ-attr='BUCHBESPRECHUNG'">rez</xsl:when>
                <xsl:when test="$ru-attr='AKTUELLE FACHBEITRÄGE' and $typ-attr='LITERATURHINWEIS'">rez</xsl:when>
                <xsl:when test="$ru-attr='BÜCHER' and $typ-attr='LITERATURHINWEIS'">rez</xsl:when>
                <xsl:when test="$ru-attr='BÜCHER' and $typ-attr='NACHRICHT'">rez</xsl:when>
                <xsl:when test="$ru-attr='GASTKOMMENTAR' and $typ-attr='KOMMENTAR'">gk</xsl:when>
                <xsl:when test="$ru-attr='GASTKOMMENTAR' and $typ-attr='EDITORIAL'">ed</xsl:when>
                <xsl:when test="$ru-attr='AKTUELLE FACHBEITRÄGE' and $typ-attr='NACHRICHT'">rez</xsl:when>
                <xsl:when test="$ru-attr='NACHRICHTEN' and $typ-attr='NACHRICHT'">nr</xsl:when>
                <xsl:when test="$ru-attr='INTERVIEW' and $typ-attr='BEITRAG'">iv</xsl:when>
                <xsl:when test="$ru-attr='INTERVIEW' and $typ-attr='INTERVIEW'">iv</xsl:when>
                <xsl:when test="$ru-attr='NEUES AUS DER DATENBANK'">divso</xsl:when>
                <xsl:otherwise>ELEMENT-ZUTEILUNG-FEHLGESCHLAGEN</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="id-mapping-wert">
            <xsl:choose>
                <xsl:when test="not($neues_aus_der_datenbank) and $idMappingDatei//docID[text()=concat('AR',$sevenDigitID)]">
                    <xsl:choose>
                        <xsl:when test="count($idMappingDatei//docID[text()=concat('AR',$sevenDigitID)])>1">
                            MEHRERE TREFFER?! --> Fehler?
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$idMappingDatei//docID[text()=concat('AR',$sevenDigitID)]/../abgedruckt/text()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('AR', $sevenDigitID)"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$dtyp}">
            <xsl:choose>
                <xsl:when test="$neues_aus_der_datenbank">
                    <xsl:attribute name="rawid" select="@SIRIUS-ID"/>
                    <xsl:attribute name="docid" select="concat('XQ', $sevenDigitID)"/> 
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="rawid" select="replace($id-mapping-wert, 'AR0{0,7}', '')"/>
                    <xsl:attribute name="docid" select="$id-mapping-wert"/>        
                </xsl:otherwise>
            </xsl:choose>
            

            <metadata>
                <title>
                    <xsl:value-of select="TITEL"/>
                </title>
                
                <xsl:if test="not($neues_aus_der_datenbank) and UTITEL[child::node()]">
                    <subtitle><xsl:value-of select="UTITEL"/></subtitle>
                </xsl:if>
                
                <xsl:if test="$neues_aus_der_datenbank">
                    <xsl:comment><subtitle><xsl:value-of select="UTITEL"/></subtitle></xsl:comment>
                </xsl:if>
                
                <xsl:if test="AUTOR">
                    <authors>
                        <xsl:for-each select="AUTOR/PERSON">
                            <author>
                                <xsl:if test="child::text()"><prefix><xsl:value-of select="text()"/></prefix></xsl:if>
                                <firstname><xsl:value-of select="VORNAME"/></firstname>
                                <surname><xsl:value-of select="NACHNAME"/></surname>
                                <!--<suffix></suffix><!-\- TODO -\->-->
                            </author>
                        </xsl:for-each>
                        <xsl:if test="AUTOR/PERSON/BIOGR[child::node()]">
                            <biography>
                                <xsl:for-each select="AUTOR/PERSON/BIOGR">
                                    <p><xsl:value-of select="replace(replace(ABS,'\n',' '),'\s{2,}',' ')"/></p>
                                </xsl:for-each>
                            </biography>
                        </xsl:if>
                    </authors>
                </xsl:if>
                
                <xsl:if test="ABSTRACT[child::node()]">
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
                    <xsl:when test="$ru-attr='BEITRAG' and $typ-attr='BEITRAG'">
                        <ressort>Beitrag</ressort>  
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
                    <xsl:when test="$ru-attr='BÜCHER'">
                        <ressort>Buchbesprechung</ressort>
                    </xsl:when>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$neues_aus_der_datenbank">
                        <pub>
                            <pubtitle><xsl:value-of select="tokenize(UTITEL/text(),' ')[1]"/></pubtitle>
                            <pubabbr>XQ</pubabbr>
                            <pubyear>
                                <xsl:comment>VON HAND EINTRAGEN</xsl:comment>
                            </pubyear>
                            
                            <pubedition>
                                <xsl:comment>VON HAND EINTRAGEN</xsl:comment>
                            </pubedition>
                            <date>
                                <xsl:comment>VON HAND EINTRAGEN</xsl:comment>
                            </date>
                            <pages>
                                <start_page>
                                    <xsl:comment>VON HAND EINTRAGEN</xsl:comment>
                                </start_page>
                                <last_page>
                                    <xsl:comment>VON HAND EINTRAGEN -  BEI SEITE XY ff. DIESES ELEMENT WEGLASSEN</xsl:comment>
                                </last_page>
                                <article_order>1</article_order>
                            </pages>
                            <add_target>ar</add_target>
                        </pub>
                    </xsl:when>
                    <xsl:otherwise>
                        <pub>
                            <pubtitle>Aufsichtsrat</pubtitle><!-- Der Ausichtsrat -->
                            <pubabbr>AR</pubabbr>
                            <pubyear>
                                <xsl:value-of select="PUB/DATUM/JAHR"/>
                            </pubyear>
                            
                            <!-- Bezieht den Inhalt vom pubedition Element aus dem ID Element des Zeitschrift Beitrags -->
                            <pubedition>
                                <xsl:value-of select="PUB/HEFTNR"/>
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
                    </xsl:otherwise>
                </xsl:choose>
                
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
                        <!--<instdoctype><xsl:value-of select="concat(upper-case(substring(@TYP,1,1)),lower-case(substring(@TYP,2)))"/></instdoctype>-->
                        <instdoctype>Schreiben</instdoctype>
                        <instdocdate><xsl:value-of select="concat(URTZEILE/DATUM/JAHR,'-',URTZEILE/DATUM/MONAT,'-',URTZEILE/DATUM/TAG)"/></instdocdate>
                        <instdocnrs><instdocnr><xsl:value-of select="URTZEILE/AZ"/></instdocnr></instdocnrs>
                    </instdoc>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="$neues_aus_der_datenbank">
                        <all_doc_type level="1">div</all_doc_type>
                        <all_source level="1">divq</all_source>
                        <all_source level="2">sonst</all_source>
                    </xsl:when>
                    <xsl:otherwise>
                        <all_doc_type level="1">zs</all_doc_type>
                        <all_source level="1">zsa</all_source>
                        <all_source level="2">ar</all_source>
                    </xsl:otherwise>
                </xsl:choose>
                
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
    
    <xsl:function name="hbfm:getGericht">
        <xsl:param name="gerichtsBezeichnung"/>    
        <xsl:variable name="option" select="$gerichteDatei/*/option[*[text() = $gerichtsBezeichnung/text()]]"/>
        <xsl:sequence select="($option/main, $option/*[@diction='true'],$option/@type)"></xsl:sequence>
    </xsl:function>
    
    <!-- Unsere IDs müssen 7-stellig sein, dieses Template füllt kürzere IDs vorne mit Nullen auf-->
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <!--xsl:value-of select="$id"/-->
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
</xsl:stylesheet>