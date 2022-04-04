<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:variable name="current_paragraph" select="./*/metadata/paragraph/text()"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="→([^)]+)\)">
            <xsl:matching-substring>
                <xsl:variable name="nonNormalizedlinkText" select="substring-before(substring-after(., '→'), ')')"/>
                <xsl:text>→&#160;</xsl:text>
                <xsl:for-each select="tokenize($nonNormalizedlinkText, ';')">
                    <xsl:if test="not(position()=1)">
                        <xsl:text>; </xsl:text>
                    </xsl:if>
                    <xsl:variable name="docNr">
                        <xsl:if test="contains(.,'§')">
                            <!--translate here removes the non breaking space-->
                            <xsl:value-of select="tokenize(normalize-space(translate(substring-after(., '§'), '&#160;', ' ')), ' ')[1]"/>
                        </xsl:if>
                    </xsl:variable>
                    <xsl:variable name="noOfTokens">
                        <xsl:if test="contains(.,'§')">
                            <!--translate here removes the non breaking space-->
                            <xsl:value-of select="count(tokenize(normalize-space(translate(substring-after(., '§'), '&#160;', ' ')), ' '))"/>
                        </xsl:if>
                    </xsl:variable>
                    <xsl:for-each select="tokenize(., ',')">
                        <xsl:if test="not(position()=1)">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                        <!--translate here removes the non breaking space-->
                        <xsl:variable name="normalizedlinkText" select="normalize-space(translate(., '&#160;', ' '))" />
                        <xsl:choose>
                            <xsl:when test="contains($normalizedlinkText,'f')">
                                <xsl:variable name="linkTextWithoutF" select="normalize-space(substring-before($normalizedlinkText, 'f'))" />
                                <xsl:variable name="f" select="normalize-space(substring-after($normalizedlinkText, 'f'))" />
                                <xsl:call-template name="convert-to-link">
                                    <xsl:with-param name="txtToLink" select="$linkTextWithoutF"/>
                                    <xsl:with-param name="docNumber" select="$docNr"/>
                                    <xsl:with-param name="numberOfTokens" select="$noOfTokens"/>
                                </xsl:call-template>
                                <xsl:text> f</xsl:text><xsl:value-of select="$f"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="convert-to-link">
                                    <xsl:with-param name="txtToLink" select="$normalizedlinkText"/>
                                    <xsl:with-param name="docNumber" select="$docNr"/>
                                    <xsl:with-param name="numberOfTokens" select="$noOfTokens"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:text>)</xsl:text>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template name="convert-to-link">
        <xsl:param name="txtToLink" required="yes"/>
        <xsl:param name="docNumber" required="no"/>
        <xsl:param name="numberOfTokens" required="no"/>
        <xsl:variable name="linkNr" select="tokenize($txtToLink, ' ')[last()]"/>
        <xsl:choose>
            <!--This condition checks if the variable is not a number-->
            <xsl:when test="not(number($linkNr) = number($linkNr))">
                <xsl:value-of select="$txtToLink"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$docNumber!=''">
                        <xsl:choose>
                            <xsl:when test="$numberOfTokens &gt;=2">
                                <link all_source ="hbfm_ccompl" all_paragraph="{concat('hbfm-ccompl-par', $docNumber)}" all_rz ="{$linkNr}" a="{concat('rz_', $linkNr)}" generator="publisher"><xsl:value-of select="$txtToLink"/></link>
                            </xsl:when>
                            <xsl:otherwise>
                                <link all_source ="hbfm_ccompl" all_paragraph="{concat('hbfm-ccompl-par', $docNumber)}" generator="publisher"><xsl:value-of select="$txtToLink"/></link>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <link all_source="hbfm_ccompl" all_paragraph="{$current_paragraph}" all_rz="{$linkNr}" a="{concat('rz_', $linkNr)}" generator="publisher"><xsl:value-of select="$txtToLink"/></link>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>