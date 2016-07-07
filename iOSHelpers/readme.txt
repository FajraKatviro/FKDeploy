
iOS helpers
iOS >= 7.0 required
Use for fast & easy app icon & splash screen setup

1. Use info.plist template, replace TARGET with executable name
2. Use ImageManager to create icon & splash screen sets from given image
3. Add variables to project file:
  * QMAKE_INFO_PLIST - path/to/info.plist
  * FK_IOS_ICONS - path/to/icons/folder
  * FK_IOS_SPLASH_SCREENS - path/to/splashscreens/folder
4. Include FKDeploy_iOS.pri to project file
