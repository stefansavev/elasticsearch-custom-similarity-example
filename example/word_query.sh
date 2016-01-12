WORD=$1 #"video"

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

cat query1.result | grep "user_ids" >> query2.tmp

cat <<EOF >> query2.tmp

        }
  },
  "aggs": {}
}
'
EOF

chmod +x ./query2.tmp
./query2.tmp > query2.result

cat query2.result | grep "_source"





