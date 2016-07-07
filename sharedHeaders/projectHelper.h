#ifndef FK_PROJECT_HELPER
#define FK_PROJECT_HELPER

#include <QCoreApplication>

namespace FKProjectHelper{

        void ReplicateApplicationInfoFromProject(){
                QCoreApplication::setApplicationName(APP_NAME);
                QCoreApplication::setApplicationVersion(APP_VERSION);
                QCoreApplication::setOrganizationName(APP_MAINTAINER);
        }

}

#endif
