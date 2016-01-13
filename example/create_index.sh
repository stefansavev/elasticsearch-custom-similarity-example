#if the index exists you may want to delete it first when testing

curl -XDELETE 'http://localhost:9200/page_clicks/'

curl -XPUT 'localhost:9200/page_clicks' -d '
{
    "settings" : {
        "index" : {
            "number_of_shards" : 1,
            "number_of_replicas" : 1,
            "store": "memory"
        },

        "similarity" : {
      	  "custom_similarity" : {
        		"type" : "overlapsimilarity"
      	  }
        }
    }
}
'

curl -XGET 'http://localhost:9200/page_clicks/_settings?pretty'

curl -XPUT 'localhost:9200/page_clicks/_mapping/pages' -d '
{
  "properties": {
    "page_id": {
      "type": "string",
      "index":  "not_analyzed"
    },
    "user_ids": {
      "type": "string",
      "analyzer": "standard",
      "index_options": "docs",
      "similarity": "custom_similarity" 
    }
  }
}
'



curl -XGET 'http://localhost:9200/page_clicks/_mappings/pages?pretty'

