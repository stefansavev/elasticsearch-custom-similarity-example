# elasticsearch-custom-similarity-example

Steps:

1. mvn clean install

2. Edit deploy_script.sh
   <pre>    
   Set the location of elasticsearch
   ES_DIR=/home/stefan2/elastic-code/download/elasticsearch-2.1.1/
   </pre>
   
3. Run deploy_script.sh

4. edit the script that starts elasticsearch
   <pre>
   Edit elasticsearch-2.1.1/bin/elasticsearch to include the plugin jars in the elasticsearch classpath
   ES_CLASSPATH="$ES_CLASSPATH:${ES_HOME}/plugins/overlap-similarity-plugin/"
   </pre>
   
5. Restart elasticsearch

6. Create the page_clicks index
<pre>   
   cd example
   ./create_index.sh
</pre>

7. Load the dataset into elasticsearch
<pre>   
   cd example
   ./populate_collection.sh
</pre>

8. Run the example queries
  <pre>
   cd example
   ./examples.sh
  </pre>    
