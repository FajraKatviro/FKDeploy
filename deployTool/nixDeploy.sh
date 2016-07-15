#!/bin/bash

if [ -z "$2" ]
  then
    exit 1
fi

#create subfolders
mkdir -p "$2/libs"
mkdir -p "$2/platforms"

#copy platform plugin
cp -v "$QTDIR/plugins/platforms/libqxcb.so" "$2/platforms"

#copy other plugins
cp -R -v "$QTDIR/plugins/imageformats" "$2"
cp -R -v "$QTDIR/plugins/bearer" "$2"
cp -R -v "$QTDIR/plugins/iconengines" "$2"

#copy shared libraries
ldd "$1" | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' "$2/libs"

#copy additional libs
cp -v "$QTDIR/lib/libQt5Widgets.so.5" "$2/libs"
cp -v "$QTDIR/lib/libQt5Network.so.5" "$2/libs"
cp -v "$QTDIR/lib/libQt5Qml.so.5" "$2/libs"
cp -v "$QTDIR/lib/libQt5Quick.so.5" "$2/libs"
cp -v "$QTDIR/lib/libQt5Svg.so.5" "$2/libs"

#create runner script
cp -v "$(dirname $0)/nixRun.sh" "$1.sh"

if [ -z "$4" ]
  then
    exit 0
fi

#copy qml imports
QMLIMPORTS=$(mktemp)
"$QTDIR/bin/qmlimportscanner" -rootPath "$4" -importPath "$QTDIR/qml" > "$QMLIMPORTS"
"$3/DeployQML" --json "$QMLIMPORTS" --qml "$QTDIR/qml" "$2"

