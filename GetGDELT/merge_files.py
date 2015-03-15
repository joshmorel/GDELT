#From windows command line:
#cd to where files and merge_files program are
#"~\python.exe" merge_files.py "pattern"
#From git bash:
#cd to where files and merge_files program are
#"~\python.exe" merge_files.py 'pattern'


import sys
import glob

def main():
    '''Merges all csv files in current working directory with pattern'''
    script = sys.argv[0]
    pattern = sys.argv[1]
    source_files = glob.glob(pattern)
    merged_file = open('merged_file.txt','a') #creates/opens file in append mode 
    merged_file.truncate() #truncate contents if any
    for x in source_files:
        source_file = open(x,'r') #opens source file in read mode
        merged_file.write(source_file.read()) #writes contents of source to end of merged
        source_file.close() #closes source file
    merged_file.close() #closes merged file
main()