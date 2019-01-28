<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
    />
    
    <!-- 
    offene Fragen:
    
    was ist bei hbfm.dtd mit den Elementen:
    
    sollten komplett uninteressant sein für diese Umwandlung:
    ROOTELEMENT/@sid
    ROOTELEMENT/@sidword
    exportblocker
    sgml_root_element
    /pub/public
        
    
    
    was ist bei hbfmcc.dtd mit den Elementen:
    
    maindate
    subtitle_rest
    toc_title
    author_info
    area
    date
    
    
    Beobachtungen:
    
    <section number="XIII."> wird zu <section number="XIII." id="sec_13"> , ich denke das sollte okay sein
    
    
    Noch beschreiben:
    
    metadata/paragraph wird umgenannt zu metadata/chapter  <-- noch testen
    
    -->
    
    <!-- identity transform: -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="/rodoc">
        <xsl:variable name="doctype" select="metadata/all_doc_type[@level='2']"/>
        <xsl:element name="{$doctype}">
            <xsl:attribute name="docid"><xsl:value-of select="metadata/docid"/></xsl:attribute>
            <xsl:if test="metadata/altdocid">
                <xsl:attribute name="altdocid"><xsl:call-template name="build_altdocid_string"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="metadata/rawid">
                <xsl:attribute name="rawid"><xsl:value-of select="metadata/rawid/text()"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="metadata/extid">
                <xsl:attribute name="extid"><xsl:value-of select="metadata/extid/text()"/></xsl:attribute>
            </xsl:if>
            <!--<xsl:apply-templates select="*"/>-->
            <metadata>
                <!--<title><xsl:apply-templates select="metadata/title/*"/></title>-->
                <xsl:copy-of select="metadata/title | metadata/subtitle | metadata/coll_title"></xsl:copy-of>
                <xsl:if test="metadata/author_info"><authors><xsl:apply-templates select="metadata/author_info/node()"/></authors></xsl:if>
                <xsl:copy-of select="metadata/summary[not(@generated)] | metadata/leitsaetze | metadata/keywords | metadata/ressort | metadata/rubriken"></xsl:copy-of>
                <xsl:apply-templates select="metadata/pub"/>
                <xsl:if test="metadata/origfile">
                    <extfile>
                        <xsl:attribute name="display">
                            <xsl:value-of select="metadata/origfile/@display"/>
                        </xsl:attribute>
                        <xsl:if test="metadata/type"><xsl:attribute name="type"><xsl:value-of select="metadata/type/text()"/></xsl:attribute></xsl:if>
                        <xsl:value-of select="metadata/origfile"/>
                    </extfile>
                </xsl:if>
                <xsl:copy-of select="metadata/law"/>
                
                <xsl:apply-templates select="metadata/instdoc | metadata/preinstdocs"/>
                
                <xsl:copy-of select="metadata/law_refs"/>
                
                
                <xsl:apply-templates select="metadata/paragraph"/>
                <!--<all_doc_type level="1"></all_doc_type>
                <all_source level="1"></all_source>
                <all_source level="2"></all_source>-->
                <xsl:apply-templates select="metadata/all_doc_type[@level='1'] | metadata/all_source"/>
            </metadata>
            <body>
               <xsl:apply-templates select="xml_body/node()"/>
            </body>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pub">
        <pub>
            <pubtitle><xsl:value-of select="pubtitle"/></pubtitle>
            <pubabbr><xsl:value-of select="pubabbr"/></pubabbr>
            <pubyear><xsl:value-of select="pubyear"/></pubyear>
            <pubedition><xsl:value-of select="pubedition"/></pubedition>
            <date><xsl:value-of select="ancestor::metadata/date/text()"/></date>
            <xsl:copy-of select="pub_suppl"></xsl:copy-of>
            <pages><xsl:apply-templates select="pages/node()"/></pages>
            <xsl:copy-of select="pages_alt"></xsl:copy-of>
            <xsl:apply-templates select="public"/>
            <xsl:copy-of select="add_target | version"></xsl:copy-of>
        </pub>
    </xsl:template>
    
    <xsl:template match="metadata/paragraph">
        <chapter><xsl:value-of select="text()"/></chapter>
    </xsl:template>
    
    <xsl:template match="intermed_page"></xsl:template>
    
    <!-- Das public Element muss bei hbfm.dtd validen Dokumenten leer sein: -->
    <xsl:template match="public/text()"></xsl:template>
    
    <xsl:template match="inst">
        <inst>
            <xsl:attribute name="type"><xsl:value-of select="following-sibling::insttype"/></xsl:attribute>
            <xsl:attribute name="code"><xsl:value-of select="following-sibling::instcode"/></xsl:attribute>
            <xsl:value-of select="text()"/>
        </inst>
    </xsl:template>
    
    <xsl:template match="insttype | instcode">
    </xsl:template>
    
    <!-- Generiert einen Kommata getrennten String aus allen altdocids: -->
    <xsl:template name="build_altdocid_string">
        <xsl:for-each select="metadata/altdocid">
            <xsl:value-of select="text()"/><xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>