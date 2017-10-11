#!/bin/bash
###############################
# Release Notes               #
###############################
if [ -n "$1" ]; then
    OLD_GIT_TAG=$1
    if [ -n "$2" ]; then
        NEW_GIT_TAG=$2
    else
        echo "Make sure you use release_notes.sh <old_tag> <new_tag>' where <*_tag> has the following syntax:"
        echo "<*_tag> -> major.minor.patch -> examples 1.2.3 -> ./release_notes.sh 1.4.4 1.4.5"
        echo "<*_tag> -> can also be a SHA -> example 0915fe27c3af54fda7b9d0f79f79a6b4b8a0f7cf -> ./release_notes.sh 0915fe27c3af54fda7b9d0f79f79a6b4b8a0f7cf 1.4.5"
        exit $?
    fi
else
    echo "Make sure you use release_notes.sh <old_tag> <new_tag>' where <*_tag> has the following syntax:"
    echo "<*_tag> -> major.minor.patch -> examples 1.2.3 -> ./release_notes.sh 1.4.4 1.4.5"
    echo "<*_tag> -> can also be a SHA -> example 0915fe27c3af54fda7b9d0f79f79a6b4b8a0f7cf -> ./release_notes.sh 0915fe27c3af54fda7b9d0f79f79a6b4b8a0f7cf 1.4.5"
    exit $?
fi
ALL_NOTES="## [What's New](https://github.com/$ORGANIZATION/$REPOSITORY/compare/$OLD_GIT_TAG...$NEW_GIT_TAG)\r\n\r\nCommit | Author | Card | Type | Title\r\n------------ | ------------- | ------------- | ------------- | -------------\r\n"
RELEASE_NOTES=$(git log --no-merges --pretty=format:"{\"abbreviated_commit_hash\":\"%h\", \"commit_hash\":\"%H\", \"author_name\":\"%an\", \"subject\":\"%s\"}" $OLD_GIT_TAG...$NEW_GIT_TAG)
echo "$RELEASE_NOTES" |
(
    while read line
    do
        echo "$line"
        NOTES_LINE=$(echo "")
        ABBREVIATED_COMMIT_HASH=$(echo "$line" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["abbreviated_commit_hash"]')
        COMMIT_HASH=$(echo "$line" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["commit_hash"]')
        AUTHOR_NAME=$(echo "$line" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["author_name"]')
        SUBJECT=$(echo "$line" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["subject"]')
        #Strip Owner Information
        SUBJECT=$(echo "$SUBJECT" | sed -E 's/^\[([A-Z]|,|\/|\\|[ ])*\][ ]*//' | sed 's/\[NOSTORY\][ ]*//')
        STORIES=$(echo "$SUBJECT" | sed -E 's/.*\[(([0-9]|,|\/|\\|[ ]|#)*)\].*/\1/' | sed 's/#//g' | sed -E 's/(,|[ ]|\\|\/)/;/g' | sed -E 's/([a-zA-Z]|\.)//g')
        STORIES=$(echo "${STORIES//\*}")
        echo "STORIES=$STORIES"
        #Strip Story information
        SUBJECT=$(echo "$SUBJECT" | sed -E 's/(.*)\[(([0-9]|,|\/|\\|[ ]|#)*)\][ ]*(.*)/\1\4/')
        NOTES_LINE=$(echo "$NOTES_LINE[$ABBREVIATED_COMMIT_HASH](https://github.com/$ORGANIZATION/$REPOSITORY/commit/$COMMIT_HASH)|$AUTHOR_NAME")
        
        STORY_LINKS=""
        STORY_TYPES=""
        array=(${STORIES//;/ })
        for i in "${!array[@]}"
        do
            echo "$i=>${array[i]}"
            echo curl -H "Authorization: Basic $LEANKIT_TOKEN" -H "Content-Type: application/json" "https://rentpath.leankit.com/io/card/${array[i]}"
            LEANKIT_RESPONSE=$(curl -H "Authorization: Basic $LEANKIT_TOKEN" -H "Content-Type: application/json" "https://rentpath.leankit.com/io/card/${array[i]}")
            if [ -n "$LEANKIT_RESPONSE" ]; then
                if [ -z "$STORY_TYPES" ]; then
                    STORY_TYPES=$(echo "$LEANKIT_RESPONSE" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["type"]["title"]')
                else
                    TMP_STORY_TYPE=$(echo "$LEANKIT_RESPONSE" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["type"]["title"]')
                    STORY_TYPES=$(echo $STORY_TYPES, $TMP_STORY_TYPE)
                fi
                if [ -z "$STORY_LINKS" ]; then
                	STORY_LINKS=$(echo "[${array[i]}](https://rentpath.leankit.com/card/${array[i]})")
                else
                	STORY_LINKS=$(echo "$STORY_LINKS, [${array[i]}](https://rentpath.leankit.com/card/${array[i]})")
                fi
            fi
        done
        
      	if [ -z "$STORY_TYPES" ]; then
            STORY_TYPES=$(echo "None")
        else
            STORY_TYPES=$(echo "$STORY_TYPES")
        fi
        
        if [ -z "$STORY_LINKS" ]; then
            STORY_LINKS=$(echo "No Story")
        else
            STORY_LINKS=$(echo "$STORY_LINKS")
        fi
        
        NOTES_LINE=$(echo "$NOTES_LINE|$STORY_LINKS|$STORY_TYPES|$SUBJECT\r\n")
        
        #echo "STORIES=$STORIES"
        #echo "STORY_TYPES=$STORY_TYPES"
        #echo "ABBREVIATED_COMMIT_HASH=$ABBREVIATED_COMMIT_HASH"
        #echo "COMMIT_HASH=$COMMIT_HASH"
        #echo "AUTHOR_NAME=$AUTHOR_NAME"
        #echo NOTES_LINE=$NOTES_LINE
        ALL_NOTES=$(echo "$ALL_NOTES$NOTES_LINE")
    done
    ALL_NOTES=$(echo "$ALL_NOTES" | sed 's/\"/\\\"/')
    #echo ALL_NOTES=$ALL_NOTES
    echo '{"tag_name":'\"$NEW_GIT_TAG\"',"prerelease":true,"name":'\"$NEW_GIT_TAG\"',"body":'\""$ALL_NOTES"\"'}' >notes.json
    cat notes.json
    PREVIOUS_RELEASE=$(curl -H "Authorization: token $GITHUB_ACCESS_TOKEN" https://api.github.com/repos/$ORGANIZATION/$REPOSITORY/releases/tags/$NEW_GIT_TAG | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["id"]')
    if [ -n "$PREVIOUS_RELEASE" ]; then
    	if [ "$PREVIOUS_RELEASE" != "None" ]; then
            curl -X PATCH -H "Authorization: token $GITHUB_ACCESS_TOKEN" -d @notes.json https://api.github.com/repos/$ORGANIZATION/$REPOSITORY/releases/$PREVIOUS_RELEASE
        fi
    else
        curl -X POST -H "Authorization: token $GITHUB_ACCESS_TOKEN" -H "Content-Type: application/json" -d @notes.json https://api.github.com/repos/$ORGANIZATION/$REPOSITORY/releases
    fi
    rm notes.json
)
