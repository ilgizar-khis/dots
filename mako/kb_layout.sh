#!/usr/bin/bash

old_layout=""
not_id=0

swaymsg -t subscribe -m '["input"]' | while read -r line; do
	cur_layout="$(echo "$line" | jq -r '.input.xkb_active_layout_name')"
	if [[ "$old_layout" != "$cur_layout" ]]; then
		old_layout="$cur_layout"
		not="$(makoctl list -j | jq -r '.[] | select(.id? == '$not_id')')"
		if [ -z "$not" ]; then
			not_id="$(notify-send -p "$cur_layout" -t 1000)"
		else
			notify-send -r "$not_id" "$cur_layout" -t 1000
		fi
	fi
done
