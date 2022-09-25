#!/bin/sh

fetch_timestamp () {
    filename="$1"
    newname=$(exif -i -t 0x9003 "$filename" | \
        awk '/Value: / {gsub(":",""); print "IMG_"$2"_"$3".jpg"}')
    if [ -z "$newname" ]; then
        exit 1
    fi
    echo $newname
}

rename_file () {
    echo mv -v "$1" "$(fetch_timestamp $1)"
    mv -v "$1" "$(fetch_timestamp $1)"
}

rename_files () {
    input="$1"
    if [ -d "$input" ]; then
        files=$(ls "$input")
        for f in $files; do
            rename_file "$f"
        done
    else
        rename_file "$1"
    fi
}
rename_files "$1"
