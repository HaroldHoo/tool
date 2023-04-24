#!/bin/bash
##############################################
# bash -c "$(curl -fsSL 'https://raw.fastgit.org/HaroldHoo/tool/master/safeDel.sh')"
# author: yaolong
# mail: mail@yaolong.net
# date: 2023-04-24
##############################################

dir=$(pwd)
[[ -n "$1" ]] && [[ -d "$1" ]] && dir=$1
dir=$(realpath -es $dir)

[[ -n "$1" ]] && [[ -f "$1" ]] && oneFile=$1

count=$(ls $dir -1 | wc -l)
[[ -n "$oneFile" ]] && count=1
dir=$oneFile

printf "\033[31m[$dir] files: $count \033[0m\n"

read -r -p "Press [y] to start eraser files! Or [n] to stop. [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
        ;;

    [nN][oO]|[nN])
        exit 1;
        ;;

    *)
        ;;
esac

if [ -n "$oneFile" ]; then
    dd if=/dev/urandom of=$oneFile bs=$(wc -c $oneFile | awk '{print $1}') count=1
    rm -rf $oneFile
    exit;
fi

for file in $(find $dir -type f); do
    echo $file
    dd if=/dev/urandom of=$file bs=$(wc -c $file | awk '{print $1}') count=1
    rm -rf $file
done

rm -rf $dir
printf "\033[31m[$dir] has been safe deleted. \033[0m\n"
