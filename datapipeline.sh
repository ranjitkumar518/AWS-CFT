#!/bin/bash

#Getting Passwords

RDS_PASS=
RedShift_Pass=

for fname in "$search_dir"./*.json
do

#loading variables.........
source data-pipeline-config.sh

#Getting Name of Pipeline from tepmlate filename.......
name=$( echo $fname | cut -d '/' -f 2 | cut -d '.' -f 1 )

#Creating pipeline..........
aws datapipeline create-pipeline --name $name --unique-id icp-$name > /tmp/id.txt

#Getting Pipeline ID from Pipeline output......
id=$(cat /tmp/id.txt | grep df | cut -d ':' -f 2 | awk -F'"' '{$0=$2}1')

#Replacing the pipeline variables into Pipeline defination template.......

sed -i .bak -e "s/RDS_Uname/$RDS_Uname/g" -e "s/RDS_PASS/$RDS_PASS/g" -e "s/RDS_SG/$RDS_SG/g" -e "s/RDS_Endpoint/$RDS_Endpoint/g" -e "s/RDS_DB/$RDS_DB/g" -e "s/RedShift_Uname/$RedShift_Uname/g" -e "s/RedShift_Pass/$RedShift_Pass/g" -e "s/RedShift_DB/$RedShift_DB/g"  -e "s/RedShift_DB/$RedShift_DB/g" -e "s/Redshift_Endpoint/$Redshift_Endpoint/g" -e "s/RedShift_SG/$RedShift_SG/g" -e "s/SubnetId/$SubnetId/g" -e "s/TopicArn/$TopicArn/g" -e "s/S3_LogUri/$S3_LogUri/g" -e "s/S3_Staging/$S3_Staging/g" -e "s/Redshift_Schema/$RedshiftSchema/g" ${name}.json


aws datapipeline put-pipeline-definition --pipeline-id $id --pipeline-definition file://./${name}.json

aws datapipeline activate-pipeline --pipeline-id $id

echo The Pipeline has been activated $name

done

echo "\n \n"
read -p "Press Enter to clean the templates configs..............."
### Cleaning the old tepmlate...
echo  "\n \nCleaing The Templates configs..............."
rm -rf *.json

find . -name "*.json.bak" -exec bash -c 'mv "$1" "${1%.json.bak}".json' - '{}' \;

echo "\nDone........"
