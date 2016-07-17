
FK_TOOLS_FOLDER =

QMAKE_SPEC_T = $$[QMAKE_SPEC]

contains(QMAKE_SPEC_T,.*win32.*){
    FK_TOOLS_FOLDER = $$system_path($$(APPDATA)/FKTools)
}

contains(QMAKE_SPEC_T,.*macx.*){
    FK_TOOLS_FOLDER = "/$$(HOME)/Applications/FKTools"
}

contains(QMAKE_SPEC_T,.*linux.*){
    FK_TOOLS_FOLDER = "/$$(HOME)/FKTools"
}

export(FK_TOOLS_FOLDER)
