<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:hbfm="http://www.fachmedien.de/"
    exclude-result-prefixes="xs saxon hbfm"
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
         <ent rawid="{@SIRIUS-ID}">
             <xsl:attribute name="docid">
                 <xsl:value-of select="concat('WUW', $sevenDigitID)"/>
             </xsl:attribute>
             <metadata>
                <title><xsl:value-of select="TITEL"/></title>
                 <xsl:if test="TOPIC[1]/BASENAME[1]/BASENAMESTRING">
                     <keywords><xsl:apply-templates select="TOPIC/BASENAME/BASENAMESTRING"/></keywords>
                 </xsl:if>
                <pub>
                    <pubtitle>Wirtschaft und Wettbewerb</pubtitle>
                    <pubabbr>WUW</pubabbr>
                    <pubyear><xsl:value-of select="PUB/DATUM/JAHR"/></pubyear>
                    <pubedition><xsl:value-of select="PUB/HEFTNR"/></pubedition>
                    <date><xsl:value-of select="concat(PUB/DATUM/JAHR,'-',PUB/DATUM/MONAT,'-',PUB/DATUM/TAG)"/></date>
                    <pages>
                        <start_page><xsl:value-of select="PUB/SEITEVON"/></start_page>
                        <last_page><xsl:value-of select="PUB/SEITEBIS"/></last_page>
                        <article_order>1</article_order>
                    </pages>
                    <pages_alt>
                        <start_page><xsl:value-of select="PUB/SEITEVON-ALTERNATIV"/></start_page>
                        <last_page><xsl:value-of select="PUB/SEITEBIS-ALTERNATIV"/></last_page>
                        <dept><xsl:value-of select="@RU"/></dept>
                    </pages_alt>
                </pub>
                 <extfile display="true" type="pdf"><xsl:value-of select="replace(DATEI-REF/DATEI/@NAME, '^\s+|\s+$', '')"/></extfile>
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
                    <instdoctype><xsl:value-of select="concat(upper-case(substring(@TYP,1,1)),lower-case(substring(@TYP,2)))"/></instdoctype>
                    <instdocdate><xsl:value-of select="concat(URTZEILE/DATUM/JAHR,'-',URTZEILE/DATUM/MONAT,'-',URTZEILE/DATUM/TAG)"/></instdocdate>
                    <instdocnrs>
                        <instdocnr><xsl:value-of select="URTZEILE/AZ"/></instdocnr>
                    </instdocnrs>
                    <instdocnote><xsl:if test="not(URTZEILE/SCHLAGWORT/starts-with(text(), ' '))"><xsl:text> </xsl:text></xsl:if><xsl:value-of select="URTZEILE/SCHLAGWORT"/></instdocnote>
                </instdoc>
                <all_doc_type level="1">zs</all_doc_type>
                <all_source level="1">zsa</all_source>
                <all_source level="2">wuw</all_source>
             </metadata>
             <body>
                 <p>
                     <xsl:apply-templates select="VOLLTEXT"/>
                 </p>
             </body>
         </ent>
     </xsl:template>
    
    <xsl:template match="BASENAMESTRING">
        <keyword><xsl:value-of select="text()"/></keyword>
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
        <xsl:sequence select="($option/main, $option/*[@diction='true'],$option/@type)"></xsl:sequence>
    </xsl:function>
</xsl:stylesheet>