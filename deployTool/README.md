Simple multiplatform tool for install package creation.

Usage:

1. Check your qt project file contain following variables:
  * DESTDIR (Qt-defined)
  * VERSION (Qt-defined)
  * ICON (Qt-defined, path to *.icns for mac systems, or to 128x128 sized *.png for linux systems)
  * RC_ICONS (Qt-defined, path to icon image for windows systems, *.ico required)
  * QMAKE_TARGET_PRODUCT (defines package name)
  * QMAKE_TARGET_COMPANY (defines package maintainer)
  * LICENSE (path to license file, RTF required by WIX)
  * DEPLOY_BUILD_FOLDER (path where distributable package would build)
  * UPGRADE_CODE (GUID for app version, used by WIX, windows only)
  * SHORT_DESCRIPTION (description text, used by dpkg-deb, linux only)
  * LONG_DESCRIPTION (path to text file with description, used to create long description for dpkg-deb, linux only)
2. Include fkdeploy.pri to your .pro file
3. Add build step 'make deploy'

Work description:
First, calls qt deploy tool to add dependencies.
After that compresses all contents of DESTDIR to a single package.
All stuff and output files are placed in DEPLOY_BUILD_FOLDER.

Also you can use helper function to apply project settings to application instance in main() function (defined in FKProjectHelper.h)

Currently avaliable for platforms:
  - Windows (WIX required)
  - Mac OS (simple dmg only)
  - Ubuntu (dpkg, lintian, md5deep packages required)

Release notes:

  1. Mac dmg does not contain any decorations and icon, this shoul be fixed later
  2. Linux deploy step is terrible and I need help to improve it. Also, lintian shows a lot of errors and it is disabled now. Please, contact me to deal with it.
