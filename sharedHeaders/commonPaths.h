#ifndef COMMONPATH_H
#define COMMONPATH_H

#include <QString>
#include <QDir>
#include <QStandardPaths>

namespace FKUtility {
    QDir dataDir(){
        return QDir(QStandardPaths::locate(QStandardPaths::AppDataLocation, "data", QStandardPaths::LocateDirectory));
    }
    QDir dlcDir(){
        return QDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/dlc");
    }
    QDir storageDir(){
        return QDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/storage");
    }
}

#endif // COMMONPATH_H
