<?xml version="1.0" encoding="UTF-8"?>

<!-- HBFM Schematron Version 1.11 -->


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
        <rule context="instdoctype">
            <!--<assert test="matches( text(), '(Kurzinformation|Beschluss|Beschlüsse|Beschluss (Teilentscheidung)|Beschluss (Zwischenentscheidung)|Entwurf|Vorlagebeschluss|Hinweisbeschluss|Nichtannahmebeschluss|Zwischenbeschluss|Teilbeschluss|Kammerbeschluss|Kostenbeschluss|Ergänzungsbeschluss|Senatsbeschluss|Normenkontrollbeschluss|Prozesskostenhilfebeschluss|Entscheidung|Entscheidungen|Vorabentscheidung|Rechtsentscheid|Antrag auf Vorabentscheidung|Urteil|Urteile|Teilurteil|Teilurteile|Versäumnisurteil|Urteil und Versäumnisurteil|Teilversäumnisurteil|Schlussurteil|Anerkenntnisurteil|Ergänzungsurteil|Zwischenurteil|Endurteil|Grundurteil|Einzelrichterurteil|Normenkontrollurteil|Senatsurteil|Senatszwischenurteil|Verzichtsurteil|Vorbehaltsurteil|(Grund- und End-) Urteil|(Grund- und Teil-) Urteil|(Teilversäumnis- und Schluss-) Urteil|(Versäumnisteil-) Urteil|(Adhäsions-) Urteil|Erlass|gleichlautender Erlass|gleichlautende Erlasse|Verfügung|Allgemeinverfügung|Rundverfügung|Hinweisverfügung|Schlussantrag|Schlussanträge|Information|Schreiben|Vergleich|Hinweis|Teil-Schiedsspruch|Bescheid|Bescheide|Gerichtsbescheid|Gerichtsbescheide|Gutachten|Rechtsgutachten|Anhängiges Verfahren|Senatssitzung|Stellungnahme|EuGH-Vorlage|Grüner Brief)')">Dieser instdoctype "<value-of select="."/>" ist nicht erlaubt</assert>-->
            <!--<assert test="text()=( 'Fallbericht', 'Kurzinformation','Beschluss','Beschlüsse','Beschluss (Teilentscheidung)','Beschluss (Zwischenentscheidung)','Entwurf','Vorlagebeschluss','Hinweisbeschluss','Nichtannahmebeschluss','Zwischenbeschluss','Teilbeschluss','Kammerbeschluss','Kostenbeschluss','Ergänzungsbeschluss','Senatsbeschluss','Normenkontrollbeschluss','Prozesskostenhilfebeschluss','Entscheidung','Entscheidungen','Vorabentscheidung','Rechtsentscheid','Antrag auf Vorabentscheidung','Urteil','Urteile','Teilurteil','Teilurteile','Versäumnisurteil','Urteil und Versäumnisurteil','Teilversäumnisurteil','Schlussurteil','Anerkenntnisurteil','Ergänzungsurteil','Zwischenurteil','Endurteil','Grundurteil','Einzelrichterurteil','Normenkontrollurteil','Senatsurteil','Senatszwischenurteil','Verzichtsurteil','Vorbehaltsurteil','(Grund- und End-) Urteil','(Grund- und Teil-) Urteil','(Teilversäumnis- und Schluss-) Urteil','(Versäumnisteil-) Urteil','(Adhäsions-) Urteil','Erlass','gleichlautender Erlass','gleichlautende Erlasse','Verfügung','Allgemeinverfügung','Rundverfügung','Hinweisverfügung','Schlussantrag','Schlussanträge','Information','Schreiben','Vergleich','Hinweis','Teil-Schiedsspruch','Bescheid','Bescheide','Gerichtsbescheid','Gerichtsbescheide','Gutachten','Rechtsgutachten','Anhängiges Verfahren','Senatssitzung','Stellungnahme','EuGH-Vorlage','Grüner Brief')">Dieser instdoctype "<value-of select="."/>" ist nicht erlaubt!</assert>-->
            <assert test="text()=( 'Kurzinformation','Beschluss','Beschlüsse','Beschluss (Teilentscheidung)','Beschluss (Zwischenentscheidung)','Vorlagebeschluss','Hinweisbeschluss','Nichtannahmebeschluss','Zwischenbeschluss','Teilbeschluss','Schlussbeschluss','Feststellungsbeschluss','Abstellungsbeschluss','Kammerbeschluss','Kostenbeschluss','Ergänzungsbeschluss','Verweisungsbeschluss','Widerspruchsbeschluss','Auflösungsbeschluss','Senatsbeschluss','Normenkontrollbeschluss','Prozesskostenhilfebeschluss','Untersagungsbeschluss','Verpflichtungszusagenbeschluss','Freigabebeschluss','Entscheidung','Entscheidungen','Vorabentscheidung','Rechtsentscheid','Antrag auf Vorabentscheidung','Freigabe-Entscheidung','Verpflichtungsentscheidung','Untersagungsentscheidung','Urteil','Urteile','Teilurteil','Teilurteile','Versäumnisurteil','Urteil und Versäumnisurteil','Teilversäumnisurteil','Schlussurteil','Anerkenntnisurteil','Ergänzungsurteil','Zwischenurteil','Endurteil','Aufhebungsurteil','Grundurteil','Einzelrichterurteil','Normenkontrollurteil','Senatsurteil','Senatszwischenurteil','Verzichtsurteil','Vorbehaltsurteil','(Grund- und End-) Urteil','(Grund- und Teil-) Urteil','(Teilversäumnis- und Schluss-) Urteil','(Versäumnisteil-) Urteil','(Adhäsions-) Urteil','Erlass','gleichlautender Erlass','gleichlautende Erlasse','Verfügung','Allgemeinverfügung','Rundverfügung','Hinweisverfügung','Zwischenverfügung','Einstellungsverfügung','Schlussantrag','Schlussanträge','Information','Schreiben','Vergleich','Hinweis','Teil-Schiedsspruch','Entscheid','Entscheide','Beschwerde-Entscheid','Beschwerde-Entscheide','Bescheid','Bescheide','Gerichtsbescheid','Gerichtsbescheide','Gutachten','Rechtsgutachten','Sondergutachten','Anhängiges Verfahren','Senatssitzung','Stellungnahme','EuGH-Vorlage','Schlussbericht','Monitoringbericht','Fallbericht','Leitlinien','Hintergrundpapier','Papier','Konsultation','Bußgeldbescheid','Grüner Brief')">Dieser instdoctype "<value-of select="."/>" ist nicht erlaubt!</assert>
        </rule>
    </pattern>
    
    <pattern>
        <!-- Instdocnr muss in VA immer gefüllt sein -->
        <rule context="vav/metadata/all_source[@level='2'][text()='vwa_collection']">
            <assert test="./../instdoc/instdocnrs/instdocnr/text() != ''">Instdocnr darf nicht leer sein in Verwaltungsanweisungen!</assert>
        </rule>
    </pattern>
    
    <!-- Bei den Zeitschriften Der Betrieb und Der Konzern werden die Rubriken auf gültige Werte getestet -->
    <pattern>        
        <rule context="rubrik[ancestor::metadata/pub/pubtitle/text()='Der Betrieb' or ancestor::metadata/pub/pubtitle/text()='Der Konzern']">
            <!--<assert test="matches( text(), '(Abgabenordnung|Abschlussprüfung|Aktienrecht|Allgemeine BWL|Allgemeine Geschäftsbedingungen|Arbeitnehmerüberlassung|Arbeitsförderung|Arbeitskampfrecht|Arbeitsschutzrecht|Arbeitsvertragsrecht|Arbeitszeitrecht|Bankrecht|Befristungsrecht|Behindertenrecht|Berufsbildungsrecht|Betriebliche Altersversorgung|Betriebsübergang|Betriebsverfassungsrecht|Bewertungsgesetz|Bilanzanalyse|Bilanzsteuerrecht|Controlling|Corporate Governance|Datenschutz|Eigenheimzulage|Einkommensteuer|Elternrecht|Entgeltrecht|Erbschaft-/Schenkungsteuer|Europarecht|Factoring|Finanzgerichtsordnung|Finanzierung|Franchising|Genossenschaftsrecht|Gewerbesteuer|Gewinnermittlung|Gleichbehandlung|GmbH-Recht|Grunderwerbsteuer|Grundgesetz|Grundsteuer|Haftungsrecht|Handelsbilanzrecht|Handelsrecht|Handelsvertreterrecht|IFRS|Insolvenzrecht|Internationales Privatrecht|Internationales Steuerrecht|Investitionszulage|Investmentsteuergesetz|Investor Relations|Kapitalanlage|Kapitalertragsteuer|Kapitalmarktrecht|Kartellrecht|Kirchensteuer|Koalitionsrecht|Körperschaftsteuer|Kreditsicherungsrecht|Kündigungsrecht|Leasing|Limited|Lohnsteuer|Mitbestimmungsrecht|Notarrecht|Öffentlicher Dienst|Personengesellschaftsrecht|Produkthaftung|Rechnungslegung|Rechtsanwaltsrecht|Schuldrecht|Solidaritätszuschlag|Sonstige BWL|Sonstige Steuerarten|Sonstiges Recht|Sozialversicherung|Steuerberaterrecht|Steuerstrafrecht|Strafrecht|Tarifvertragsrecht|Teilzeitrecht|Umsatzsteuer|Umwandlungsrecht|Umwandlungssteuerrecht|Unfallversicherung|Unternehmensbewertung|Unternehmenskauf|Unternehmensorganisation|Urlaubsrecht|Verbraucherrecht|Verfahrensrecht|Versicherungsrecht|Wettbewerbsrecht|Wettbewerbsverbot|Wirtschaftsprüferrecht|Zollrecht|Zwangsvollstreckung)')">
                Die Rubrik "<value-of select="."/>" ist nicht erlaubt!
            </assert>-->
            <assert test="text()=('Abgabenordnung','Abschlussprüfung','Aktienrecht','Allgemeine BWL','Allgemeine Geschäftsbedingungen','Arbeitnehmerüberlassung','Arbeitsförderung','Arbeitskampfrecht','Arbeitsschutzrecht','Arbeitsvertragsrecht','Arbeitszeitrecht','Bankrecht','Befristungsrecht','Behindertenrecht','Berufsbildungsrecht','Betriebliche Altersversorgung','Betriebsübergang','Betriebsverfassungsrecht','Bewertungsgesetz','Bilanzanalyse','Bilanzsteuerrecht','Controlling','Corporate Governance','Datenschutz','Eigenheimzulage','Einkommensteuer','Elternrecht','Entgeltrecht','Erbschaft-/Schenkungsteuer','Europarecht','Factoring','Finanzgerichtsordnung','Finanzierung','Franchising','Genossenschaftsrecht','Gewerbesteuer','Gewinnermittlung','Gleichbehandlung','GmbH-Recht','Grunderwerbsteuer','Grundgesetz','Grundsteuer','Haftungsrecht','Handelsbilanzrecht','Handelsrecht','Handelsvertreterrecht','IFRS','Insolvenzrecht','Internationales Privatrecht','Internationales Steuerrecht','Investitionszulage','Investmentsteuergesetz','Investor Relations','Kapitalanlage','Kapitalertragsteuer','Kapitalmarktrecht','Kartellrecht','Kirchensteuer','Koalitionsrecht','Körperschaftsteuer','Kreditsicherungsrecht','Kündigungsrecht','Leasing','Limited','Lohnsteuer','Mitbestimmungsrecht','Notarrecht','Öffentlicher Dienst','Personengesellschaftsrecht','Produkthaftung','Rechnungslegung','Rechtsanwaltsrecht','Schuldrecht','Solidaritätszuschlag','Sonstige BWL','Sonstige Steuerarten','Sonstiges Recht','Sozialversicherung','Steuerberaterrecht','Steuerstrafrecht','Strafrecht','Tarifvertragsrecht','Teilzeitrecht','Umsatzsteuer','Umwandlungsrecht','Umwandlungssteuerrecht','Unfallversicherung','Unternehmensbewertung','Unternehmenskauf','Unternehmensorganisation','Urlaubsrecht','Verbraucherrecht','Verfahrensrecht','Versicherungsrecht','Wettbewerbsrecht','Wettbewerbsverbot','Wirtschaftsprüferrecht','Zollrecht','Zwangsvollstreckung')">
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
        <rule context="pub/pubedition[ancestor::metadata/all_source[@level='1']/text()='zsa' and  ancestor::metadata/all_source[@level='2' and not(text()='str')]]">
            <assert test="not(string(number(replace(.,'-',''))) = 'NaN')">Die Pubedition darf nur aus Zahlen bestehen!</assert>
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
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/ressort[ancestor::metadata/pub/pubtitle/text()='Der Betrieb']">
            <assert test="text()= 'bw' or text() ='sr' or text() ='wr' or text() ='ar' or text() ='br' or text() ='kr'" >Das Ressort besitzt einen ungültigen Inhalt!</assert>
        </rule>
        <rule context="metadata/ressort[ancestor::metadata/pub/pubtitle/text()='Corporate Finance']">
            <assert test="text()= 'Finanzierung' or text() ='Kapitalmarkt' or text() ='Bewertung' or text() ='Mergers &amp; Acquisitions' or text() ='Agenda' or text() ='Bildung' or text() ='Corporate Governance' or text() ='Existenzgründung' or text() ='Finanzmanagement' or text() ='Finanzmarkt' or text() ='Gründung' or text() ='Unternehmen' or text() ='Märkte' or text() ='Outlook' or text() ='Private Equity' or text() ='Scope' or text() ='Statements' or text() ='Tools' or text() ='Venture Capital' or text() ='Transaktionen'" >Das Ressort besitzt einen ungültigen Inhalt!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/summary//footnote">
            <assert test="false()">Im Abstract/Summary dürfen keine Fußnoten vorkommen!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="file/@width | file/@height">
            <assert test="number(.)>0 or (number(replace(/*/metadata/pub/date, '-',''))&lt; 20151201)">Die @width / @height Attribute müssen gefüllt sein!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="metadata/authors/author/surname">
            <assert test="not(contains(text(),','))">Autoren Nachnamen dürfen keine Zusatzinformationen getrennt durch Kommata enthalten!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/body//section">
            <assert test=".[count(child::*)&gt;1] or .[not(count(child::*)=1 and child::*[name()='title'])]">Es darf keine leeren Section Elemente geben und es darf keine Section Elemente geben, die nur einen title erhalten!</assert>
        </rule>
    </pattern>
</schema>