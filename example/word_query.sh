#!/bin/bash

set -eu

if [ "$#" -ne 1 ]; then
	echo "Illegal number of parameters"
    	echo "Example: ./word_query.sh page_encryption"
	exit 1
fi

WORD=$1

cat <<EOF > query1.tmp
curl -XGET 'localhost:9200/page_clicks/pages/_search' -d'
{
    "query" : {
        "match" : {
            "page_id" : "$WORD"
        }
    }
}
'
EOF

chmod +x ./query1.tmp
./query1.tmp > query1.result

cat <<EOF > query2.tmp
curl -XGET 'localhost:9200/page_clicks/pages/_search?pretty' -d'
{
  "_source": [ "page_id" ],
  size: 20,
  "query": {
        "match" : {
EOF



awk 'BEGIN { FS = "\"" } ; {
        for(i=1; i<=NF; i++) {
                tmp=match($i, /user_ids/)
                if(tmp) {
                        print ("\"user_ids\" : \"", $(i + 2),"\"")
			break	
                }
        }
}' query1.result >> query2.tmp

#echo $USER_IDS

cat <<EOF >> query2.tmp
        }
  },
  "aggs": {}
}
'
EOF

chmod +x ./query2.tmp
./query2.tmp > query2.result

cat query2.result | grep "_source" | sed s/\"_source\"\://





