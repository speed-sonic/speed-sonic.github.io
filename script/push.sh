#!/bin/bash

gitPush() {
    git add .;
    git commit -m "$1";
    git push origin master;
}

git status;

echo -e "\n"
read -p "Submit or not? (y|yes or other key): " isCommit;

if [[ "$isCommit" =~ ^(y|yes)$ ]]; then
    read -p "Commit message: " commitText;
    if [ -z "$commitText" ]; then
        commitText="update";
    fi
    gitPush "$commitText";

    echo -e "\ndone."
fi
