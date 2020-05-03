#!/bin/bash

set -e

echo -e "### :calendar: $(date +%d/%m/%Y)\n" >> /tmp/updated-history.md

ADDED_TIL_FILES=$(git status -s --porcelain | grep 'A  ' | sed -e 's/A[[:space:]]*//')
for file in $ADDED_TIL_FILES
do
    category=$(echo $file | cut -d "/" -f1)
    description=$(head -n1 $file | sed -e 's/## //')
    url="https://github.com/danielSbastos/til/blob/master/${file}"
    echo "- [(${category}) ${description}](${url})" >> /tmp/updated-history.md
done

echo -e "\n----------------------------\n" >> /tmp/updated-history.md

touch HISTORY.md
cat HISTORY.md >> /tmp/updated-history.md
mv /tmp/updated-history.md HISTORY.md
