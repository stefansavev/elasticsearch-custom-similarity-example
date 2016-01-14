./list-pages.sh 1000  | grep page_id | sed s/\"_source\":\{\"page_id\"\:\"// | sed s/\"\}// | awk '{print "echo ", $1, " && time ./word_query.sh ", $1}' > run-multiple-queries.tmp

chmod +x run-multiple-queries.tmp

#./run-multiple-queries.tmp

#output only the query results to a file
echo "outputing results to multiple-query.results"
./run-multiple-queries.tmp 2>&1 1 > multiple-query.results | grep real

