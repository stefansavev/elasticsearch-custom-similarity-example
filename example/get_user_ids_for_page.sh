curl -XGET 'localhost:9200/page_clicks/pages/_search' -d'
{
    "query" : {
        "match" : {
            "page_id" : "page_another"
        }
    }
}
'
