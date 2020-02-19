#!/bin/bash

git status;

commitText="update";
if [ -n "$1" ]; then
    commitText=$1;
fi

echo "=======" $commitText "========";
git add .;
git commit -m $commitText;
git push origin master;
