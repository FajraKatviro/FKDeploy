#ifndef COMMONPATH_H
#define COMMONPATH_H

#include <QString>
#include <QDir>
#include <QStandardPaths>

namespace FKUtility {
    QDir dataDir(){
        QString path(QStandardPaths::locate(QStandardPaths::AppDataLocation, "data", QStandardPaths::LocateDirectory));
        if(path.isEmpty())
            path="./data";
        return QDir(path);
    }
    QDir dlcDir(){
        return QDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/dlc");
    }
    QDir storageDir(){
        return QDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/storage");
    }
}

#endif // COMMONPATH_H
