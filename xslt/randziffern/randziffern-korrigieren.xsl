<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    >
    
    <!-- Ein Stylesheet, welches die bisher falsch ausgezeichneten Randzifferblöcke (bisher: span[@class='randziffer']) in die 
        dafür gewünschten rzblock Elemente konvertiert-->
    
    <!--doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"-->
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
    
    
    <!-- HIER WEITER : Über die Großeltern gehen? sind meißtens sections (fast alle) aber auch block, body und listitem-->
    <!-- tricky Beispiel: DB_1991_04_0203_A_0089539 RZ 7 und 8 sind auf unterschiedlichen Höhen
        und RZ 8 hat vor sich ein p Element, das bisher nicht mit eingeschlossen wird in den neuen rz-block -->
    
    
    <!-- Großeltern haben nie -->
    
    <!-- Identity Template -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- dritter Versuch, wieder über die Großeltern: -->
    <!--<xsl:template match="*[*[span[@class='randziffer']]]">
        <xsl:variable name="depth" select="count(ancestor::*)"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <!-\-<xsl:attribute name="tiefe"><xsl:value-of select="$depth-of-grandparent"/></xsl:attribute>-\->
            <xsl:variable name="alle-rz-in-dieser-section" select="./*/span[@class='randziffer']"/>
            <!-\-<xsl:value-of select="count($alle-rz-in-dieser-section)"/>-\-> <!-\- klappt -\->
            
            <!-\- Für alle Elemente vor der ersten RZ: -\->
            <xsl:for-each select="*[descendant::span[@class='randziffer'][deep-equal(., ($alle-rz-in-dieser-section)[1])]]/preceding-sibling::*">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:for-each>
            
            <!-\- Für alle Elemente, die Randziffern enthalten: -\->
            <xsl:for-each select="$alle-rz-in-dieser-section">
                <xsl:variable name="for-index-position" select="position()"/>
                <xsl:choose>
                    <xsl:when test="position() != last()">
                        <rzblock>
                            <rz><xsl:value-of select="./text()"/></rz>
                            <xsl:apply-templates select="./.. | ./../following-sibling::*[following-sibling::*[descendant::*[deep-equal(., ($alle-rz-in-dieser-section)[$for-index-position+1])]]]"/>
                            <!-\- hier muss die Beschränkung noch rein, dass es nur für RZ mit der Tiefe + 2 gelten darf -\->
                            
                        </rzblock>
                    </xsl:when>
                    <xsl:otherwise>
                        <rzblock>
                            <rz><xsl:value-of select="./text()"/></rz>
                            <xsl:apply-templates select="./.. | ./../following-sibling::*"/>
                        </rzblock>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        
        </xsl:copy>
    </xsl:template>-->
    
    
    <!-- zweiter Versuch über die Eltern: Klappt nicht, da nachfolgende Geschwister doppelt verarbeitet werden -->
    <xsl:variable name="alle-rz" select="//span[@class='randziffer']"/>
    <xsl:template match="*[span[@class='randziffer']]" priority="100">
        
        <xsl:variable name="index-der-rz" select="index-of($alle-rz, span[@class='randziffer'])"/><!-- HIER WEITER!! Den Index in Zeile 107 verwenden! -->
        
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
            <!--<xsl:apply-templates mode="geschwister-von-rz" select="following-sibling::*[not(descendant::span[@class='randziffer'])]"/>--> <!-- funktioniert --> <!-- HIER FEHLT NOCH:
            NACH DER NÄCHSTEN RZ AUCH KEINE GESCHWISTER MEHR-->
            <xsl:apply-templates mode="geschwister-von-rz" select="following-sibling::*[not(descendant::span[@class='randziffer']) and not(preceding-sibling::node()[deep-equal(., ($alle-rz)[$index-der-rz+1])])]"/>
        </rzblock>
    </xsl:template>
    
    <xsl:template match="node()" mode="geschwister-von-rz">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node()[not(descendant::span[@class='randziffer'])][preceding-sibling::node()[child::span[@class='randziffer']]]">
    </xsl:template>
    
    <!-- erster Versuch über die Großeltern: -->
    <!--<xsl:template match="*[*[span[@class='randziffer']]]">
        <xsl:variable name="depth" select="count(ancestor::*)"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <!-\-<xsl:attribute name="tiefe"><xsl:value-of select="$depth-of-grandparent"/></xsl:attribute>-\->
            <xsl:variable name="alle-rz-in-dieser-section" select="./*/span[@class='randziffer']"/>
            <!-\-<xsl:value-of select="count($alle-rz-in-dieser-section)"/>-\-> <!-\- klappt -\->
            
            <!-\- Für alle Elemente vor der ersten RZ: -\->
            <xsl:for-each select="*[descendant::span[@class='randziffer'][deep-equal(., ($alle-rz-in-dieser-section)[1])]]/preceding-sibling::*">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:for-each>
            
            <!-\- Für alle Elemente, die Randziffern enthalten: -\->
            <xsl:for-each select="$alle-rz-in-dieser-section">
                <xsl:variable name="for-index-position" select="position()"/>
                <xsl:choose>
                    <xsl:when test="position() != last()">
                        <rzblock>
                            <rz><xsl:value-of select="./text()"/></rz>
                            <xsl:apply-templates select="./.. | ./../following-sibling::*[following-sibling::*[descendant::*[deep-equal(., ($alle-rz-in-dieser-section)[$for-index-position+1])]]]"/>
                            <!-\- hier muss die Beschränkung noch rein, dass es nur für RZ mit der Tiefe + 2 gelten darf -\->
                            
                        </rzblock>
                    </xsl:when>
                    <xsl:otherwise>
                        <rzblock>
                            <rz><xsl:value-of select="./text()"/></rz>
                            <xsl:apply-templates select="./.. | ./../following-sibling::*"/>
                        </rzblock>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        
        </xsl:copy>
    </xsl:template>-->
    
    <xsl:template match="span[@class='randziffer']"></xsl:template>
    
    <!--<xsl:template match="title[span[@class='randziffer']]">
        <subhead><xsl:apply-templates /></subhead>
    </xsl:template>-->
    
    
    <!-- nachfolgende Zeilen reichen um RZ umzuwandeln bis auf ihre Geschwistelemente -->
    <!--<xsl:variable name="alle-rz" select="//span[@class='randziffer']"/>
    <xsl:template match="*[span[@class='randziffer']]">
        <!-\- RZ Block bis zur nächsten RZ oder bis das Eltern Element schließt: -\->
        <rzblock>
            <rz><xsl:value-of select="span[@class='randziffer']/text()"/></rz>
            
            <xsl:variable name="elementname">
                <xsl:choose>
                    <xsl:when test="name()='title'">subhead</xsl:when><!-\- title ist nicht erlaubt in RZ Blöcken -\->
                    <xsl:otherwise><xsl:value-of select="name()"/></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:element name="{$elementname}">
                <xsl:apply-templates/>
            </xsl:element>
            
            <!-\-<xsl:apply-templates select="./.. | ./../following-sibling::*[following-sibling::*[descendant::*[deep-equal(., ($alle-rz-in-dieser-section)[$for-index-position+1])]]]"/>-\->
            
        </rzblock>
    </xsl:template>-->
    
</xsl:stylesheet>