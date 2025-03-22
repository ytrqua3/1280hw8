function getLinks(){
	curl -s $1 | grep -E -o '<a[^>]*>' | sed -E '/<a(.*)href=\"([^\"]*)\"(.*)$/s//http:\/\/localhost:8000\/\2/'
}
pagesVisited=()

function crawl(){
	links=$(mktemp)
	getLinks $1 >$links
	while read link
	do
		isNewPage=0
		for page in "${pagesVisited[@]}"
		do
			if [ "$link" == "$page" ]
			then
				isNewPage=1
			fi
		done
		if [ "$isNewPage" == "0" ]
		then
			pagesVisited+=($link)
			crawl $link
		fi
	done <$links
}

crawl $1

echo -n "${pagesVisited[@]}" | tr " " "\n" | sort
