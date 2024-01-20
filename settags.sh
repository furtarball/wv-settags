#!/bin/bash

printf "— settags 1.0 —\n\n"

printf "Artist: "
read artist
printf "Album title: "
read album
printf "Original release year: "
read date
printf "Catalogue number: "
read labelid

wvtag -q -w "Artist=$artist" -w "Album=$album" -w "Year=$date" -w "Catalog=$labelid" *.wv

printf "Writing track numbers…\n\n"
declare -i tracknumber=0
for i in *.wv;
	do ((++tracknumber)) &&
	if [ $tracknumber -le 9 ]
		then
		wvtag -q -w "Track=0$tracknumber" "$i"
		mv "$i" "0$tracknumber.wv"
	else
		wvtag -q -w "Track=$tracknumber" "$i"
		mv "$i" "$tracknumber.wv"
	fi
done

for i in *.wv;
	do printf "Track ${i::-3} title: " &&
	read title &&
	wvtag -q -w "Title=$title" "$i" &&
	mv "$i" "${i::-3} – $title.wv";
done

printf "Done!\n"
