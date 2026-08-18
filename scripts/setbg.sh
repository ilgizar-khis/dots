#!/usr/bin/bash

pkill swaybg || true

if [[ "$#" == 2 ]]; then
	dir="$(dirname $0)"
	size="$(swaymsg -t get_outputs | jq -r '.. | select(.name? == "'$2'") | "\(.rect.width)x\(.rect.height)" ')"
	magick $1 -resize $size $dir/$2.jpg

	cmd=("swaybg")
	for file in $dir/*.jpg; do
		name="$(basename $file)"
		cmd+=" -o"
		cmd+=" ${name%.*}"
		cmd+=" -i"
		cmd+=" $file"
	done
	echo "$cmd"
	$cmd &
fi
