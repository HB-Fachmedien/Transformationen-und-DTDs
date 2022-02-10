<?xml version="1.0" encoding="UTF-8"?>

<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <!-- TODO:
    
    1. Regel für all_source Elemente
    
    -->
    <pattern>  
        <rule context="all_doc_type[@level='1']">
            <!--<assert test="text()= 'nb' or text() ='zs' or text() ='ko' or text() ='zt' or text() ='gt' or text() ='ent' or text() ='va' or text() ='div'">Das all-doc-type @level=1 Element besitzt unbekannten Content!</assert>-->
            <assert test="text()= ('nb','zs','ko','zt','gt','ent','va','div')">Das all-doc-type @level=1 Element besitzt unbekannten Content!</assert>
        </rule>
    </pattern>
    
    <!-- ab dem 1.Juni 2019 werden keine RS Nummern mehr im Dokument erlaubt sein: -->
    <pattern>
        <rule context="/*/body[number(replace(../metadata/pub/date, '-', '')) &gt;= 20190601]">
            <report test="matches(string-join(descendant::*[not(ancestor-or-self::note and /*/metadata/pub/pubabbr/text()='WUW')]/text(), ' '), 'RS\d{7,7}')">RS Nummern werden nicht mehr vergeben: <value-of select="descendant::*[matches(string-join(text(), ' '), 'RS\d{7,7}')]"/></report>
        </rule>
    </pattern>
    
    <!-- Nicht nötig, überprüft die DTD: -->
    <!--<pattern>  
        <rule context="/*">
            <assert test="name() = 'au' or name() ='divah' or name() ='divsu' or name() ='divso' or name() ='ed' or name() ='ent' or name() ='entk' or name() ='entv' or name() ='gh' or name() ='gk' or name() ='gtdraft' or name() ='toc' or name() ='kk' or name() ='nbb' or name() ='nr' or name() ='sp' or name() ='va' or name() ='vadraft' or name() ='vav'">Das all-doc-type @level=2 Element besitzt unbekannten Content!</assert>
        </rule>
    </pattern>-->
    
    <!-- Regel mal rausgenommen, nicht sicher, ob wir die noch brauchen -->
    <!--<pattern>
        <rule context="pub/add_target">
            <assert test="text() = ancestor::metadata/all_source[@level='2']/text()">Das add_target Element muss dem all-source @level=2 Element gleichen! Hier wäre das: "<value-of select="ancestor::metadata/all_source[@level='2']/text()"/>"</assert>
        </rule>
    </pattern>-->
    
    <pattern>
        <rule context="metadata/instdoc">
            <assert test="inst[text()]">Inst Elemente dürfen nicht leer sein!</assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="instdoctype">
            <assert test="text()=('Gemeinsame Erklärung', '(Teilversäumnis- und End-) Urteil' , 'Merkblatt', 'Richtlinie', 'Änderungsbeschluss', 'Koalitionsvertrag', 'Bekanntmachung', 'Berichtigungsbeschluss', 'Hinweispapier', 'Ländererlass', 'Geschäftsanweisung', 'Richtlinienvorschlag', 'Sachstandsbericht', 'Aufforderung', 'Entwurf', 'Teilversäumnis- und Teilendurteil', 'Gesetzentwurf', 'Terminpläne', 'Issues Paper', 'Mitteilung', 'Hauptgutachten', 'Leitfaden', 'Zwischenbericht', 'Bericht', 'Arbeitspapier', 'Studie', 'Grünbuch', 'Persönliche Erklärung', 'Referentenentwurf', 'Pressemitteilung', 'Commission Staff Working Document', 'Verordnung', 'Report', 'Kurzinformation','Beschluss','Beschlüsse','Beschluss (Teilentscheidung)','Beschluss (Zwischenentscheidung)','Vorlagebeschluss','Hinweisbeschluss','Nichtannahmebeschluss','Zwischenbeschluss','Teilbeschluss','Schlussbeschluss','Feststellungsbeschluss','Abstellungsbeschluss','Kammerbeschluss','Kostenbeschluss','Ergänzungsbeschluss','Verweisungsbeschluss','Widerspruchsbeschluss','Auflösungsbeschluss','Senatsbeschluss','Normenkontrollbeschluss','Prozesskostenhilfebeschluss','Untersagungsbeschluss','Verpflichtungszusagenbeschluss','Freigabebeschluss','Entscheidung','Entscheidungen','Vorabentscheidung','Rechtsentscheid','Antrag auf Vorabentscheidung','Freigabe-Entscheidung','Verpflichtungsentscheidung','Untersagungsentscheidung','Urteil','Urteile','Teilurteil','Teilurteile','Versäumnisurteil','Urteil und Versäumnisurteil','Teilversäumnisurteil','Schlussurteil','Anerkenntnisurteil','Ergänzungsurteil','Zwischenurteil','Endurteil','Aufhebungsurteil','Grundurteil','Einzelrichterurteil','Normenkontrollurteil','Senatsurteil','Senatszwischenurteil','Verzichtsurteil','Vorbehaltsurteil','(Grund- und End-) Urteil','(Grund- und Teil-) Urteil','(Teilversäumnis- und Schluss-) Urteil','(Versäumnisteil-) Urteil','(Adhäsions-) Urteil','Erlass','gleichlautender Erlass','gleichlautende Erlasse','Verfügung','Allgemeinverfügung','Rundverfügung','Hinweisverfügung','Zwischenverfügung','Einstellungsverfügung','Schlussantrag','Schlussanträge','Information','Schreiben','Vergleich','Hinweis','Teil-Schiedsspruch','Entscheid','Entscheide','Beschwerde-Entscheid','Beschwerde-Entscheide','Bescheid','Bescheide','Gerichtsbescheid','Gerichtsbescheide','Gutachten','Rechtsgutachten','Sondergutachten','Anhängiges Verfahren','Senatssitzung','Stellungnahme','EuGH-Vorlage','Schlussbericht','Monitoringbericht','Fallbericht','Leitlinien','Hintergrundpapier','Papier','Konsultation','Bußgeldbescheid','Grüner Brief')">Dieser instdoctype "<value-of select="."/>" ist nicht erlaubt!</assert>
        </rule>
    </pattern>
    
    <pattern>
        <!-- Instdocnr muss in VA immer gefüllt sein -->
        <rule context="/*[name()=('vav', 'entv')]">
            <assert test="metadata/instdoc/instdocnrs/instdocnr/text() != ''">Instdocnr darf nicht leer sein in Verwaltungsanweisungen!</assert>
        </rule>
    </pattern>
    
    <!-- Bei den Zeitschriften Der Betrieb und Der Konzern werden die Rubriken auf gültige Werte getestet -->
    <pattern>        
        <rule context="rubrik[ancestor::metadata/pub/pubtitle/text()=('Der Betrieb', 'Der Konzern', 'Rechtsboard-Blog', 'Steuerboard-Blog')]">
            <!--<assert test="matches( text(), '(Compliance|Abgabenordnung|Abschlussprüfung|Aktienrecht|Allgemeine BWL|Allgemeine Geschäftsbedingungen|Arbeitnehmerüberlassung|Arbeitsförderung|Arbeitskampfrecht|Arbeitsschutzrecht|Arbeitsvertragsrecht|Arbeitszeitrecht|Bankrecht|Befristungsrecht|Behindertenrecht|Berufsbildungsrecht|Betriebliche Altersversorgung|Betriebsübergang|Betriebsverfassungsrecht|Bewertungsgesetz|Bilanzanalyse|Bilanzsteuerrecht|Controlling|Corporate Governance|Datenschutz|Eigenheimzulage|Einkommensteuer|Elternrecht|Entgeltrecht|Erbschaft-/Schenkungsteuer|Europarecht|Finanzgerichtsordnung|Finanzierung|Genossenschaftsrecht|Gewerbesteuer|Gewinnermittlung|Gleichbehandlung|GmbH-Recht|Grunderwerbsteuer|Grundgesetz|Grundsteuer|Haftungsrecht|Handelsbilanzrecht|Handelsrecht|Handelsvertreterrecht|IFRS|Insolvenzrecht|Internationales Privatrecht|Internationales Steuerrecht|Investitionszulage|Investmentsteuergesetz|Investor Relations|Kapitalanlage|Kapitalertragsteuer|Kapitalmarktrecht|Kartellrecht|Kirchensteuer|Koalitionsrecht|Körperschaftsteuer|Kreditsicherungsrecht|Kündigungsrecht|Leasing|Limited|Lohnsteuer|Mitbestimmungsrecht|Notarrecht|Öffentlicher Dienst|Personengesellschaftsrecht|Produkthaftung|Rechnungslegung|Rechtsanwaltsrecht|Schuldrecht|Solidaritätszuschlag|Sonstige BWL|Sonstige Steuerarten|Sonstiges Recht|Sozialversicherung|Steuerberaterrecht|Steuerstrafrecht|Strafrecht|Tarifvertragsrecht|Teilzeitrecht|Umsatzsteuer|Umwandlungsrecht|Umwandlungssteuerrecht|Unfallversicherung|Unternehmensbewertung|Unternehmenskauf|Unternehmensorganisation|Urlaubsrecht|Verbraucherrecht|Verfahrensrecht|Versicherungsrecht|Wettbewerbsrecht|Wettbewerbsverbot|Wirtschaftsprüferrecht|Zollrecht|Zwangsvollstreckung)')">
                Die Rubrik "<value-of select="."/>" ist nicht erlaubt!
            </assert>-->
            <assert test="text()=('Vertriebsrecht','Compliance','Abgabenordnung','Abschlussprüfung','Aktienrecht','Allgemeine BWL','Allgemeine Geschäftsbedingungen','Arbeitnehmerüberlassung','Arbeitsförderung','Arbeitskampfrecht','Arbeitsschutzrecht','Arbeitsvertragsrecht','Arbeitszeitrecht','Bankrecht','Befristungsrecht','Behindertenrecht','Berufsbildungsrecht','Betriebliche Altersversorgung','Betriebsübergang','Betriebsverfassungsrecht','Bewertungsgesetz','Bilanzanalyse','Bilanzsteuerrecht','Controlling','Corporate Governance','Datenschutz','Digitalisierung', 'Eigenheimzulage','Einkommensteuer','Elternrecht','Entgeltrecht','Erbschaft-/Schenkungsteuer','Europarecht','Finanzgerichtsordnung','Finanzierung','Genossenschaftsrecht','Gewerbesteuer','Gewinnermittlung','Gleichbehandlung','GmbH-Recht','Grunderwerbsteuer','Grundgesetz','Grundsteuer','Haftungsrecht','Handelsbilanzrecht','Handelsrecht','Handelsvertreterrecht','IFRS','Insolvenzrecht','Internationales Privatrecht','Internationales Steuerrecht','Investitionszulage','Investmentsteuergesetz','Investor Relations','Kapitalanlage','Kapitalertragsteuer','Kapitalmarktrecht','Kartellrecht','Kirchensteuer','Koalitionsrecht','Körperschaftsteuer','Kreditsicherungsrecht','Kündigungsrecht','Leasing','Limited','Lohnsteuer','Mitbestimmungsrecht','Notarrecht','Öffentlicher Dienst','Personengesellschaftsrecht','Produkthaftung','Rechnungslegung','Rechtsanwaltsrecht','Schuldrecht','Solidaritätszuschlag','Sonstige BWL','Sonstige Steuerarten','Sonstiges Recht','Sozialversicherung','Steuerberaterrecht','Steuerstrafrecht','Strafrecht','Tarifvertragsrecht','Teilzeitrecht','Umsatzsteuer','Umwandlungsrecht','Umwandlungssteuerrecht','Unfallversicherung','Unternehmensbewertung','Unternehmenskauf','Unternehmensorganisation','Urlaubsrecht','Verbraucherrecht','Verfahrensrecht','Versicherungsrecht','Wettbewerbsrecht','Wettbewerbsverbot','Wirtschaftsprüferrecht','Zollrecht','Zwangsvollstreckung')">
                Die Rubrik "<value-of select="."/>" ist nicht erlaubt!
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="instdocdate | pub/date[ancestor::metadata/all_source[@level='1']/text()='zsa'] | pub/date[text() != '']">
            <assert test="string-length(text()) = 10  and (translate(text(), '0123456789-', '') = '')">Das <value-of select="name()"/> Format entspricht nicht YYYY-MM-DD</assert>    
            <assert test="number(substring(text(), 1, 4)) &gt;= 1900 or number(substring(text(), 1, 4)) = 0000">Das <value-of select="name()"/> Format entspricht nicht YYYY-MM-DD (rule2)</assert>
            <assert test="number(substring(text(), 6, 2)) &gt;= 0 and number(substring(text(), 6, 2)) &lt;= 12">Die Monatsangabe (hier <value-of select="substring(text(), 6, 2)"/>) muss im Interval 0-12 liegen.</assert>
            <assert test="number(substring(text(), 9, 2)) &gt;= 0 and number(substring(text(), 9, 2)) &lt;= 31">Die Angabe des Tags (hier <value-of select="substring(text(), 9, 2)"/>) muss im Interval 0-31 liegen.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/metadata/pub/date[text() != '']">
            <assert test="number(substring(text(), 1, 4)) &gt;= 1900">Das <value-of select="name()"/> Format entspricht nicht YYYY-MM-DD (rule2)</assert>
            <assert test="number(substring(text(), 6, 2)) &gt;= 1 and number(substring(text(), 6, 2)) &lt;= 12">Die Monatsangabe (hier <value-of select="substring(text(), 6, 2)"/>) muss im Interval 1-12 liegen.</assert>
            <assert test="number(substring(text(), 9, 2)) &gt;= 1 and number(substring(text(), 9, 2)) &lt;= 31">Die Angabe des Tags (hier <value-of select="substring(text(), 9, 2)"/>) muss im Interval 1-31 liegen.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/@altdocid">
            <assert test="string-length(replace(., '[A-Z]','')) &gt;= 7">Das @altdocid Attribut besitzt die falsche Länge!</assert>
            <assert test="string(number(.)) = 'NaN'">Das @altdocid Attribut darf nicht nur aus Ziffern bestehen, sondern benötigt noch einen Buchstaben Präfix!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/@docid">
            <assert test="string-length(replace(., '[A-Z]','')) = 7">Das @docid Attribut besitzt die falsche Länge!</assert>
            <assert test="string(number(.)) = 'NaN'">Das @docid Attribut darf nicht nur aus Ziffern bestehen, sondern benötigt noch einen Buchstaben Präfix!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="pub/pubyear[ancestor::metadata/all_source[@level='1']/text()='zsa'] | pub/pubyear[text() != '']">
            <assert test="string-length(.) = 4">Das Pubyear muss vierstellig sein!</assert>
            <assert test="not(string(number(.)) = 'NaN')">Das pubyear darf nur aus Zahlen bestehen!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/pub/pubabbr">
            <assert test="string-length(text()) &gt; 0">Das Pubabbr Feld muss gefüllt werden!</assert>
        </rule>
    </pattern>
    <pattern>
        <!-- Regel für alle Werke außer Str Kompakt und ifst Schriften: -->
        <rule context="pub/pubedition[ancestor::metadata/all_source[@level='1']/text()='zsa' and ancestor::metadata/all_source[@level='2' and not(text()=('str','ifst','zoe'))]]">
            <assert test="/gh or not(string(number(replace(.,'-',''))) = 'NaN')">Die Pubedition darf nur aus Zahlen bestehen!</assert>
        </rule>
        
        <!-- Regel für ifst Schriften -->
        <rule context="pub/pubedition[ancestor::metadata/all_source[@level='2' and text()='ifst']]">
            <assert test="not(string(number(replace(replace(.,'ifst',''),'-',''))) = 'NaN')">Die Pubedition von ifst-Schriften darf nur aus dem Kürzel 'ifst' + Zahlen bestehen!</assert>
        </rule>
        
        <!-- Regel für zoe: Hier wird die pubedition gesondert abgefragt, weil es 3 Sonderausgaben gibt, die sich nicht von den normalen Heftartikeln unterscheiden -->
        <rule context="pub/pubedition[ancestor::metadata/all_source[@level='2' and text()='zoe']]">
            <assert test="not(string(number(replace(replace(.,'Spezial ',''),'-',''))) = 'NaN')">Die Pubedition von ifst-Schriften darf nur aus dem Kürzel 'ifst' + Zahlen bestehen!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/@rawid">
            <assert test="not(string(number(.)) = 'NaN')">Das @rawid Attribut darf nur aus Ziffern bestehen!</assert>
        </rule>
    </pattern>
    <pattern>
        <!-- Wenn das last-page Element gefüllt ist, dann muss das start_page Element ebenfalls einen Zahlenwert haben, sonst schlägt die Transformation fehl -->
        <rule context="last_page[string(number(text())) != 'NaN']">
            <assert test="number(./../start_page/text()) = ./../start_page/text()">Wenn das last-page Element gefüllt ist, dann muss das start_page Element ebenfalls einen Inhalt haben!</assert>
            <assert test="number(.) - number(./../start_page/text()) &gt;= 0">Die last_page Seitenzahl [<value-of select="number(.)"/>] muss größer oder gleich der start_page Seitenzahl [<value-of select="number(./../start_page/text())"/>] sein.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/ressort[ancestor::metadata/pub/pubtitle/text()='Der Betrieb']">
            <assert test="text()= 'bw' or text() ='sr' or text() ='wr' or text() ='ar' or text() ='br' or text() ='kr'" >Das Ressort besitzt einen ungültigen Inhalt!</assert>
        </rule>
        <rule context="metadata/ressort[ancestor::metadata/pub/pubtitle/text()='Corporate Finance']">
            <assert test="text()= 'Finanzierung' or text() ='Kapitalmarkt' or text() ='Bewertung' or text() ='Mergers &amp; Acquisitions' or text() ='Agenda' or text() ='Bildung' or text() ='Corporate Governance' or text() ='Existenzgründung' or text() ='Finanzmanagement' or text() ='Finanzmarkt' or text() ='Gründung' or text() ='Unternehmen' or text() ='Märkte' or text() ='Outlook' or text() ='Private Equity' or text() ='Scope' or text() ='Statements' or text() ='Tools' or text() ='Venture Capital' or text() ='Transaktionen'" >Das Ressort besitzt einen ungültigen Inhalt!</assert>
        </rule>
        <rule context="metadata[not(parent::*[name()=('ed', 'toc')]) and pub/pubtitle/text()='changement!']">
            <assert test="ressort" >Alle Changement Dokumente (außer Editorial Dokumente) benötigen ein Ressort Element!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/summary//footnote">
            <assert test="false()">Im Abstract/Summary dürfen keine Fußnoten vorkommen!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="file/@width | file/@height">
            <assert test="number(.)&gt;0 or (number(replace(/*/metadata/pub/date, '-',''))&lt; 20151201)">Die @width / @height Attribute müssen gefüllt sein!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/authors/author/surname">
            <assert test="not(contains(text(),','))">Autoren Nachnamen dürfen keine Zusatzinformationen getrennt durch Kommata enthalten!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/authors/organisation">
            <assert test=".[text()]">Organisation Felder dürfen nicht leer sein.</assert>
            <report test=".[comment()]">Fehler: XML Kommentar im organisation Element!</report>
        </rule>
    </pattern>
    <pattern>
        <rule context="body//p/comment()">
            <!-- Siehe Teams Chat mit Lisa/Dirk am 07.10.2020 -->
            <report test=".='Achtung: Liste Einzug'">Listen Einzug Kommentar vom Konverter entdeckt.</report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/body//section">
            <assert test=".[count(child::*)&gt;1] or .[not(count(child::*)=1 and child::*[name()='title'])]">Es darf keine leeren Section Elemente geben und es darf keine Section Elemente geben, die nur einen title erhalten!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="rzblock">
            <assert test="p or table or block or example or figure or list or newpage or rzblock or sidenote or subhead">Randzifferblöcke müssen ein p (oder block oder example oder figure oder list oder newpage oder rzblock oder sidenote oder subhead oder table)  Element besitzen!</assert>
            <assert test="not(p) or p[child::node()]">Das p Element darf nicht leer sein!</assert>
            <assert test="rz[child::node()]">Das rz Element darf nicht leer sein!</assert>
        </rule>
    </pattern>
    
    <!-- Regeln, die Sonderzeichen in Dateinamen und External Files überprüfen: -->
    <pattern>
        <rule context="/*">
            <assert test="not(contains(tokenize(document-uri(./..),'/')[last()], '+'))">Der Dateiname: <value-of select="tokenize(document-uri(./..),'/')[last()]"/> darf kein '+' Zeichen enthalten!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/metadata/extfile">
            <assert test="not(contains(text(), '+'))">Der PDF Name: darf kein '+' Zeichen enthalten!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//file/@class">
            <assert test=". = ('pdf','rtf','doc','docx','xls','xlsx','ppt','pptx')">Der Wert "<value-of select="."/>" ist für das class Atribute von file Elementen nicht erlaubt!</assert>
            <assert test=". =  tokenize(../text(),'\.')[last()]">Die Dateiendung des Filenamens "<value-of select="tokenize(../text(),'\.')[last()]"/>" muss mit dem @class Attribut "<value-of select="."/>" übereinstimmen!</assert>
        </rule>
    </pattern>
    
    <!-- Temporäre Regel, bis Dirk und Lisa feste Ressort Werte für alle Zeitschriften festgelegt haben: Alle Aufsätze sollen ein
    ressort Element gesetzt haben. Zur Not soll es leer sein: --> <!-- Bis auf bei der KoR -->
    <pattern>
        <rule context="/au[metadata/all_source[@level='1']='zsa'][not(metadata/pub/pubtitle/text()=('KoR','Bewertungspraktiker'))]">
            <assert test="/au/metadata/ressort">Das Ressort Element muss bei Aufsätzen gesetzt sein. Zur Not ohne Inhalt.</assert>
        </rule>
    </pattern>
</schema>
