# elasticsearch-custom-similarity-example

<a href="http://stefansavev.com/blog/custom-similarity-for-elasticsearch/">Blog post describing the stages to create the custom similarity plugin</a>

Steps to run the code:

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

9. Check the output of ./examples.sh

  <pre>
      query: page_god
      "_source":{"page_id":"page_god"}
      "_source":{"page_id":"page_jesus"}
      "_source":{"page_id":"page_christian"}
      "_source":{"page_id":"page_believe"}
      "_source":{"page_id":"page_him"}
      "_source":{"page_id":"page_life"}
      "_source":{"page_id":"page_bible"}
      "_source":{"page_id":"page_christians"}
      "_source":{"page_id":"page_our"}
      "_source":{"page_id":"page_must"}
      "_source":{"page_id":"page_his"}
      "_source":{"page_id":"page_fact"}
      "_source":{"page_id":"page_apr"}
      "_source":{"page_id":"page_things"}
      "_source":{"page_id":"page_true"}
      "_source":{"page_id":"page_christ"}
      "_source":{"page_id":"page_man"}
      "_source":{"page_id":"page_say"}
      "_source":{"page_id":"page_come"}
      "_source":{"page_id":"page_being"}
  </pre>
  
  <pre>
  query: page_encryption
      "_source":{"page_id":"page_encryption"}
      "_source":{"page_id":"page_clipper"}
      "_source":{"page_id":"page_chip"}
      "_source":{"page_id":"page_key"}
      "_source":{"page_id":"page_keys"}
      "_source":{"page_id":"page_secure"}
      "_source":{"page_id":"page_algorithm"}
      "_source":{"page_id":"page_escrow"}
      "_source":{"page_id":"page_security"}
      "_source":{"page_id":"page_secret"}
      "_source":{"page_id":"page_crypto"}
      "_source":{"page_id":"page_government"}
      "_source":{"page_id":"page_house"}
      "_source":{"page_id":"page_wiretap"}
      "_source":{"page_id":"page_announcement"}
      "_source":{"page_id":"page_privacy"}
      "_source":{"page_id":"page_nsa"}
      "_source":{"page_id":"page_white"}
      "_source":{"page_id":"page_encrypted"}
      "_source":{"page_id":"page_pgp"}
  </pre>
