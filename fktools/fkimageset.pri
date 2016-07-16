
include(fktoolsfolder.pri)

isEmpty(ART_FOLDER){
    error("ART_FOLDER is not set")
}
isEmpty(ART_BUILD_FOLDER){
    error("ART_BUILD_FOLDER is not set")
}

ART_DEPLOY_FOLDER =

!mac:!android{ # win/linux
    ART_DEPLOY_FOLDER = "$$DESTDIR/data"
}

mac{
    !isEmpty(QMAKE_POST_LINK): QMAKE_POST_LINK += ";"
    ios{
        QMAKE_POST_LINK += \
            "cp -r $$ART_BUILD_FOLDER/bin/* $CODESIGNING_FOLDER_PATH/Library/Application Support/data/"
    }else{
        QMAKE_POST_LINK += \
            "cp -r $$ART_BUILD_FOLDER/bin/* $$DESTDIR/$${TARGET}.app/Contents/Resources/data"
    }
}

imagesets.commands =   "$$FK_TOOLS_FOLDER/PackageManager" "$$ART_FOLDER" --dir $$escape_expand(\n\t) \
                       "$$FK_TOOLS_FOLDER/PackageGenerator"  "$$ART_FOLDER" "$$ART_BUILD_FOLDER" $$ART_DEPLOY_FOLDER --clean --add --qrc --rcc --dir $$escape_expand(\n\t)
#Note: missing no quotes around ART_DEPLOY_FOLDER is not a bug

first.depends += qmake

QMAKE_EXTRA_TARGETS += first imagesets
