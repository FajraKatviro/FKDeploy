
isEmpty(FK_IOS_PLIST){
    warning("FK_IOS_PLIST path is not set")
}

isEmpty(FK_MOBILE_ICONS){
    warning("FK_MOBILE_ICONS path is not set")
}

isEmpty(FK_MOBILE_SPLASH_SCREENS){
    ios{
        FK_MOBILE_SPLASH_SCREENS = $$PWD/ios_splashScreen
    }
    android{
        FK_MOBILE_SPLASH_SCREENS = $$PWD/android_splashScreen
    }
    warning("FK_MOBILE_SPLASH_SCREENS path is not set, default splash screens used")
}

ios{
    QMAKE_INFO_PLIST = $$FK_IOS_PLIST

    QMAKE_IOS_DEPLOYMENT_TARGET = 7.0

    ios_icon.files = $$files($$FK_MOBILE_ICONS/AppIcon*.png) $$files($$FK_MOBILE_ICONS/iTunesArtwork*)
    QMAKE_BUNDLE_DATA += ios_icon

    app_launch_images.files = $$files($$FK_MOBILE_SPLASH_SCREENS/LaunchImage*.png)
    QMAKE_BUNDLE_DATA += app_launch_images
}

android{
    android_icon.files = $$FK_MOBILE_ICONS/mipmap*
    android_icon.path = $$ANDROID_PACKAGE_SOURCE_DIR/res
    INSTALLS += android_icon

    app_launch_images.files = $$FK_MOBILE_SPLASH_SCREENS/drawable*
    app_launch_images.path = $$ANDROID_PACKAGE_SOURCE_DIR/res
    INSTALLS += app_launch_images
}
