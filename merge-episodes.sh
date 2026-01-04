#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
	    echo "Error: missing parameters. Provide playlist folder" >&2
	        exit 1
fi
playlist_folder="$1"

for item in $playlist_folder/*; do
	if [[ ! -d "$item" ]]; then
		continue
	fi

	echo "Processing folder: $item"
	ep_num=$(basename "$item" | grep -o '[0-9]\+')

	files=("$item"/*.webm)
	 if [[ ${#files[@]} -ne 5 ]]; then
		echo "Warning: folder '$item' does not contain 5 webm files!"
	 fi
	# Build mkvmerge command
	cmd="mkvmerge -o \"${playlist_folder}/episodio_${ep_num}.mkv\""
	for f in "${files[@]}"; do 
		cmd+=" \"$f\" +" 
	done 
	# Remove trailing '+'
	cmd="${cmd%+}"
	cmd+=" --generate-chapters 'when-appending'"

	# Print the command (or execute with eval)
	#echo "$cmd"
	eval $cmd
done


