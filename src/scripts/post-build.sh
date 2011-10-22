#!/bin/sh -xe

echo "POST BUILD"

YUM_LOCATION_OLD=${YUM_LOCATION}-OLD

if [ -d $YUM_LOCATION ]; then
  mv $YUM_LOCATION $YUM_LOCATION_OLD
fi

mkdir -p $YUM_LOCATION

mv ./target/yum/* $YUM_LOCATION

if [ -d $YUM_LOCATION_OLD ]; then
  rm -Rf $YUM_LOCATION_OLD
fi
