<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs saxon hbfm"
    version="2.0">
    
    <xsl:output indent="yes"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
    />

    <xsl:variable name="gerichteDatei" select="document('gerichte.xml')"/>
    
    <xsl:template match="ZEITSCHRIFT-BEITRAG">
        <xsl:variable name="sevenDigitID">
            <xsl:call-template name="calculateDocId">
                <xsl:with-param name="id" select="@SIRIUS-ID"/>
            </xsl:call-template>
        </xsl:variable>
        <vav rawid="{@SIRIUS-ID}">
            <!--<xsl:attribute name="docid">
                <xsl:value-of select="concat('VA', $sevenDigitID)"/>
            </xsl:attribute>-->
            <xsl:attribute name="altdocid">
                <xsl:value-of select="concat('DB', $sevenDigitID)"/>
            </xsl:attribute>
            <metadata>
                <title>
                    <xsl:value-of select="TITEL"/>
                </title>
                
                <!-- Beim Bewertungspraktiker soll das Abstract Element gefüllt werden -->
                <xsl:if test="@TYP = 'BEWERTUNGSPRAKTIKER'">
                    <summary>
                        <p>
                            <xsl:value-of select="replace(saxon:parse-html(replace(substring-before(VOLLTEXT/text(),'&lt;br&gt;&lt;br&gt;'),'&lt;br&gt;www.der-betrieb.de&lt;br&gt;','')),'\n','&lt;br/&gt;')" disable-output-escaping="yes"/>
                        </p>
                    </summary>
                </xsl:if>
                <pub>
                    <pubtitle>Verwaltungsanweisung</pubtitle>
                    <pubabbr>VA</pubabbr>
                    <pubyear>
                        <xsl:value-of select="PUB/DATUM/JAHR"/>
                    </pubyear>

                    <!-- Bezieht den Inhalt vom pubedition Element aus dem ID Element des Zeitschrift Beitrags -->
                    <pubedition/>
                    <date>
                        <xsl:value-of
                            select="concat(PUB/DATUM/JAHR,'-',PUB/DATUM/MONAT,'-',PUB/DATUM/TAG)"/>
                    </date>
                    <pages>
                        <start_page>1</start_page>
                        <last_page>1</last_page>
                        <article_order>1</article_order>
                    </pages>
                </pub>
                <extfile display="true" type="{lower-case(DATEI-REF/DATEI/@TYP)}">
                    <xsl:value-of select="DATEI-REF/DATEI/@NAME"/>
                </extfile>
                <xsl:if test="GZEILE/VORSCHRIFT">
                    <law>
                        <lawname><xsl:value-of select="GZEILE/VORSCHRIFT"/></lawname>
                        <lawabbr></lawabbr>
                        <lawyear></lawyear>
                        <artnum></artnum>
                    </law>
                </xsl:if>
                <instdoc>
                    <inst type="authority">
                        <xsl:variable name="gerichtsabfrage" select="hbfm:getGericht(URTZEILE/BEHOERDE)"/>
                        <xsl:attribute name="code">
                            <xsl:value-of select="$gerichtsabfrage[1]"/>
                        </xsl:attribute>
                        <xsl:value-of select="$gerichtsabfrage[2]"/>
                    </inst>
                    <instdoctype>Schreiben</instdoctype>
                    <instdocdate><xsl:value-of select="concat(URTZEILE/DATUM/JAHR,'-',URTZEILE/DATUM/MONAT,'-',URTZEILE/DATUM/TAG)"/></instdocdate>
                    <instdocnrs><instdocnr><xsl:value-of select="URTZEILE/AZ"/></instdocnr></instdocnrs>
                </instdoc>
                <all_doc_type level="1">va</all_doc_type>
                <all_source level="1">draft</all_source>
                <all_source level="2">draftvwa</all_source>
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
        </vav>
    </xsl:template>
    
    <!-- Kopiert das CDATA Element aus dem VOLLTEXT Element mit -->
    <xsl:template match="VOLLTEXT">
        <xsl:if test="not(. ='')">
            <xsl:value-of select="saxon:parse-html(text())"/>
        </xsl:if>
    </xsl:template>
    
    <!-- Unsere IDs müssen 7-stellig sein, dieses Template füllt kürzere IDs vorne mit Nullen auf-->
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
    
    <xsl:function name="hbfm:getGericht">
        <xsl:param name="gerichtsBezeichnung"/>    
        <xsl:variable name="option" select="$gerichteDatei/*/option[*[text() = $gerichtsBezeichnung/text()]]"/>
        <xsl:sequence select="($option/main, $option/*[@diction='true'])"></xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>