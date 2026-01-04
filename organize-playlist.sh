#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
	    echo "Error: missing parameters. Provide playlist folder" >&2
	        exit 1
fi
playlist_folder="$1"

move_file() {
	local ep=$1
	local parte=$2
	local item=$3
	local ep_name="episodio_${ep}"
	local ep_folder="$playlist_folder/$ep_name"  
	local ext="${item##*.}"

	if [ ! -d $ep_folder ]; then
		echo "Creating folder $ep_folder ..."
		mkdir -p "$ep_folder"
	fi

	echo "Moving file..."
	mv "$item" "${ep_folder}/${ep_name}_${parte}.${ext}"
}

for item in $playlist_folder/*; do
	if [[ ! -f "$item" ]]; then
		continue
	fi

	read parte < <(awk -F '｜' '{print $2}' <<< "$item")
	read ep < <(awk -F '｜' '{print $3}' <<< "$item")

	parte=${parte//[^0-9]/}
	ep=$(printf "%02d" "${ep//[^0-9]/}")

	while true; do
		echo ""
		read -p "move and rename ${item} to episodio ${ep}_${parte}? " answer
		case "${answer,,}" in
			y) move_file $ep $parte "${item}"; break;;
			n) echo "Ignoring..."; break;;
			*) echo "Please enter y or n";;
		esac
	done
done


