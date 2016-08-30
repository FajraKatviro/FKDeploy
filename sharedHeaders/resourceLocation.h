#ifndef RESOURCELOCATION_H
#define RESOURCELOCATION_H

#include <QString>
#include <QMap>
#include <QDir>
#include <QFileInfo>
#include <QResource>

#include "commonPaths.h"

namespace FKUtility {
    struct ResourceLocator{
        ResourceLocator(const QString& package=QString("universalResources")):_package(package){
            read(dataDir());
            read(dlcDir());
        }
        inline QString pacakge()const{
            return _package;
        }
        inline QMap<QString,QString> resourceFiles()const{
            return _resources;
        }


        enum Result{
            loadingSuccess,
            resourceNotFound,
            loadingFailed
        };
        Result load(const QString& resource)const{
            auto i=_resources.constFind(resource + ".rcc");
            if(i==_resources.constEnd()){
                return resourceNotFound;
            }
            if(!QResource::registerResource(i.value())){
                return loadingFailed;
            }
            return loadingSuccess;
        }
    private:
        void read(QDir dir){
            if(!dir.cd(_package))
                return;
            QFileInfoList resourceFiles=dir.entryInfoList(QDir::Files);
            foreach(QFileInfo resourceFile,resourceFiles){
                _resources[resourceFile.fileName()]=resourceFile.canonicalFilePath();
            }
        }
        const QString _package;
        QMap<QString,QString> _resources;
    };
}

#endif // RESOURCELOCATION_H
