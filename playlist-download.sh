#!/usr/bin/env bash

if ! command -v yt-dlp &>/dev/null; then
    echo "Error: yt-dlp not installed!" >&2
    exit 1
fi

if [[ $# -lt 3 ]]; then
    echo "Error: missing parameters. Provide playlist link, cookies path and output folder!" >&2
    exit 1
fi
playlist_link="$1"
cookies_path="$2"
output_folder="$3"

yt-dlp "$playlist_link" --cookies "$cookies_path" -P $output_folder 
