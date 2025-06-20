import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: townScreen
    anchors.fill: parent
    focus: true

    // 地图背景
    Image {
        id: map
        source: "qrc:/map/Map003.png"
        smooth: false
        width: sourceSize.width
        height: sourceSize.height
        x:0
        y:0
    }

    Player{
        id:player
    }

    Rectangle{
        id:hintBox
        anchors.horizontalCenter: parent.horizontalCenter
        y:parent.height * 0.25
        width: sceneName.width + 40
        height: sceneName.height + 20
        radius: 10
        color:"#AA4ECDC4"
        border.color: "white"
        border.width: 2
        opacity: 0
        scale: 0.8

        Text {
            id: sceneName
            anchors.centerIn: parent
            text: "沙坪坝"
            color:"white"
            font{
                family: "Hiragino Sans GB"
                pixelSize: 100
                bold: true
                italic: true
            }
        }

        ParallelAnimation{
            id:enterAnim
            running: true
            NumberAnimation{target:hintBox; property: "opacity"; to:1; duration: 800}
            NumberAnimation{target:hintBox; property: "scale"; to:1; duration: 800;
                easing.type: Easing.OutBack}
        }

        Timer{
            interval: 2500
            running: true
            onTriggered: exitAnim.start()
        }

        ParallelAnimation{
            id:exitAnim
            running: true
            NumberAnimation{target:hintBox; property: "opacity"; to:0; duration: 800}
            NumberAnimation{target:hintBox; property: "scale"; to:0.8; duration: 800;
                easing.type: Easing.OutBack}
        }
    }

    function savePlayerState() {
        mainWindow.playerState = {
            x: player.x + map.x,
            y: player.y + map.y,
            direction: player.direction,
            inventory: mainWindow.playerState.inventory
        }
    }

    function loadPlayerState(spawnPoint) {
        if(spawnPoint) {
            player.x = spawnPoint.x - map.x
            player.y = spawnPoint.y - map.y
        } else {
            player.x = mainWindow.playerState.x - map.x
            player.y = mainWindow.playerState.y - map.y
        }
        player.direction = mainWindow.playerState.direction || "down"
    }

    property var transitionAreas: [
        {
            id: "weaponShop",
            x: 1053,  y: 500,
            width: 80, height: 64,
            targetScene: "WeaponShop.qml",
            playerSpawn: { x: 1290, y: 750 }
        }
    ]

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: checkAreaTransition()
    }

    function checkAreaTransition() {
        if(!player.moving) return

        var playerLeft = player.x
        var playerRight = player.x + player.width
        var playerTop = player.y
        var playerBottom = player.y + player.height

        for(var i = 0; i < transitionAreas.length; i++) {
            var area = transitionAreas[i]

            var areaLeft = area.x
            var areaRight = areaLeft + area.width
            var areaTop = area.y
            var areaBottom = areaTop + area.height

            if(playerRight > areaLeft &&
               playerLeft < areaRight &&
               playerBottom > areaTop &&
               playerTop < areaBottom) {
                mainWindow.changeScene(area.targetScene, area.playerSpawn)
                break
            }
        }
    }

    MediaPlayer{
        id:backgroudPlayer
        source: "qrc:/BGM/The First Town.mp3"
        audioOutput: AudioOutput{
            volume: 0.8
        }

        loops: MediaPlayer.Infinite
    }

    Component.onCompleted: {
        loadPlayerState()
        player.forceActiveFocus()
        backgroudPlayer.play()
    }

    Component.onDestruction: {
        backgroudPlayer.stop()
    }
}
