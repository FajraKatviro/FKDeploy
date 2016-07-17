#!/bin/bash

TARGET=$1
DESTDIR=$2
TOOLS_PATH=$3
SRC_PATH=$4

if [ -z "$DESTDIR" ]
  then
    exit 1
fi

#create subfolders
mkdir -p "$DESTDIR/libs"
mkdir -p "$DESTDIR/platforms"

#copy platform plugin
cp -v "$QTDIR/plugins/platforms/libqxcb.so" "$DESTDIR/platforms"

#copy other plugins
cp -R -v "$QTDIR/plugins/imageformats" "$DESTDIR"
cp -R -v "$QTDIR/plugins/bearer" "$DESTDIR"
cp -R -v "$QTDIR/plugins/iconengines" "$DESTDIR"
cp -R -v "$QTDIR/plugins/xcbglintegrations" "$DESTDIR"

#copy shared libraries
ldd "$DESTDIR/$TARGET" | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' "$DESTDIR/libs"

#copy additional libs
cp -v "$QTDIR/lib/libQt5Widgets.so.5" "$DESTDIR/libs"
cp -v "$QTDIR/lib/libQt5Network.so.5" "$DESTDIR/libs"
cp -v "$QTDIR/lib/libQt5Qml.so.5" "$DESTDIR/libs"
cp -v "$QTDIR/lib/libQt5Quick.so.5" "$DESTDIR/libs"
cp -v "$QTDIR/lib/libQt5Svg.so.5" "$DESTDIR/libs"
cp -v "$QTDIR/lib/libQt5DBus.so"* "$DESTDIR/libs"
cp -v "$QTDIR/lib/libQt5XcbQpa.so"* "$DESTDIR/libs"

#create runner script
cp -v "$(dirname $0)/nixRun.sh" "$DESTDIR/$TARGET.sh"

#copy qml imports
if ! [ -z "$SRC_PATH" ]
  then
      QMLIMPORTS=$(mktemp)
      "$QTDIR/bin/qmlimportscanner" -rootPath "$SRC_PATH" -importPath "$QTDIR/qml" > "$QMLIMPORTS"
      "$TOOLS_PATH/DeployQML" --json "$QMLIMPORTS" --qml "$QTDIR/qml" "$DESTDIR"
fi


