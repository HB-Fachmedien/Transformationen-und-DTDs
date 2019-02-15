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
    
    <xsl:strip-space elements="*"/>
    
    <!-- identity transform: -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="/rodoc">
        <xsl:variable name="doctype">
            <xsl:choose>
                <xsl:when test="metadata/all_doc_type[@level='2'] = ('fb', 'hb', 'rg', 'abc')">
                    <xsl:text>fb</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="metadata/all_doc_type[@level='2']"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
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
                <xsl:copy-of select="metadata/summary | metadata/leitsaetze | metadata/keywords | metadata/ressort | metadata/rubriken"></xsl:copy-of>
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
                
                <xsl:apply-templates select="metadata/toc"/>
                
                <xsl:copy-of select="metadata/inner_toc"/>
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
    
    <xsl:template match="metadata/toc">
        <global_toc>
            <xsl:apply-templates/>
        </global_toc>
    </xsl:template>
    
    <xsl:template match="pub">
        <pub>
            <pubtitle><xsl:value-of select="pubtitle"/></pubtitle>
            <pubabbr><xsl:value-of select="pubabbr"/></pubabbr>
            <pubyear><xsl:value-of select="pubyear"/></pubyear>
            <pubedition><xsl:value-of select="pubedition"/></pubedition>
            <date><xsl:value-of select="ancestor::metadata/date/text()"/></date>
            <xsl:copy-of select="pub_suppl"></xsl:copy-of>
            <xsl:if test="pages">
                <pages><xsl:apply-templates select="pages/node()"/></pages>
            </xsl:if>
            <xsl:copy-of select="pages_alt"></xsl:copy-of>
            <xsl:apply-templates select="public"/>
            <xsl:copy-of select="add_target | version"></xsl:copy-of>
        </pub>
    </xsl:template>
    
    <xsl:template match="metadata/paragraph">
        <chapter><xsl:value-of select="text()"/></chapter>
    </xsl:template>
    
    <xsl:template match="intermed_page">
        <intermed_pages><xsl:value-of select="text()"/></intermed_pages>
    </xsl:template>
    
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
    
    
    <!-- Wir haben uns auf eine Umbenennung der Link Element Attribute geeinigt: -->
    <xsl:template match="link">
        <link>
            <xsl:if test="@a">
                <xsl:attribute name="anchor"><xsl:value-of select="@a"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_docid">
                <xsl:attribute name="meta_docid"><xsl:value-of select="@all_docid"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_lawabbr">
                <xsl:attribute name="meta_lawabbr"><xsl:value-of select="@all_lawabbr"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_artnum">
                <xsl:attribute name="meta_artnum"><xsl:value-of select="@all_artnum"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_paragraph">
                <xsl:attribute name="meta_chapter"><xsl:value-of select="@all_paragraph"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@meta_context">
                <xsl:attribute name="meta_context"><xsl:value-of select="@meta_context"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_source">
                <xsl:attribute name="meta_target"><xsl:value-of select="@all_source"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_rubrik">
                <xsl:attribute name="meta_rubrik"><xsl:value-of select="@all_rubrik"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@all_rz">
                <xsl:attribute name="meta_marginnr"><xsl:value-of select="@all_rz"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@ts_page">
                <xsl:attribute name="meta_page"><xsl:value-of select="@ts_page"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@ts_pubedition">
                <xsl:attribute name="meta_pubedition"><xsl:value-of select="@ts_pubedition"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@ts_pubyear">
                <xsl:attribute name="meta_pubyear"><xsl:value-of select="@ts_pubyear"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@generator">
                <xsl:attribute name="generator"><xsl:value-of select="@generator"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </link>
    </xsl:template>
    
    
</xsl:stylesheet>