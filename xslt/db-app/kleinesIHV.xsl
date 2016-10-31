<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <div>
                    <p><b>Gastkommentar</b>
                        <br/>
                        <xsl:for-each select="output/DOKUMENT">
                            <xsl:if test="DOCTYPBEZ[text()='Gastkommentar']">
                                <xsl:for-each select="AUTOR">
                                    <i>
                                        <xsl:variable name="autorenname" select="."/>
                                        <xsl:value-of select="replace($autorenname,',','')"/>
                                        <xsl:choose>
                                            <xsl:when test="position()=last()"/>
                                            <xsl:otherwise> / </xsl:otherwise>
                                        </xsl:choose>
                                    </i>
                                </xsl:for-each>
                                <br/>
                                <xsl:value-of select="TITEL"/>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <p><b>Betriebswirtschaft</b>
                        <br/>
                        <xsl:for-each select="output/DOKUMENT">
                            <xsl:if test="DOCTYPBEZ[text()='Aufsatz']">
                                <xsl:if test="HAUPTRUBRIK/BEZ[text()='Betriebswirtschaft']">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <p><b>Steuerrecht</b>
                        <br/>
                        <xsl:for-each select="output/DOKUMENT">
                            <xsl:if test="HAUPTRUBRIK/BEZ[text()='Steuerrecht']">
                                <xsl:if test="DOCTYPBEZ[text()='Aufsatz']">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                                <xsl:if test="DOCTYPBEZ[text()='Kompakt'][1]">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <p><b>Wirtschaftsrecht</b>
                        <br/>
                        <xsl:for-each select="output/DOKUMENT">
                            <xsl:if test="HAUPTRUBRIK/BEZ[text()='Wirtschaftsrecht']">
                                <xsl:if test="DOCTYPBEZ[text()='Aufsatz']">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                                <xsl:if test="DOCTYPBEZ[text()='Kompakt'][1]">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <p><b>Arbeitsrecht</b>
                        <br/>
                        <xsl:for-each select="output/DOKUMENT">
                            <xsl:if test="HAUPTRUBRIK/BEZ[text()='Arbeitsrecht']">
                                <xsl:if test="DOCTYPBEZ[text()='Aufsatz']">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                                <xsl:if test="DOCTYPBEZ[text()='Kompakt'][1]">
                                    <xsl:for-each select="AUTOR">
                                        <i>
                                            <xsl:variable name="autorenname" select="."/>
                                            <xsl:value-of select="replace($autorenname,',','')"/>
                                            <xsl:choose>
                                                <xsl:when test="position()=last()"/>
                                                <xsl:otherwise> / </xsl:otherwise>
                                            </xsl:choose>
                                        </i>
                                    </xsl:for-each>
                                    <br/>
                                    <xsl:value-of select="TITEL"/>
                                    <br/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>