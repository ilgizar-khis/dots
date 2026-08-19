#!/usr/bin/bash

if [[ "$ROFI_RETV" == "0" ]]; then
	swaymsg -t get_tree | jq -c '.. | select(.type? == "con" and .name != null) | {"id": .id, "name": "\(.app_id): \(.name)"}' | while read -r client; do
		name="$(echo "$client" | jq -r '.name')"
		con_id="$(echo "$client" | jq -r '.id')"
		echo -en "$name\0info\x1f$con_id\n"
	done
else
	swaymsg '[con_id='$ROFI_INFO'] focus' >> /dev/null
	exit 0
fi
