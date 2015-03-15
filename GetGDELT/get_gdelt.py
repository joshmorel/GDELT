#From windows command line:
#cd to where get_gdelt program and expected location for files
#"~\python.exe" dl_files.py "YYYY,M,D,H,M" "YYYY,M,D,H,M" (start date time then end date time)
#From git bash:
#cd to where dl_files program and expected location for files
#python dl_files.py 'YYYY,M,D,H,M' 'YYYY,M,D,H,M' (start date time then end date time)

import sys
import os
from datetime import datetime
from datetime import timedelta
import urllib2
import glob
import zipfile

def main():
    '''Download zipped files from GDELT export website for given datetime range,
unzips downloaded files, and merges files into one txt file'''
    script = sys.argv[0]
    StartDateIn = sys.argv[1]
    EndDateIn = sys.argv[2]
    sys.argv = ['dl_files.py', StartDateIn, EndDateIn]
    execfile('dl_files.py') #calls dl_files.py program
    sys.argv = ['unzip_files.py', '*.zip']
    execfile('unzip_files.py') #calls unzip_files.py program
    sys.argv = ['merge_files.py', '*.CSV']
    execfile('merge_files.py') #calls merge_files.py program
    #clean up directory, deleting all zip and csv files
    files = glob.glob('*.CSV*')
    for filename in files:
        os.unlink(filename)
main()