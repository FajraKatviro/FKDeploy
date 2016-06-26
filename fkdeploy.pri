
ATTRIBUTELIST =
ATTRIBUTELIST += NAME=$$PRODUCT
ATTRIBUTELIST += FOLDER=$$DESTDIR
ATTRIBUTELIST += VERSION=$$VERSION
ATTRIBUTELIST += ICON=$$ICON
ATTRIBUTELIST += COMPANY=$$ORGANIZATION
ATTRIBUTELIST += LICENSE=$$LICENSE

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
