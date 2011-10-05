#!/bin/bash 

for file in *.rpm ; do

  echo "FILE: ${file}"
  groupid='eu.stratuslab.externals'
  artifactid=`rpm -qp --qf "%{N}" ${file}`
  version=`rpm -qp --qf "%{V}-%{R}.%{ARCH}" ${file}`

  mvn deploy:deploy-file \
    -Dpackaging=rpm \
    -Durl=http://nexus.stratuslab.eu:8081/content/repositories/fedora-14-externals/ \
    -DrepositoryId=stratuslab.snapshots \
    -DgroupId=${groupid} \
    -DartifactId=${artifactid} \
    -Dversion=${version} \
    -Dfile=${file}

done
