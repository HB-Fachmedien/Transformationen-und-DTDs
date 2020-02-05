'''

Ein Pyhton Skript, welches Entscheidungen vom Entscheidungsregister sortiert, die vom selben Gericht und vom selben
Datum stammen.

Nimmt als einzigen Parameter den Speicherort der Entscheidungsregister Datei entgegen und schreibt die Ergbebnisdatei
in den gleichen Ordner mit dem [-sortiert] Suffix.

'''

import os
import re
import sys
from collections import defaultdict
# import xml.etree.ElementTree as ET

def read_xml_file(file):
    with open(file, encoding='utf-8') as f:
        content = f.readlines()

    content = [x.strip() for x in content]

    return content

def write_xml(file): # muss noch editiert werden
    with open("yourfile.txt", "w") as f:
        for line in lines:
            if line.strip("\n") != "nickname_to_delete":
                f.write(line)


def get_gerichts_indices(filecontent):
    '''
    Markiert die Postionen der Gerichtsüberschriften:

    :param filecontent:
    :return: list containing court positions
    '''

    return [i for i, x in enumerate(filecontent) if x.startswith('<h2>')]


def get_needless_h2_and_line_intervals_with_affected_court_decisions(filecontent, idx_list):

    resultlist_of_court_decisions = []
    needless_headlines = []
    for gerichts_ueberschriften_zeile in idx_list:

        if not filecontent[gerichts_ueberschriften_zeile + 1].startswith('<zeile-gericht>'):
            #print(f'Gerichtsüberschrift: {filecontent[gerichts_ueberschriften_zeile]}, Zeile {gerichts_ueberschriften_zeile + 1} kann gelöscht werden. Kein Content.')
            needless_headlines.append(gerichts_ueberschriften_zeile)
            continue

        counter = 1

        d = defaultdict(list)

        while filecontent[gerichts_ueberschriften_zeile + counter].startswith('<zeile-gericht>'):

            date = re.search(r'<datum(-gericht)?>(.*?)</datum(-gericht)?>', filecontent[gerichts_ueberschriften_zeile + counter]).group(2)

            d[date].append(gerichts_ueberschriften_zeile + counter)
            counter += 1

        for key in d:
            if len(d[key])>1:
                resultlist_of_court_decisions.append(d[key])

    return resultlist_of_court_decisions, needless_headlines


def sort_court_decisions(filecontent, resultlist_of_court_decisions):

    for scope in resultlist_of_court_decisions:
        for row in scope:
            #print(filecontent[row])
            print(re.search(r'<az(-gericht)?>(.*?)</az(-gericht)?>', filecontent[row]).group(2))

        print('###')



def delete_empty_lines(filename):
    '''
    :param filename:

     Entfernt zunächst die Leerzeilen aus der Datei.
    '''
    with open(filename, 'r+') as fd:
        lines = fd.readlines()
        fd.seek(0)
        fd.writelines(line for line in lines if line.strip())
        fd.truncate()

if __name__ == '__main__':
    if not sys.argv[1].endswith('.xml'):
        raise IOError('Input Datei scheint keine XML Datei zu sein. Das Skript benötigt nur einen Parameter -> den absoluten Pfad zur Verschlagwortungsdatei.')

    delete_empty_lines(sys.argv[1])

    filecontent = read_xml_file(sys.argv[1])

    indices_list = get_gerichts_indices(filecontent)

    resultlist_of_court_decisions, needless_headlines = get_needless_h2_and_line_intervals_with_affected_court_decisions(filecontent, indices_list)

    print('Urteilszeilen, die sortiert werden müssen:', resultlist_of_court_decisions, '', sep='\n')
    print('Überflüssige Gerichtsüberschriften', needless_headlines) # sollte aber mittlerweile unnötig sein, wird vorher mit einer XSLT Regel abgefangen

    filecontent = sort_court_decisions(filecontent, resultlist_of_court_decisions)
    