PROPS=gradle.properties
LIB_SRC=libsrc
LIB_LIST=`grep _LIB_VERSION $PROPS`
echo $LIB_LIST
for n in $LIB_LIST
do
    echo "parse lib..."
    NAME=`echo ${n/_LIB_VERSION=*/} |  tr [:upper:] [:lower:]`
    echo name=[$NAME]
    DIR=`echo ${NAME/_/-}`
    echo dir=[$DIR]
    if [ -d $DIR ]
    then
        rm -f $DIR
    fi
    if [ -L $DIR ]
    then
        rm $DIR
    fi
    echo ""
done
rm -rf $LIB_SRC
