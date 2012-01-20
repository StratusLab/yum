#!/bin/sh -xe

echo "PRE BUILD"

git branch one-3.0 ${GIT_BRANCH}
git checkout one-3.0
git pull

# Update to use latest defined versions.
mvn versions:use-latest-versions
mvn versions:commit

# Push any changes back into repository.
git add . 
git commit -m "update dependency versions" || echo "NOTHING TO COMMIT"
git push
