<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:num="http://dummy" exclude-result-prefixes="xs num" version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="seite-gericht"/>
    
    <xsl:variable name="alle-Hefte" select="collection('file:/C:/verschlagwortung/?recurse=yes;select=*.xml')"/>
    
    <!--<xsl:variable name="gerichts-sortierung" select="'&lt; Freshman &lt; Sophomore &lt; Junior   &lt; Senior'" />-->
    <!-- Definition hier: http://docs.oracle.com/javase/6/docs/api/java/text/RuleBasedCollator.html
    
    siehe auch: http://stackoverflow.com/questions/7795474/can-you-define-a-custom-collation-using-a-function-in-xslt?noredirect=1&lq=1
    
    -->
    
    <xsl:variable name="sort-variable">
        <xsl:choose>
            <xsl:when test="$alle-Hefte[1]/*/metadata/pub/pubtitle/text() = 'Wirtschaft und Wettbewerb'"><xsl:copy-of select="$inline-array-wuw"></xsl:copy-of></xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$inline-array-dk"></xsl:copy-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="inline-array-wuw">      
        <class sort="10">EuGH</class>
        <class sort="20">GA Kokott</class>
        <class sort="30">Generalanwalt beim EuGH Nils Wahl</class>
        <class sort="40">EuG</class>
        <class sort="50">EU-Kommission</class>
        <class sort="55">Europäisches Parlament/Europäischer Rat</class>
        <class sort="60">BVerfG</class>
        <class sort="80">BGH</class>
        <class sort="83">BFH</class>
        <class sort="85">BPatG</class>
        <class sort="86">BVerwG</class>
        <class sort="87">BayObLG</class>
        <class sort="87">BayObLG München</class>
        <class sort="88">KG Berlin</class>
        <class sort="89">OLG Brandenburg</class>
        <class sort="90">OLG Celle</class>
        <class sort="100">OLG Düsseldorf</class>
        <class sort="110">OLG Frankfurt/M.</class>
        <class sort="112">Hanseatisches OLG Hamburg</class>
        <class sort="115">OLG Hamm</class>
        <class sort="120">OLG Karlsruhe</class>
        <class sort="125">OLG Köln</class>
        <class sort="130">OLG München</class>
        <class sort="135">OLG Nürnberg</class>
        <class sort="137">OLG Oldenburg</class>
        <class sort="138">SchlHOLG</class>
        <class sort="140">OLG Stuttgart</class>
        <class sort="145">OLG Thüringen</class>
        <class sort="150">LG Berlin</class>
        <class sort="155">LG Dortmund</class>
        <class sort="160">LG Düsseldorf</class>
        <class sort="165">LG Frankfurt/M.</class>
        <class sort="170">LG Hamburg</class>
        <class sort="180">LG Hannover</class>
        <class sort="190">LG Köln</class>
        <class sort="200">LG Leipzig</class>
        <class sort="202">LG Magdeburg</class>
        <class sort="203">LG Mannheim</class> 
        <class sort="205">LG München I</class>
        <class sort="207">LG Nürnberg-Fürth</class>
        <class sort="210">LG Potsdam</class>
        <class sort="215">LG Stuttgart</class>
        <class sort="220">AG Bonn</class>
        <class sort="225">FG Köln</class>
        <class sort="230">LAG Düsseldorf</class>
        <class sort="233">OVG Nordrhein-Westfalen</class>
        <class sort="235">VG Arnsberg</class>
        <class sort="240">VG Düsseldorf</class>
        <class sort="245">VG Köln</class>
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
        <class sort="295">Autorité de la concurrence (Frankreich)</class>
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
        <class sort="375">European Competition Network (ECN)</class>
        <class sort="380">Prof. Dr. Daniel Zimmer</class>
    </xsl:variable>
    
    <xsl:variable name="inline-array-dk">
        <!-- Der Konzern: -->
        <!-- DK Gerichte Reihenfolge: -->
        <class sort="5">BMF</class>
        <class sort="10">BGH</class>
        <class sort="15">BVerfG</class>
        <class sort="16">Oberste Finanzbehörden der Länder</class>
        <class sort="17">BayLfSt</class>
        <class sort="18">KG Berlin</class>
        <class sort="19">OLG Brandenburg</class>
        <class sort="20">OLG Braunschweig</class>
        <class sort="25">OLG Celle</class>
        <class sort="27">OLG Dresden</class>
        <class sort="30">OLG Düsseldorf</class>
        <class sort="40">OLG Frankfurt/M.</class>
        <class sort="45">OLG Hamburg</class>
        <class sort="46">OLG Hamm</class>
        <class sort="50">OLG Karlsruhe</class>
        <class sort="60">OLG Koblenz</class>
        <class sort="70">OLG Köln</class>
        <class sort="80">OLG München</class>
        <class sort="85">OLG Rostock</class>
        <class sort="90">OLG Saarbrücken</class>
        <class sort="95">OLG Stuttgart</class>
        <class sort="101">LG Berlin</class>
        <class sort="102">LG Bonn</class>
        <class sort="103">LG Dortmund</class>
        <class sort="104">LG Frankfurt/M.</class>
        <class sort="105">LG Hamburg</class>
        <class sort="106">LG Heidelberg</class>
        <class sort="108">LG Köln</class>
        <class sort="109">LG München I</class>
        <class sort="115">BFH</class>
        <class sort="120">FG Düsseldorf</class>
        <class sort="130">FG Hessen</class>
        <class sort="140">FG Köln</class>
        <class sort="143">FG Mecklenburg-Vorpommern</class>
        <class sort="145">FG München</class>
        <class sort="150">FG Münster</class>
        <class sort="160">FG Rheinland-Pfalz</class>
        <class sort="162">FG Schleswig-Holstein</class>
        <class sort="165">EuGH</class>
        <class sort="170">VG Frankfurt/M.</class>
        <class sort="180">ArbG Berlin</class>
        <class sort="190">BAG</class>
        <class sort="210">FinMin. Schleswig-Holstein</class>
        <class sort="215">OFD Frankfurt/M.</class>
        <class sort="220">OFD Karlsruhe</class>
        <class sort="225">LfSt Niedersachsen</class>
        <class sort="230">OFD NRW</class>
        <!-- End DK -->
    </xsl:variable>
   
    
    <xsl:template match="/">
        <entscheidungsregister><xsl:text>&#xa;</xsl:text>
            <xsl:for-each-group select="$alle-Hefte/*[name() = ('ent','va')]" group-by="/*/name()">
                <xsl:choose>
                    <xsl:when test="current-grouping-key() = 'ent'">
                        <h1>Entscheidungen</h1><xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="current-grouping-key() = 'va'">
                        <h1>Verwaltungsanweisungen</h1><xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:for-each-group select="current-group()" group-by="/*/metadata/instdoc/inst/text()">
                    <xsl:sort select="$sort-variable/child::*[text() = current-grouping-key()]/@sort" data-type="number"/>
                    
                    <!--<xsl:variable name="debug-v1" select="./attribute::*"/>
                    <xsl:variable name="debug-v2" select="current-grouping-key()"/>
                    <xsl:variable name="debug-v3" select="$inline-array-dk/child::*[1]/text()"/>
                    <xsl:variable name="debug-v4" select="$inline-array-dk[child::*[ text() = current-grouping-key()]]/@sort"/>
                    <xsl:variable name="debug-v5" select="current-group()"/>
                    <xsl:variable name="debug-v6" select="current()"/>-->
                    
                    <h2><xsl:if test="not($sort-variable/child::*/text() = current-grouping-key())"><GERICHT_NICHT_BEKANNT/></xsl:if><xsl:value-of select="current-grouping-key()"/></h2><xsl:text>&#xa;</xsl:text>
                        
                    <xsl:for-each select="current-group()">
                        <!-- hier nach Datum sortieren -->
                        <xsl:sort select="replace(/*/metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                        <xsl:sort select="num:RomanToInteger(tokenize(metadata/instdoc/instdocnrs/instdocnr[1],' ')[1])" data-type="number"/>
                        <xsl:sort select="tokenize(metadata/instdoc/instdocnrs/instdocnr[1],' ')[2]" data-type="text"/>
                        <xsl:sort select="substring-after(metadata/instdoc/instdocnrs/instdocnr[1],'/')" data-type="text"/>
                        <xsl:sort select="substring-before(tokenize(metadata/instdoc/instdocnrs/instdocnr[1],' ')[3],'/')" data-type="number"/>
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
            <xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
            <WICHTIG>REIHENFOLGE VON ENTSCHEIDUNGEN GLEICHEN DATUMS BEACHTEN! Siehe Mail von Eva 6.3.2018</WICHTIG><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
            <WICHTIG2>Eva immer vorm Register die Behörden Liste für die Reihenfolge zusenden</WICHTIG2>
        </entscheidungsregister>
    </xsl:template>
    
    <xsl:function name="num:RomanToInteger" as="xs:integer">
        <xsl:param name="r" as="xs:string?"/>
        <xsl:choose>
            <xsl:when test="ends-with($r,'XC')">
                <xsl:sequence select="90+num:RomanToInteger(substring($r,1,string-length($r)-2))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'L')">
                <xsl:sequence select="50+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'C')">
                <xsl:sequence select="100+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'D')">
                <xsl:sequence select="500+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'M')">
                <xsl:sequence select="1000+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'IV')">
                <xsl:sequence select="4+num:RomanToInteger(substring($r,1,string-length($r)-2))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'IX')">
                <xsl:sequence select="9+num:RomanToInteger(substring($r,1,string-length($r)-2))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'IIX')">
                <xsl:sequence select="8+num:RomanToInteger(substring($r,1,string-length($r)-2))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'I')">
                <xsl:sequence select="1+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'V')">
                <xsl:sequence select="5+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="ends-with($r,'X')">
                <xsl:sequence select="10+num:RomanToInteger(substring($r,1,string-length($r)-1))"/>
            </xsl:when>
            <xsl:when test="floor(number($r)) = number($r)">
                <xsl:sequence select="xs:integer(number($r))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="0"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
</xsl:stylesheet>
