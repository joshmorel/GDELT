#From windows command line:
#cd to where dl_files program and expected location for files
#"~\python.exe" dl_files.py "YYYY,M,D,H,M" "YYYY,M,D,H,M" "e" (start date time then end date time)
#"e" for english, "t" for translated
#From git bash:
#cd to where dl_files program and expected location for files
#python dl_files.py 'YYYY,M,D,H,M' 'YYYY,M,D,H,M' 'e' (start date time then end date time)
#'e' for english, 't' for translated

import sys
from datetime import datetime
from datetime import timedelta
import urllib2

def main():
    '''Download zipped files from GDELT export website for given datetime range
	,e for english, t for translated'''
    script = sys.argv[0]
    StartDateIn = sys.argv[1]
    EndDateIn = sys.argv[2]
    UseEnglish = sys.argv[3]
    assert (UseEnglish == 'e' or UseEnglish == 't'), 'Use e for english, t for translated'
    exec 'StartDate = datetime('+StartDateIn+')'
    exec 'EndDate = datetime('+EndDateIn+')'
    d_add = timedelta(minutes=15) #define time delta of fifteen minutes for loop
    delta = EndDate - StartDate
    diff_minute = delta.days*1440 + delta.seconds/60 #minutes between start and end dates
    ExportDate = StartDate
    for x in range(0,diff_minute+15,15):
        if UseEnglish == 'e':
            filename = ExportDate.strftime('%Y'+'%m'+'%d'+'%H'+'%M')+'00.export.CSV.zip'
        else:
            filename = ExportDate.strftime('%Y'+'%m'+'%d'+'%H'+'%M')+'00.translation.export.CSV.zip'
        zipfile = urllib2.urlopen('http://data.gdeltproject.org/gdeltv2/'+filename)
        output = open(filename,'wb') #locally creates a zip file with same name
        output.write(zipfile.read())
        output.close()
        ExportDate = ExportDate + d_add
main()
