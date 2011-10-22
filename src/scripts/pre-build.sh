#!/bin/sh -xe

# Force repository back to master.
git checkout ${GIT_BRANCH}

# Update to use latest defined versions.
mvn versions:use-latest-versions
mvn versions:commit

# Push any changes back into repository.
git add . 
git commit -m "update dependency versions" || echo "NOTHING TO COMMIT"
git push
