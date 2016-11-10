<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de"
    exclude-result-prefixes="xs hbfm"
    version="2.0"
    >
    
    <!-- Ein Stylesheet, welches die bisher falsch ausgezeichneten Randzifferblöcke (bisher: span[@class='randziffer']) in die 
        dafür gewünschten rzblock Elemente konvertiert-->

    <xsl:output indent="no"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
        method="xml"
    />
    
    <!-- XPath Ausdrücke:
        es gibt spans unter Listen: //span[@class="randziffer" and not(ancestor::section)]
        
        jeweils die ersten Span Eltern aussuchen: //section/*[descendant::span[deep-equal(., (../..//span)[1])]]
        
        
        Elemente vor den Span Elementen:
        //section/*[descendant::span[deep-equal(., (../..//span)[1])]]/preceding-sibling::*
    
    -->
    
    <!-- Identity Template -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="hbfm:index-of-deep-equal-node" as="xs:integer*">
        <xsl:param name="nodes" as="node()*"/>
        <xsl:param name="nodeToFind" as="node()"/>
        
        <!--<xsl:sequence select="
            for $seq in (1 to count($nodes))
            return $seq[deep-equal($nodes[$seq],$nodeToFind)]
            "/>-->
        
        <xsl:sequence select="
            for $seq in (1 to count($nodes))
            return $seq[$nodes[$seq] is $nodeToFind]
            "/>
        
    </xsl:function>
    
    
    <!-- zweiter Versuch über die Eltern: Klappt nicht, da nachfolgende Geschwister doppelt verarbeitet werden -->
    <xsl:variable name="alle-rz" select="(//span[@class='randziffer'])"/>
    <xsl:template match="*[span[@class='randziffer']]" priority="100">
        
        <xsl:variable name="this-rz" select="span[@class='randziffer']" as="item()*"/>
        <!--<xsl:variable name="index-der-rz" select="index-of($alle-rz, span[@class='randziffer'])"/>-->
        <xsl:variable name="index-der-rz" select="hbfm:index-of-deep-equal-node($alle-rz,span[@class='randziffer'])"/>
        
        <!-- RZ Block bis zur nächsten RZ oder bis das Eltern Element schließt: -->
        <rzblock>
            <rz><xsl:value-of select="span[@class='randziffer']/text()"/></rz>

            <xsl:variable name="elementname">
                <xsl:choose>
                    <xsl:when test="name()='title'">subhead</xsl:when><!-- title ist nicht erlaubt in RZ Blöcken -->
                    <xsl:otherwise><xsl:value-of select="name()"/></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:element name="{$elementname}">
                <xsl:apply-templates/>
            </xsl:element>

            <!--<xsl:apply-templates mode="geschwister-von-rz" select="following-sibling::*[not(descendant::span[@class='randziffer']) and not(preceding-sibling::node()[deep-equal(., ($alle-rz)[$index-der-rz+1])])]"/>-->
            <xsl:apply-templates mode="geschwister-von-rz" select="following-sibling::*[not(descendant::span[@class='randziffer']) and not(preceding-sibling::node()[descendant::*[ self::* is ($alle-rz)[$index-der-rz+1]]])]"/>
        </rzblock>
    </xsl:template>
    
    <xsl:template match="node()" mode="geschwister-von-rz">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node()[not(descendant::span[@class='randziffer'])][preceding-sibling::node()[child::span[@class='randziffer']]]">
    </xsl:template>
      
    <xsl:template match="span[@class='randziffer']"></xsl:template>
    
</xsl:stylesheet>