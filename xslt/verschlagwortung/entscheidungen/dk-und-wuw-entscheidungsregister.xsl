<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="seite-gericht"/>
    
    <xsl:variable name="alle-Hefte" select="collection('file:/c:/tempWuW/2017/?recurse=yes;select=*.xml')"/>
    
    <!--<xsl:variable name="gerichts-sortierung" select="'&lt; Freshman &lt; Sophomore &lt; Junior   &lt; Senior'" />-->
    <!-- Definition hier: http://docs.oracle.com/javase/6/docs/api/java/text/RuleBasedCollator.html
    
    siehe auch: http://stackoverflow.com/questions/7795474/can-you-define-a-custom-collation-using-a-function-in-xslt?noredirect=1&lq=1
    
    -->
    
    <xsl:variable name="inline-array-wuw">      
        <class sort="10">EuGH</class>
        <class sort="20">GA Kokott</class>
        <class sort="30">Generalanwalt beim EuGH Nils Wahl</class>
        <class sort="40">EuG</class>
        <class sort="50">EU-Kommission</class>
        <class sort="60">BVerfG</class>
        <class sort="80">BGH</class>
        <class sort="85">BPatG</class>
        <class sort="86">BVerwG</class>
        <class sort="90">OLG Celle</class>
        <class sort="100">OLG Düsseldorf</class>
        <class sort="110">OLG Frankfurt/M.</class>
        <class sort="115">OLG Hamm</class>
        <class sort="120">OLG Karlsruhe</class>
        <class sort="145">OLG München</class>
        <class sort="130">OLG Nürnberg</class>
        <class sort="140">OLG Stuttgart</class>
        <class sort="145">OLG Thüringen</class>
        <class sort="150">LG Berlin</class>
        <class sort="155">LG Dortmund</class>
        <class sort="160">LG Düsseldorf</class>
        <class sort="170">LG Hamburg</class>
        <class sort="180">LG Hannover</class>
        <class sort="190">LG Köln</class>
        <class sort="200">LG Mannheim</class>
        <class sort="210">LG Potsdam</class>
        <class sort="220">AG Bonn</class>
        <class sort="225">FG Köln</class>
        <class sort="230">LAG Düsseldorf</class>
        <class sort="240">VG Düsseldorf</class>
        <class sort="250">VG München</class>
        <class sort="255">Bundesregierung</class>
        <class sort="256">Deutscher Bundestag</class>
        <class sort="257">Deutscher Bundesrat</class>
        <class sort="260">Bundesministerium für Wirtschaft und Energie</class>
        <class sort="270">BMWi</class>
        <class sort="280">Bundeskartellamt</class>
        <class sort="285">BKartA</class>
        <class sort="286">LKartB Baden-Württemberg</class>
        <class sort="290">Monopolkommission</class>
        <class sort="300">Belgische Mededingingsautoriteit</class>
        <class sort="310">Schweizerische Wettbewerbskommission (WEKO)</class>
        <class sort="320">England and Wales High Court of Justice Chancery Division (Mr Justice Roth)</class>
        <class sort="321">Brexit Competition Law Working Group</class>
        <class sort="322">BVGer (Schweiz)</class>
        <class sort="323">Competition and Markets Authority (CMA)</class>
        <class sort="324">Competition Appeal Tribunal</class>
        <class sort="325">Competition Appeal Tribunal (Vereinigtes Königreich)</class>
        <class sort="326">High Court of Justice (Mr. Justice Birss)</class>
        <class sort="327">OGH Österreich</class>
        <class sort="328">U.S. Department of Justice, Federal Trade Commission</class>
        <class sort="330">Polnische Wettbewerbsbehörde (UOKiK)</class>
        <class sort="340">VK Südbayern</class>
        <class sort="350">Bund-Länder-Kommission</class>
        <class sort="360">Europäischer Rat</class>
        <class sort="370">Europäisches Hochschulinstitut</class>
        <class sort="380">Prof. Dr. Daniel Zimmer</class>
    </xsl:variable>
    
    <xsl:variable name="inline-array-dk">
        <!-- Der Konzern: -->
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
    
    <xsl:variable name="array">
        <xsl:value-of select="document('')/*/xsl:variable[@name='inline-array-wuw']/*"/>
    </xsl:variable>
    
    <!--<xsl:variable name="array">
        <xsl:choose>
            <xsl:when test="$alle-Hefte[1]/descendant::metadata/pub/pubtitle = ('Wirtschaft und Wettbewerb')">
                <xsl:value-of select="document('')//xsl:variable[@name='inline-array-wuw']/*"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document('')//xsl:variable[@name='inline-array-dk']/*"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>-->
    
    <xsl:template match="/">
        <xsl:text>&#xa;</xsl:text>
        <entscheidungsregister><xsl:text>&#xa;</xsl:text>
            <xsl:for-each-group select="$alle-Hefte/*[name() = ('ent','va')]" group-by="/*/name()">
                <xsl:choose>
                    <xsl:when test="current-grouping-key() = 'ent'">
                        <h1>Entscheidungen</h1><xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="current-grouping-key() = 'va'">
                        <h1>Dokumentation</h1><xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:for-each-group select="current-group()" group-by="/*/metadata/instdoc/inst">
                    <xsl:sort select="$inline-array-wuw/child::*[text() = current-grouping-key()]/@sort" data-type="number"/>
                    
                    <!--<xsl:variable name="debug-v1" select="./attribute::*"/>
                    <xsl:variable name="debug-v2" select="current-grouping-key()"/>
                    <xsl:variable name="debug-v3" select="$array[1]"/>
                    <xsl:variable name="debug-v4" select="$array[. = current-grouping-key()]/@sort"/>
                    <xsl:variable name="debug-v5" select="current-group()"/>-->
                    
                    <h2><xsl:value-of select="current-grouping-key()"/></h2><xsl:text>&#xa;</xsl:text>
                        
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
                            <az><xsl:for-each select="/*/metadata/instdoc/instdocnrs/instdocnr">
                                    <xsl:if test="not(position()=1)">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="."/>
                            </xsl:for-each></az>
                            <xsl:if test="not(/*[name()='va'])">
                                <xsl:text>, </xsl:text><xsl:text>&#xa;</xsl:text>
                                <xsl:value-of select="/*/metadata/title"/>
                            </xsl:if>
                            <seite-gericht>
                                <xsl:text>&#x09;</xsl:text>
                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>
                            </seite-gericht>
                        </zeile-gericht><xsl:text>&#xa;</xsl:text>
                    </xsl:for-each>    
                </xsl:for-each-group>
            </xsl:for-each-group>
            <xsl:text>&#xa;</xsl:text>
        </entscheidungsregister>
    </xsl:template>
    
</xsl:stylesheet>