<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
	version="2.0">

<xsl:output indent="yes"
		encoding="UTF-8"
	/>



<!-- =========================================================
=== rename some elements to match c-content specification
=========================================================== -->
<!-- root elements -->
<xsl:template match="hbfmdoc">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="au | divah | divso | divsu | ed | ent | entk | entv | gh | gk | gtdraft | toc | kk | nbb | nr | sp | va | vadraft | vav | iv | rez | kb">
	<rodoc>
		<xsl:apply-templates/>
	</rodoc>
</xsl:template>


<!-- metadata elements -->
	<xsl:template match="metadata">
		<metadata>
			<!-- create elements from attributes -->
			<xsl:if test="../@docid">
				<docid>
					<xsl:value-of select="../@docid"/>
				</docid>
			</xsl:if>
			<xsl:variable name="altdocid" select="../@altdocid"/>
			<xsl:if test="$altdocid">
					<!-- Test, ob mehrere altdocids, getrennt durch Leerzeichen, vorhanden sind -->
					<xsl:choose>
					<xsl:when test="not(contains($altdocid, ' '))">
						<altdocid>
							<xsl:value-of select="$altdocid"/>
						</altdocid>
					</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="altdocIDs" select="tokenize($altdocid, ' ')"/>
							<xsl:for-each select="$altdocIDs">
								<altdocid><xsl:value-of select="."/></altdocid>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
			</xsl:if>
			<xsl:if test="../@rawid">
				<rawid>
					<xsl:value-of select="../@rawid"/>
				</rawid>
			</xsl:if>
			<xsl:if test="../@extid">
				<extid>
					<xsl:value-of select="../@extid"/>
				</extid>
			</xsl:if>

			<!-- create element maindate -->
			<maindate>
				<xsl:choose>
					<xsl:when test="/*[name()=('entv', 'vav', 'vadraft')] and instdoc[1]/instdocdate">
						<xsl:apply-templates select="descendant::instdoc[1]/instdocdate/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="descendant::pub/date/node()"/>
					</xsl:otherwise>
				</xsl:choose>
			</maindate>


			<xsl:apply-templates
				select="*[name() != 'all_doc_type' 
		                               and name() != 'all_source']"/>

			<xsl:call-template name="createToc"/>
			<xsl:call-template name="createLocalToc"/>

			<xsl:apply-templates select="all_doc_type | all_source"/>
		</metadata>
	</xsl:template>



<!-- =========================================================
=== create all_doc_type level 2
========================================================= -->
<xsl:template match="all_doc_type">
	<xsl:copy-of select="."/>
	
	<all_doc_type level="2">
		<xsl:value-of select="name(../..)"/>
	</all_doc_type>
</xsl:template>


<!-- =========================================================
=== add area/code
=== move date out of pub
========================================================= -->
<xsl:template match="pub">
	<xsl:if test="../ressort">
		<area>
			<code>ASDB</code>
			<code>AVDB</code>
			<code>BKDB</code>
			<code>BzDB</code>
			<code>IRDB</code>
			<code>KRDB</code>
			<code>WBDB</code>
			<code>GRDB</code>
			<code>HGDB</code>
			<code>VRDB</code>
			<code>UHDB</code>
			<code>MRDB</code>
			<code>HVDB</code>
			<code>DSDB</code>
			<code>SADB</code>
			<code>USDB</code>
			<code>GSDB</code>
			<code>ESDB</code>
			<code>EbDB</code>
			<code>KSDB</code>
			<code>ISDB</code>
			<code>SRDB</code>
			<code>ZVDB</code>
			<code>BSDB</code>
			<code>BRDB</code>
			<code>BWDB</code>
		</area>
	</xsl:if>

	<xsl:copy-of select="date"/>
	
	<pub>
		<xsl:apply-templates/>
	</pub>
	
	<!-- create type/origfile from extfile -->
	<xsl:if test="not(../extfile)">
		<type>html</type>
	</xsl:if>
</xsl:template>

<xsl:template match="pub/date"/>


<!-- =========================================================
=== flaten keywords
========================================================= -->
<xsl:template match="keywords">
	<keywords>
		<xsl:for-each select="descendant::text()">
			<xsl:variable name="keywordCandidate" select="normalize-space(.)"/>
			<xsl:if test="$keywordCandidate != ''">
				<keyword>
					<xsl:value-of select="$keywordCandidate"/>
				</keyword>
			</xsl:if>
		</xsl:for-each>
	</keywords>
</xsl:template>

<!-- =========================================================
=== create type/origfile from extfile
========================================================= -->
<xsl:template match="extfile">
	<xsl:choose>
		<xsl:when test="@display = 'false'">
			<type>html</type>
			<origfile display="false">
				<xsl:apply-templates/>
			</origfile>
		</xsl:when>
		
		<xsl:otherwise>
			<type>
				<xsl:value-of select="@type"/>
			</type>
			<origfile display="true">
				<xsl:apply-templates/>
			</origfile>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>




<!-- =========================================================
=== create element intermed_page
========================================================= -->
<xsl:template match="last_page">
	<!-- do we have roman numbers -->
	<xsl:choose>
		<xsl:when test="matches(text(), '[ivxlc]+', 'i')">
			<xsl:call-template name="createIntermedPageElemForRomanNumbers"/>
		</xsl:when>
		
		<xsl:otherwise>
			<!-- normal arab numbers -->
			<xsl:call-template name="createIntermedPageElemForArabNumbers"/>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:copy-of select="."/>
</xsl:template>


<!-- =========================================================
=== create element marginnr in doctype entv
========================================================= -->
<xsl:template match="pub/pages[ancestor::entv]">
	<xsl:copy-of select="."/>
	
	<xsl:if test="descendant::rz">
		<marginnr>
			<xsl:for-each select="descendant::rz">
				<xsl:value-of select="."/>
				<xsl:text> </xsl:text>
			</xsl:for-each>
		</marginnr>
	</xsl:if>
</xsl:template>



<!-- =========================================================
=== flaten metadata
=========================================================== -->
<xsl:template match="id
                     | sgml_root_element
                     | judges
                     | exportblocker"/>



<!-- =========================================================
=== add authors_rest
========================================================= -->
<xsl:template match="authors">
	<author_info>
		<xsl:apply-templates/>
	</author_info>
	
	<authors>
		<xsl:for-each select="author | organisation">
			<xsl:choose>
				<xsl:when test="self::author">
					<xsl:value-of select="fullname/node()"/>
					<xsl:value-of select="firstname/node()"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="surname/node()"/>
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:value-of select="node()"/>
				</xsl:otherwise>
			</xsl:choose>
				
			<xsl:if test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</authors>
</xsl:template>





<!-- =========================================================
=== convert gerichts und behoerde codes to plain text
========================================================= -->
<xsl:template match="inst">
	<inst><xsl:apply-templates/></inst>
	
	<instcode>
		<xsl:attribute name="{@type}" select="@code"/>
		<xsl:value-of select="@code"/>
	</instcode>
	
	<insttype value="{@type}">
		<xsl:value-of select="@type"/>
	</insttype>
</xsl:template>

<xsl:template match="public">
	<public>
		<xsl:copy-of select="@*"/>
		<xsl:value-of select="@value"/>
	</public>
</xsl:template>


<!-- =========================================================
=== create toc and local toc
=========================================================== -->
<xsl:template name="createToc">
	<xsl:variable name="pub-abbr" select="descendant::pubabbr/text()"/>
	<xsl:if test="not( (/gh and all_source[@level='2']='ar') or (descendant::pubtitle/text() = 'Steuerboard-Blog') or ($pub-abbr='SU') or (descendant::pubtitle/text() = 'Rechtsboard-Blog') or (/*/local-name() = 'gtdraft') or (/*/local-name() = 'divso') or (/*/local-name() = 'divah')or (/*/local-name() = 'entv') or (/*/local-name() = 'vav') or (/*/local-name() = 'vadraft') or ( pub/pubtitle='OrganisationsEntwicklung' and starts-with(coll_title/text(), 'ZOE Spezial')))">
			<toc>
				<node title="root" childOrder="BySequenceNr">
					<node title="Zeitschriften" sequenceNr="200" childOrder="BySequenceNr">
						<node sequenceNr="100" childOrder="ByTitleReverseAlphanumeric">
							<xsl:attribute name="title">
								<xsl:choose>
									<xsl:when test="descendant::pubtitle/text() = 'StR kompakt'">
										<xsl:text>StR kompakt</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'BWP'">
										<xsl:text>Bewertungspraktiker</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'IFST'">
										<xsl:text>ifst-Schriften</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = ('DB','DBL')">
										<xsl:text>Der Betrieb</xsl:text>
									</xsl:when>
									<xsl:when test="($pub-abbr = 'CF') or ($pub-abbr = 'CFL') or ($pub-abbr = 'CFB') or ($pub-abbr = 'FB')">
										<xsl:text>Corporate Finance</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'KOR'">
										<xsl:text>KoR</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'DK'">
										<xsl:text>Der Konzern</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'AR'">
										<xsl:text>Aufsichtsrat</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'DSB'">
										<xsl:text>Datenschutz-Berater</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'ZOE'">
										<xsl:text>OrganisationsEntwicklung</xsl:text>
									</xsl:when>
									<xsl:when test="$pub-abbr = 'WUW'">
										<xsl:text>Wirtschaft und Wettbewerb</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Unbekannte Zeitschrift</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>

							<!-- get year from element date -->
							<node title="{replace(descendant::date/text(), '(\d+).*', '$1')}">
								<xsl:variable name="beilagennummer" select="descendant::pub/pub_suppl/text()"/>
								
								<!-- Gibt womöglich ein Problem, wenn z.B. wie beim GK von CF kein Ressort vorhanden ist.
								Habe das weiter unten im CF TOC Bereich abgefangen.
								-->
								<xsl:variable name="ressortname" select="ressort/text()"/>
								<xsl:choose>
									<!-- Wenn es sich um eine Heftbeilage handelt, dann ist das pub_suppl Element gefüllt und wird gesondert behandelt: -->
									<xsl:when test="number($beilagennummer) > 0">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<node childOrder="ByTitleAlphanumeric">
											<xsl:attribute name="title">Beilage <xsl:value-of select="$beilagennummer"/> (zu Heft <xsl:value-of select="descendant::pub/pubedition"/>)</xsl:attribute>
											<leaf sequenceNr="0"/>
										</node>
									</xsl:when>
									
									<!-- Bewertungspraktiker -->
									<xsl:when test="$pub-abbr = 'BWP'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:choose>
											<!-- SM: BWP wird seit 2017 auch als XML produziert, daher hier Differenzierung: -->
											<xsl:when test="number(substring(pub/date/text(), 1, 4)) &gt; 2016">
												<xsl:variable name="get-pubedition">
													<xsl:choose>
														<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
														<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<node title="{$get-pubedition}" childOrder="BySequenceNr">
													<leaf sequenceNr="{(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100) + ((number(descendant::article_order/text()) - 1) * 10)}"/>
												</node>
											</xsl:when>
											<xsl:otherwise>
												<leaf sequenceNr="0"/>		
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									
									<!-- IFST SCHRIFT -->
									<xsl:when test="$pub-abbr = 'IFST'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										
										<node title="Schrift {descendant::pubedition}"
											childOrder="BySequenceNr">
											<!-- calculate sequenceNr from first page and article's position on page -->
											<leaf
												sequenceNr="{
												(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
												+
												((number(descendant::article_order/text()) - 1) * 10)
												}"
											/>
										</node>
									</xsl:when>
									
									<!-- StR Kompakt -->
									<xsl:when test="descendant::pubtitle/text() = 'StR kompakt'">
										<xsl:attribute name="childOrder">BySequenceNr</xsl:attribute>
										
										<xsl:variable name="monat" select="number(tokenize(descendant::date/text(), '-')[2])"/>
										
										<xsl:variable name="monatAusgeschrieben">
											<xsl:choose>
												<xsl:when test="$monat=1">Januar</xsl:when>
												<xsl:when test="$monat=2">Februar</xsl:when>
												<xsl:when test="$monat=3">März</xsl:when>
												<xsl:when test="$monat=4">April</xsl:when>
												<xsl:when test="$monat=5">Mai</xsl:when>
												<xsl:when test="$monat=6">Juni</xsl:when>
												<xsl:when test="$monat=7">Juli</xsl:when>
												<xsl:when test="$monat=8">August</xsl:when>
												<xsl:when test="$monat=9">September</xsl:when>
												<xsl:when test="$monat=10">Oktober</xsl:when>
												<xsl:when test="$monat=11">November</xsl:when>
												<xsl:when test="$monat=12">Dezember</xsl:when>
											</xsl:choose>
										</xsl:variable>
										<!-- Dezember soll oben stehen, daher nachfolgende Absolutfunktion-->
										<node title="{$monatAusgeschrieben}"
											childOrder="ByTitleAlphanumeric" sequenceNr="{abs($monat - 13)}">
											<leaf sequenceNr="100" />
										</node>
									</xsl:when>
									
									<xsl:when test="$pub-abbr = 'DK'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}" childOrder="BySequenceNr">
											<xsl:variable name="dk-ressorts" >
												<xsl:choose>
													<xsl:when test="$ressortname='kr'">Konzernrecht#100</xsl:when>
													<xsl:when test="$ressortname='sr'">Steuerrecht#200</xsl:when>
													<xsl:when test="$ressortname='br'">Bilanzrecht/Rechnungslegung#300</xsl:when>
													<xsl:otherwise>Weitere Inhalte#2100</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node title="{tokenize($dk-ressorts, '#')[1]}" sequenceNr="{tokenize($dk-ressorts, '#')[2]}" childOrder="BySequenceNr" expanded="true">
												<xsl:variable name="dk-dokt">
													<xsl:choose>
														<xsl:when test="../name()='ed'">Editorial#50</xsl:when>
														<xsl:when test="../name()='gk'">Gastkommentar#60</xsl:when>
														<xsl:when test="../name()='au'">Aufsätze#100</xsl:when>
														<xsl:when test="../name()='ent'">Entscheidungen#200</xsl:when>
														<xsl:when test="../name()='entk'">Entscheidungen#200</xsl:when>
														<xsl:when test="../name()='va'">Verwaltungsanweisungen#300</xsl:when>
														<xsl:when test="../name()='nr'">Nachrichten#400</xsl:when>
														<xsl:when test="../name()='kk'">Kompakt#500</xsl:when>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="leafseqnr">
													<xsl:choose>
														<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="
																(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
																+
																((number(descendant::article_order/text()) - 1) * 10)"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<node title="{tokenize($dk-dokt, '#')[1]}" sequenceNr="{tokenize($dk-dokt, '#')[2]}" childOrder="BySequenceNr">
													<leaf sequenceNr="{$leafseqnr}"/>
												</node>
											</node>
										</node>
									</xsl:when>
									
									<!-- KOR -->
									<xsl:when test="$pub-abbr = 'KOR'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}" childOrder="BySequenceNr" expanded="true">
											<xsl:variable name="kor-docType-SeqN">
												<xsl:choose>
													<xsl:when test="../name()='au'">Beiträge#100</xsl:when>
													<xsl:when test="../name()='nr'">Reports#500</xsl:when>
													<xsl:when test="../name()='gk'">Gastkommentar#700</xsl:when>
													<xsl:when test="../name()='ed'">Editorial#800</xsl:when>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="leafseqnr">
												<xsl:choose>
													<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="
															(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
															+
															((number(descendant::article_order/text()) - 1) * 10)"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node title="{tokenize($kor-docType-SeqN, '#')[1]}" sequenceNr="{tokenize($kor-docType-SeqN, '#')[2]}" childOrder="BySequenceNr">
												<leaf sequenceNr="{$leafseqnr}"/>
											</node>
										</node>
									</xsl:when>
									
									<xsl:when test="$pub-abbr = 'ZOE'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}" childOrder="BySequenceNr" expanded="true">
											<xsl:variable name="kor-docType-SeqN">
												<xsl:choose>
													<xsl:when test="../name()='au'">Beiträge#100</xsl:when>
													<xsl:when test="../name()='nr'">Nachrichten#500</xsl:when>
													<!--<xsl:when test="../name()='ent'">Recht &amp; Politik#550</xsl:when>-->
													<xsl:when test="../name()='rez'">Buchbesprechungen#570</xsl:when>
													<xsl:when test="../name()='iv'">Interview#600</xsl:when>
													<xsl:when test="../name()='gk'">Gastkommentar#700</xsl:when>
													<xsl:when test="../name()='ed'">Editorial#800</xsl:when>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="leafseqnr">
												<xsl:choose>
													<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="
															(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
															+
															((number(descendant::article_order/text()) - 1) * 10)"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node title="{tokenize($kor-docType-SeqN, '#')[1]}" sequenceNr="{tokenize($kor-docType-SeqN, '#')[2]}" childOrder="BySequenceNr">
												<leaf sequenceNr="{$leafseqnr}"/>
											</node>
										</node>
									</xsl:when>
									
									<xsl:when test="$pub-abbr = 'WUW'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}" childOrder="BySequenceNr" expanded="true">
											<xsl:variable name="kor-docType-SeqN">
												<xsl:choose>
													<xsl:when test="../name()='ed'">Editorial#50</xsl:when>
													<xsl:when test="../name()='gk'">Gastkommentar#60</xsl:when>
													<xsl:when test="../name()='au'">Abhandlungen#100</xsl:when>
													<xsl:when test="../name()='nr'">Nachrichten#500</xsl:when>
													<xsl:when test="../name()='rez'">Literatur#530</xsl:when>
													<xsl:when test="../name()='ent'">Entscheidungen#550</xsl:when>
													<xsl:when test="../name()='iv'">Interview#600</xsl:when>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="leafseqnr">
												<xsl:choose>
													<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="
															(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
															+
															((number(descendant::article_order/text()) - 1) * 10)"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node title="{tokenize($kor-docType-SeqN, '#')[1]}" sequenceNr="{tokenize($kor-docType-SeqN, '#')[2]}" childOrder="BySequenceNr">
												<leaf sequenceNr="{$leafseqnr}"/>
											</node>
										</node>
									</xsl:when>
									
									<xsl:when test="$pub-abbr = 'DSB'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}" childOrder="BySequenceNr" expanded="true">
											<xsl:variable name="kor-docType-SeqN">
												<xsl:choose>
													<xsl:when test="../name()='au'">Beiträge#100</xsl:when>
													<xsl:when test="../name()='nr'">Nachrichten#500</xsl:when>
													<xsl:when test="../name()='ent'">Rechtsprechung#550</xsl:when>
													<xsl:when test="../name()='kk'">Kompakt#560</xsl:when>
													<xsl:when test="../name()='rez'">Buchbesprechungen#570</xsl:when>
													<xsl:when test="../name()='gk'">Gastkommentar#700</xsl:when>
													<xsl:when test="../name()='ed'">Editorial#800</xsl:when>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="leafseqnr">
												<xsl:choose>
													<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="
															(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
															+
															((number(descendant::article_order/text()) - 1) * 10)"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node title="{tokenize($kor-docType-SeqN, '#')[1]}" sequenceNr="{tokenize($kor-docType-SeqN, '#')[2]}" childOrder="BySequenceNr">
												<leaf sequenceNr="{$leafseqnr}"/>
											</node>
										</node>
									</xsl:when>
									
									<xsl:when test="$pub-abbr = 'AR'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}" childOrder="BySequenceNr" expanded="true">
											<xsl:variable name="kor-docType-SeqN">
												<xsl:choose>
													<xsl:when test="../name()='au'">Beiträge#100</xsl:when>
													<xsl:when test="../name()='nr'">Nachrichten#500</xsl:when>
													<xsl:when test="../name()='ent'">Rechtsprechung#550</xsl:when>
													<xsl:when test="../name()='rez'">Rezensionen#570</xsl:when>
													<xsl:when test="../name()='iv'">Interview#600</xsl:when>
													<xsl:when test="../name()='gk'">Gastkommentar#700</xsl:when>
													<xsl:when test="../name()='ed'">Editorial#800</xsl:when>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="leafseqnr">
												<xsl:choose>
													<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="
															(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
															+
															((number(descendant::article_order/text()) - 1) * 10)"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node title="{tokenize($kor-docType-SeqN, '#')[1]}" sequenceNr="{tokenize($kor-docType-SeqN, '#')[2]}" childOrder="BySequenceNr">
												<leaf sequenceNr="{$leafseqnr}"/>
											</node>
										</node>
									</xsl:when>
									
									<!-- Corporate Finance -->
									<xsl:when test="($pub-abbr = 'CF') or ($pub-abbr = 'CFL') or ($pub-abbr = 'CFB') or ($pub-abbr = 'FB')">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="cf-title">
											<xsl:choose>
												<xsl:when test="$pub-abbr = 'CFL'">Heft CFL <xsl:value-of select="descendant::pubedition"/></xsl:when>
												<xsl:when test="$pub-abbr = 'CFB'">Heft CFB <xsl:value-of select="descendant::pubedition"/></xsl:when>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$cf-title}" childOrder="BySequenceNr">
											<xsl:variable name="cf-ressort-seq-nr" >
												<xsl:choose>
													<xsl:when test="$ressortname='Finanzierung'">100</xsl:when>
													<xsl:when test="$ressortname='Kapitalmarkt'">200</xsl:when>
													<xsl:when test="$ressortname='Bewertung'">300</xsl:when>
													<xsl:when test="$ressortname='Mergers &amp; Acquisitions'">400</xsl:when>
													<xsl:when test="$ressortname='Agenda'">500</xsl:when>
													<xsl:when test="$ressortname='Bildung'">600</xsl:when>
													<xsl:when test="$ressortname='Corporate Governance'">700</xsl:when>
													<xsl:when test="$ressortname='Existenzgründung'">800</xsl:when>
													<xsl:when test="$ressortname='Finanzmanagement'">900</xsl:when>
													<xsl:when test="$ressortname='Finanzmarkt'">1000</xsl:when>
													<xsl:when test="$ressortname='Gründung'">1100</xsl:when>
													<xsl:when test="$ressortname='Märkte'">1200</xsl:when>
													<xsl:when test="$ressortname='Outlook'">1300</xsl:when>
													<xsl:when test="$ressortname='Private Equity'">1400</xsl:when>
													<xsl:when test="$ressortname='Scope'">1500</xsl:when>
													<xsl:when test="$ressortname='Statements'">1600</xsl:when>
													<xsl:when test="$ressortname='Tools'">1700</xsl:when>
													<xsl:when test="$ressortname='Transaktionen'">1800</xsl:when>
													<xsl:when test="$ressortname='Unternehmen'">1900</xsl:when>
													<xsl:when test="$ressortname='Venture Capital'">2000</xsl:when>
													<xsl:otherwise>2100</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<node sequenceNr="{$cf-ressort-seq-nr}" childOrder="BySequenceNr" expanded="true">
												<xsl:attribute name="title">
													<!-- title="{$ressortname}" -->
													<xsl:choose>
														<xsl:when test="string($ressortname)=''">Weitere Inhalte</xsl:when>
														<xsl:otherwise><xsl:value-of select="$ressortname"/></xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<xsl:variable name="docType-SeqN">
													<xsl:choose>
														<xsl:when test="../name()='au'">Aufsätze#100</xsl:when>
														<xsl:when test="../name()='kk'">Kompakt#200</xsl:when>
														<xsl:when test="../name()='va'">Verwaltungsanweisungen#300</xsl:when>
														<xsl:when test="../name()='ent'">Entscheidungen#400</xsl:when>
														<xsl:when test="../name()='entk'">Entscheidungen#400</xsl:when>
														<xsl:when test="../name()='nr'">Nachrichten#800</xsl:when>
														<xsl:when test="../name()='sp'">Standpunkte#600</xsl:when>
														<xsl:when test="../name()='gk'">Gastkommentar#700</xsl:when>
														<xsl:when test="../name()='ed'">Editorial#500</xsl:when>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="leafseqnr">
													<xsl:choose>
														<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="
																(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
																+
																((number(descendant::article_order/text()) - 1) * 10)"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<node title="{tokenize($docType-SeqN, '#')[1]}" sequenceNr="{tokenize($docType-SeqN, '#')[2]}" childOrder="BySequenceNr">
													<leaf sequenceNr="{$leafseqnr}"/>
												</node>
											</node>
										</node>
									</xsl:when>
									
									<!-- Der Betrieb -->
									<xsl:when test="descendant::pubtitle/text() = 'Der Betrieb'">
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										
										<node title="{$get-pubedition}"
											childOrder="BySequenceNr">
											
											<!-- Hier jetzt Ressorts Unterscheidung -->
											<xsl:variable name="ressortNameAndSeqN">
												<xsl:choose>
													<xsl:when test="$ressortname='bw'">Betriebswirtschaft#100</xsl:when>
													<xsl:when test="$ressortname='sr'">Steuerrecht#200</xsl:when>
													<xsl:when test="$ressortname='wr'">Wirtschaftsrecht#300</xsl:when>
													<xsl:when test="$ressortname='ar'">Arbeitsrecht#400</xsl:when>
													<xsl:otherwise>Weitere Inhalte#500</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>

											<node title="{tokenize($ressortNameAndSeqN, '#')[1]}" sequenceNr="{tokenize($ressortNameAndSeqN, '#')[2]}" childOrder="BySequenceNr" expanded="true">
												<xsl:variable name="docTypeAndSeqN">
													<xsl:choose>
														<xsl:when test="../name()='au'">Aufsätze#100</xsl:when>
														<xsl:when test="../name()='kk'">Kompakt#200</xsl:when>
														<xsl:when test="../name()='va'">Verwaltungsanweisungen#300</xsl:when>
														<xsl:when test="../name()='ent'">Entscheidungen#400</xsl:when>
														<xsl:when test="../name()='entk'">Entscheidungen#400</xsl:when>
														<xsl:when test="../name()='nr'">Nachrichten#800</xsl:when>
														<xsl:when test="../name()='kb'">Kurzbeiträge#850</xsl:when>
														<xsl:when test="../name()='sp'">Standpunkte#600</xsl:when>
														<xsl:when test="../name()='gk'">Gastkommentar#700</xsl:when>
														<xsl:when test="../name()='ed'">Editorial#500</xsl:when>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="leafseqnr">
													<xsl:choose>
														<xsl:when test="descendant::pubedition = '00'"><xsl:value-of select="21000000 - number(replace(pub/date,'-',''))"/></xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="
																(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
																+
																((number(descendant::article_order/text()) - 1) * 10)"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<node title="{tokenize($docTypeAndSeqN, '#')[1]}" sequenceNr="{tokenize($docTypeAndSeqN, '#')[2]}" childOrder="BySequenceNr">
													<leaf sequenceNr="{$leafseqnr}"/>
												</node>
											</node> 
										</node>
									</xsl:when>
									<xsl:otherwise>
										<!-- Default Verarbeitung -->
										<xsl:attribute name="childOrder">ByTitleReverseAlphanumeric</xsl:attribute>
										<xsl:variable name="get-pubedition">
											<xsl:choose>
												<xsl:when test="descendant::pubedition = '00'">Online exklusiv</xsl:when>
												<xsl:otherwise>Heft <xsl:value-of select="descendant::pubedition"/></xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<node title="{$get-pubedition}"
											childOrder="BySequenceNr">
											
											<!-- calculate sequenceNr from first page and article's position on page -->
											<leaf
												sequenceNr="{
												(number(replace(descendant::pages/start_page/text(), '[^\d]', '')) * 100)
												+
												((number(descendant::article_order/text()) - 1) * 10)
												}"
											/>
										</node>
									</xsl:otherwise>
								</xsl:choose>							
							</node>
						</node>
					</node>
				</node>
			</toc>
		</xsl:if>
</xsl:template>

<xsl:template name="createLocalToc">
	<inner_toc/>
</xsl:template>


<!-- =========================================================
=== copy rich metadata to body
=========================================================== -->
<xsl:template match="body[../metadata/descendant::pubabbr/text() = 'DB']" priority="2">
	<!-- in DB don't rearrange sections -->
	<xml_body>
		<xsl:apply-templates/>
	</xml_body>
</xsl:template>

<xsl:template match="body">
	<xml_body>
		<xsl:apply-templates select="section[@class='rkvermerk']" mode="show"/>
		<xsl:apply-templates select="section[@class='veroeffhinw']" mode="show"/>
		<xsl:apply-templates select="section[@class='extnote']" mode="show"/>
		<xsl:apply-templates select="section[@class='tenor']" mode="show"/>
		<xsl:apply-templates select="section[@class='streitjahre']" mode="show"/>
		<xsl:apply-templates select="section[@class='sachverhalt']" mode="show"/>
		<xsl:apply-templates select="section[@class='tatbestand']" mode="show"/>
		<xsl:apply-templates select="section[@class='gruende']" mode="show"/>
		<xsl:apply-templates select="section[@class='entscheidung']" mode="show"/>
		<xsl:apply-templates select="section[@class='konsequenz']" mode="show"/>

		<xsl:apply-templates/>
		
		<xsl:apply-templates select="section[@class='replik']" mode="show"/>
		<xsl:apply-templates select="note" mode="show"/>
	</xml_body>
</xsl:template>


<!-- in non-DB. sections get rearranged, so use template with mode=show -->
<xsl:template match="section[ancestor::*[metadata]/descendant::pubabbr/text() != 'DB' 
                             and (@class='rkvermerk'
								 or @class='veroeffhinw'
								 or @class='extnote'
								 or @class='tenor'
								 or @class='streitjahre'
								 or @class='sachverhalt'
								 or @class='tatbestand'
								 or @class='gruende'
								 or @class='entscheidung'
								 or @class='konsequenz'
								 or @class='replik')
                            ]"/>
<xsl:template match="section[@class='rkvermerk'
                             or @class='veroeffhinw'
                             or @class='extnote'
                             or @class='tenor'
                             or @class='streitjahre'
                             or @class='tatbestand'
                             or @class='replik'
                            ]"
              mode="show">
	<section>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
	</section>
</xsl:template>


<!-- create title for some sections -->
<xsl:template match="section[@class='sachverhalt'
                             or @class='gruende'
                             or @class='entscheidung'
                             or @class='konsequenz']" mode="show">
	<xsl:call-template name="createSectionTitles"/>
</xsl:template>

<!-- create title for some sections in DB -->
<xsl:template match="section[ancestor::*[metadata]/descendant::pubabbr/text() = 'DB' 
                             and (@class='sachverhalt'
								 or @class='gruende'
								 or @class='entscheidung'
								 or @class='konsequenz')
                            ]">
	<xsl:call-template name="createSectionTitles"/>
</xsl:template>


<xsl:template name="createSectionTitles">
	<section>
		<xsl:copy-of select="@*"/>
		
		<xsl:if test="not(title)">
			<title>
				<xsl:choose>
					<xsl:when test="@class='sachverhalt'">
						<xsl:text>Sachverhalt</xsl:text>
					</xsl:when>
					<xsl:when test="@class='gruende'">
						<xsl:text>Entscheidungsgründe</xsl:text>
					</xsl:when>
					<xsl:when test="@class='entscheidung'">
						<xsl:text>Entschiedene Rechtsfragen</xsl:text>
					</xsl:when>
					<xsl:when test="@class='konsequenz'">
						<xsl:text>Bedeutung für die Praxis</xsl:text>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</title>
		</xsl:if>
		
		<xsl:apply-templates/>
	</section>
</xsl:template>






<!-- in DB don't rearrange sections -->
<xsl:template match="note[ancestor::*[metadata]/descendant::pubabbr/text() != 'DB']"/>
<xsl:template match="note" mode="show">
	<note>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
	</note>
</xsl:template>

<!-- =========================================================
=== remove some sections
=========================================================== -->
<xsl:template match="section[@class='antrag' or @class='rubrum']" priority="2"/>




<!-- =========================================================
=== metadata: 
=== arab numbered pages
=========================================================== -->
<xsl:template name="createIntermedPageElemForArabNumbers">
	<xsl:if test="../last_page/text() != ''">
		<xsl:variable name="pagePrefix" select="replace(../start_page/text(), '\d+', '')"/>
		
		<!-- remove any prefixes to convert to "pure" numbers -->
		<xsl:variable name="startPage" select="number(replace(../start_page/text(), '[^\d]+', '')) cast as xs:integer"/>
		<xsl:variable name="endPage"   select="number(replace(../last_page/text(), '[^\d]+', '')) cast as xs:integer"/>
		
		<xsl:variable name="endPageForLoop"   select="($endPage - 2) cast as xs:integer"/>
		
		<xsl:if test="($endPage - $startPage) &gt; 1">
			<intermed_page>
				<xsl:for-each select="$startPage to $endPageForLoop">
					<xsl:value-of select="$pagePrefix"/>
					<xsl:value-of select="$startPage + position()"/>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</intermed_page>
		</xsl:if>
	</xsl:if>
</xsl:template>




<!-- =========================================================
=== metadata: 
=== roman pages
=========================================================== -->
<xsl:template name="createIntermedPageElemForRomanNumbers">
	<!-- get map -->
	<xsl:variable name="romanNumbersMap">
		<xsl:call-template name="getRomanNumbersMap"/>
	</xsl:variable>
	
	<!-- get pure roman numbers -->
	<xsl:variable name="startPageRoman" select="replace(../start_page/text(), '[^ivxlc]+', '', 'i')"/>
	<xsl:variable name="endPageRoman"   select="replace(../last_page/text(), '[^ivxlc]+', '', 'i')"/>
	<xsl:variable name="startPageRomanUC" select="upper-case($startPageRoman)"/>
	<xsl:variable name="endPageRomanUC"   select="upper-case($endPageRoman)"/>
	
	<!-- look up arab numbers -->
	<xsl:variable name="startPageArab" select="$romanNumbersMap/descendant::romanMap[@roman = $startPageRomanUC]/@arab"/>
	<xsl:variable name="endPageArab"   select="$romanNumbersMap/descendant::romanMap[@roman = $endPageRomanUC]/@arab"/>
	
	<!-- convert to "pure" numbers -->
	<xsl:variable name="startPage" select="number($startPageArab) cast as xs:integer"/>
	<xsl:variable name="endPage"   select="number($endPageArab) cast as xs:integer"/>
	<xsl:variable name="endPageForLoop"   select="($endPage - 2) cast as xs:integer"/>
	
	<xsl:if test="($endPageArab - $startPageArab) &gt; 1">
		<intermed_page>
			<xsl:for-each select="$startPageArab to $endPageForLoop">
				<xsl:variable name="currentPage" select="$startPageArab + position()"/>
				<xsl:value-of select="$romanNumbersMap/descendant::romanMap[@arab = $currentPage]/@roman"/>
				<xsl:text> </xsl:text>
			</xsl:for-each>
		</intermed_page>
	</xsl:if>
</xsl:template>




<!-- =========================================================
=== return map as variable
=========================================================== -->
<xsl:template name="getRomanNumbersMap" as="element()*">
	<map>
		<romanMap arab="1" roman="I"/>
		<romanMap arab="2" roman="II"/>
		<romanMap arab="3" roman="III"/>
		<romanMap arab="4" roman="IV"/>
		<romanMap arab="5" roman="V"/>
		<romanMap arab="6" roman="VI"/>
		<romanMap arab="7" roman="VII"/>
		<romanMap arab="8" roman="VIII"/>
		<romanMap arab="9" roman="IX"/>
		<romanMap arab="10" roman="X"/>
		<romanMap arab="11" roman="XI"/>
		<romanMap arab="12" roman="XII"/>
		<romanMap arab="13" roman="XIII"/>
		<romanMap arab="14" roman="XIV"/>
		<romanMap arab="15" roman="XV"/>
		<romanMap arab="16" roman="XVI"/>
		<romanMap arab="17" roman="XVII"/>
		<romanMap arab="18" roman="XVIII"/>
		<romanMap arab="19" roman="XIX"/>
		<romanMap arab="20" roman="XX"/>
		<romanMap arab="21" roman="XXI"/>
		<romanMap arab="22" roman="XXII"/>
		<romanMap arab="23" roman="XXIII"/>
		<romanMap arab="24" roman="XXIV"/>
		<romanMap arab="25" roman="XXV"/>
		<romanMap arab="26" roman="XXVI"/>
		<romanMap arab="27" roman="XXVII"/>
		<romanMap arab="28" roman="XXVIII"/>
		<romanMap arab="29" roman="XXIX"/>
		<romanMap arab="30" roman="XXX"/>
		<romanMap arab="31" roman="XXXI"/>
		<romanMap arab="32" roman="XXXII"/>
		<romanMap arab="33" roman="XXXIII"/>
		<romanMap arab="34" roman="XXXIV"/>
		<romanMap arab="35" roman="XXXV"/>
		<romanMap arab="36" roman="XXXVI"/>
		<romanMap arab="37" roman="XXXVII"/>
		<romanMap arab="38" roman="XXXVIII"/>
		<romanMap arab="39" roman="XXXIX"/>
		<romanMap arab="40" roman="XL"/>
		<romanMap arab="41" roman="XLI"/>
		<romanMap arab="42" roman="XLII"/>
		<romanMap arab="43" roman="XLIII"/>
		<romanMap arab="44" roman="XLIV"/>
		<romanMap arab="45" roman="XLV"/>
		<romanMap arab="46" roman="XLVI"/>
		<romanMap arab="47" roman="XLVII"/>
		<romanMap arab="48" roman="XLVIII"/>
		<romanMap arab="49" roman="XLIX"/>
		<romanMap arab="50" roman="L"/>
		<romanMap arab="51" roman="LI"/>
		<romanMap arab="52" roman="LII"/>
		<romanMap arab="53" roman="LIII"/>
		<romanMap arab="54" roman="LIV"/>
		<romanMap arab="55" roman="LV"/>
		<romanMap arab="56" roman="LVI"/>
		<romanMap arab="57" roman="LVII"/>
		<romanMap arab="58" roman="LVIII"/>
		<romanMap arab="59" roman="LIX"/>
		<romanMap arab="60" roman="LX"/>
		<romanMap arab="61" roman="LXI"/>
		<romanMap arab="62" roman="LXII"/>
		<romanMap arab="63" roman="LXIII"/>
		<romanMap arab="64" roman="LXIV"/>
		<romanMap arab="65" roman="LXV"/>
		<romanMap arab="66" roman="LXVI"/>
		<romanMap arab="67" roman="LXVII"/>
		<romanMap arab="68" roman="LXVIII"/>
		<romanMap arab="69" roman="LXIX"/>
		<romanMap arab="70" roman="LXX"/>
		<romanMap arab="71" roman="LXXI"/>
		<romanMap arab="72" roman="LXXII"/>
		<romanMap arab="73" roman="LXXIII"/>
		<romanMap arab="74" roman="LXXIV"/>
		<romanMap arab="75" roman="LXXV"/>
		<romanMap arab="76" roman="LXXVI"/>
		<romanMap arab="77" roman="LXXVII"/>
		<romanMap arab="78" roman="LXXVIII"/>
		<romanMap arab="79" roman="LXXIX"/>
		<romanMap arab="80" roman="LXXX"/>
		<romanMap arab="81" roman="LXXXI"/>
		<romanMap arab="82" roman="LXXXII"/>
		<romanMap arab="83" roman="LXXXIII"/>
		<romanMap arab="84" roman="LXXXIV"/>
		<romanMap arab="85" roman="LXXXV"/>
		<romanMap arab="86" roman="LXXXVI"/>
		<romanMap arab="87" roman="LXXXVII"/>
		<romanMap arab="88" roman="LXXXVIII"/>
		<romanMap arab="89" roman="LXXXIX"/>
		<romanMap arab="90" roman="XC"/>
		<romanMap arab="91" roman="XCI"/>
		<romanMap arab="92" roman="XCII"/>
		<romanMap arab="93" roman="XCIII"/>
		<romanMap arab="94" roman="XCIV"/>
		<romanMap arab="95" roman="XCV"/>
		<romanMap arab="96" roman="XCVI"/>
		<romanMap arab="97" roman="XCVII"/>
		<romanMap arab="98" roman="XCVIII"/>
		<romanMap arab="99" roman="XCIX"/>
		<romanMap arab="100" roman="C"/>
		<romanMap arab="101" roman="CI"/>
		<romanMap arab="102" roman="CII"/>
		<romanMap arab="103" roman="CIII"/>
		<romanMap arab="104" roman="CIV"/>
		<romanMap arab="105" roman="CV"/>
		<romanMap arab="106" roman="CVI"/>
		<romanMap arab="107" roman="CVII"/>
		<romanMap arab="108" roman="CVIII"/>
		<romanMap arab="109" roman="CIX"/>
		<romanMap arab="110" roman="CX"/>
		<romanMap arab="111" roman="CXI"/>
		<romanMap arab="112" roman="CXII"/>
		<romanMap arab="113" roman="CXIII"/>
		<romanMap arab="114" roman="CXIV"/>
		<romanMap arab="115" roman="CXV"/>
		<romanMap arab="116" roman="CXVI"/>
		<romanMap arab="117" roman="CXVII"/>
		<romanMap arab="118" roman="CXVIII"/>
		<romanMap arab="119" roman="CXIX"/>
		<romanMap arab="120" roman="CXX"/>
		<romanMap arab="121" roman="CXXI"/>
		<romanMap arab="122" roman="CXXII"/>
		<romanMap arab="123" roman="CXXIII"/>
		<romanMap arab="124" roman="CXXIV"/>
		<romanMap arab="125" roman="CXXV"/>
		<romanMap arab="126" roman="CXXVI"/>
		<romanMap arab="127" roman="CXXVII"/>
		<romanMap arab="128" roman="CXXVIII"/>
		<romanMap arab="129" roman="CXXIX"/>
		<romanMap arab="130" roman="CXXX"/>
		<romanMap arab="131" roman="CXXXI"/>
		<romanMap arab="132" roman="CXXXII"/>
		<romanMap arab="133" roman="CXXXIII"/>
		<romanMap arab="134" roman="CXXXIV"/>
		<romanMap arab="135" roman="CXXXV"/>
		<romanMap arab="136" roman="CXXXVI"/>
		<romanMap arab="137" roman="CXXXVII"/>
		<romanMap arab="138" roman="CXXXVIII"/>
		<romanMap arab="139" roman="CXXXIX"/>
		<romanMap arab="140" roman="CXL"/>
		<romanMap arab="141" roman="CXLI"/>
		<romanMap arab="142" roman="CXLII"/>
		<romanMap arab="143" roman="CXLIII"/>
		<romanMap arab="144" roman="CXLIV"/>
		<romanMap arab="145" roman="CXLV"/>
		<romanMap arab="146" roman="CXLVI"/>
		<romanMap arab="147" roman="CXLVII"/>
		<romanMap arab="148" roman="CXLVIII"/>
		<romanMap arab="149" roman="CXLIX"/>
		<romanMap arab="150" roman="CL"/>
		<romanMap arab="151" roman="CLI"/>
		<romanMap arab="152" roman="CLII"/>
		<romanMap arab="153" roman="CLIII"/>
		<romanMap arab="154" roman="CLIV"/>
		<romanMap arab="155" roman="CLV"/>
		<romanMap arab="156" roman="CLVI"/>
		<romanMap arab="157" roman="CLVII"/>
		<romanMap arab="158" roman="CLVIII"/>
		<romanMap arab="159" roman="CLIX"/>
		<romanMap arab="160" roman="CLX"/>
		<romanMap arab="161" roman="CLXI"/>
		<romanMap arab="162" roman="CLXII"/>
		<romanMap arab="163" roman="CLXIII"/>
		<romanMap arab="164" roman="CLXIV"/>
		<romanMap arab="165" roman="CLXV"/>
		<romanMap arab="166" roman="CLXVI"/>
		<romanMap arab="167" roman="CLXVII"/>
		<romanMap arab="168" roman="CLXVIII"/>
		<romanMap arab="169" roman="CLXIX"/>
		<romanMap arab="170" roman="CLXX"/>
		<romanMap arab="171" roman="CLXXI"/>
		<romanMap arab="172" roman="CLXXII"/>
		<romanMap arab="173" roman="CLXXIII"/>
		<romanMap arab="174" roman="CLXXIV"/>
		<romanMap arab="175" roman="CLXXV"/>
		<romanMap arab="176" roman="CLXXVI"/>
		<romanMap arab="177" roman="CLXXVII"/>
		<romanMap arab="178" roman="CLXXVIII"/>
		<romanMap arab="179" roman="CLXXIX"/>
		<romanMap arab="180" roman="CLXXX"/>
		<romanMap arab="181" roman="CLXXXI"/>
		<romanMap arab="182" roman="CLXXXII"/>
		<romanMap arab="183" roman="CLXXXIII"/>
		<romanMap arab="184" roman="CLXXXIV"/>
		<romanMap arab="185" roman="CLXXXV"/>
		<romanMap arab="186" roman="CLXXXVI"/>
		<romanMap arab="187" roman="CLXXXVII"/>
		<romanMap arab="188" roman="CLXXXVIII"/>
		<romanMap arab="189" roman="CLXXXIX"/>
		<romanMap arab="190" roman="CXC"/>
		<romanMap arab="191" roman="CXCI"/>
		<romanMap arab="192" roman="CXCII"/>
		<romanMap arab="193" roman="CXCIII"/>
		<romanMap arab="194" roman="CXCIV"/>
		<romanMap arab="195" roman="CXCV"/>
		<romanMap arab="196" roman="CXCVI"/>
		<romanMap arab="197" roman="CXCVII"/>
		<romanMap arab="198" roman="CXCVIII"/>
		<romanMap arab="199" roman="CXCIX"/>
		<romanMap arab="200" roman="CC"/>
		<romanMap arab="201" roman="CCI"/>
		<romanMap arab="202" roman="CCII"/>
		<romanMap arab="203" roman="CCIII"/>
		<romanMap arab="204" roman="CCIV"/>
		<romanMap arab="205" roman="CCV"/>
		<romanMap arab="206" roman="CCVI"/>
		<romanMap arab="207" roman="CCVII"/>
		<romanMap arab="208" roman="CCVIII"/>
		<romanMap arab="209" roman="CCIX"/>
		<romanMap arab="210" roman="CCX"/>
		<romanMap arab="211" roman="CCXI"/>
		<romanMap arab="212" roman="CCXII"/>
		<romanMap arab="213" roman="CCXIII"/>
		<romanMap arab="214" roman="CCXIV"/>
		<romanMap arab="215" roman="CCXV"/>
		<romanMap arab="216" roman="CCXVI"/>
		<romanMap arab="217" roman="CCXVII"/>
		<romanMap arab="218" roman="CCXVIII"/>
		<romanMap arab="219" roman="CCXIX"/>
		<romanMap arab="220" roman="CCXX"/>
		<romanMap arab="221" roman="CCXXI"/>
		<romanMap arab="222" roman="CCXXII"/>
		<romanMap arab="223" roman="CCXXIII"/>
		<romanMap arab="224" roman="CCXXIV"/>
		<romanMap arab="225" roman="CCXXV"/>
		<romanMap arab="226" roman="CCXXVI"/>
		<romanMap arab="227" roman="CCXXVII"/>
		<romanMap arab="228" roman="CCXXVIII"/>
		<romanMap arab="229" roman="CCXXIX"/>
		<romanMap arab="230" roman="CCXXX"/>
		<romanMap arab="231" roman="CCXXXI"/>
		<romanMap arab="232" roman="CCXXXII"/>
		<romanMap arab="233" roman="CCXXXIII"/>
		<romanMap arab="234" roman="CCXXXIV"/>
		<romanMap arab="235" roman="CCXXXV"/>
		<romanMap arab="236" roman="CCXXXVI"/>
		<romanMap arab="237" roman="CCXXXVII"/>
		<romanMap arab="238" roman="CCXXXVIII"/>
		<romanMap arab="239" roman="CCXXXIX"/>
		<romanMap arab="240" roman="CCXL"/>
		<romanMap arab="241" roman="CCXLI"/>
		<romanMap arab="242" roman="CCXLII"/>
		<romanMap arab="243" roman="CCXLIII"/>
		<romanMap arab="244" roman="CCXLIV"/>
		<romanMap arab="245" roman="CCXLV"/>
		<romanMap arab="246" roman="CCXLVI"/>
		<romanMap arab="247" roman="CCXLVII"/>
		<romanMap arab="248" roman="CCXLVIII"/>
		<romanMap arab="249" roman="CCXLIX"/>
		<romanMap arab="250" roman="CCL"/>
	</map>
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
