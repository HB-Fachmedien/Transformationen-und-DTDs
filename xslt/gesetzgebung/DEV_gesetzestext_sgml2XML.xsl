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
    
    <xsl:template match="ZEITSCHRIFT-BEITRAG">
        <xsl:variable name="sevenDigitID">
            <xsl:call-template name="calculateDocId">
                <xsl:with-param name="id" select="@SIRIUS-ID"/>
            </xsl:call-template>
        </xsl:variable>
        <gtdraft rawid="{@SIRIUS-ID}">
            <!--<xsl:attribute name="docid">
                <xsl:value-of select="concat('DB', $sevenDigitID)"/>
            </xsl:attribute>-->
            <xsl:attribute name="altdocid">
                <xsl:value-of select="concat('DB', $sevenDigitID)"/>
            </xsl:attribute>

            <metadata>
                <title>
                    <xsl:value-of select="TITEL"/>
                </title>
                
                <!-- Beim Bewertungspraktiker soll das Abstract Element gefüllt werden -->
                <xsl:if test="@TYP = 'BEWERTUNGSPRAKTIKER'">
                    <summary>
                        <p>
                            <!-- Das noch abändern wie hier: http://stackoverflow.com/questions/2963633/how-to-get-cdata-from-xml-node-using-xsl -->
                            <!--<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>-->
                            <xsl:value-of select="replace(saxon:parse-html(replace(substring-before(VOLLTEXT/text(),'&lt;br&gt;&lt;br&gt;'),'&lt;br&gt;www.der-betrieb.de&lt;br&gt;','')),'\n','&lt;br/&gt;')" disable-output-escaping="yes"/>
                            <!--<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>-->
                        </p>
                    </summary>
                </xsl:if>
                <pub>
                    <pubtitle><xsl:value-of select="concat(upper-case(substring(@TYP,1,1)),lower-case(substring(@TYP,2)))"/></pubtitle>
                    <pubabbr>XQ</pubabbr>
                    <pubyear>
                        <xsl:value-of select="PUB/DATUM/JAHR"/>
                    </pubyear>

                    <!-- Bezieht den Inhalt vom pubedition Element aus dem ID Element des Zeitschrift Beitrags -->
                    <pubedition/>
                    <date>
                        <xsl:value-of
                            select="concat(PUB/DATUM/JAHR,'-',PUB/DATUM/MONAT,'-',PUB/DATUM/TAG)"/>
                    </date>
                    <pages>
                        <start_page>
                            <xsl:value-of select="PUB/SEITEVON"/>
                        </start_page>
                        <last_page>
                            <xsl:value-of select="PUB/SEITEBIS"/>
                        </last_page>
                        <article_order>1</article_order>
                    </pages>
                </pub>
                <extfile display="true" type="pdf">
                    <xsl:value-of select="DATEI-REF/DATEI/@NAME"/>
                </extfile>
                <xsl:if test="GZEILE/VORSCHRIFT">
                    <law>
                        <lawname><xsl:value-of select="GZEILE/VORSCHRIFT"/></lawname>
                        <lawabbr></lawabbr>
                        <lawyear></lawyear>
                        <artnum></artnum>
                    </law>
                </xsl:if>
                <all_doc_type level="1">gt</all_doc_type>
                <all_source level="1">ent</all_source>
                <all_source level="2">entges</all_source>
                <sgml_root_element doctype="{name()}">
                    <xsl:value-of
                        select="concat(name(), ' SIRIUS-ID=', @SIRIUS-ID, ' TYP=', @TYP, ' ID=', @ID, ' RU=', @RU)"
                    />
                </sgml_root_element>
            </metadata>
            <body>
                <p>
                    <!--<xsl:value-of select="replace(tokenize(base-uri(),'/')[last()],'.sgm','')"/>-->
                    <xsl:apply-templates select="VOLLTEXT"/>
                    
                    
                    <!--<xsl:value-of select="VOLLTEXT" disable-output-escaping="no"/>-->
                    <!-- Diese Ersetzungsregeln sind nicht sehr performant, geht es auch anders? -->
                    <!--<xsl:variable name="temp1" select="replace(VOLLTEXT/text(),'&lt;br&gt;','&lt;br/&gt;')"/>
                    <xsl:variable name="temp1a" select="replace($temp1,'&amp;&amp;','&amp;')"/>
                    <xsl:variable name="temp2" select="replace($temp1a,'&amp;auml;','ä')"/>
                    <xsl:variable name="temp3" select="replace($temp2,'&amp;uuml;','ü')"/>
                    <xsl:variable name="temp4" select="replace($temp3,'&amp;ouml;','ö')"/>
                    <xsl:variable name="temp5" select="replace($temp4,'&amp;szlig;','ß')"/>
                    <xsl:variable name="temp6" select="replace($temp5,'&amp;middot;','·')"/>
                    <xsl:variable name="temp7" select="replace($temp6,'&amp;Uuml;','Ü')"/>
                    <xsl:variable name="temp8" select="replace($temp7,'&amp;Ouml;','Ö')"/>
                    <xsl:variable name="temp9" select="replace($temp8,'&amp;Auml;','Ä')"/>
                    <xsl:variable name="temp10" select="replace($temp9,'&amp;sect;','&#167;')"/>
                    <xsl:variable name="temp11" select="replace($temp10,'&amp;Oslash;','&#216;')"/>
                    <xsl:variable name="temp12" select="replace($temp11,'&amp;sup2;','&#178;')"/>
                    <xsl:variable name="temp13" select="replace($temp12,'&amp;sup3;','&#179;')"/>
                    <xsl:variable name="temp14" select="replace($temp13,'&amp;copy;','&#169;')"/>
                    <xsl:variable name="temp15" select="replace($temp14,'&amp;amp;','&#38;')"/>
                    
                    <xsl:value-of select="$temp14" disable-output-escaping="no"/>-->
                </p>
            </body>
        </gtdraft>
    </xsl:template>
    
    <!-- Kopiert das CDATA Element aus dem VOLLTEXT Element mit -->
    <xsl:template match="VOLLTEXT">
        <!--<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
        <xsl:apply-templates select="child::node()" />
        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>-->

        <!--<xsl:copy>
            <xsl:apply-templates select="child::node()" />
        </xsl:copy>-->
        <!--<xsl:variable name="temp" select="replace(text(),'&amp;auml;','ä')"/>
        <xsl:variable name="temp1" select="replace($temp,'&amp;ouml;','ö')"/>-->
        <!-- Das noch abändern wie hier: http://stackoverflow.com/questions/2963633/how-to-get-cdata-from-xml-node-using-xsl -->
        <!--<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
        <xsl:value-of select="text()" disable-output-escaping="yes"/>
        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>-->
        <!--<xsl:value-of select="replace($temp1,'&lt;br&gt;','&lt;br/&gt;')"
            disable-output-escaping="yes"/>-->
        <xsl:if test=". !=''">
            <xsl:value-of select="saxon:parse-html(text())"/>
        </xsl:if>
    </xsl:template>
    
    <!-- Unsere IDs müssen 7-stellig sein, dieses Template füllt kürzere IDs vorne mit Nullen auf-->
    <xsl:template name="calculateDocId">
        <xsl:param name="id"/>
        <!--xsl:value-of select="$id"/-->
        <xsl:value-of select="format-number($id, '0000000')"/>
    </xsl:template>
</xsl:stylesheet>