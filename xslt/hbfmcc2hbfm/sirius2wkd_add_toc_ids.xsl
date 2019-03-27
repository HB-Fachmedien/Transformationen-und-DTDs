<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

	<xsl:output indent="yes" doctype-public="-//Handelsblatt Fachmedien//DTD V1.0//DE" doctype-system="hbfm.dtd" encoding="UTF-8"/>

	<xsl:template match="/">

		<!-- Generate seperate Document for Der Betrieb Arbeitsrecht -->
		<xsl:if test="/*/metadata/all_source[@level='2']/text()='db' and /*/metadata/ressort/text()='Arbeitsrecht'">
			<xsl:call-template name="der-betrieb-arbeitsrecht"/>
		</xsl:if>

		<xsl:apply-templates/>

	</xsl:template>

	<xsl:template match="metadata" name="md">
		<metadata>
			<xsl:apply-templates/>
		</metadata>
	</xsl:template>
	
	
	<xsl:template name="taxonomy">
		<xsl:param name="werks_mapping" select="document('werks_mapping.xml')"/>
		<xsl:param name="src-level-2" required="yes"></xsl:param>
		
		<xsl:variable name="string-of-keys" select="tokenize($werks_mapping/werke/werk[lower-case(@dpsi)=lower-case($src-level-2)]/text(), ' ')"/>
		<taxonomy>
			<xsl:for-each select="$string-of-keys">
				<key><xsl:text></xsl:text><xsl:value-of select="current()"/></key>
			</xsl:for-each>
		</taxonomy>
	</xsl:template>
	

	<xsl:template name="der-betrieb-arbeitsrecht">
		<xsl:variable name="filename" select="concat(replace(substring-before(tokenize(base-uri(),'/')[last()], '.xml'), 'DB', 'DBAR'), '.xml')"/>

		<xsl:result-document href="{$filename}" method="xml" encoding="UTF-8">
			
			<xsl:element name="{/*/name()}">
				<xsl:apply-templates select="/*/attribute::*"/>
				<metadata>
					<xsl:apply-templates select="/*/metadata/title | /*/metadata/subtitle | /*/metadata/coll_title | /*/metadata/authors | /*/metadata/summary | /*/metadata/summary_plain | /*/metadata/leitsaetze | /*/metadata/keywords "/>
					
					<xsl:call-template name="taxonomy">
						<xsl:with-param name="src-level-2" select="'dbar'"/>
					</xsl:call-template>
					
					<xsl:apply-templates select="/*/metadata/ressort | /*/metadata/rubriken"/> 
						
					<xsl:apply-templates select="/*/metadata/pub" mode="pub_dbar"/> 
						
					<xsl:apply-templates select="/*/metadata/extfile | /*/metadata/law | /*/metadata/instdoc | /*/metadata/preinstdocs | /*/metadata/law_refs | /*/metadata/chapter | /*/metadata/global_toc | /*/metadata/inner_toc | /*/metadata/date_sort | /*/metadata/all_doc_type | /*/metadata/all_source[@level='1']"/>
					<all_source level="2">dbar</all_source>
				</metadata>
				
				<xsl:apply-templates select="/*/body"/>
				
			</xsl:element>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="pub" mode="pub_dbar">
		<pub>
			<xsl:apply-templates select="pubtitle"/>
			<pubabbr>DBAR</pubabbr>
			<xsl:apply-templates select="pubyear | pubedition | date | pub_suppl | pages | pages_alt | public | add_target | version | publisher"/>
		</pub>
	</xsl:template>
	
	<xsl:template match="inner_toc">
		<inner_toc>
			<xsl:apply-templates select="../../body/section" mode="localToc"/>
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


	<xsl:template match="section[ancestor::body]">
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
