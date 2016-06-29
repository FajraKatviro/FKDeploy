Simple multiplatform tool for install package creation.

Usage:

1. Check your qt project file contain following variables:
  * DESTDIR (Qt-defined)
  * VERSION (Qt-defined)
  * ICON (Qt-defined, path to icon image for unix systems)
  * RC_ICONS (Qt-defined, path to icon image for windows systems, ICO required)
  * QMAKE_TARGET_PRODUCT (defines package name)
  * QMAKE_TARGET_COMPANY (defines package maintainer)
  * LICENSE (path to license file, RTF required by WIX)
  * DEPLOY_BUILD_FOLDER (path where distributable package would build)
  * UPGRADE_CODE (GUID for app version, used by WIX, windows only)
2. Include fkdeploy.pri to your .pro file
3. Add build step 'make deploy'

Work description:
First, calls qt deploy tool to add dependencies.
After that compresses all contents of DESTDIR to a single package.
All stuff and output files are placed in DEPLOY_BUILD_FOLDER.

Also you can use helper function to apply project settings to application instance in main() function (defined in FKProjectHelper.h)

Currently avaliable for platforms:
  - Windows (WIX required)
