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
    <xsl:variable name="gerichts-sortierung" select="'BMF &gt; Oberste Finanzbehörden der Länder &gt; SenFin. Berlin &gt; FinMin. Niedersachsen &gt; FinMin. NRW &gt; FinMin. Sachsen-Anhalt &gt; FinMin. Schleswig-Holstein s BayLfSt &gt; LSF Sachsen &gt; OFD Frankfurt/M. &gt; OFD Karlsruhe &gt; OFD Niedersachsen &gt; OFD NRW &gt; Rheinland-Pfälzisches Landesamt für Steuern'" />
    
    
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
                    
                    <!-- hier nach collation sortieren -->
                    <xsl:sort select="/*/metadata/instdoc/inst"/> <!-- collation="http://saxon.sf.net/collation?rules={encode-for-uri($gerichts-sortierung)}" -->
                    
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