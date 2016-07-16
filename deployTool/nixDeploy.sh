#!/bin/bash

CONFIG_FILE=$1
PACKAGE_BUILD_PATH=$2

if [ -z "$PACKAGE_BUILD_PATH" ]
  then
    exit 1
fi

#read config file
while IFS= read -r line; do
    line=${line%%#*}  # strip comment (if any)
    case $line in
      *=*)
        var=${line%%=*}
        case $var in
          *[!A-Z_a-z]*)
            echo "Warning: invalid variable name $var ignored" >&2
            continue;;
        esac
        if eval '[ -n "${'$var'+1}" ]'; then
          echo "Warning: variable $var already set, redefinition ignored" >&2
          continue
        fi
        line=${line#*=}
        eval $var='"$line"'
    esac
done <"$CONFIG_FILE"

#create build folders
mkdir -p "$PACKAGE_BUILD_PATH/deb/opt/$TARGET"

#copy templates
cp -R "$(dirname $0)/DEBIAN" "$PACKAGE_BUILD_PATH/deb"
mkdir -p "$PACKAGE_BUILD_PATH/deb/usr/share/applications"
cp -R "$(dirname $0)/target.desktop" "$PACKAGE_BUILD_PATH/deb/usr/share/applications/$TARGET.desktop"

#fill template
sed -i "s/{NAME}/${NAME}/g" "$PACKAGE_BUILD_PATH/deb/DEBIAN/control"
sed -i "s/{VERSION}/${VERSION}/g" "$PACKAGE_BUILD_PATH/deb/DEBIAN/control"
sed -i "s/{COMPANY}/${COMPANY}/g" "$PACKAGE_BUILD_PATH/deb/DEBIAN/control"
sed -i "s/{SHORT_DESCRIPTION}/${SHORT_DESCRIPTION}/g" "$PACKAGE_BUILD_PATH/deb/DEBIAN/control"
while IFS='' read -r line
do
    echo " $line" >> "$PACKAGE_BUILD_PATH/deb/DEBIAN/control"
    echo " ." >> "$PACKAGE_BUILD_PATH/deb/DEBIAN/control"
done < "$LONG_DESCRIPTION"
sed -i "s/{TARGET}/${TARGET}/g" "$PACKAGE_BUILD_PATH/deb/usr/share/applications/$TARGET.desktop"
sed -i "s/{NAME}/${NAME}/g" "$PACKAGE_BUILD_PATH/deb/usr/share/applications/$TARGET.desktop"
sed -i "s/{VERSION}/${VERSION}/g" "$PACKAGE_BUILD_PATH/deb/usr/share/applications/$TARGET.desktop"
sed -i "s/{SHORT_DESCRIPTION}/${SHORT_DESCRIPTION}/g" "$PACKAGE_BUILD_PATH/deb/usr/share/applications/$TARGET.desktop"

#copy content
cp "$LICENSE" "$PACKAGE_BUILD_PATH/deb/DEBIAN/copyright"
cp -R "$FOLDER/." "$PACKAGE_BUILD_PATH/deb/opt/$TARGET"

#copy icon
mkdir -p "$PACKAGE_BUILD_PATH/deb/usr/share/icons/hicolor/128x128/apps"
cp "$INSTALL_ICON" "$PACKAGE_BUILD_PATH/deb/usr/share/icons/hicolor/128x128/apps/$TARGET.png"

#strip binary
#find "$PACKAGE_BUILD_PATH/deb/opt" -type f | xargs strip --strip-debug #not working


#calculate hashsum
cd "$PACKAGE_BUILD_PATH/deb"
md5deep -rl opt > "DEBIAN/md5sums"
cd -


#build deb-pack
fakeroot dpkg-deb --build "$PACKAGE_BUILD_PATH/deb" "$PACKAGE_BUILD_PATH"

#lintian "$PACKAGE_BUILD_PATH/$(echo ${NAME}_${VERSION}_amd64.deb | tr '[:upper:]' '[:lower:]')" #a lot of errors
