#!/bin/bash
##############################################
# author: yaolong
# mail: mail@yaolong.net
# date: 2023-04-24
##############################################

dir=$(pwd)
count=$(ls $dir -1 | wc -l)

printf "\033[33m [$dir] files: $count \033[0m\n"

read -r -p "Press [y] to start eraser files [$dir]. Or [n] to stop. [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
        ;;

    [nN][oO]|[nN])
        exit 1;
        ;;

    *)
        ;;
esac

for file in $(find $dir -type f); do
    echo $file
    dd if=/dev/urandom of=$file bs=$(wc -c $file | awk '{print $1}') count=1
done


