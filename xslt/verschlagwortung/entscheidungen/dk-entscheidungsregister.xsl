<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="seite-gericht"/>
    
    <xsl:variable name="alle-Hefte" select="collection('file:/c:/work/verschlagwortung/2016/?recurse=yes;select=*.xml')"/>
    
    <!--<xsl:variable name="gerichts-sortierung" select="'&lt; Freshman &lt; Sophomore &lt; Junior   &lt; Senior'" />-->
    <!-- Definition hier: http://docs.oracle.com/javase/6/docs/api/java/text/RuleBasedCollator.html
    
    siehe auch: http://stackoverflow.com/questions/7795474/can-you-define-a-custom-collation-using-a-function-in-xslt?noredirect=1&lq=1
    
    -->
    
    <xsl:variable name="inline-array">
        <!-- WUW Gerichte Reihenfolge: -->
        <!--<class sort="1">EuGH</class>
        <class sort="2">GA Kokott</class>
        <class sort="3">Generalanwalt beim EuGH Nils Wahl</class>
        <class sort="4">EU-Kommission</class>
        <class sort="5">EuG</class>
        <class sort="6">BVerfG</class>
        <class sort="7">BVGer (Schweiz)</class>
        <class sort="8">BGH</class>
        <class sort="9">OLG Celle</class>
        <class sort="10">OLG Düsseldorf</class>
        <class sort="11">OLG Frankfurt/M.</class>
        <class sort="12">OLG Karlsruhe</class>
        <class sort="13">OLG Nürnberg</class>
        <class sort="14">OLG Stuttgart</class>
        <class sort="15">LG Berlin</class>
        <class sort="16">LG Düsseldorf</class>
        <class sort="17">LG Hamburg</class>
        <class sort="18">LG Hannover</class>
        <class sort="19">LG Köln</class>
        <class sort="20">LG Mannheim</class>
        <class sort="21">LG Potsdam</class>
        <class sort="22">AG Bonn</class>
        <class sort="23">LAG Düsseldorf</class>
        <class sort="24">VG Düsseldorf</class>
        <class sort="25">VG München</class>
        <class sort="26">Bundesministerium für Wirtschaft und Energie</class>
        <class sort="27">BMWi</class>
        <class sort="28">Bundeskartellamt</class>
        <class sort="29">Monopolkommission</class>
        <class sort="30">Belgische Mededingingsautoriteit</class>
        <class sort="31">Schweizerische Wettbewerbskommission (WEKO)</class>
        <class sort="32">England and Wales High Court of Justice Chancery Division (Mr Justice Roth)</class>
        <class sort="33">Polnische Wettbewerbsbehörde (UOKiK)</class>
        <class sort="34">VK Südbayern</class>
        <class sort="35">Bund-Länder-Kommission</class>
        <class sort="36">Europäischer Rat</class>
        <class sort="37">Europäisches Hochschulinstitut</class>
        <class sort="38">Prof. Dr. Daniel Zimmer</class>-->
        <!-- End: WuW -->
        
        <!-- DK Gerichte Reihenfolge: -->
        <class sort="1">BGH</class>
        <class sort="2">OLG Braunschweig</class>
        <class sort="3">OLG Düsseldorf</class>
        <class sort="4">OLG Frankfurt/M.</class>
        <class sort="5">OLG Karlsruhe</class>
        <class sort="6">OLG Koblenz</class>
        <class sort="7">OLG Köln</class>
        <class sort="8">OLG München</class>
        <class sort="9">OLG Saarbrücken</class>
        <class sort="10">KG Berlin</class>
        <class sort="11">BFH</class>
        <class sort="12">FG Düsseldorf</class>
        <class sort="13">FG Hessen</class>
        <class sort="14">FG Köln</class>
        <class sort="15">FG Münster</class>
        <class sort="16">FG Rheinland-Pfalz</class>
        <class sort="17">VG Frankfurt/M.</class>
        <class sort="18">ArbG Berlin</class>
        <class sort="19">BAG</class>
        <class sort="20">BMF</class>
        <class sort="21">FinMin. Schleswig-Holstein</class>
        <class sort="22">OFD Karlsruhe</class>
        <class sort="23">OFD NRW</class>
        <!-- End DK -->
    </xsl:variable>
    
    <xsl:variable name="pubtitle">
        <xsl:choose>
            <xsl:when test="$alle-Hefte[1]/*/metadata/pub/pubtitle/text() = 'Wirtschaft und Wettbewerb'">wuw</xsl:when>
            <xsl:otherwise>
                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="array" select="document('')/*/xsl:variable[@name='inline-array']/*"/>
    
    <xsl:template match="/">
        <entscheidungsregister>
            <xsl:for-each-group select="$alle-Hefte/*[name() = ('ent','va')]" group-by="/*/name()">
                <xsl:choose>
                    <xsl:when test="current-grouping-key() = 'ent'">
                        <h1>Entscheidungen</h1>
                    </xsl:when>
                    <xsl:when test="current-grouping-key() = 'va'">
                        <h1>Dokumentation</h1>
                    </xsl:when>
                </xsl:choose>
                <xsl:for-each-group select="current-group()" group-by="/*/metadata/instdoc/inst">
                    <xsl:sort select="$array[. = current()[1]/descendant::metadata/instdoc/inst]/@sort" data-type="number"/>
                    
                    <h2><xsl:value-of select="current-grouping-key()"/></h2>
                        
                    <xsl:for-each select="current-group()">
                        <!-- hier nach Datum sortieren -->
                        <xsl:sort select="replace(/*/metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                        <xsl:variable name="datum-tokenized" select="tokenize(/*/metadata/instdoc/instdocdate/text(), '-')"/>
                        <zeile-gericht>
                            <!-- Hier weiter: VAs und Ent sehen anders aus -->
                            <xsl:if test="/*[name()='va']">
                                <xsl:value-of select="/*/metadata/title"/>
                                <br/>
                            </xsl:if>
                            <xsl:value-of select="/*/metadata/instdoc/inst"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="replace(replace(replace(/*/metadata/instdoc/instdoctype,'Beschluss','Beschl.'),'Urteil','Urt.'),'Schreiben','Schr.')"/>
                            <xsl:text> v. </xsl:text>
                            <datum-gericht><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>.</xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                                <xsl:text>.</xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum-gericht>
                            <trennzeichen><xsl:text> - </xsl:text></trennzeichen>
                            <az><xsl:value-of select="/*/metadata/instdoc/instdocnrs"/></az>
                            <xsl:if test="not(/*[name()='va'])">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="/*/metadata/title"/>
                            </xsl:if>
                            <seite-gericht>
                                <xsl:text>&#x09;</xsl:text>
                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                            </seite-gericht>
                        </zeile-gericht>
                    </xsl:for-each>    
                </xsl:for-each-group>
            </xsl:for-each-group> 
        </entscheidungsregister>
    </xsl:template>
    
</xsl:stylesheet>