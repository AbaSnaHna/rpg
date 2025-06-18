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

    // 状态保存/加载
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

    // 区域检测定时器
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: checkAreaTransition()
    }

    function checkAreaTransition() {
        if(!player.moving) return

        // 获取玩家矩形区域
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
