<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
	version="2.0">

<xsl:output indent="yes"
		doctype-public="-//Handelsblatt Fachmedien CContent//DTD V1.0//DE"
		doctype-system="hbfmcc.dtd"
		encoding="UTF-8"
	/>


<!-- =========================================================
=== split if used in issue conversion mode
=========================================================== -->
<xsl:template match="convFile">
	<xsl:result-document href="{processing-instruction('CL')}"
		indent="yes"
		encoding="UTF-8">
		<xsl:apply-templates/>
	</xsl:result-document>
</xsl:template>

<xsl:template match="processing-instruction('CL')"/>




<xsl:template match="inner_toc">
	<inner_toc>
		<xsl:apply-templates select="../../xml_body/section" mode="localToc"/>
	</inner_toc>
</xsl:template>


<!-- skip sections without number or title -->
<xsl:template match="section[not(@number) and not(title)]" mode="localToc" priority="9"/>

<xsl:template match="section" mode="localToc">
	<item>
		<content>
			<name>
				<!-- build link target id -->
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text>
					<xsl:call-template name="buildIdForLocalToc"/>
				</xsl:attribute>
				
				<xsl:if test="@number">
					<xsl:value-of select="@number"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:apply-templates select="title/descendant::text()[not(ancestor::footnote)]"/>
			</name>
		</content>
		<xsl:apply-templates select="section" mode="localToc"/>
	</item>
</xsl:template>



<xsl:template match="section[ancestor::xml_body]">
	<section>
		<xsl:copy-of select="@*"/>
		
		<!-- build link id for local toc -->
		<xsl:attribute name="id">
			<xsl:call-template name="buildIdForLocalToc"/>
		</xsl:attribute>
		
		<xsl:apply-templates/>
	</section>
</xsl:template>




<!-- =========================================================
=== helper templates
=========================================================== -->
<!-- build ids for local toc: use section nesting -->
<xsl:template name="buildIdForLocalToc">
	<xsl:text>sec</xsl:text>
	<xsl:for-each select="ancestor-or-self::section">
		<xsl:text>_</xsl:text>
		<xsl:value-of select="count(preceding-sibling::section) + 1"/>
	</xsl:for-each>
</xsl:template>





<!-- =========================================================
=== fallback identity template
=========================================================== -->
<xsl:template match="@* | node()">
	<xsl:copy>
		<xsl:apply-templates select="@* | node()"/>
	</xsl:copy>
</xsl:template>


</xsl:transform>
