#!/bin/bash
FORCE_TAG=false
VERSION=""
if [[ "$1" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]] ; then
    VERSION="$1"
else
    echo "Make sure you use release.sh <tag> [-f]' where <tag> has the following syntax:"
    echo "major.minor.patch -> example 1.2.3"
    echo "-f is optional and should be used when we want to re-tag an existent tag -> release.sh 1.2.3 -f"
    exit $?
fi

if [[ "$2" == "-f" ]] ; then
	FORCE_TAG=true
fi

if [ "$FORCE_TAG" = true ]; then
	echo "For moving tag: enabled"
else
	echo "For moving tag: disabled"
	PREVIOUS_TAG=$(git tag -l | grep "$1")
	if [[ "$PREVIOUS_TAG" == "$1" ]] ; then
		echo "$1 already exists, if you want to re-tag this version make sure you use -f"
		exit $?
	fi
fi

echo git reset --hard
git reset --hard

echo git clean -f -d
git clean -f -d
    
echo git checkout master
git checkout master

echo git fetch origin
git fetch origin
	
echo git reset --hard origin/master
git reset --hard origin/master
    
if [ "$FORCE_TAG" = true ]; then
    echo git tag -a $1 -m '$1' -f
    git tag -a $1 -m '$1' -f
else
    echo git tag -a $1 -m '$1'
    git tag -a $1 -m '$1'
fi
    
if [ "$FORCE_TAG" = true ]; then
    echo git push origin $1 -f
    git push origin $1 -f
else
    echo git push origin $1
    git push origin $1
fi

echo Finished releasing $1
