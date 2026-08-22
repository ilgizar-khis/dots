#!/usr/bin/bash

if [[ "$ROFI_RETV" == "0" ]]; then
	swaymsg -t get_tree | jq -c '.. | select(.type? == "con" or .type? == "floating_con") | {"id": .id, app_id: .app_id, "name":  .name}' | while read -r client; do
		name="$(echo "$client" | jq -r '.name')"
		if [[ "$name" == "null" ]]; then
			continue
		fi
		app_id="$(echo "$client" | jq -r '.app_id')"
		client_id="$(echo "$client" | jq -r '.id')"
		echo -en "$app_id: $name\0info\x1f$client_id\n"
	done
else
	swaymsg '[con_id='$ROFI_INFO'] focus' >> /dev/null
	exit 0
fi
