
isEmpty(QMAKE_INFO_PLIST){
    error("QMAKE_INFO_PLIST path is not set")
}

isEmpty(FK_IOS_ICONS){
    error("FK_IOS_ICONS path is not set")
}

isEmpty(FK_IOS_SPLASH_SCREENS){
    error("FK_IOS_SPLASH_SCREENS path is not set")
}

ios{
    QMAKE_IOS_DEPLOYMENT_TARGET = 7.0

    ios_icon.files = $$files($$FK_IOS_ICONS/AppIcon@*.png) $$files($$FK_IOS_ICONS/iTunesArtwork*)
    QMAKE_BUNDLE_DATA += ios_icon

    app_launch_images.files = $$files($$FK_IOS_SPLASH_SCREENS/LaunchImage*.png)
    QMAKE_BUNDLE_DATA += app_launch_images
}
