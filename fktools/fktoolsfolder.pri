
FK_TOOLS_FOLDER =

win32{
    FK_TOOLS_FOLDER = "$(APPDATA)/FKTools"
}

mac{
    FK_TOOLS_FOLDER = "/$(HOME)/Applications/FKTools"
}

export(FK_TOOLS_FOLDER)
