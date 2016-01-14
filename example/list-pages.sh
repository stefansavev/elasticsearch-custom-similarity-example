#!/bin/bash

set -eu
export SIZE=10
if [ "$#" -eq 1 ]; then
	export SIZE=$1
fi

echo $SIZE

curl -XGET 'localhost:9200/page_clicks/pages/_search?pretty' -d '{
  "_source": [ "page_id" ],
  size: '"$SIZE"',
  "query": {	
  	"match_all": {} 
  }	
}'
