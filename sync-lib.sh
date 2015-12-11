#!/bin/bash
LIB_SRC=libsrc

LIB_NAME=$1
LIB_REPO=$2
LIB_BRANCH=$3
LIB_HASH=$4
echo "sync lib $LIB_NAME $LIB_REPO $LIB_BRANCH $LIB_HASH"

WORKING_DIR=`pwd`
echo "[working dir:> `pwd`"

if  [ ! -d $LIB_SRC ]
then
    echo "mkdir $LIB_SRC"
    mkdir $LIB_SRC
fi

if [ -z $LIB_REPO ]
then
    echo "!!! No Repo Url !!!"
    exit 1
fi

if [ -z $LIB_NAME ]
then
    echo "!!! No Lib Name !!!"
    exit 1
fi

if [ -z $LIB_BRANCH ]
then
    echo "no branch, using master branch"
    LIB_BRANCH=master
fi

if [ ! -d $LIB_NAME ] && [ ! -L $LIB_NAME ]
then
    cd $LIB_SRC
    echo "[working dir:> `pwd`"
    if [ ! -d $LIB_NAME ]
    then
        echo "start clone $LIB_NAME..."
        git clone $LIB_REPO $LIB_NAME
    fi
    if [ ! -d $LIB_NAME/$LIB_NAME ]
    then
        echo "!!! Wrong Lib Path !!!"
    else
        echo "create link for $LIB_NAME"
        ln -s $WORKING_DIR/$LIB_SRC/$LIB_NAME/$LIB_NAME ../$LIB_NAME
    fi
    cd $WORKING_DIR
    echo "[working dir:> `pwd`"
fi

echo "start sync lib $LIB_NAME..."

cd $WORKING_DIR/$LIB_SRC/$LIB_NAME
echo "[working dir:> `pwd`"
echo "start fetch origin..."
git fetch origin
echo "switch branch $LIB_BRANCH..."
git checkout $LIB_BRANCH
if [ -n $LIB_HASH ]
then
    echo "check HEAD $LIB_HASH..."
    git checkout $LIB_HASH -b br-$LIB_HASH
    echo "using latest HEAD"
fi
cd $WORKING_DIR
echo "[working dir:> $WORKING_DIR"

IGNORE=`grep $LIB_NAME .gitignore`
if [ -z $IGNORE ]
then
    echo "add git ignore"
    echo $LIB_NAME >> .gitignore
fi

#SETTINGS=`grep $LIB_NAME settings.gradle`
#if [ -z $SETTINGS ]
#then
#    echo "add lib to settings.gradle"
#    echo -e "include ':$LIB_NAME'\n$(cat settings.gradle)" > settings.gradle
#fi

cd $WORKING_DIR
echo "[working dir:> `pwd`"
echo "quit"
