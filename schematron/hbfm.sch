<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <pattern>  
        <rule context="all_doc_type[@level='1']">
            <assert test="matches( text(), '(nb|zs|ko|zt|gt|ent|va|div)')">Das all-doc-type @level=1 Element besitzt unbekannten Content!</assert>
        </rule>
    </pattern>
    <pattern>  
        <rule context="all_doc_type[@level='2']">
            <assert test="matches( text(), '(au|divah|divsu|divso|ed|ent|entk|entv|gh|gk|gtdraft|toc|kk|nbb|nr|sp|va|vadraft|vav)')">Das all-doc-type @level=2 Element besitzt unbekannten Content!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="instdoctype">
            <assert test="matches( text(), '(Kurzinformation|Beschluss|Beschlüsse|Beschluss (Teilentscheidung)|Beschluss (Zwischenentscheidung)|Vorlagebeschluss|Hinweisbeschluss|Nichtannahmebeschluss|Zwischenbeschluss|Teilbeschluss|Kammerbeschluss|Kostenbeschluss|Ergänzungsbeschluss|Senatsbeschluss|Normenkontrollbeschluss|Prozesskostenhilfebeschluss|Entscheidung|Entscheidungen|Vorabentscheidung|Rechtsentscheid|Antrag auf Vorabentscheidung|Urteil|Urteile|Teilurteil|Teilurteile|Versäumnisurteil|Urteil und Versäumnisurteil|Teilversäumnisurteil|Schlussurteil|Anerkenntnisurteil|Ergänzungsurteil|Zwischenurteil|Endurteil|Grundurteil|Einzelrichterurteil|Normenkontrollurteil|Senatsurteil|Senatszwischenurteil|Verzichtsurteil|Vorbehaltsurteil|(Grund- und End-) Urteil|(Grund- und Teil-) Urteil|(Teilversäumnis- und Schluss-) Urteil|(Versäumnisteil-) Urteil|(Adhäsions-) Urteil|Erlass|gleichlautender Erlass|gleichlautende Erlasse|Verfügung|Allgemeinverfügung|Rundverfügung|Hinweisverfügung|Schlussantrag|Schlussanträge|Information|Schreiben|Vergleich|Hinweis|Teil-Schiedsspruch|Bescheid|Bescheide|Gerichtsbescheid|Gerichtsbescheide|Gutachten|Rechtsgutachten|Anhängiges Verfahren|Senatssitzung|Stellungnahme|EuGH-Vorlage|Grüner Brief)')">Dieser instdoctype "<value-of select="."/>" ist nicht erlaubt</assert>
        </rule>
    </pattern>
    
    <!-- Bei den Zeitschriften Der Betrieb und Der Konzern werden die Rubriken auf gültige Werte getestet -->
    <pattern>        
        <rule context="rubrik[ancestor::metadata/pub/pubtitle/text()='Der Betrieb' or ancestor::metadata/pub/pubtitle/text()='Der Konzern']">
            <assert test="matches( text(), '(Abgabenordnung|Abschlussprüfung|Aktienrecht|Allgemeine BWL|Allgemeine Geschäftsbedingungen|Arbeitnehmerüberlassung|Arbeitsförderung|Arbeitskampfrecht|Arbeitsschutzrecht|Arbeitsvertragsrecht|Arbeitszeitrecht|Bankrecht|Befristungsrecht|Behindertenrecht|Berufsbildungsrecht|Betriebliche Altersversorgung|Betriebsübergang|Betriebsverfassungsrecht|Bewertungsgesetz|Bilanzanalyse|Bilanzsteuerrecht|Controlling|Corporate Governance|Datenschutz|Eigenheimzulage|Einkommensteuer|Elternrecht|Entgeltrecht|Erbschaft-/Schenkungsteuer|Europarecht|Factoring|Finanzgerichtsordnung|Finanzierung|Franchising|Genossenschaftsrecht|Gewerbesteuer|Gewinnermittlung|Gleichbehandlung|GmbH-Recht|Grunderwerbsteuer|Grundgesetz|Grundsteuer|Haftungsrecht|Handelsbilanzrecht|Handelsrecht|Handelsvertreterrecht|IFRS|Insolvenzrecht|Internationales Privatrecht|Internationales Steuerrecht|Investitionszulage|Investmentsteuergesetz|Investor Relations|Kapitalanlage|Kapitalertragsteuer|Kapitalmarktrecht|Kartellrecht|Kirchensteuer|Koalitionsrecht|Körperschaftsteuer|Kreditsicherungsrecht|Kündigungsrecht|Leasing|Limited|Lohnsteuer|Mitbestimmungsrecht|Notarrecht|Öffentlicher Dienst|Personengesellschaftsrecht|Produkthaftung|Rechnungslegung|Rechtsanwaltsrecht|Schuldrecht|Solidaritätszuschlag|Sonstige BWL|Sonstige Steuerarten|Sonstiges Recht|Sozialversicherung|Steuerberaterrecht|Steuerstrafrecht|Strafrecht|Tarifvertragsrecht|Teilzeitrecht|Umsatzsteuer|Umwandlungsrecht|Umwandlungssteuerrecht|Unfallversicherung|Unternehmensbewertung|Unternehmenskauf|Unternehmensorganisation|Urlaubsrecht|Verbraucherrecht|Verfahrensrecht|Versicherungsrecht|Wettbewerbsrecht|Wettbewerbsverbot|Wirtschaftsprüferrecht|Zollrecht|Zwangsvollstreckung)')">
                Die Rubrik "<value-of select="."/>" ist nicht erlaubt!
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="pub/date |instdoc/instdocdate">
            <assert test="string-length(text()) = 10  and (translate(text(), '0123456789-', '') = '')">Das <value-of select="name()"/> Format entspricht nicht YYYY-MM-DD</assert>    
            <!-- http://stackoverflow.com/questions/1188748/xslt-function-to-validate-date-in-the-format-of-yyyymmdd -->
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
        <rule context="pub/pubyear">
            <assert test="string-length(.) = 4">Das Pubyear muss vierstellig sein!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="/*/@rawid">
            <assert test="not(string(number(.)) = 'NaN')">Das @rawid Attribut darf nur aus Ziffern bestehen!</assert>
        </rule>
    </pattern>
</schema>