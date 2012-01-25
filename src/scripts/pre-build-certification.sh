#!/bin/sh -xe

echo "PRE BUILD"

# Force repository back to master.
git checkout ${GIT_BRANCH}
git pull

# Replace SNAPSHOT versions.
#sed 's%<version>.*-SNAPSHOT</version>%<version>0.0</version>%' pom.xml > pom2.xml
#mv -f pom2.xml pom.xml

# Update to use latest defined versions.
mvn versions:use-latest-releases -DgenerateBackupPoms=false

