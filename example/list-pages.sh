curl -XGET 'localhost:9200/page_clicks/pages/_search?pretty' -d '{
  "_source": [ "page_id" ],
  "query": {	
  	"match_all": {} 
  }	
}'
