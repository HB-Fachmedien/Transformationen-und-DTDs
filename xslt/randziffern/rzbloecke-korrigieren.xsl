<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hbfm="http://www.fachmedien.de"
    exclude-result-prefixes="xs hbfm"
    version="2.0"
    >
    
    <!-- Ein Stylesheet, welches die schon mit rzblock ausgezeichneten Randziffern um die Blöcke erweitert, die
    fälschlicherweise noch ausserhalbs des Blocks stehen -->

    <xsl:output indent="no"
        doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE"
        doctype-system="hbfm.dtd"
        encoding="UTF-8" 
        method="xml"
    />
    
    <!-- **************************************************************************************** -->
    
    <!-- Ich brauche drei Templates, eins für die RZ-Blöcke, eins für die Elemente die nach rz blöcken kommen und eins für den Rest  -->
    
    <xsl:template match="*[not(descendant-or-self::rzblock)][not(name()='p' and child::*[1]/name()=('i','b'))][preceding-sibling::rzblock]" priority="2">
    </xsl:template>
    
    <xsl:template match="rzblock">
        <rzblock>
            <xsl:variable name="this-rz" select="." as="item()*"/>
            
            <xsl:variable name="index-der-rz" select="hbfm:index-of-deep-equal-node($alle-rz,.)"/>
            
            <xsl:apply-templates/>
            
            <!-- das muss ich noch testen -->
            <xsl:apply-templates mode="geschwister-von-rz" select="following-sibling::*[not(name()='rzblock')][not(name()='p' and child::*[1]/name()=('i','b'))][not(descendant::rzblock) and not(preceding-sibling::node()[descendant-or-self::*[ self::* is ($alle-rz)[$index-der-rz+1]]])]"/>
            
        </rzblock>
    </xsl:template>
    
    <!-- **************************************************************************************** -->
    
    <!-- Identity Template -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--<xsl:template match="p[not(ancestor::rzblock)][preceding-sibling::rzblock][not(child::*[1]/name()=('i','b'))]">
        
    </xsl:template>-->
    
    <xsl:template match="node()" mode="geschwister-von-rz">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- ************ -->
    
    <xsl:function name="hbfm:index-of-deep-equal-node" as="xs:integer*">
        <xsl:param name="nodes" as="node()*"/>
        <xsl:param name="nodeToFind" as="node()"/>
        
        <xsl:sequence select="
            for $seq in (1 to count($nodes))
            return $seq[$nodes[$seq] is $nodeToFind]
            "/>
        
    </xsl:function>
    
    
    <xsl:variable name="alle-rz" select="(//rzblock)"/>
    <!--<xsl:template match="*[rzblock]" priority="100">
        
        <xsl:variable name="this-rz" select="rzblock" as="item()*"/>
        
        <xsl:variable name="index-der-rz" select="hbfm:index-of-deep-equal-node($alle-rz,rzblock)"/>
        
        <!-\- RZ Block bis zur nächsten RZ oder bis das Eltern Element schließt: -\->
        <rzblock>
            <xsl:apply-templates/>
            
            <xsl:apply-templates mode="geschwister-von-rz" select="following-sibling::*[not(name()='p' and child::*[1]/name()=('i','b'))][not(descendant::rzblock) and not(preceding-sibling::node()[descendant::*[ self::* is ($alle-rz)[$index-der-rz+1]]])]"/>
        </rzblock>
    </xsl:template>-->
    
    
    
    <!--<xsl:template match="node()[not(descendant::rzblock)][preceding-sibling::node()[child::rzblock]]">
    </xsl:template>
    
    <xsl:template match="rzblock"></xsl:template>-->
    
</xsl:stylesheet>