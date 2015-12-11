#!/bin/bash
PROPS=gradle.properties
LIB_LIST=`grep _LIB_VERSION $PROPS`
echo $LIB_LIST
for n in $LIB_LIST
do
    echo "parse lib..."
    NAME=`echo ${n/_LIB_VERSION=*/}`
    echo name=[$NAME]

    TMP=`grep ${NAME}_LIB_VERSION $PROPS`
    VERSION=`echo ${TMP/${NAME}_LIB_VERSION=/}`
    echo version=[$VERSION]

    TMP=`grep ${NAME}_LIB_LINK $PROPS`
    LINK=`echo ${TMP/${NAME}_LIB_LINK=/}`
    echo link=[$LINK]

    TMP=`grep ${NAME}_LIB_REPO $PROPS`
    REPO=`echo ${TMP/${NAME}_LIB_REPO=/}`
    echo repo=[$REPO]

    TMP=`grep ${NAME}_LIB_BRANCH $PROPS`
    BRANCH=`echo ${TMP/${NAME}_LIB_BRANCH=/}`
    echo branch=[$BRANCH]

    TMP=`grep ${NAME}_LIB_HASH $PROPS`
    HASH=`echo ${TMP/${NAME}_LIB_HASH=/}`
    echo hash=[$HASH]

    LIB_NAME=`echo ${NAME/_/-}`
    LIB_NAME=`tr '[A-Z]' '[a-z]' <<<"$LIB_NAME"`
    echo name=[$LIB_NAME]

    if [ $LINK = "git" ]
    then
        ./sync-lib.sh $LIB_NAME $REPO $BRANCH $HASH $AUTOCLEAN
    fi

    echo ""
done
