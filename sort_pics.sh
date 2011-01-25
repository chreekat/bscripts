#!/usr/bin/zsh

## Program for sorting pics
##
## New pics are unloaded to $ALBUMS/dump before program is run. This program
## moves them into a different album and optionally modifies them.

ALBUMS=~/var/photos
DUMP=$ALBUMS/dump

# Testing function
doo () {
    $@
    # echo "Doing: $@"
}

# Helper function
# note dependence on $album and $pic at runtime!
new_album () {
    [ -n "$pic" -and -n "$album" ] || {
        echo '$pic and/or $album do not exist! What is going on?' >&2
        exit 1
    }

    identify -verbose dump/$pic | grep 'Date Time Original' 
    while true; do
        read album\?'New name: '
        echo -n "Use $album? "
        read -q && mkdir -p $album || continue
        break
    done
}

# initialize before loop begins
last_album=
dim_flag=0         # flag for proper resize dimensions
cd $DUMP

# MAIN LOOP!
for pic in *; do
    # 1. view pic
    xzgv $pic

    # 2. utter garbage?
    echo -n "Utter garbage? "
    if read -q ; then
        doo rm $pic
        continue
    fi

    # 3. rotate?
    echo "Rotate? "
    select rot in '180' '90 cw' '90 ccw' 'No'; do
        case $rot in
            '180'   ) doo mogrify -rotate 180 $pic ;;
            '90 cw' ) doo mogrify -rotate 90 $pic
                      let dim_flag="($dim_flag+1) % 2"
                      ;;
            '90 ccw') doo mogrify -rotate -90 $pic
                      let dim_flag="($dim_flag+1) % 2"
                      ;;
            *       ) break ;;
        esac
        xzgv $pic
    done

    # 4. choose an album
    # if prev album should not be used, or if no previous album, choose an album
    # otherwise, use previous
    cd ..
    if [ -z "$last_album" ] ||
       ( echo -n "Use a different album instead of $album? "; read -q )
    then
        echo "Choose an album"
        select album in *(/m-1) 'Other...' 'New...'; do break; done
        case $album in
          'New...') new_album ;;
          'Other...')
            select album in *(/) 'New...'; do break; done
            [ $album = 'New...' ] && new_album ;; 
        esac
    else
        album=$last_album
    fi
    doo mv dump/$pic $album
    last_album=$album
    cd $album


    # 5. shrink for posting?
    echo -n 'Shrink for posting? '
    read -q && {
        mkdir -p 640x480
        
        # If image is rotated a total of +/- 90, it should be resized 480x640!
        if [ $dim_flag -eq 0 ]; then
            doo convert -resize 640x480 $pic 640x480/$pic
        else
            doo convert -resize 480x640 $pic 640x480/$pic
        fi
    }

    cd $DUMP
done
