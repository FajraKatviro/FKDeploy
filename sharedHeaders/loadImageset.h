#ifndef LOADIMAGESET_H
#define LOADIMAGESET_H

#include <QSize>
#include <QList>
#include <QString>
#include <QStringList>

#include "selectBestSizeset.h"
#include "resourceLocation.h"

namespace FKUtility {
    bool loadImageset(const QString& imageset, const QSize& platformResolution){
        qDebug("load imageset %s", imageset.toLatin1().constData());
        QList<QSize> avaliableSizes;
        ResourceLocator locator(imageset);

        foreach(QString resourceFile,locator.resourceFiles()){
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
        if(targetSize.isEmpty()){
            return false;
        }

        QString resource=QString("%1x%2").arg(QString::number(targetSize.width())).arg(QString::number(targetSize.height()));

        ResourceLocator::Result result=locator.load(resource);
        return result==ResourceLocator::loadingSuccess;
    }
}

#endif // LOADIMAGESET_H
