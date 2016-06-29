
isEmpty(DESTDIR){
        error("DESTDIR variable not set, deploy tool would fail")
}
isEmpty(DEPLOY_BUILD_FOLDER){
        error("DEPLOY_BUILD_FOLDER variable not set, deploy tool would fail")
}
isEmpty(LICENSE){
        error("LICENSE variable not set, deploy for windows would fail")
}
isEmpty(UPGRADE_CODE){
        error("UPGRADE_CODE variable not set, deploy for windows would fail")
}

include(fkprojecthelper.pri)

win32{
    INSTALL_ICON = $$RC_ICONS
}else{
    INSTALL_ICON = $$ICON
}

ATTRIBUTELIST =
ATTRIBUTELIST += NAME=$$QMAKE_TARGET_PRODUCT
ATTRIBUTELIST += FOLDER=$$DESTDIR
ATTRIBUTELIST += VERSION=$$VERSION
ATTRIBUTELIST += INSTALL_ICON=$$INSTALL_ICON
ATTRIBUTELIST += COMPANY=$$QMAKE_TARGET_COMPANY
ATTRIBUTELIST += LICENSE=$$LICENSE
ATTRIBUTELIST += UPGRADE_CODE=$$UPGRADE_CODE
ATTRIBUTELIST += TARGET=$$TARGET

DEPLOY_BUILD_CONFIG_FILE = $$DEPLOY_BUILD_FOLDER/buildConfig.txt

!exists($$DEPLOY_BUILD_FOLDER){
    mkpath($$DEPLOY_BUILD_FOLDER)
}

write_file($$DEPLOY_BUILD_CONFIG_FILE,ATTRIBUTELIST)

win32{
    deploy.commands = windeployqt --no-translations --qmldir $$_PRO_FILE_PWD_ $$DESTDIR $$escape_expand(\n\t) \
        $$PWD/winDeploy.bat $$system_path($$DEPLOY_BUILD_CONFIG_FILE) $$system_path($$DEPLOY_BUILD_FOLDER)
}else:mac{
    !ios{
        deploy.commands = $$PWD/macDeploy.sh $$system_path($$DEPLOY_BUILD_CONFIG_FILE) $$system_path($$DEPLOY_BUILD_FOLDER)
    }else{
        deploy.commands = echo Target not supported
    }
}else:!android{
    deploy.commands = $$PWD/nixDeploy.sh $$system_path($$DEPLOY_BUILD_CONFIG_FILE) $$system_path($$DEPLOY_BUILD_FOLDER)
}else{
    deploy.commands = echo Target not supported
}

QMAKE_EXTRA_TARGETS += deploy
