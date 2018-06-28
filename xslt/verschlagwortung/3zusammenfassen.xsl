<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="no"/>
    
    <xsl:template match="/sortiertes-register">
        <raw-reg>
            <xsl:for-each select="reg-zeile">
                <xsl:choose>
                    <xsl:when test=".[some $sibling in preceding-sibling::reg-zeile satisfies deep-equal(. ,$sibling)]">
                        <xsl:if test="not(.[some $sibling in following-sibling::reg-zeile satisfies deep-equal(. ,$sibling)])">
                            <reg-zeile>
                                <xsl:copy-of select="hauptebene"/>
                                <xsl:copy-of select="zweite-ebene"/>
                                <xsl:copy-of select="dritte-ebene"/>
                                
                                <!--<xsl:variable name="fundstellen">
                                    <xsl:for-each select="preceding-sibling::reg-zeile[hauptebene/text()= ./hauptebene/text() and zweite-ebene/text() = ./zweite-ebene/text() and dritte-ebene/text() = ./dritte-ebene/text()]">
                                        <xsl:value-of select="./comment()"/><xsl:text>,</xsl:text>
                                    </xsl:for-each>
                                </xsl:variable>-->
                                
                                <fundstellen>
                                    <!--<xsl:value-of select="$fundstellen"/>-->
                                    <xsl:call-template name="fundstellensuche">
                                        <xsl:with-param name="this" select="."/>
                                    </xsl:call-template>
                                </fundstellen>
                            </reg-zeile>
                            <!--<xsl:apply-templates select="." mode="ident"/>-->
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test=".[some $sibling in following-sibling::reg-zeile satisfies deep-equal(. ,$sibling)]"></xsl:when>
                    <xsl:otherwise>
                        <!-- Unikat -->
                        <xsl:apply-templates select="." mode="ident"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:for-each select="autoren-zeile">
                <!-- Hier Autorenregister -->
                <xsl:apply-templates select="." mode="ident"/>
            </xsl:for-each>
        </raw-reg>
    </xsl:template>
    
    <xsl:template name="fundstellensuche">
        <xsl:param name="this"/><!-- <reg-zeile/> -->
        <!--<xsl:value-of select="/sortiertes-register/reg-zeile[deep-equal(.,$this)]/comment()"/>-->
        <xsl:variable name="result">
            <xsl:for-each select="/sortiertes-register/reg-zeile[deep-equal(.,$this)]">
                <xsl:sort select="translate(comment(), 'AKERV ()','')" data-type="number"/>
                <xsl:if test="not(position()=1)">,</xsl:if><xsl:value-of select="comment()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$result"/>
    </xsl:template>
    
    <xsl:template name="autorenfundstellensuche"><!-- brauche ich, glaube ich, gar nicht -->
        <xsl:param name="this"/><!-- <autoren-zeile/> -->
        <xsl:variable name="result">
            <xsl:for-each select="/sortiertes-register/autoren-zeile[deep-equal(.,$this)]">
                <xsl:sort select="substring-before(comment(),' (')" data-type="number"/>
                <xsl:if test="not(position()=1)">,</xsl:if><xsl:value-of select="comment()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$result"/>
    </xsl:template>
    
    <xsl:template match="reg-zeile" mode="ident">
        <!--<xsl:copy-of select="."/>-->
        <reg-zeile>
            <xsl:copy-of select="hauptebene"/>
            <xsl:copy-of select="zweite-ebene"/>
            <xsl:copy-of select="dritte-ebene"/>
            <fundstellen><xsl:value-of select="comment()"/></fundstellen>
        </reg-zeile>
    </xsl:template>
    
    <xsl:template match="autoren-zeile" mode="ident">
        <reg-zeile>
            <xsl:copy-of select="autor"/>
            <xsl:copy-of select="title"/>
            <fundstellen><xsl:value-of select="comment()"/><xsl:value-of select="abkuerzung"/></fundstellen>
        </reg-zeile>
    </xsl:template>
    
</xsl:stylesheet>