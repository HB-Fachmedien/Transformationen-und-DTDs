#!/usr/bin/env python3


'''
Skript, um mehrere Transformationen nacheinander laufen zu lassen. Unten müssen Transformationsfolgen definiert werden.

Voraussetzung ist eine Java saxon.jar und eine resolver.jar Datei im Verzeichnis. 
'''

import shutil, subprocess, os, tempfile

TEMP_FOLDER = 'TEMP'

OUTPUT_FILE = os.path.join(TEMP_FOLDER, 'register.xml')

XSL_SKRIPT_FOLDER = 'D:\\programmierung\\workspace\\hbfm\\Transformationen-und-DTDs\\xslt\\verschlagwortung\\'
XML_CATALOG_FILE = 'D:\\programmierung\\workspace\\hbfm\\Transformationen-und-DTDs\\dtd\\myCatalog.xml'

HAUPTSCRIPT = os.path.join(XSL_SKRIPT_FOLDER, "verschlagwortung.xsl")

SCRIPT_2 = os.path.join(XSL_SKRIPT_FOLDER, '2sortierung.xsl')

SCRIPT_3 = os.path.join(XSL_SKRIPT_FOLDER, '3zusammenfassen.xsl')

SCRIPT_4b = os.path.join(XSL_SKRIPT_FOLDER, '4b-rawreg2autorenverzeichnis-prototpye.xsl')

WUW_ENTSCHEIDUNGS_SKRIPT = os.path.join(XSL_SKRIPT_FOLDER, '.\\entscheidungen\\dk-und-wuw-entscheidungsregister.xsl')


# Hier Transformationsfolgen definieren
WUW_AUTOREN_REGISTER = (HAUPTSCRIPT, SCRIPT_2, SCRIPT_3, SCRIPT_4b)
WUW_ENTSCHEIDUNGS_REGISTER = (WUW_ENTSCHEIDUNGS_SKRIPT,)

# Debug Scripts:
WUW_DEBUG_1 = (HAUPTSCRIPT,)
WUW_DEBUG_2 = (HAUPTSCRIPT, SCRIPT_2,)
WUW_DEBUG_3 = (HAUPTSCRIPT, SCRIPT_2, SCRIPT_3)

# Clean Up
shutil.rmtree(TEMP_FOLDER)
os.makedirs(TEMP_FOLDER)


def run_transformation(scriptname, input_filename, output_filename):
    subprocess.run(['java', '-cp', 'saxon9he.jar;resolver.jar', 'net.sf.saxon.Transform',
                #'-dtd:off',
                f'-catalog:{XML_CATALOG_FILE}',
                f'-s:{os.path.join(XSL_SKRIPT_FOLDER, input_filename)}',
                f'-xsl:{os.path.join(XSL_SKRIPT_FOLDER, scriptname)}', 
                f'-o:{os.path.join(TEMP_FOLDER, output_filename)}'])


def run_batch_transformation(batch_name):
    tmp_files = ["dummy.xml"]
    file_descriptors = []
    for index, script in enumerate(batch_name):
        fd, filename = tempfile.mkstemp()

        print(filename)

        run_transformation(script, tmp_files[index], filename)

        tmp_files.append(filename)
        file_descriptors.append(fd)

    
    #copy last output file:
    shutil.copyfile(tmp_files[-1], OUTPUT_FILE)

    for fd in file_descriptors:
        os.close(fd)


#run_batch_transformation(WUW_DEBUG_3)
run_batch_transformation(WUW_AUTOREN_REGISTER)
#run_batch_transformation(WUW_ENTSCHEIDUNGS_REGISTER)