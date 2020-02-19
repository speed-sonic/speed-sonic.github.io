#!/bin/bash

gitPush() {
    commitText=$1;
    echo "=======" $commitText "========";
    git add .;
    git commit -m $commitText;
    git push origin master;
}

git status;

echo -e "\n\nSubmit or not? (y|yes or other key)"
read isCommit;

if [[ "$isCommit" =~ ^(y|yes)$ ]]; then
    echo "Commit message:"
    read commitText;
    if [ -z "$commitText" ]; then
        commitText="update";
    fi
    gitPush $commitText;
fi
