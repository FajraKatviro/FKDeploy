#ifndef LOADIMAGESET_H
#define LOADIMAGESET_H

#include <QSize>
#include <QString>
#include <QResource>
#include <QStringList>
#include <QDir>
#include <QFileInfo>

#include "selectBestSizeset.h"

namespace FKUtility {
    bool loadImageset(const QString& imageset, const QSize& platformResolution){
        qDebug("load imageset %s", imageset.toLatin1().constData());
        QString resourceLocation(".");
#ifdef Q_OS_OSX
        resourceLocation="../Resources";
#endif
        QDir dir(resourceLocation+"/"+imageset);
        QFileInfoList resourceFiles=dir.entryInfoList(QStringList("*.rcc"));
        QList<QSize> avaliableSizes;
        foreach(QFileInfo resourceFile,resourceFiles){
            QStringList sizeInfo=resourceFile.completeBaseName().split('x');
            if(sizeInfo.size()!=2){
                qWarning("Invalid resource file");
                continue;
            }
            qint32 width=sizeInfo.at(0).toInt();
            qint32 height=sizeInfo.at(1).toInt();
            if(width<=0 || height<=0){
                qWarning("Invalid resource file");
                continue;
            }
            avaliableSizes.append(QSize(width,height));
        }
        QSize targetSize(selectBestSizeset(avaliableSizes,platformResolution));
        if(targetSize.isEmpty())return false;
        QString resourceFileName=QString("%1/%2/%3x%4.rcc").arg(resourceLocation).arg(imageset).arg(QString::number(targetSize.width())).arg(QString::number(targetSize.height()));
        return QResource::registerResource(resourceFileName);
    }
}

#endif // LOADIMAGESET_H
