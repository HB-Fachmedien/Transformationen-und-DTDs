<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs saxon"
    version="2.0">
    
    <xsl:output indent="yes"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
    />

<!-- WICHITG ZU BEACHTEN BEI DER TRANSFORMATION:
        
        Leere Rubriken? Steht manchmal im Attribut. Könnte man noch anpassen.. ;)
        
        distinct-values(//*[matches(name(),'VERWEIS')]/name())


### GUCKEN, OB BEIM BODY ALLE ELEMENTE ABGEARBEITET HABEN, BEARBEITE BISHER FOLGENDE ELEMENTE:  <xsl:apply-templates select="ABS|ZWI|HV|VERWEIS-GS|VERWEIS-ID|VERWEIS-ES"/>

AUSSERDEM:

### IM QUELLDOKUMENT NACH &amp; ENTITIES SUCHEN, DIE GEHEN VERMUTLICH BEI DER sx.exe TRANSFORMATION VERLOREN

### KEIN INTEND AUF QUELLDOKUMENT VOR KONVERTIERUNG!

### RUBRIKEN neuerdings in Attributen?

-->


    
    <xsl:template match="ZEITSCHRIFT-BEITRAG/MEINUNG">
        
        <xsl:variable name="sevenDigitID">
            <xsl:call-template name="calculateDocId">
                <xsl:with-param name="id" select="@DOKID"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="rubrikenwert" select="@RU"/>
        
        <nbb rawid="{@DOKID}" docid="{concat('DB',$sevenDigitID)}">
            <metadata>
                <title><xsl:value-of select="TITEL"/></title>
                <authors>
                    <xsl:for-each select="AUTOR/PERSON">
                        <author>
                            <prefix><xsl:value-of select="text()[1]"/></prefix>
                            <firstname><xsl:value-of select="VORNAME"/></firstname>
                            <surname><xsl:value-of select="NACHNAME"/></surname>
                            <suffix><xsl:value-of select="text()[2]"/></suffix>
                        </author>
                    </xsl:for-each>
                </authors>
                <ressort><xsl:value-of select="lower-case($rubrikenwert)"/></ressort>
                
                <xsl:if test="not(RUBRIK-NORMIERT/@RU='')">
                    <rubriken>
                        <rubrik><xsl:value-of select="concat(upper-case(substring(RUBRIK-NORMIERT/@RU,1,1)),lower-case(substring(RUBRIK-NORMIERT/@RU,2)))"/></rubrik>
                    </rubriken>
                </xsl:if>
                
                <pub>
                    <pubtitle>
                        <xsl:choose>
                            <xsl:when test="$rubrikenwert='SR'">
                                <xsl:text>Steuerboard-Blog</xsl:text>
                            </xsl:when>
                            <xsl:when test="$rubrikenwert='AR'">
                                <xsl:text>Rechtsboard-Blog</xsl:text>
                            </xsl:when>
                            <xsl:when test="$rubrikenwert='WR'">
                                <xsl:text>Rechtsboard-Blog</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </pubtitle>
                    <pubabbr>DB</pubabbr>
                    <pubyear><xsl:value-of select="PUB/INTERNET/DATUM/JAHR"/></pubyear>
                    <pubedition/>
                    <date><xsl:value-of select="PUB/INTERNET/DATUM/JAHR"/>-<xsl:value-of select="format-number(PUB/INTERNET/DATUM/MONAT,'00')"/>-<xsl:value-of select="format-number(PUB/INTERNET/DATUM/TAG,'00')"/></date>
                    <pages>
                        <start_page/>
                        <article_order>1</article_order>
                    </pages>
                </pub>
                <all_doc_type level="1">nb</all_doc_type>
                <all_source level="1">news</all_source>
                <all_source level="2">
                    <xsl:choose>
                        <xsl:when test="$rubrikenwert='SR'">
                            <xsl:text>sb</xsl:text>
                        </xsl:when>
                        <xsl:when test="$rubrikenwert='AR'">
                            <xsl:text>rb</xsl:text>
                        </xsl:when>
                        <xsl:when test="$rubrikenwert='WR'">
                            <xsl:text>rb</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </all_source>
                <sgml_root_element doctype="MEINUNG">
                    <xsl:value-of select="concat(name(), ' DOKID=', @DOKID, ' RU=', @RU, ' MID=', @MID, ' MDATUM=', @MDATUM)"/>
                </sgml_root_element>
            </metadata>
            
            <!-- was kommt hier alles? ABS/ZWI/HV/VERWEIS-GS -->
            <body><xsl:apply-templates select="ABS|ZWI|HV|VERWEIS-GS|VERWEIS-S|VERWEIS-RS|VERWEIS-ID|VERWEIS-ES|LISTE"/></body>
        </nbb>
    </xsl:template>
    
    <xsl:template match="HV">
        <xsl:choose>
            <xsl:when test="@TYP='KURSIV'"><i><xsl:apply-templates/></i></xsl:when>
            <xsl:when test="@TYP='FETT'"><b><xsl:apply-templates/></b></xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="ZWI">
        <subhead><xsl:apply-templates/></subhead>
    </xsl:template>
    
    <xsl:template match="LISTE">
        <list type="dash"><xsl:apply-templates/></list>
    </xsl:template>
    
    <xsl:template match="LE">
        <listitem><p><xsl:apply-templates/></p></listitem>
    </xsl:template>
    
    <xsl:template match="ABS">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
    
    <!--<xsl:template match="text()[not(string-length(normalize-space()))]"/>
    
    <xsl:template match=
        "text()[string-length(normalize-space()) > 0]">
        <xsl:value-of select="translate(.,'&#xA;&#xD;', '  ')"/>
    </xsl:template>-->
    
    <!--<xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>-->
    
</xsl:stylesheet>