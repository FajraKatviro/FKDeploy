#ifndef SELECTBESTSIZESET_H
#define SELECTBESTSIZESET_H

#include <QSize>
#include <QList>
#include <algorithm>

namespace FKUtility{
    QSize selectBestSizeset(const QList<QSize>& avaliableSizes,const QSize& targetSize){
        if(avaliableSizes.isEmpty() || targetSize.isEmpty())return QSize();

        struct Comp{
            Comp(const QSize& targetSize):target(targetSize){}
            bool operator()(const QSize& a,const QSize& b){
                return getScaleFactor(a)>getScaleFactor(b);
            }
            qreal getScaleFactor(const QSize& a){
                qreal scaleFactor;
                if(a.height()<target.height() || a.width()<target.width()){
                    //need upscale
                    scaleFactor=std::max((qreal)target.height()/a.height(),(qreal)target.width()/a.width());
                    scaleFactor+=(scaleFactor-1)*upscaleDiscourage; //upscale is bad...
                }else{
                    //need downscale
                    scaleFactor=std::min((qreal)a.height()/target.height(),(qreal)a.width()/target.width());
                }
                return scaleFactor;
            }
            QSize target;
            const qreal upscaleDiscourage=4.0;
        };

        return *(std::max_element(avaliableSizes.begin(),avaliableSizes.end(),Comp(targetSize)));
    }
}

#endif // SELECTBESTSIZESET_H
