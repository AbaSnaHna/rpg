import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    id: mainWindow

    width:1680
    height:1920
    visible: true
    title: "Allinal"
    color: "#1a1a1a"

    // 玩家全局状态
    property var playerState: ({
        x: 1290,
        y: 755,
        direction: "down",
        inventory: []
    })

    // 场景加载器
    Loader {
        id: sceneLoader
        anchors.fill: parent
        source: "TownScreen.qml"
    }

    Rectangle {
        id: fadeOverlay
        anchors.fill: parent
        color: "black"
        opacity: 0
        z: 1000
        visible: opacity > 0
    }

    // 场景切换函数
    function changeScene(scenePath, playerSpawn) {
        if(sceneLoader.item && sceneLoader.item.savePlayerState) {
            sceneLoader.item.savePlayerState()
        }

        fadeOverlay.opacity = 1
        sceneTransition.scenePath = scenePath
        sceneTransition.playerSpawn = playerSpawn
        sceneTransition.start()
    }

    Timer {
        id: sceneTransition
        property string scenePath
        property var playerSpawn

        interval: 300
        onTriggered: {
            sceneLoader.source = scenePath
            fadeOverlay.opacity = 0
            if(sceneLoader.item && sceneLoader.item.loadPlayerState) {
                sceneLoader.item.loadPlayerState(playerSpawn)
            }
        }
    }

    Component.onCompleted: {
    }
}
