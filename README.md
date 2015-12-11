# android app demo for gradle modules #

## config gradle.properties

### 1 please config your nexus url

    NEXUS_URL=http://YOUR_IP_AND_PORT/nexus/content/repositories/youshop-release/

### 2 add all your modules to settings.gradle

    include ':demo-net'
    include ':app-demo'

### 3 config your module link type

#### 3.1 link with version using gradle dependencies

    DEMO_NET_LIB_LINK=version
    DEMO_NET_LIB_VERSION=0.1.0
    DEMO_NET_LIB_GROUP=com.lib
    DEMO_NET_LIB_REPO=git@github.com:beartung/android-demo-net.git
    DEMO_NET_LIB_BRANCH=master
    DEMO_NET_LIB_HASH=

#### 3.2 link with codes using git repo

    DEMO_NET_LIB_LINK=git
    DEMO_NET_LIB_VERSION=0.1.0
    DEMO_NET_LIB_GROUP=com.lib
    DEMO_NET_LIB_REPO=git@github.com:beartung/android-demo-net.git
    DEMO_NET_LIB_BRANCH=master
    DEMO_NET_LIB_HASH=

## usage

    ./prepare.sh && gradle asB

## implements

    prepare.sh - parse gradle.properties to sync modules repos

### app-demo/build.gradle

    String compileLib(String libName) {
        def name = libName.toUpperCase().replace("-", "_")
        println "compileLib srcname " + libName + " prop name " + name
        def libKeys = [ "VERSION", "LINK", "GROUP" ]
        def libMap = [:]

        for (k in libKeys) {
            libMap.put(k, project.ext.properties.get(name + "_LIB_" + k))
        }

        libMap.each { println "$it.key: $it.value" }

        def link = libMap.get("LINK")
        def version = libMap.get("VERSION")
        def group = libMap.get("GROUP")
        if (link.equalsIgnoreCase("version")) {
            println "compile version " + version
            dependencies.compile "${group}:${libName}:${version}"
        } else if (link.equalsIgnoreCase("git")) {
            println "compile project " + libName
            dependencies.compile project(":" + libName)
        }
    }

    dependencies {
        ...
        compileLib("demo-net")
        ...
    }
