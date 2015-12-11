# youshop 安卓app demo#

## 请仔细阅读gradle.properties说明 ##

    VERSION_NAME=0.1.0-SNAPSHOT //版本号
    ARTIFACT=demo //模块名
    GROUP=com.youshop //组名，统一使用com.youshop

    BUILD_TOOLS_VERSION=23.0.0 //build tools版本，如果不满足，自动找最高的
    COMPILE_SDK_VERSION=23 // sdk 版本，如果不满足，自动找最高的
    ANDROID_GRADLE_PLUGIN_VERSION=1.3.1 //gradle plugin 版本

## 打release包 ##

    修改gradle.properties里的版本号VERSION_NAME为x.y.z，然后 gradle uploadArchives

## 打snapshots包 ##

    修改gradle.properties里的版本号VERSION_NAME为x.y.z-SNAPSHOT，然后 gradle uploadArchives
