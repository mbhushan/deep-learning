#!/bin/bash
# Find biggest files from a Git repository
# See http://progit.org/book/ch9-7.html

MAX_FILES=20
LINES=`git verify-pack -v .git/objects/pack/pack-*.idx | grep blob | sort -k 3 -n | tail -${MAX_FILES}`

IFS=$'\n'
for LINE in $LINES
do
    SHA=`echo $LINE | awk '{print $1}'`
    SIZE=`echo $LINE | awk  '{print $3}'`
    FILE=`git rev-list --objects --all | grep $SHA | awk '{print $2}'`
    printf '%.8s... %-10d %s\n' $SHA $SIZE $FILE
done
