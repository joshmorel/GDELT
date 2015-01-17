
#dluz - Download and unzip. 
#Paramater 1 is desired folder and filename (without zip) 
#Parameter 2 is HTTP directory and filename (with zip)
#
#Uses curl to download zip file to provided location
curl -o $1.zip $2
#Uses dirname to get directory name of downloaded zip file
#Uses unzip to unzip file to provided location, -o flag to overwrite if exists
unzip -o  $1.zip -d $(dirname $1.zip)
#Uses rm to delete zip file, leaving only unzipped file
rm $1.zip
