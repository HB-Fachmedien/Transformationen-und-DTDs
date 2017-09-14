<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.editeur.org/onix/2.1/short"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>
    
    <xsl:strip-space elements="*"></xsl:strip-space>
    
    <xsl:template match="@*|node()">
        <!--<xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>-->
    </xsl:template>
    
    <xsl:template match="/ONIXmessage">
        <!--NotificationType;RecordSourceTypeCode;...--><!-- just csv things -->
        <fachmedien-shop-xml>
            <xsl:apply-templates select="product"/>
        </fachmedien-shop-xml>
    </xsl:template>
    
    <xsl:template match="product">
        <product>
            <xsl:apply-templates select="*[not(name()='contributor')]"/> <!-- Herausgeber werdern zusammengefasst und müssen daher seperat ermittelt werden -->
            <xsl:call-template name="contributors"/>
        </product>
    </xsl:template>
    
    
    <xsl:template name="contributors">
        <Contributer>
            <xsl:for-each-group group-by="b035" select="contributor">
                <xsl:variable name="c-role">
                    <xsl:choose>
                        <xsl:when test="current-grouping-key()='A01'">Autor(en):</xsl:when>
                        <xsl:when test="current-grouping-key()='A15'">Einleitung von</xsl:when>
                        <xsl:when test="current-grouping-key()='B01'">Herausgegeben von</xsl:when>
                        <xsl:when test="current-grouping-key()='A19'">Nachwort von</xsl:when>
                        <xsl:when test="current-grouping-key()='B06'">Übersetzt von</xsl:when>
                        <xsl:when test="current-grouping-key()='A23'">Vorwort von</xsl:when>
                        <xsl:when test="current-grouping-key()='B05'">Bearbeitet von</xsl:when>
                        <xsl:when test="current-grouping-key()='A33'">Anhang von</xsl:when>
                        <xsl:when test="current-grouping-key()='A20'">Anmerkungen von</xsl:when>
                        <xsl:when test="current-grouping-key()='B25'">Arrangiert von</xsl:when>
                        <xsl:when test="current-grouping-key()='E99'">Aufgeführt von</xsl:when>
                        <xsl:when test="current-grouping-key()='F99'">Aufgezeichnet von</xsl:when>
                        <xsl:when test="current-grouping-key()='C02'">Ausgewählt von</xsl:when>
                        <xsl:when test="current-grouping-key()='B13'">Bandherausgeber:</xsl:when>
                        <xsl:when test="current-grouping-key()='C99'">Bearbeiter (sonst.):</xsl:when>
                        <xsl:when test="current-grouping-key()='B99'">Bearbeitet von</xsl:when>
                        <xsl:when test="current-grouping-key()='B17'">Begründet von</xsl:when>
                        <xsl:when test="current-grouping-key()='A32'">Beiträge von</xsl:when>
                        <xsl:when test="current-grouping-key()='B20'">Beratender Herausgeber:</xsl:when>
                        <xsl:when test="current-grouping-key()='A31'">Buch und Lieder von</xsl:when>
                        <xsl:when test="current-grouping-key()='B11'">Chefredakteur:</xsl:when>
                        <xsl:when test="current-grouping-key()='A26'">Denkschrift</xsl:when>
                        <xsl:when test="current-grouping-key()='D03'">Dirigent</xsl:when>
                        <xsl:when test="current-grouping-key()='B22'">Dramatisiert von</xsl:when>
                        <xsl:when test="current-grouping-key()='A03'">Drehbuch von</xsl:when>
                        <xsl:when test="current-grouping-key()='A29'">Einführung und Anmerkungen von</xsl:when>
                        <xsl:when test="current-grouping-key()='A24'">Einführung von</xsl:when>
                        <xsl:when test="current-grouping-key()='A09'">Entwurf von</xsl:when>
                        <xsl:when test="current-grouping-key()='A22'">Epilog von</xsl:when>
                        <xsl:when test="current-grouping-key()='A14'">Erläuternder Text von</xsl:when>
                        <xsl:when test="current-grouping-key()='A38'">Erstverfasser:</xsl:when>
                        <xsl:when test="current-grouping-key()='E03'">Erzählt von</xsl:when>
                        <xsl:when test="current-grouping-key()='A27'">Experimente von</xsl:when>
                        <xsl:when test="current-grouping-key()='A42'">fortgeführt von</xsl:when>
                        <xsl:when test="current-grouping-key()='A13'">Foto(s) von</xsl:when>
                        <xsl:when test="current-grouping-key()='A08'">Fotograf:</xsl:when>
                        <xsl:when test="current-grouping-key()='B18'">Für die Veröffentlichung vorbereitet von</xsl:when>
                        <xsl:when test="current-grouping-key()='A25'">Fussnoten von</xsl:when>
                        <xsl:when test="current-grouping-key()='B12'">Gastherausgeber:</xsl:when>
                        <xsl:when test="current-grouping-key()='F01'">Gefilmt / Fotografiert von</xsl:when>
                        <xsl:when test="current-grouping-key()='B04'">Gekürzt von</xsl:when>
                        <xsl:when test="current-grouping-key()='E07'">Gelesen von</xsl:when>
                        <xsl:when test="current-grouping-key()='E08'">Gespielt von</xsl:when>
                        <xsl:when test="current-grouping-key()='B21'">Hauptschriftleiter:</xsl:when>
                        <xsl:when test="current-grouping-key()='B15'">Herausgeberische Koordinierung:</xsl:when>
                        <xsl:when test="current-grouping-key()='B10'">Herausgegeben und übersetzt von</xsl:when>
                        <xsl:when test="current-grouping-key()='A10'">Idee von</xsl:when>
                        <xsl:when test="current-grouping-key()='A12'">Illustriert von</xsl:when>
                        <xsl:when test="current-grouping-key()='A34'">Index von</xsl:when>
                        <xsl:when test="current-grouping-key()='E06'">Instrumentalsolist:</xsl:when>
                        <xsl:when test="current-grouping-key()='A43'">Interviewer</xsl:when>
                        <xsl:when test="current-grouping-key()='A44'">Interviewter</xsl:when>
                        <xsl:when test="current-grouping-key()='A39'">Karten von</xsl:when>
                        <xsl:when test="current-grouping-key()='A40'">koloriert von</xsl:when>
                        <xsl:when test="current-grouping-key()='E04'">Kommentator:</xsl:when>
                        <xsl:when test="current-grouping-key()='A21'">Kommentiert von</xsl:when>
                        <xsl:when test="current-grouping-key()='B08'">Kommentierte Übersetzung von</xsl:when>
                        <xsl:when test="current-grouping-key()='A06'">Komponiert von</xsl:when>
                        <xsl:when test="current-grouping-key()='A11'">Konzeption von</xsl:when>
                        <xsl:when test="current-grouping-key()='B16'">Leitender Herausgeber:</xsl:when>
                        <xsl:when test="current-grouping-key()='D99'">Leitung (sonst.):</xsl:when>
                        <xsl:when test="current-grouping-key()='A04'">Libretto von</xsl:when>
                        <xsl:when test="current-grouping-key()='A05'">Liedtext von</xsl:when>
                        <xsl:when test="current-grouping-key()='B24'">literarischer Herausgeber:</xsl:when>
                        <xsl:when test="current-grouping-key()='A07'">Maler:</xsl:when>
                        <xsl:when test="current-grouping-key()='B14'">Redaktion:</xsl:when>
                        <xsl:when test="current-grouping-key()='B19'">Mitherausgeber:</xsl:when>
                        <xsl:when test="current-grouping-key()='Z99'">Mitwirkung (sonst.):</xsl:when>
                        <xsl:when test="current-grouping-key()='B07'">Nach einer Erzählung von</xsl:when>
                        <xsl:when test="current-grouping-key()='B03'">Nacherzählt von</xsl:when>
                        <xsl:when test="current-grouping-key()='A41'">Pop-ups von</xsl:when>
                        <xsl:when test="current-grouping-key()='D01'">Produzent:</xsl:when>
                        <xsl:when test="current-grouping-key()='A16'">Prolog von</xsl:when>
                        <xsl:when test="current-grouping-key()='D02'">Regie von</xsl:when>
                        <xsl:when test="current-grouping-key()='B09'">Reihe herausgegeben von</xsl:when>
                        <xsl:when test="current-grouping-key()='E05'">Sänger:</xsl:when>
                        <xsl:when test="current-grouping-key()='E01'">Schauspieler:</xsl:when>
                        <xsl:when test="current-grouping-key()='A30'">Software von</xsl:when>
                        <xsl:when test="current-grouping-key()='A18'">Supplement von</xsl:when>
                        <xsl:when test="current-grouping-key()='E02'">Tänzer:</xsl:when>
                        <xsl:when test="current-grouping-key()='B02'">Überarbeitet von</xsl:when>
                        <xsl:when test="current-grouping-key()='A36'">Umschlaggestaltung von</xsl:when>
                        <xsl:when test="current-grouping-key()='Z01'">Unterstützt von</xsl:when>
                        <xsl:when test="current-grouping-key()='A99'">Urheber (sonst.):</xsl:when>
                        <xsl:when test="current-grouping-key()='B23'">Verantwortlicher Berichterstatter:</xsl:when>
                        <xsl:when test="current-grouping-key()='A02'">verfasst mit:</xsl:when>
                        <xsl:when test="current-grouping-key()='A37'">Vorarbeiten von</xsl:when>
                        <xsl:when test="current-grouping-key()='A35'">Zeichnungen von</xsl:when>
                        <xsl:when test="current-grouping-key()='A17'">Zusammenfassung von</xsl:when>
                        <xsl:when test="current-grouping-key()='C01'">Zusammengestellt von</xsl:when>
                        <xsl:otherwise>
                            <xsl:text>TYP NICHT ERFASST</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:value-of select="$c-role"/><xsl:text> </xsl:text>
                <xsl:for-each select="current-group()">
                    
                
                    <xsl:sort select="b034" data-type="number"/>
                    <xsl:if test="not(position()=1)"><xsl:text>, </xsl:text></xsl:if>
                    <xsl:if test="b038"><xsl:value-of select="b038"/><xsl:text> </xsl:text></xsl:if>
                    <xsl:value-of select="b036"/>
                </xsl:for-each>
                
                <xsl:if test="not(position() = last())" ><br/></xsl:if>
                
            </xsl:for-each-group>
        </Contributer>
    </xsl:template>

    
    <xsl:template match="a001">
        <RecordReference><xsl:value-of select="text()"/></RecordReference>
    </xsl:template>
    
    <xsl:template match="a002">
        <NotificationType>
            <xsl:choose>
                <xsl:when test="text() = '01'">
                    <xsl:text>Frühe Ankündigung</xsl:text>
                </xsl:when>
                <xsl:when test="text() = '02'">
                    <xsl:text>Vorankündigung</xsl:text>
                </xsl:when>
                <xsl:when test="text() = '03'">
                    <xsl:text>Meldung bei Erscheinen</xsl:text>
                </xsl:when>
                <xsl:when test="text() = '04'">
                    <xsl:text>Aktualisierung</xsl:text>
                </xsl:when>
                <xsl:when test="text() = '05'">
                    <xsl:text>Löschung</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>TYP NICHT ERFASST</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </NotificationType>
    </xsl:template>
    
    <xsl:template match="a195">
        <RecordSourceTypeCode>
            <xsl:choose>
                <xsl:when test="text() = '04'">
                    <xsl:text>Bibliographische Agentur</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>TYP NICHT ERFASST</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </RecordSourceTypeCode>
    </xsl:template>
    
    <xsl:template match="a196">
        <RecordSourceID>
            <xsl:value-of select="text()"/>
        </RecordSourceID>
    </xsl:template>
    
    <xsl:template match="a197">
        <RecordSourceName>
            <xsl:value-of select="text()"/>
        </RecordSourceName>
    </xsl:template>
    
    <xsl:template match="productidentifier">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="productidentifier/b221">
        <xsl:choose>
            <xsl:when test="text() = '01'">
                <xsl:element name="{../b233/text()}"><xsl:value-of select="../b244/text()"/></xsl:element>
            </xsl:when>
            <xsl:when test="text() = '02'">
                <xsl:element name="ISBN-10"><xsl:value-of select="../b244/text()"/></xsl:element>
            </xsl:when>
            <xsl:when test="text() = '03'">
                <xsl:element name="EAN"><xsl:value-of select="../b244/text()"/></xsl:element>
            </xsl:when>
            <xsl:when test="text() = '06'">
                <xsl:element name="DOI"><xsl:value-of select="../b244/text()"/></xsl:element>
            </xsl:when>
            <xsl:when test="text() = '15'">
                <xsl:element name="ISBN-13"><xsl:value-of select="../b244/text()"/></xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>TYP NICHT ERFASST</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="b246">
        <Barcode><xsl:value-of select="text()"/></Barcode>
    </xsl:template>
    
    <xsl:template match="b012">
        <ProductForm>
            <xsl:choose>
                <xsl:when test="text()='BA'">Buch</xsl:when>
                <xsl:when test="text()='BB'">Hardcover</xsl:when>
                <xsl:when test="text()='BC'">Softcover</xsl:when>
                <xsl:when test="text()='BD'">Loseblattwerk</xsl:when>
                <xsl:when test="text()='BE'">Spiralbindung</xsl:when>
                <xsl:when test="text()='BF'">Geheftet</xsl:when>
                <xsl:when test="text()='BG'">Leder / Künstler. Einbd.</xsl:when>
                <xsl:when test="text()='BH'">Kinder-Pappbuch</xsl:when>
                <xsl:when test="text()='BI'">Kinder-Stoffbuch</xsl:when>
                <xsl:when test="text()='BJ'">Kinder-Badebuch</xsl:when>
                <xsl:when test="text()='BK'">Spielzeugbuch</xsl:when>
                <xsl:when test="text()='BL'">Geklebt</xsl:when>
                <xsl:when test="text()='BM'">Großbuch</xsl:when>
                <xsl:when test="text()='BN'">Teilwerk</xsl:when>
                <xsl:when test="text()='BO'">Leporello</xsl:when>
                <xsl:when test="text()='BZ'">Buch (sonst.)</xsl:when>
                <xsl:when test="text()='DA'">Digital Digitales oder Multimedia-Produkt</xsl:when>
                <xsl:when test="text()='DB'">CD-ROM</xsl:when>
                <xsl:when test="text()='DC'">CD</xsl:when>
                <xsl:when test="text()='DE'">Computerspiel</xsl:when>
                <xsl:when test="text()='DF'">Diskette</xsl:when>
                <xsl:when test="text()='DG'">E-Book</xsl:when>
                <xsl:when test="text()='DH'">Datenbank</xsl:when>
                <xsl:when test="text()='DI'">DVD</xsl:when>
                <xsl:when test="text()='DJ'">Secure Digital (SD) Memory Card</xsl:when>
                <xsl:when test="text()='DK'">Compact Flash Memory Card</xsl:when>
                <xsl:when test="text()='DL'">Memory Stick Memory Card</xsl:when>
                <xsl:when test="text()='DM'">USB Flash Drive</xsl:when>
                <xsl:when test="text()='DN'">CD/DVD (doppelseitig)</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </ProductForm>
    </xsl:template>
    
    <xsl:template match="b333">
        <ProductFormDetail>
            <xsl:choose>
                <xsl:when test="text()='B301'">Loseblattwerk mit Sammelordner</xsl:when>
                <xsl:when test="text()='B302'">Sammelordner</xsl:when>
                <xsl:when test="text()='B303'">Loseblattwerk</xsl:when>
                <xsl:when test="text()='B304'">Fadengeheftet</xsl:when>
                <xsl:when test="text()='B305'">Geklebt</xsl:when>
                <xsl:when test="text()='B306'">Bibliothekseinband</xsl:when>
                <xsl:when test="text()='B308'">Halbband</xsl:when>
                <xsl:when test="text()='B312'">Wire-O</xsl:when>
                <xsl:when test="text()='B401'">Leinen</xsl:when>
                <xsl:when test="text()='B402'">Pappband</xsl:when>
                <xsl:when test="text()='B403'">Leder</xsl:when>
                <xsl:when test="text()='B404'">Leder (Imitat)</xsl:when>
                <xsl:when test="text()='B405'">Leder (kaschiert)</xsl:when>
                <xsl:when test="text()='B406'">Pergament</xsl:when>
                <xsl:when test="text()='B407'">Kunststoff</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </ProductFormDetail>
    </xsl:template>
    
    <xsl:template match="b210">
        <NumberOfPieces>
            <xsl:value-of select="text()"/>
        </NumberOfPieces>
    </xsl:template>
    
    <xsl:template match="b211">
        <EpubType>
            <xsl:choose>
                <xsl:when test="text()='000'">E-Publikation</xsl:when>
                <xsl:when test="text()='001'">HTML</xsl:when>
                <xsl:when test="text()='002'">PDF</xsl:when>
                <xsl:when test="text()='003'">PDF-Merchant</xsl:when>
                <xsl:when test="text()='004'">Adobe Ebook Reader</xsl:when>
                <xsl:when test="text()='005'">Microsoft Reader Level 1/Level 3</xsl:when>
                <xsl:when test="text()='006'">Microsoft Reader Level 5</xsl:when>
                <xsl:when test="text()='007'">NetLibrary</xsl:when>
                <xsl:when test="text()='008'">MetaText</xsl:when>
                <xsl:when test="text()='009'">MightyWords</xsl:when>
                <xsl:when test="text()='010'">Palm Reader</xsl:when>
                <xsl:when test="text()='011'">Softbook</xsl:when>
                <xsl:when test="text()='012'">RocketBook</xsl:when>
                <xsl:when test="text()='013'">Gemstar REB 1100</xsl:when>
                <xsl:when test="text()='014'">Gemstar REB 1200</xsl:when>
                <xsl:when test="text()='015'">Franklin eBookman</xsl:when>
                <xsl:when test="text()='016'">Books24x7</xsl:when>
                <xsl:when test="text()='017'">DigitalOwl</xsl:when>
                <xsl:when test="text()='018'">Handheldmed</xsl:when>
                <xsl:when test="text()='019'">WizeUp</xsl:when>
                <xsl:when test="text()='020'">TK3</xsl:when>
                <xsl:when test="text()='021'">Litraweb</xsl:when>
                <xsl:when test="text()='022'">MobiPocket</xsl:when>
                <xsl:when test="text()='023'">Open Ebook</xsl:when>
                <xsl:when test="text()='024'">Town Compass DataViewer</xsl:when>
                <xsl:when test="text()='025'">TXT</xsl:when>
                <xsl:when test="text()='026'">ExeBook</xsl:when>
                <xsl:when test="text()='027'">Sony BBeB</xsl:when>
                <xsl:when test="text()='099'">unspezifiziert</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </EpubType>
    </xsl:template>
    
    <xsl:template match="b214">
        <EpubFormat>
            <xsl:choose>
                <xsl:when test="text()='01'">HTML</xsl:when>
                <xsl:when test="text()='02'">PDF</xsl:when>
                <xsl:when test="text()='03'">Microsoft Reader</xsl:when>
                <xsl:when test="text()='04'">RocketBook</xsl:when>
                <xsl:when test="text()='05'">Rich text format (RTF)</xsl:when>
                <xsl:when test="text()='06'">Open Ebook Publication Structure (OEBPS) format standard</xsl:when>
                <xsl:when test="text()='07'">XML</xsl:when>
                <xsl:when test="text()='08'">SGML</xsl:when>
                <xsl:when test="text()='09'">EXE</xsl:when>
                <xsl:when test="text()='10'">ASCII</xsl:when>
                <xsl:when test="text()='11'">MobiPocket format</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </EpubFormat>
    </xsl:template>
    
    <xsl:template match="series">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="series/seriesidentifier">
       <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="series/seriesidentifier/b273">
        <SeriesIDType>
            <xsl:choose>
                <xsl:when test="text()='01'">Proprietär</xsl:when>
                <xsl:when test="text()='02'">ISSN</xsl:when>
                <xsl:when test="text()='04'">VLB Reihen-ID</xsl:when>
                <xsl:when test="text()='06'">DOI</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </SeriesIDType>
    </xsl:template>
    
    <xsl:template match="series/seriesidentifier/b233">
        <IDTypeName><xsl:value-of select="text()"/></IDTypeName>
    </xsl:template>
    
    <xsl:template match="series/seriesidentifier/b244">
        <IDValue><xsl:value-of select="text()"/></IDValue>
    </xsl:template>
    
    <xsl:template match="product/title">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="title/b202">
        <TitleType>
            <xsl:choose>
                <xsl:when test="text()='01'">Eindeutiger Titel</xsl:when>
                <xsl:when test="text()='03'">Originaltitel</xsl:when>
                <xsl:when test="text()='05'">Kurztitel</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </TitleType>
    </xsl:template>
    
    <xsl:template match="title/b203">
        <TitleText><xsl:value-of select="text()"/></TitleText>
    </xsl:template>
    
    <xsl:template match="title/b029">
        <Subtitle><xsl:value-of select="text()"/></Subtitle>
    </xsl:template>
    
    <xsl:template match="b057">
        <EditionNumber><xsl:value-of select="text()"/></EditionNumber>
    </xsl:template>
    
    <xsl:template match="b058">
        <EditionStatement><xsl:value-of select="text()"/></EditionStatement>
    </xsl:template>
    
    <xsl:template match="language">
        <xsl:apply-templates select="b252|b253"/>
    </xsl:template>
    
    <xsl:template match="language/b252">
        <LanguageCode>
            <xsl:choose>
                <xsl:when test="text()='07'">Masterarbeit</xsl:when>
                <xsl:when test="text()='ger'">Deutsch</xsl:when>
                <xsl:when test="text()='gsw'">Schweizerdeutsch</xsl:when>
                <xsl:when test="text()='eng'">Englisch</xsl:when>
                <xsl:when test="text()='fre'">Französisch</xsl:when>
                <xsl:when test="text()='ita'">Italienisch</xsl:when>
                <xsl:when test="text()='spa'">Spanisch</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </LanguageCode>
    </xsl:template>
    
    <xsl:template match="language/b253">
        <LanguageRole>
            <xsl:choose>
                <xsl:when test="text()='01'">Produktsprache</xsl:when>
                <xsl:when test="text()='02'">Originalsprache</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </LanguageRole>
    </xsl:template>
    
    <xsl:template match="b255">
        <PagesArabic><xsl:value-of select="text()"/></PagesArabic>
    </xsl:template>
    
    <xsl:template match="b062">
        <IllustrationsNote><xsl:value-of select="text()"/></IllustrationsNote>
    </xsl:template>
    
    <xsl:template match="mainsubject">
        <xsl:apply-templates select="b191|b068|b069"/>
    </xsl:template>
    
    <xsl:template match="mainsubject/b191">
        <MainSubjectSchemeIdentifier><xsl:value-of select="text()"/></MainSubjectSchemeIdentifier>
    </xsl:template>
    
    <xsl:template match="mainsubject/b068">
        <SubjectSchemeVersion><xsl:value-of select="text()"/></SubjectSchemeVersion>
    </xsl:template>
    
    <xsl:template match="mainsubject/b069">
        <SubjectCode><xsl:value-of select="text()"/></SubjectCode>
    </xsl:template>
    
    <xsl:template match="subject">
        <xsl:apply-templates select="b070|b067|b069"/>
    </xsl:template>
    
    <xsl:template match="subject/b070">
        <SubjectHeadingText><xsl:value-of select="text()"/></SubjectHeadingText>
    </xsl:template>
    
    <xsl:template match="subject/b067">
        <SubjectSchemeIdentifier>
            <xsl:choose>
                <xsl:when test="text()='20'">Stichwort</xsl:when>
                <xsl:when test="text()='23'">Verlagseigener Kategorie</xsl:when>
                <xsl:when test="text()='24'">Proprietäres Schlagwortschema</xsl:when>
                <xsl:when test="text()='27'">Schlagwort-Normdatei der DNB</xsl:when>
                <xsl:when test="text()='30'">DNB-Sachgruppen (alt)</xsl:when>
                <xsl:when test="text()='36'">DDC Deutsch</xsl:when>
                <xsl:when test="text()='59'">VdS Bildungsmedien Fächer</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </SubjectSchemeIdentifier>
    </xsl:template>
    
    <xsl:template match="subject/b069">
        <SubjectCode><xsl:value-of select="text()"/></SubjectCode>
    </xsl:template>
    
    <xsl:template match="b207">
        <AudienceDescription><xsl:value-of select="text()"/></AudienceDescription>
    </xsl:template>
    
    <xsl:template match="othertext">
        <xsl:apply-templates select="d102|d103|d104|d105|d106|d109"/>
    </xsl:template>
    
    <xsl:template match="othertext/d102">
        <TextTypeCode>
            <xsl:choose>
                <xsl:when test="text()='01'">Hauptbeschreibung</xsl:when>
                <xsl:when test="text()='02'">Kurzbeschreibung</xsl:when>
                <xsl:when test="text()='03'">Ausführliche Beschreibung</xsl:when>
                <xsl:when test="text()='04'">Inhaltsverzeichnis</xsl:when>
                <xsl:when test="text()='07'">Rezension</xsl:when>
                <xsl:when test="text()='08'">Rezensionszitat</xsl:when>
                <xsl:when test="text()='13'">Biografische Anmerkung</xsl:when>
                <xsl:when test="text()='18'">Text der Buchrückseite</xsl:when>
                <xsl:when test="text()='23'">Textauszug</xsl:when>
                <xsl:when test="text()='24'">Erstes Kapitel</xsl:when>
                <xsl:when test="text()='25'">Verkaufshinweise</xsl:when>
                <xsl:when test="text()='33'">Einführung oder Vorwort</xsl:when>
                <xsl:when test="text()='99'">99</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </TextTypeCode>
    </xsl:template>
    
    <xsl:template match="othertext/d103">
        <TextFormat>
            <xsl:choose>
                <xsl:when test="text()='02'">HTML</xsl:when>
                <xsl:when test="text()='05'">XHTML</xsl:when>
                <xsl:when test="text()='06'">Textformat (Voreinstellung)</xsl:when>
                <xsl:when test="text()='07'">Basic ASCII text</xsl:when>
                <xsl:when test="text()='08'">PDF</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </TextFormat>
    </xsl:template>
    
    <xsl:template match="othertext/d104">
        <Text><xsl:value-of select="text()"/></Text>
    </xsl:template>
    
    <xsl:template match="othertext/d105">
        <TextLinkType>
            <xsl:choose>
                <xsl:when test="text()='01'">URL</xsl:when>
                <xsl:when test="text()='02'">DOI</xsl:when>
                <xsl:when test="text()='05'">FTP-Addresse</xsl:when>
                <xsl:when test="text()='06'">Dateiname</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </TextLinkType>
    </xsl:template>
    
    <xsl:template match="othertext/d106">
        <TextLink><xsl:value-of select="text()"/></TextLink>
    </xsl:template>
    
    <xsl:template match="othertext/d109">
        <TextPublicationDate><xsl:value-of select="concat(substring(text(),7,2),'.',substring(text(),5,2),'.',substring(text(),1,4))"/></TextPublicationDate>
    </xsl:template>
    
    <xsl:template match="mediafile">
        <xsl:apply-templates select="f114|f115|f116|f117|f259"/>
    </xsl:template>
    
    <xsl:template match="mediafile/f114">
        <MediaFileTypeCode>
            <xsl:choose>
                <xsl:when test="text()='01'">Whole product</xsl:when>
                <xsl:when test="text()='03'">Image: whole cover</xsl:when>
                <xsl:when test="text()='04'">Image: front cover</xsl:when>
                <xsl:when test="text()='05'">Image: whole cover, high quality</xsl:when>
                <xsl:when test="text()='06'">Image: front cover, high quality</xsl:when>
                <xsl:when test="text()='07'">Image: front cover thumbnail</xsl:when>
                <xsl:when test="text()='08'">Image: contributor(s)</xsl:when>
                <xsl:when test="text()='10'">Image: for series</xsl:when>
                <xsl:when test="text()='11'">Image: series logo</xsl:when>
                <xsl:when test="text()='12'">Image: product logo</xsl:when>
                <xsl:when test="text()='16'">Image: Master brand logo</xsl:when>
                <xsl:when test="text()='17'">Image: publisher logo</xsl:when>
                <xsl:when test="text()='18'">Image: imprint logo</xsl:when>
                <xsl:when test="text()='22'">Image: table of contents</xsl:when>
                <xsl:when test="text()='23'">Image: sample content</xsl:when>
                <xsl:when test="text()='24'">Image: back cover</xsl:when>
                <xsl:when test="text()='25'">Image: back cover, high quality</xsl:when>
                <xsl:when test="text()='26'">Image: back cover thumbnail</xsl:when>
                <xsl:when test="text()='27'">Image: other cover material</xsl:when>
                <xsl:when test="text()='28'">Image: promotional material</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </MediaFileTypeCode>
    </xsl:template>
    
    <xsl:template match="mediafile/f115">
        <MediaFileFormatCode>
            <xsl:choose>
                <xsl:when test="text()='02'">GIF</xsl:when>
                <xsl:when test="text()='03'">JPEG</xsl:when>
                <xsl:when test="text()='04'">PDF</xsl:when>
                <xsl:when test="text()='05'">TIF</xsl:when>
                <xsl:when test="text()='06'">RealAudio 28.8</xsl:when>
                <xsl:when test="text()='07'">MP3</xsl:when>
                <xsl:when test="text()='08'">MPEG-4</xsl:when>
                <xsl:when test="text()='09'">PNG</xsl:when>
                <xsl:when test="text()='10'">WMA</xsl:when>
                <xsl:when test="text()='11'">AAC</xsl:when>
                <xsl:when test="text()='12'">WAV</xsl:when>
                <xsl:when test="text()='13'">AIFF</xsl:when>
                <xsl:when test="text()='14'">WMV</xsl:when>
                <xsl:when test="text()='15'">OGG</xsl:when>
                <xsl:when test="text()='16'">AVI</xsl:when>
                <xsl:when test="text()='17'">MOV</xsl:when>
                <xsl:when test="text()='18'">Flash</xsl:when>
                <xsl:when test="text()='19'">3GP</xsl:when>
                <xsl:when test="text()='20'">WebM</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </MediaFileFormatCode>
    </xsl:template>
    
    <xsl:template match="mediafile/f259">
        <ImageResolution><xsl:value-of select="text()"/></ImageResolution>
    </xsl:template>
    
    <xsl:template match="mediafile/f116">
        <MediaFileLinkTypeCode>
            <xsl:choose>
                <xsl:when test="text()='01'">URL</xsl:when>
                <xsl:when test="text()='02'">DOI</xsl:when>
                <xsl:when test="text()='03'">PURL</xsl:when>
                <xsl:when test="text()='04'">URN</xsl:when>
                <xsl:when test="text()='05'">FTP Addresse</xsl:when>
                <xsl:when test="text()='06'">Dateiname</xsl:when>
                <xsl:otherwise>TYP NICHT ERFASST</xsl:otherwise>
            </xsl:choose>
        </MediaFileLinkTypeCode>
    </xsl:template>
    
    <xsl:template match="mediafile/f117">
        <MediaFileLink><xsl:value-of select="text()"/></MediaFileLink>
    </xsl:template>
    
    <!-- weiter mit productwebsite: Zeile 311 -->
    
</xsl:stylesheet>