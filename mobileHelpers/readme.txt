
mobile helpers
iOS >= 7.0 required
android >= 4.4 recommended 
Use for fast & easy app icon & splash screen setup

1. Use info.plist template, replace TARGET with executable name
2. Use ImageManager to create icon & splash screen sets from given image
3. Add variables to project file:
  * FK_IOS_PLIST - path/to/info.plist
  * FK_MOBILE_ICONS - path/to/icons/folder
  * FK_MOBILE_SPLASH_SCREENS - path/to/splashscreens/folder
4. Include FKDeploy_mobile.pri to project file
