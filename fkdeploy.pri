
ATTRIBUTELIST =
ATTRIBUTELIST += NAME=$$PRODUCT
ATTRIBUTELIST += FOLDER=$$OUT_PWD
ATTRIBUTELIST += VERSION=$$VERSION
ATTRIBUTELIST += ICON=$$ICON
ATTRIBUTELIST += COMPANY=$$ORGANIZATION
ATTRIBUTELIST += LICENSE=$$LICENSE

DEPLOY_BUILD_CONFIG_FILE = $$DEPLOY_BUILD_FOLDER/buildConfig.txt

write_file(DEPLOY_BUILD_CONFIG_FILE,ATTRIBUTELIST)

deploy.commands += echo Build deploy package

win32{
    deploy.commands += $$PWD/winDeploy.bat $$DEPLOY_BUILD_CONFIG_FILE $$DEPLOY_BUILD_FOLDER
}else:mac{
    !ios{
        deploy.commands += $$PWD/macDeploy.sh $$DEPLOY_BUILD_CONFIG_FILE $$DEPLOY_BUILD_FOLDER
    }else{
        deploy.commands += echo Target not supported
    }
}else:!android{
    deploy.commands += $$PWD/nixDeploy.sh $$DEPLOY_BUILD_CONFIG_FILE $$DEPLOY_BUILD_FOLDER
}else{
    deploy.commands += echo Target not supported
}

QMAKE_EXTRA_TARGETS += deploy
