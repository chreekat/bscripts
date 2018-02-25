#!/usr/bin/env bash

: ${DIM:=6}

echo '

This is a test for color terminals. Use the env var DIM to choose between
88 colors (DIM=4) or 256 (DIM=6).


First, 24 colors (8 standard colors times 3 ways of making them)
'

for (( i=0; i<5; i++ )); do
    for (( j=0; j<8; j++ )); do
        c=
        n=
        if [ $i -eq 0 ]; then
            (( n = $j+30 ))
            c="\\e[22;${n}m"
            explanation="Using \\e[NUMm, 30 <= NUM <= 37"
        elif [ $i -eq 1 ]; then
            (( n = $j+90 ))
            c="\\e[${n}m"
            explanation="Using \\e[NUMm, 90 <= NUM <= 97"
        elif [ $i -eq 2 ]; then
            (( n = $j+30 ))
            c="\\e[1;${n}m"
            explanation="Using \\e[1;NUMm, 30 <= NUM <= 37"
        elif [ $i -eq 3 ]; then
            (( n = $j+40 ))
            c="\\e[${n};$((n-10))m"
            explanation="Background, using \\e[NUMm, 40 <= NUM <= 47"
        elif [ $i -eq 4 ]; then
            (( n =  $j + 8 ))
            c="\\e[38;5;${n}m"
            explanation="Using extended: \\e[38;5;NUMm, 8<=num<=15"
        fi

        # print color code
        echo -en $c

        # print something to see the color
        printf 'color%.3d' $j
        echo -ne '\e[0m    '
    done
    echo -ne '\e[0m'
    echo $explanation
done

# Formula is DIM*12 - 8 but that's unnecessary
space=""
if [ $DIM -eq 4 ]; then
    space=$(perl -e 'print " " x 22')
else
    space=$(perl -e 'print " " x 46')
fi
echo "

Next, a ${DIM}x${DIM}x${DIM} block of extended colors, using \e[38;5;NUMm, 0 <= NUM < ( ${DIM}x${DIM}x${DIM} )
Bold off (\e[0;38;5;NUMm) ${space}| Bold on (\e[1;38;5;NUMm)
------------------------- ${space}| ------------------------
                          ${space}|"

for (( i=0; i<$DIM; i++ )); do
    for (( j=0; j<$DIM; j++ )); do
        for (( bold_p=0; bold_p < 2; bold_p++ )); do
            for (( k=0; k<$DIM; k++)); do
                (( n = 16 + i + j*$DIM + k*$DIM*$DIM ))
                c="\\e[${bold_p};38;5;${n}m"
                echo -en $c
                printf 'color%.3d    ' $n
            done
            [ $bold_p -eq 0 ] && echo -en "\e[0m|    "
        done
        echo -e "\e[0m"
    done
done

echo '

And now grayscale, using \e[38;5;NUMm. Bottom group is with bold on.

'
# It looks like there are $DIM * 4 levels of grayscale. At least, that's
# true for 88 and 256.
((start= 16 + $DIM*$DIM*$DIM))
((end= $start + $DIM*4))
for (( bold_p=0; bold_p < 2; bold_p++ )); do
    for ((i = start; i < end; i++ )); do
        c="\\e[${bold_p};38;5;${i}m"
        echo -en $c
        printf 'color%.3d    ' $i
        # Make breaks
        if [ 0 -eq $(( (($i+1) - $start) % 4)) ]; then
            echo
        fi
    done
    echo -e "\n"
done

echo -e "\e[0m"
