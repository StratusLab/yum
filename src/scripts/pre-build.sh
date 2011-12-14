#!/bin/sh -xe

echo "PRE BUILD"

# Force repository back to master.
git checkout ${GIT_BRANCH}
git pull

# Update to use latest versions.
mvn versions:use-latest-versions
mvn versions:commit

# Push any changes back into repository.
git add . 
git commit -m "update dependency versions" || echo "NOTHING TO COMMIT"
git push
