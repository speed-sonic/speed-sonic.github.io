#!/bin/bash

git add .;
commitText="update";
if [ -n "$1" ]; then
    commitText=$1;
fi

git commit -m $commitText;
git push origin master;
