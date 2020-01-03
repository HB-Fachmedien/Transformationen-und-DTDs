<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="seite-gericht"/>
    
    <xsl:variable name="alle-Hefte" select="collection('file:/c:/tempDB/?recurse=yes;select=*.xml')"/>
    <!--<xsl:variable name="alle-ent-dateien" select="$alle-Hefte/*[name()= ('ent', 'entk')]"/> -->
    
    <!-- Zum Debuggen unten den das if-Statement auf true() schalten! -->
    
    <!-- hilfreiche XPATH Ausdrücke
    
    /* hier alle zu verarbeitenden Gerichte: */
    /*[not(name()=('kk','entk'))]/metadata/instdoc/inst[not(starts-with(ancestor::metadata/pub/pages/start_page/text(),'M') or starts-with(ancestor::metadata/pub/pages/start_page/text(),'S'))]
    
    
    /* findet im Ergbnis Dokument alle Zeilen, die dem entsprechendem Gericht zuzuordnen sind: */    
    /*/h2[text()='Oberste Finanzbehörden der Länder']/following-sibling::zeile-gericht[count(.|/*/h2[text()='Oberste Finanzbehörden der Länder']/following-sibling::h2[1]/preceding-sibling::zeile-gericht)=count(/*/h2[text()='Oberste Finanzbehörden der Länder']/following-sibling::h2[1]/preceding-sibling::zeile-gericht)]
    
    
    /* Anzahl Entscheidungen pro Gericht ausgeben: */
    //h2/concat(text(), ';', abs(506-count(following-sibling::zeile-gericht)-count(following-sibling::h2[1]/preceding-sibling::zeile-gericht)))
    
    mit diesem Regex alle Gerichte entfernen, die nicht vorkommen:
    .*?\;0$
    
    -->
    
    <!-- 
    
    ToDo:
    
    ********************************************************************************************************
    
    
    Entscheidungen vom selben Tag nach Römischen Zahlen sortieren! -->
    
    
    <!-- ALLE ENTSCHEIDUNGEN AUßER KOMMENTIERTE UND AUS DEM MANTELTEIL
    
        
    
    ********************************************************************************************************
    
    -->

    <xsl:template match="/">
        <xsl:if test="$alle-Hefte[1]/descendant::metadata/pub/pubtitle = ('Der Konzern', 'Wirtschaft und Wettbewerb')">!!! FÜR WUW ODER DK ENTSCHEIDUNGSREGISTER DAS ANDERE SKRIPT NEHMEN!!!</xsl:if>
        
        <xsl:text>&#xa;</xsl:text><entscheidungsregister><xsl:text>&#xa;</xsl:text>
            <WICHTIG>!!Eva immer vorm Register die Behörden Liste für die Reihenfolge zusenden!!</WICHTIG><xsl:text>&#xa;</xsl:text>
            <WICHTIG>REIHENFOLGE VON ENTSCHEIDUNGEN GLEICHEN DATUMS BEACHTEN! Siehe Mail von Eva 6.3.2018</WICHTIG><xsl:text>&#xa;</xsl:text>
            <WICHTIG2>Eva immer vorm Register die Behörden Liste für die Reihenfolge zusenden</WICHTIG2><xsl:text>&#xa;</xsl:text>
            
            <h1>Entscheidungen des europäischen Gerichtshofs</h1><xsl:text>&#xa;</xsl:text>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'EuGH'"/>
                <xsl:with-param name="ressort" select="'all'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Europäischer Gerichtshof'"/>
            </xsl:call-template>
            
            <h1>Entscheidungen des Bundesverfassungsgerichts</h1><xsl:text>&#xa;</xsl:text>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BVerfG'"/>
                <xsl:with-param name="ressort" select="'all'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Bundesverfassungsgericht'"/>
            </xsl:call-template>
            
            <h1>Steuerrechtliche Entscheidungen</h1><xsl:text>&#xa;</xsl:text>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BFH'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Bundesfinanzhof'"/>
            </xsl:call-template>           
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Baden-Württemberg'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Berlin-Brandenburg'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Bremen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Düsseldorf'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Hamburg'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Hessen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Köln'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Mecklenburg-Vorpommern'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG München'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Münster'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Nürnberg'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Rheinland-Pfalz'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Saarland'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Sachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Sachsen-Anhalt'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Schleswig-Holstein'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FG Thüringen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            
            <h1>Steuerrechtliche Verwaltungsanweisungen</h1><xsl:text>&#xa;</xsl:text>           
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BMF'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
                <xsl:with-param name="schreibweise" select="'Bundesfinanzministerium'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'Oberste Finanzbehörden der Länder'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'Bayer. Staatsmin. d. Fin.'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'SenFin. Berlin'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Mecklenburg-Vorpommern'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'Landesamt für Steuern Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. NRW'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Sachsen-Anhalt'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Schleswig-Holstein'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'FinMin. Thüringen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BayLfSt'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD Frankfurt/M.'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD Karlsruhe'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LfSt Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LSF Sachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>       
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD Niedersachsen'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OFD NRW'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
                        
            <!-- ist das richtig hier? -->
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'Rheinland-Pfälzisches Landesamt für Steuern'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            <!-- bis hier -->
            
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LfSt Rheinland-Pfalz'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'Finanzbehörde Hamburg'"/>
                <xsl:with-param name="ressort" select="'sr'"/>
                <xsl:with-param name="doctype" select="'va'"/>
            </xsl:call-template>
            
            <!-- WR -->
            <h1>Wirtschaftsrechtliche Entscheidungen</h1><xsl:text>&#xa;</xsl:text>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BGH'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Bundesgerichtshof'"/>
            </xsl:call-template>
            
            <h1>Sonstige Gerichte</h1><xsl:text>&#xa;</xsl:text>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'EuGH'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BAG'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'KG Berlin'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Bamberg'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Brandenburg'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Celle'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Dresden'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Düsseldorf'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Frankfurt/M.'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Hamburg'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Hamm'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Karlsruhe'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'AGH Nordrhein-Westfalen'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG München'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Nürnberg'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Oldenburg'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Rostock'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Stuttgart'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'OLG Thüringen'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LSG Rheinland-Pfalz'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LG München I'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'SchlHOLG'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BVerwG'"/>
                <xsl:with-param name="ressort" select="'wr'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            
            <!-- AR -->
            <h1>Arbeits- und sozialrechtliche Entscheidungen</h1><xsl:text>&#xa;</xsl:text>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BAG'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Bundesarbeitsgericht'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BGH'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Bundesgerichtshof'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BVerwG'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'BSG'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
                <xsl:with-param name="schreibweise" select="'Bundessozialgericht'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Düsseldorf'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Hamm'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Hessen'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Köln'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Mecklenburg-Vorpommern'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG München'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Nürnberg'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LAG Rheinland-Pfalz'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'LSG Hessen'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <xsl:call-template name="entscheidungsdaten">
                <xsl:with-param name="gerichtsBezeichnung" select="'KG Berlin'"/>
                <xsl:with-param name="ressort" select="'ar'"/>
                <xsl:with-param name="doctype" select="'ent'"/>
            </xsl:call-template>
            <h2>ELEMENT FÜR DAS TESTEN. Anzahl Entscheidungen: </h2><xsl:text>&#xa;</xsl:text>
        </entscheidungsregister>
    </xsl:template>

    <xsl:template name="entscheidungsdaten">
        <xsl:param name="gerichtsBezeichnung" required="yes"/>
        <xsl:param name="ressort" required="yes"/>
        <xsl:param name="doctype" required="yes"/>
        <xsl:param name="schreibweise" required="no"/>
        
        <h2>
            <xsl:if test="$schreibweise"><xsl:value-of select="$schreibweise"/></xsl:if>
            <xsl:if test="not($schreibweise)"><xsl:value-of select="$gerichtsBezeichnung"/></xsl:if>
            <!-- ZUM DEBUGGEN: -->
            <xsl:if test="false()"><xsl:text> ANZAHL: </xsl:text><xsl:value-of select="count($alle-Hefte/*[name()=$doctype][if ($ressort != 'all') then (metadata/ressort/text()= $ressort) else (true())][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))])"/></xsl:if>
            <!-- BIS HIER -->
        </h2><xsl:text>&#xa;</xsl:text>
        <xsl:choose>
            <xsl:when test="not($doctype = 'va')"> <!-- hier Test auf ent  -->
                <xsl:for-each select="$alle-Hefte/*[name()=$doctype][if ($ressort != 'all') then (metadata/ressort/text()= $ressort) else (true())][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))]">
                    <xsl:sort select="replace(metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                    <xsl:variable name="datum-tokenized" select="tokenize(metadata/instdoc/instdocdate/text(), '-')"/>
                    <zeile-gericht>
                        <datum-gericht><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                            <xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum-gericht>
                        <trennzeichen><xsl:text> - </xsl:text></trennzeichen>
                        <az-gericht>
                            <xsl:for-each select="metadata/instdoc/instdocnrs/instdocnr">
                                <xsl:if test="not(position()=1)">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </az-gericht>
                        <seite-gericht><xsl:text>&#x9;</xsl:text><xsl:value-of select="metadata/pub/pages/start_page"/></seite-gericht>
                    </zeile-gericht><xsl:text>&#xa;</xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="$doctype = 'va'"> <!-- hier Test auf va  -->
                <xsl:for-each select="$alle-Hefte/*[name()='va'][if ($ressort != 'all') then (metadata/ressort/text()= $ressort) else (true())][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))]">
                    <xsl:sort select="replace(metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                    <xsl:variable name="datum-tokenized" select="tokenize(metadata/instdoc/instdocdate/text(), '-')"/>
                    <zeile-gericht>
                        <datum><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                            <xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum>
                        <xsl:text>&#x9;</xsl:text>                        
                        <az>
                            <xsl:choose>
                                <xsl:when test="metadata/instdoc/instdocnrs/instdocnr">
                                    <xsl:for-each select="metadata/instdoc/instdocnrs/instdocnr">
                                        <xsl:if test="not(position()=1)">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="metadata/instdoc/instdoctype"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </az>
                        
                        <xsl:variable name="rubik-gekuerzt">
                            <xsl:choose>
                                <xsl:when test="metadata/rubriken/rubrik='Abgabenordnung'">AO</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Bewertungsgesetz'">BewG</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Bilanzsteuerrecht'">BiStR</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Eigenheimzulage'">EigZul</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Einkommensteuer'">ESt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Erbschaft-/Schenkungsteuer'">ErbSt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Finanzgerichtsordnung'">FGO</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Gewerbesteuer'">GewSt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Gewinnermittlung'">GE</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Grunderwerbsteuer'">GrESt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Grundsteuer'">GrSt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Internationales Steuerrecht'">IStR</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Investitionszulage'">InvZul</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Investmentsteuergesetz'">InvStG</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Kapitalertragsteuer'">KapESt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Kirchensteuer'">KiSt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Körperschaftsteuer'">KSt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Lohnsteuer'">LSt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Solidaritätszuschalg'">SolZ</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Steuerstrafrecht'">StStrafR</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Umsatzsteuer'">USt</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Umwandlungssteuerrecht'">UmwStR</xsl:when>
                                <xsl:when test="metadata/rubriken/rubrik='Zollrecht'">Zoll</xsl:when>
                                <xsl:otherwise><xsl:value-of select="metadata/rubriken/rubrik[1]"/></xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <break>***</break>
                        <title><xsl:value-of select="$rubik-gekuerzt"/><xsl:text>, </xsl:text><xsl:value-of select="metadata/title"/></title>
                        
                        <seite-gericht><xsl:text>&#x9;</xsl:text><xsl:value-of select="metadata/pub/pages/start_page"/></seite-gericht>
                    </zeile-gericht><xsl:text>&#xa;</xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <!-- Ressort = ALL -->
                <!--<xsl:for-each select="$alle-Hefte/*[not(name()=('kk','entk'))][metadata/instdoc/inst/text()=$gerichtsBezeichnung and (not(starts-with(metadata/pub/pages/start_page, 'M')) or starts-with(metadata/pub/pages/start_page, 'S'))]">
                    <xsl:sort select="replace(metadata/instdoc/instdocdate,'-','')" data-type="number"/>
                    <xsl:variable name="datum-tokenized" select="tokenize(metadata/instdoc/instdocdate/text(), '-')"/>
                    <zeile-gericht>
                        <datum><xsl:value-of select="$datum-tokenized[3]"/><xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[2]"/>
                            <xsl:text>. </xsl:text><xsl:value-of select="$datum-tokenized[1]"/></datum>
                        
                        <trennzeichen><xsl:text> - </xsl:text></trennzeichen>
                        
                        <az>
                            <xsl:for-each select="metadata/instdoc/instdocnrs/instdocnr">
                                <xsl:if test="not(position()=1)">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </az>
                        <seite-gericht><xsl:text>&#x9;</xsl:text><xsl:value-of select="metadata/pub/pages/start_page"/></seite-gericht>
                    </zeile-gericht><xsl:text>&#xa;</xsl:text>
                </xsl:for-each>-->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
