import time, os, zipfile, re
import shutil
import xml.etree.ElementTree as ET
from collections import Counter
import arrow

# SRC_DIRECTORY = './in' # for debugging
SRC_DIRECTORY = './from_ftp'

WORKING_DIRECTORY = './temp_extracted_files'

PROCESSED_DIRECTORY = './processed/'


def copy_src_file_to_processed_directory(filename):
    filename = os.path.join(SRC_DIRECTORY, filename)
    shutil.move(filename, PROCESSED_DIRECTORY)


def extract_zip(filename):
    z_file = zipfile.ZipFile(os.path.join(SRC_DIRECTORY, filename))
    
    z_file.extractall(path=WORKING_DIRECTORY) # PermissionError

    name_list = z_file.namelist()

    z_file.close()

    return name_list


def process_xml_fix():

    number_processed_files = None

    for dirpath, dirnames, filenames in os.walk(os.path.join(WORKING_DIRECTORY, 'documents')):

        if number_processed_files is None:
            number_processed_files = len(filenames)

        for f in filenames:

            try:
                xml_file = ET.parse(os.path.join(WORKING_DIRECTORY, 'documents', f))

                file_root = xml_file.getroot()

                global_toc = file_root.find('./metadata/global_toc')

                if global_toc is None: # Datei hat wohl kein global_toc
                    print('****: KEIN GLOBAL_TOC: ' + f)
                    continue

                first_node = global_toc.find('./node')

                if first_node.attrib['title'] == 'root':
                    expected_year_node = first_node.find('./node/node/node')
                    year_node_match_object = re.fullmatch('\d{4}' ,expected_year_node.attrib['title']) # test for right node

                    if year_node_match_object is not None:

                        # expected_heft_node = expected_year_node.find('./node')
                        #
                        # expected_beitraege_node = expected_heft_node.find('./node')
                        #
                        # leaf_node = expected_year_node.find('./node/node/leaf')
                        #
                        # # tests:
                        # if None in (expected_heft_node, expected_beitraege_node, leaf_node) or expected_beitraege_node.attrib['title'] != 'Beiträge':
                        #     print('************************************: BEITRAGS NODE ODER LEAF NODE WURDE NICHT GEFUNDEN!: ' + f)
                        #     continue
                        #
                        # expected_heft_node.remove(expected_beitraege_node)
                        #
                        # expected_heft_node.insert(0, leaf_node)

                        # first remove root node:
                        global_toc.clear()

                        # then again insert year node:
                        global_toc.insert(0, expected_year_node)

                        xml_file.write(os.path.join(WORKING_DIRECTORY, 'documents', f), encoding='utf-8')


                    else:
                        print('************************************: VIERTER NODE KEINE JAHRESZAHL!: ' + f)
                        continue

                else:
                    print('************************************: ERSTE EBENE KEIN ROOT NODE: ' + f)
                    continue

            except Exception as e:
                print('Fehler ist aufgetreten: ', e)
                continue

    return number_processed_files


def clean_working_directory():
    shutil.rmtree(WORKING_DIRECTORY)


def pack_zip_file(output_filename):

    filename = shutil.make_archive(output_filename, format='zip', root_dir=WORKING_DIRECTORY+'/')

    z_file = zipfile.ZipFile(filename)

    name_list = z_file.namelist()

    z_file.close()

    shutil.move(filename, "./out/")

    return name_list


if __name__ == '__main__':

    counter = 0

    file_Counter = Counter()

    time_now = arrow.now()

    for dirpath, dirnames, filenames in os.walk(SRC_DIRECTORY):

        no_of_files = len(filenames)

        for filename in filenames:
            if filename.endswith('.zip'):

                counter += 1

                print(f'Paket {counter} von {no_of_files}: {filename} wird bearbeitet.')

                try:
                    src_name_list = extract_zip(filename)

                    how_many_files_processed = process_xml_fix()

                    file_name_prefix = re.search('(.*?)\_\d+\.zip', filename).group(1)

                    file_Counter[file_name_prefix] += how_many_files_processed

                    time_now_ctr = time_now.shift(seconds=counter) # for unique filenames

                    output_filename = file_name_prefix + '_' + time_now_ctr.format('YYYYMMDDHHmmss')

                    dest_name_list = pack_zip_file(output_filename)

                    assert src_name_list, dest_name_list

                    clean_working_directory()

                    copy_src_file_to_processed_directory(filename)

                except Exception as e:
                    print(file_Counter)
                    print(f'FEHLER IN DER VERARBEITUNG, PAKET {filename} ÜBERPRÜFEN!')
                    print(e)
                    break

    print(file_Counter)

