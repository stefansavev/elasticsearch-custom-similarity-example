#!/bin/bash

set -e #fail on error
set -u #fail on undefined

echoerr() { echo "Error: $@" 1>&2; } #write an error to stderr

#set the variable to your elasticsearch installation

ES_DIR=/home/stefan2/elastic-code/download/elasticsearch-2.1.1/

if [ ! -d "$ES_DIR" ]; then
	echoerr "ElasticSearch directory $ES_DIR does not exist"
	exit 1
fi

PLUGIN_CMD=$ES_DIR/bin/plugin

CURRENT_SCRIPT=$(readlink -f $0) #get the path of the current script
CURRENT_DIR=$(dirname "${CURRENT_SCRIPT}") #get the directory of the current script

JAR_FILE="overlap-similarity-plugin-0.0.1-SNAPSHOT.jar" #name of the jar file
PLUGIN_NAME="overlap-similarity-plugin"

FULL_JAR_FILE_PATH=$CURRENT_DIR/target/$JAR_FILE

if [ ! -f "$FULL_JAR_FILE_PATH" ]; then
	echoerr "Plugin jar file does not exist in $FULL_JAR_FILE_PATH"
	exit 1
fi

ls $FULL_JAR_FILE_PATH

#cp /home/stefan2/kaggle/taste-es/my-plugin/target/releases/my-plugin-1.0.0.zip .
#unzip my-plugin-1.0.0.zip
#./plugin remove scala-es
echo "Checking if a previous installation of the plugin exists"
LIST_RESULT=$(${PLUGIN_CMD} list | grep "${PLUGIN_NAME}")
echo $LIST_RESULT

if [[ $LIST_RESULT == *"${PLUGIN_NAME}"* ]]
then
	echo "Plugin is already installed. Need to remove it first!";
	${PLUGIN_CMD} remove ${PLUGIN_NAME}
fi 


echo "Installing plugin"
${PLUGIN_CMD} install file:${FULL_JAR_FILE_PATH}

echo "Done."
echo "Asking for a list of installed plugins. You should see our plugin: ${PLUGIN_NAME}"
${PLUGIN_CMD} list



