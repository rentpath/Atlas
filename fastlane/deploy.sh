if [ "$BITRISE_GIT_BRANCH" == "master" ]; then
	sleep 5
	
	git config --global user.email "builduser@cibuild.com"
	git config --global user.name "build user"

	export OLD_GIT_TAG=$(git tag --sort version:refname | tail -n1)
	export NEW_GIT_TAG=$(echo $OLD_GIT_TAG | (IFS=".$IFS" ; read a b c && echo $a.$b.$((c + 1))))

	git tag $NEW_GIT_TAG -a -m "Generated tag $NEW_GIT_TAG"
	git push --quiet https://$GITHUB_ACCESS_TOKEN@github.com/$ORGANIZATION/$REPOSITORY $NEW_GIT_TAG > /dev/null 2>&1;
	
	./release_notes.sh $OLD_GIT_TAG $NEW_GIT_TAG;
fi
