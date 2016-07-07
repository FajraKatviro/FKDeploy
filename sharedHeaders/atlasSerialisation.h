#ifndef ATLASSERIALISATION_H
#define ATLASSERIALISATION_H


#include <QSize>
#include <QPoint>
#include <QStringList>
#include <QFile>
#include <QDataStream>
#include <QMap>

/*
 *
 * Assumed usage of identical structure:
 *
 * struct ImageInfo{
 *     bool mapped;
 *     QString file;
 *     QPoint pos;
 *     QSize size;
 * };
 *
 */

namespace FKUtility{
    template <class ImageInfo>
    [[deprecated("Internal QML cache atlas usage preferred")]]
    bool writeAtlasDescription(const QString& path,const QMap<QString,ImageInfo>& container){
        QFile source(path);
        if(source.open(QIODevice::WriteOnly)){
            QDataStream stream(&source);
            stream.setVersion(QDataStream::Qt_5_6);

            //group images by atlas files
            QMap<QString,QList<ImageInfo>> atlasMap;
            QStringList notMapped;
            for(auto i=container.constBegin();i!=container.constEnd();++i){
                const ImageInfo& info=i.value();
                if(info.mapped){
                    ImageInfo mappedImage;
                    mappedImage.file = i.key();     //re-use field to store image name
                    mappedImage.pos = info.pos;
                    mappedImage.size = info.size;
                    atlasMap[info.file].append(mappedImage);
                }else{
                    notMapped.append(i.key());
                }
            }

            qint32 atlasCount=atlasMap.count();
            stream<<atlasCount;
            for(auto a=atlasMap.constBegin();a!=atlasMap.constEnd();++a){
                const QList<ImageInfo>& images=a.value();
                qint32 imageCount=images.count();
                stream<<a.key()<<imageCount;
                for(auto i=images.constBegin();i!=images.constEnd();++i){
                    const ImageInfo& info=*i;
                    QString image(info.file); QPoint pos(info.pos); QSize size(info.size);
                    stream<<image<<pos<<size;
                }
            }
            for(auto i=notMapped.constBegin();i!=notMapped.constEnd();++i){
                stream<<(*i);
            }
            return true;
        }
        return false;
    }

    template <class ImageInfo>
    [[deprecated("Internal QML cache atlas usage preferred")]]
    bool readAtlasDescription(const QString& path,QMap<QString,ImageInfo>& container){
        QFile source(path);
        QMap<QString,ImageInfo> temp;
        if(source.open(QIODevice::ReadOnly)){
            QDataStream stream(&source);
            stream.setVersion(QDataStream::Qt_5_6);

            //read atlases
            qint32 atlasCount;
            stream>>atlasCount;
            while(atlasCount>0){
                QString file; qint32 imageCount;
                stream>>file>>imageCount;
                while(imageCount>0){
                    QString image; QPoint pos; QSize size;
                    stream>>image>>pos>>size;
                    ImageInfo& info=temp[image];
                    info.mapped=true;
                    info.file=file;
                    info.pos=pos;
                    info.size=size;
                    --imageCount;
                }
                --atlasCount;
            }

            //read not mapped images list
            while(!stream.atEnd()){
                QString image;
                stream>>image;
                temp[image].mapped=false;
            }
            container=temp;
            return true;
        }
        return false;
    }
}

#endif // ATLASSERIALISATION_H
