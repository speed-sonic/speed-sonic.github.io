#!/bin/bash

git add .;
commitText="update";
if [ -n "$1" ]; then
    commitText=$1;
fi
echo "=======" commitText "========";
git commit -m $commitText;
git push origin master;
