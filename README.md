Simple multiplatform tool for install package creation.

Usage:

1. Check your qt project file contain following variables:
  * DESTDIR (Qt-defined)
  * VERSION (Qt-defined)
  * INSTALL_ICON (path to icon image, ICO required by WIX)
  * PRODUCT (defines package name)
  * ORGANIZATION (defines package maintainer)
  * LICENSE (path to license file, RTF required by WIX)
  * DEPLOY_BUILD_FOLDER (path where distributable package would build)
  * UPGRADE_CODE (GUID for app version, used by WIX, windows only)
2. Include fkdeploy.pri to your .pro file
3. Add build step 'make deploy'

Work description:
First, calls qt deploy tool to add dependencies.
After that compresses all contents of DESTDIR to a single package.
All stuff and output files are placed in DEPLOY_BUILD_FOLDER.

Currently avaliable for platforms:
  - Windows (WIX required)
