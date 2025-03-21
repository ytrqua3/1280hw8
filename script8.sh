fucntion readAnchor(){
	curl $1 | sed '/<a/s//'
}

readAnchor $1
cat site/index.html | sed -r -n '/<a([^>]*)>(.*)<\/a>/s//\1/pg'
