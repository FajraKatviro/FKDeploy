
isEmpty(ICON){
        error("ICON variable not set, icon for unix platforms would be missed")
}
isEmpty(RC_ICONS){
        error("RC_ICONS variable not set, icon for windows platforms would be missed")
}
isEmpty(VERSION){
        error("VERSION varibale not set, application version information would be missed")
}
isEmpty(QMAKE_TARGET_COMPANY){
        error("QMAKE_TARGET_COMPANY varibale not set, maintainer information would be missed")
}
isEmpty(QMAKE_TARGET_PRODUCT){
        error("QMAKE_TARGET_PRODUCT varibale not set, application name information would be missed")
}

DEFINES += \
APP_VERSION=\"\\\"$$VERSION\\\"\" \
APP_MAINTAINER=\"\\\"$$QMAKE_TARGET_COMPANY\\\"\" \
APP_NAME=\"\\\"$$QMAKE_TARGET_PRODUCT\\\"\"
