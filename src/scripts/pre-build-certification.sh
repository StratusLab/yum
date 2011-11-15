#!/bin/sh -xe

echo "PRE BUILD"

# Force repository back to master.
git checkout ${GIT_BRANCH}

# Replace SNAPSHOT versions.
sed -i '' 's%<version>.*-SNAPSHOT</version>%<version>0.0</version>%' pom.xml

# Update to use latest defined versions.
mvn versions:use-latest-releases -DgenerateBackupPoms=false

