#From windows command line:
#cd to where files and unzip_files program are
#"~\python.exe" unzip_files.py "pattern"
#From git bash:
#cd to where files and unzip_files program are
#"~\python.exe" unzip_files.py 'pattern'


import sys
import glob
import zipfile

def main():
    '''Unzip all files current working directory with pattern'''
    script = sys.argv[0]
    pattern = sys.argv[1]
    source_files = glob.glob(pattern)    
    for x in source_files:
        zf = zipfile.ZipFile(x,'r') #reads zip file
        zf.extractall() #exctracts all to working directory
        zf.close() #closes zip file
main()