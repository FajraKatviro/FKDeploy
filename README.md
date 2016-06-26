Simple multiplatform toolset for install packages creation

Usage:

1. Check your qt project file contain following variables:
  * DESTDIR (Qt-defined)
  * VERSION (Qt-defined)
  * ICON (Qt-defined, path to icon image)
  * PRODUCT (defines package name)
  * ORGANIZATION (defines package maintainer)
  * LICENSE (path to license file)
  * DEPLOY_BUILD_FOLDER (path where distributable package would build)
  * UPGRADE_CODE (GUID for app version, used by WIX, windows only)
2. Include fkdeploy.pri to your .pro file
3. Add build step 'make deploy'

Currently avaliable for platforms:
  - None
