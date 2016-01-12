# elasticsearch-custom-similarity-example

Steps:

1. mvn clean install

2. Edit deploy_script.sh
    Set the location of elasticsearch
    ES_DIR=/home/stefan2/elastic-code/download/elasticsearch-2.1.1/

3. Run deploy_script.sh

4. edit the script that starts elasticsearch

    Edit elasticsearch-2.1.1/bin/elasticsearch to include the plugin jars in the elasticsearch classpath
    ES_CLASSPATH="$ES_CLASSPATH:${ES_HOME}/plugins/overlap-similarity-plugin/"

5. Restart elasticsearch

6. Create the page_clicks index
   cd example
   ./create_index.sh

##Load the dataset into elasticsearch
cd example
./populate_collection.sh

##Run the example queries
cd example
./examples.sh
