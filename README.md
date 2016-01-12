# elasticsearch-custom-similarity-example

Steps:

## mvn clean install

## edit deploy_script.sh

Set the location of elasticsearch

ES_DIR=/home/stefan2/elastic-code/download/elasticsearch-2.1.1/

##Run deploy_script.sh

##edit the script that starts elasticsearch

Edit elasticsearch-2.1.1/bin/elasticsearch to include the plugin jars in the elasticsearch classpath

ES_CLASSPATH="$ES_CLASSPATH:${ES_HOME}/plugins/overlap-similarity-plugin/"

##Restart elasticsearch

##Create the page_clicks index
cd example
./create_index.sh

##Load the dataset into elasticsearch
cd example
./populate_collection.sh

##Run the example queries
cd example
./examples.sh
